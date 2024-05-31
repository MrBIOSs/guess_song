using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

// github.com/MrBIOSs

namespace Blitz_Music.Views
{
    public partial class SettingsForm : Form
    {
        public string CurrentMod { get; private set; }
        public string CurrentDifficulty { get; private set; }

        private readonly MainForm _mainForm;
        private string[] _modes = new string[] { "Случайный отрезок" };
        private Dictionary<string, (int duration, int variants, int rounds)> _difficultyLevels = new Dictionary<string, (int, int, int)>
        {
            { "Легкая", (30, 2, 5) },
            { "Средная", (15, 4, 10) },
            { "Сложная", (10, 6, 15) }
        };

        public SettingsForm(MainForm mainForm)
        {
            InitializeComponent();

            _mainForm = mainForm;
        }

        private void OnSettingsFormLoad(object sender, EventArgs e)
        {
            string[] difficultyLevels = _difficultyLevels.Keys.ToArray();

            cbMode.Items.AddRange(_modes);
            cbDifficulty.Items.AddRange(difficultyLevels);
        }

        private void OnDropDownClosed(object sender, EventArgs e)
        {
            btnApply.Focus();
        }

        private void OnApplyButtonClick(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(cbDifficulty.Text) || string.IsNullOrEmpty(cbMode.Text))
            {
                _mainForm.ShowErrorMessage("Выберете Режим и Сложность игры") ;
            }
            else
            {
                int duration, variants, rounds;

                CurrentMod = cbMode.Text;
                CurrentDifficulty = cbDifficulty.Text;

                _mainForm.ApplySettings(CurrentMod, CurrentDifficulty);

                duration = _difficultyLevels[CurrentDifficulty].Item1;
                variants = _difficultyLevels[CurrentDifficulty].Item2;
                rounds = _difficultyLevels[CurrentDifficulty].Item3;

                _mainForm.SetSettings(duration, variants, rounds);
                
                this.Close();
            }
        }

        private void OnSettingsFormClosed(object sender, FormClosedEventArgs e)
        {
            _mainForm.EnableForm();
        }
    }
}
