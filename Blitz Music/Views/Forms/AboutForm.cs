using System.Diagnostics;
using System.Windows.Forms;

// github.com/MrBIOSs

namespace Blitz_Music.Views
{
    public partial class AboutForm : Form
    {
        private readonly MainForm _mainForm;

        public AboutForm(MainForm mainForm)
        {
            InitializeComponent();
            _mainForm = mainForm;
        }

        private void OnGitHubLinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            Process.Start("https://github.com/MrBIOSs");
        }

        private void OnAboutFormClosed(object sender, FormClosedEventArgs e)
        {
            _mainForm.EnableForm();
        }
    }
}
