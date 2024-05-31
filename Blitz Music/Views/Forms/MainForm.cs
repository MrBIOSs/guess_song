using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Threading.Tasks;
using System.Windows.Forms;
using NAudio.Wave;
using Blitz_Music.Views;

// github.com/MrBIOSs

namespace Blitz_Music
{
    public partial class MainForm : Form
    {
        public int Duration { get; private set; }
        public int Variants { get; private set; }
        public int Rounds { get; private set; }

        private ToolStripLabel[] _labels;
        private Button[] _gameButtons;
        private List<string> _playList;
        private List<string> _songTitles;
        private Form _form;
        private Random _random;
        private WaveOutEvent _outputDevice;
        private AudioFileReader _audioFile;

        private int _maxDurationSong, _minLimit, _maxLimit, _currentDurationSong, _currentScore, _maxScore, _currentRound;
        private string _startGameText, _playText, _stopText, _songNameX, _currentVariant, _currentSong, _currentSongTitle;
        private string[] _titles;

        public MainForm()
        {
            InitializeComponent();

            _labels = new[] { toolStripLabel1, toolStripLabel2, toolStripLabel3 };
            _gameButtons = new[] { btn1, btn2, btn3, btn4, btn5, btn6};
            _playList = new List<string>();
            _songTitles = new List<string>();
            _random = new Random();

            _startGameText = "Начать игру";
            _playText = "▷";
            _stopText = "■";
            _titles = new[] { "Новичок", "Любитель", "Фанат", "Профессионал", "Преданный фанат" };
        }

        public void SetSettings(int duration, int variants, int rounds)
        {
            Duration = duration;
            Variants = variants;
            Rounds = rounds;
        }

        public async void SetPlayList(List<string> playList)
        {
            _playList.Clear();
            _playList = playList;
            await Task.Run(() => ParseSongTitles());
        }

        public void EnableForm()
        {
            foreach (var label in _labels)
            {
                label.ForeColor = Color.Black;
            }

            this.Enabled = true;
        }

        public void ApplySettings(string mode, string difficulty)
        {
            lblDifficulty.Text = difficulty;
            lblMode.Text = mode;
        }

