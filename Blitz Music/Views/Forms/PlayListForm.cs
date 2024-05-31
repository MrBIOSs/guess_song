using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

// github.com/MrBIOSs

namespace Blitz_Music.Views
{
    public partial class PlayListForm : Form
    {
        private readonly MainForm _mainForm;
        private List<string> _musicPaths = new List<string>();

        public PlayListForm(MainForm mainForm)
        {
            InitializeComponent();

            _mainForm = mainForm;
        }

        private async void OnAddButtonClick(object sender, EventArgs e)
        {
            var selectedPath = ShowFolderBrowserDialog();
            if (selectedPath != null)
            {
                var songFiles = await Task.Run(() => Directory.GetFiles(selectedPath, "*.mp3"));

                _musicPaths.AddRange(songFiles);

                songFiles = _musicPaths.Select(Path.GetFileName).ToArray();
                RefreshPlayList(songFiles);
            }
        }

        private void OnDeleteButtonClick(object sender, EventArgs e)
        {
            if (lbMusic.SelectedItems.Count == 0)
            {
                _mainForm.ShowErrorMessage("Выберите песню из списка, которую хотите удалить.");
            }
            else
            {
                var selectedIndices = lbMusic.SelectedIndices.Cast<int>().ToList();
                var selectedSongs = lbMusic.Items.Cast<string>().ToList();

                _musicPaths.RemoveAll(path => selectedIndices.Contains(_musicPaths.IndexOf(path)));
                selectedSongs.RemoveAll(song => selectedIndices.Contains(selectedSongs.IndexOf(song)));

                RefreshPlayList(selectedSongs.ToArray());
            }
        }

        private void OnSaveButtonClick(object sender, EventArgs e)
        {
            _mainForm.ShowCountMusic(lbMusic.Items.Count);
            _mainForm.SetPlayList(_musicPaths);
            this.Close();
        }

        private void OnPlayListFormClosed(object sender, FormClosedEventArgs e)
        {
            _mainForm.EnableForm();
        }

        private string ShowFolderBrowserDialog()
        {
            var dialog = new FolderBrowserDialog();
            if (dialog.ShowDialog() == DialogResult.OK) return dialog.SelectedPath;
            
            return null;
        }

        private void RefreshPlayList(string[] songFiles)
        {
            lbMusic.Items.Clear();
            lbMusic.Items.AddRange(songFiles);
        }
    }
}
