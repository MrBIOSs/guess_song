namespace Blitz_Music.Views
{
    partial class SettingsForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SettingsForm));
            this.label1 = new System.Windows.Forms.Label();
            this.btnApply = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.cbMode = new System.Windows.Forms.ComboBox();
            this.cbDifficulty = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.label1.Location = new System.Drawing.Point(51, 59);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(80, 25);
            this.label1.TabIndex = 1;
            this.label1.Text = "Режим";
            // 
            // btnApply
            // 
            this.btnApply.BackColor = System.Drawing.Color.DarkCyan;
            this.btnApply.FlatAppearance.BorderSize = 0;
            this.btnApply.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnApply.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btnApply.ForeColor = System.Drawing.SystemColors.Window;
            this.btnApply.Location = new System.Drawing.Point(131, 229);
            this.btnApply.Name = "btnApply";
            this.btnApply.Size = new System.Drawing.Size(144, 55);
            this.btnApply.TabIndex = 1;
            this.btnApply.Tag = "1";
            this.btnApply.Text = "Применить";
            this.btnApply.UseVisualStyleBackColor = false;
            this.btnApply.Click += new System.EventHandler(this.OnApplyButtonClick);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label2.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.label2.Location = new System.Drawing.Point(12, 133);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(119, 25);
            this.label2.TabIndex = 1;
            this.label2.Text = "Сложность";
            // 
            // cbMode
            // 
            this.cbMode.BackColor = System.Drawing.SystemColors.Menu;
            this.cbMode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbMode.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.cbMode.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.cbMode.Location = new System.Drawing.Point(146, 56);
            this.cbMode.Name = "cbMode";
            this.cbMode.Size = new System.Drawing.Size(233, 33);
            this.cbMode.TabIndex = 2;
            this.cbMode.Tag = "2";
            this.cbMode.DropDownClosed += new System.EventHandler(this.OnDropDownClosed);
            // 
            // cbDifficulty
            // 
            this.cbDifficulty.BackColor = System.Drawing.SystemColors.Menu;
            this.cbDifficulty.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbDifficulty.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.cbDifficulty.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.cbDifficulty.Location = new System.Drawing.Point(146, 130);
            this.cbDifficulty.Name = "cbDifficulty";
            this.cbDifficulty.Size = new System.Drawing.Size(233, 33);
            this.cbDifficulty.TabIndex = 2;
            this.cbDifficulty.Tag = "2";
            this.cbDifficulty.DropDownClosed += new System.EventHandler(this.OnDropDownClosed);
            // 
            // SettingsForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.ClientSize = new System.Drawing.Size(404, 323);
            this.Controls.Add(this.btnApply);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.cbDifficulty);
            this.Controls.Add(this.cbMode);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "SettingsForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Настройки";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.OnSettingsFormClosed);
            this.Load += new System.EventHandler(this.OnSettingsFormLoad);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnApply;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox cbMode;
        private System.Windows.Forms.ComboBox cbDifficulty;
    }
}