        public void ShowErrorMessage(string message)
        {
            MessageBox.Show(message, "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        public void ShowCountMusic(int count)
        {
            lblMusicCount.Text = count.ToString();
        }

        private void OnMainFormLoad(object sender, EventArgs e)
        {
            btnStart.Enabled = false;
        }

        private void OnLabelDifficultyTextChanged(object sender, EventArgs e)
        {
            if (lblDifficulty.Text == "-") 
                btnStart.Enabled = false;
            else
                btnStart.Enabled = true;
        }

        private void OnToolStripLabelMouseEnter(object sender, EventArgs e)
        {
            ToolStripLabel label = sender as ToolStripLabel;

            label.ForeColor = Color.FromArgb(192, 0, 192);
        }

        private void OnToolStripLabelMouseLeave(object sender, EventArgs e)
        {
            ToolStripLabel label = sender as ToolStripLabel;

            label.ForeColor = Color.Black;
        }

        private void OnToolStripLabelClick(object sender, EventArgs e)
        {
            string label = sender.ToString();

            if (label == _labels[0].Text) _form = new PlayListForm(this);
            if (label == _labels[1].Text) _form = new SettingsForm(this);
            if (label == _labels[2].Text) _form = new AboutForm(this);

            _form.Show();
            this.Enabled = false;
        }

        private void OnStartButtonClick(object sender, EventArgs e)
        {
            int countMusic = Convert.ToInt32(lblMusicCount.Text);
            int songsRequired = Variants + Rounds;

            if (lblDifficulty.Text == "-" || lblMode.Text == "-" || countMusic < songsRequired)
            {
                ShowErrorMessage("Выберите Сложность и Режим игры в Настройках. \n" +
                    "Песен в папке с игрой должно быть больше " + songsRequired);
            }
            else
            {
                if (btnStart.Text == _startGameText)
                {
                    StartGame();
                }
                else
                {
                    if (_currentVariant == _songNameX) _currentScore++;

                    _currentRound++;

                    if (_currentRound < Rounds)
                    {
                        if (btnPlayMusic.Text == _stopText) StopSong();
                        
                        StartRound();
                    }
                    else
                    {
                        EndGame();
                    }
                }
            }
        }

        private void OnButtonPlayMusicClick(object sender, EventArgs e)
        {
            if (btnPlayMusic.Text == _stopText)
            {
                StopSong();
            }
            else
            {
                PlaySong(_currentSong);
            }
        }

        private void OnGameButtonClick(object sender, EventArgs e)
        {
            Button button = sender as Button;

            _currentVariant = button.Text;
        }

        private void OnTimerTick(object sender, EventArgs e)
        {
            _currentDurationSong++;

            if (_currentDurationSong >= _maxDurationSong) StopTimer();

            lblTimeMusic.Text = _currentDurationSong.ToString();
        }

        private void OnPlaybackStopped(object sender, StoppedEventArgs args)
        {
            _outputDevice.Dispose();
            _audioFile.Dispose();
            _audioFile = null;
            _outputDevice = null;

            btnPlayMusic.Text = _playText;
            lblTimeMusic.Text = "0";
        }

        private void StartGame()
        {
            if (lblMode.Text == "Случайный отрезок") RandomizeInterval();
           
            ToggleStateGame(true, "Следующая");
            InitializationRound();
            StartRound();
        }

        private void StartRound()
        {
            string[] titleSongs = new string[Variants];
            int randomIndex = new Random().Next(0, Variants);

            RandomizeSong();

            _songNameX = _currentSongTitle;

            for (int index = 0; index < titleSongs.Length; index++)
            {
                titleSongs[index] = _songTitles[index];
            }

            titleSongs[randomIndex] = _songNameX;

            for (int buttonId = 0; buttonId < Variants; buttonId++)
            {
                _gameButtons[buttonId].Text = titleSongs[buttonId];
            }
        }

        private void InitializationRound()
        {
            _currentScore = 0;
            _maxScore = 0;
            _currentRound = 0;

            for (int button = 0; button < Variants; button++)
            {
                _gameButtons[button].Visible = true;
            }
        }

        private async void EndGame()
        {
            StopSong();

            _maxScore = Rounds;

            lblTitle.Text = AnalysisTitle();

            await Task.Run(() => Directory.Delete("Temp", true)); 

            foreach (var button in _gameButtons)
            {
                button.Visible = false;
            }

            ToggleStateGame(false, _startGameText);

            lblMusicCount.Text = "0";
        }

        private void ToggleStateGame(bool state, string title)
        {
            toolStripLabel1.Enabled = !state;
            toolStripLabel2.Enabled = !state;

            btnPlayMusic.Visible = state;
            lblTimeMusic.Visible = state;
            btnStart.Text = title;
        }

        private void ParseSongTitles()
        {
            _songTitles.Clear();

            foreach (string songPath in _playList)
            {
                var file = TagLib.File.Create(songPath);
                string title = file.Tag.Title;

                _songTitles.Add(title);
            }
        }

        private void RandomizeSong()
        {
            if (_playList.Count == 0)
            {
                throw new InvalidOperationException("Плейлист пустой");
            }

            var randomIndex = _random.Next(0, _playList.Count);
            var randomSong = _playList[randomIndex];
            var randomSongTitle = _songTitles[randomIndex];

            _playList.RemoveAt(randomIndex);
            _songTitles.RemoveAt(randomIndex);

            _currentSongTitle = randomSongTitle;
            _currentSong = randomSong;
        }

        private void PlaySong(string song)
        {
            btnPlayMusic.Text = _stopText;

            if (_outputDevice == null)
            {
                _outputDevice = new WaveOutEvent();
                _outputDevice.PlaybackStopped += OnPlaybackStopped;
            }

            if (_audioFile == null)
            {
                _audioFile = new AudioFileReader(song);
                _outputDevice.Init(_audioFile);
                _maxDurationSong = (int)_audioFile.TotalTime.TotalSeconds;
            }

            _outputDevice.Play();
            StartTimer();
        }

        private void StopSong()
        {
            btnPlayMusic.Text = _playText;
            _outputDevice.Stop();
            StopTimer();
        }

        private void StartTimer()
        {
            _currentDurationSong = 0;
            timer.Start();
        }

        private void StopTimer()
        {
            timer.Stop();
            lblTimeMusic.Text = "0";
        }

        private double CalculationPercent()
        {
            int percent = 100;
            double result = (double)_currentScore / _maxScore;

            if (_currentScore <= 0 || _maxScore <= 0) return 0;

            return result * percent;
        }

        private string AnalysisTitle()
        {
            double result = CalculationPercent();
            string defoultTitle = "-";

            if (result <= 0) return defoultTitle;
            if (result <= 20) return _titles[0];
            if (result <= 40) return _titles[1];
            if (result <= 60) return _titles[2];
            if (result <= 80) return _titles[3];
            if (result <= 100) return _titles[4];
            else return defoultTitle;
        }

        private void RandomizeInterval()
        {
            string basepath = AppDomain.CurrentDomain.BaseDirectory;
            string tempDirectoryPath = Path.Combine(basepath, "Temp");
            string tempSongPath;
            Mp3FileReader reader = null;
            FileStream writer = null;
            TimeSpan startTime, endTime;

            if (Directory.Exists(tempDirectoryPath) == false)
            {
                Directory.CreateDirectory(tempDirectoryPath);
            }

            for (int i = 0; i < _playList.Count; i++)
            {
                tempSongPath = Path.Combine(tempDirectoryPath, $"temp{i}.mp3");
                reader = new Mp3FileReader(_playList[i]);
                writer = File.Create(tempSongPath);

                CalculateLimits(reader);

                startTime = TimeSpan.FromSeconds(_minLimit);
                endTime = TimeSpan.FromSeconds(_maxLimit);

                CutSong(startTime, endTime, reader, writer);

                _playList[i] = tempSongPath;

                writer.Close();
                reader.Close();
            }
            reader.Dispose();
            writer.Dispose();
        }

        private void CalculateLimits(Mp3FileReader reader)
        {
            int limit = (int)reader.TotalTime.TotalSeconds - Duration + 1;
            int minLimit = _random.Next(0, limit);
            int maxLimit = minLimit + Duration;

            _minLimit = minLimit;
            _maxLimit = maxLimit;
        }

        private void CutSong(TimeSpan startTime, TimeSpan endTime, Mp3FileReader reader, FileStream writer)
        {
            Mp3Frame frame;

            while ((frame = reader.ReadNextFrame()) != null)
            {
                if (reader.CurrentTime >= startTime && reader.CurrentTime <= endTime)
                {
                    writer.Write(frame.RawData, 0, frame.RawData.Length);
                }
            }
        }
    }
}
