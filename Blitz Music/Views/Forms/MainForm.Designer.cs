namespace Blitz_Music
{
    partial class MainForm
    {
        
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Требуемый метод для поддержки конструктора — не изменяйте 
        /// содержимое этого метода с помощью редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.toolStripLabel1 = new System.Windows.Forms.ToolStripLabel();
            this.toolStripLabel2 = new System.Windows.Forms.ToolStripLabel();
            this.toolStripLabel3 = new System.Windows.Forms.ToolStripLabel();
            this.btnStart = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.lblMusicCount = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.lblTitle = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.lblDifficulty = new System.Windows.Forms.Label();
            this.lblMode = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.btn6 = new System.Windows.Forms.Button();
            this.btn4 = new System.Windows.Forms.Button();
            this.btn5 = new System.Windows.Forms.Button();
            this.btn3 = new System.Windows.Forms.Button();
            this.btn2 = new System.Windows.Forms.Button();
            this.btn1 = new System.Windows.Forms.Button();
            this.btnPlayMusic = new System.Windows.Forms.Button();
            this.lblTimeMusic = new System.Windows.Forms.Label();
            this.timer = new System.Windows.Forms.Timer(this.components);
            this.toolStrip1.SuspendLayout();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // toolStrip1
            // 
            this.toolStrip1.ImageScalingSize = new System.Drawing.Size(24, 24);
            this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripLabel1,
            this.toolStripLabel2,
            this.toolStripLabel3});
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Size = new System.Drawing.Size(800, 30);
            this.toolStrip1.TabIndex = 0;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // toolStripLabel1
            // 
            this.toolStripLabel1.Name = "toolStripLabel1";
            this.toolStripLabel1.Size = new System.Drawing.Size(76, 25);
            this.toolStripLabel1.Text = "Музыка";
            this.toolStripLabel1.Click += new System.EventHandler(this.OnToolStripLabelClick);
            this.toolStripLabel1.MouseEnter += new System.EventHandler(this.OnToolStripLabelMouseEnter);
            this.toolStripLabel1.MouseLeave += new System.EventHandler(this.OnToolStripLabelMouseLeave);
            // 
            // toolStripLabel2
            // 
            this.toolStripLabel2.Name = "toolStripLabel2";
            this.toolStripLabel2.Size = new System.Drawing.Size(100, 25);
            this.toolStripLabel2.Text = "Настройки";
            this.toolStripLabel2.Click += new System.EventHandler(this.OnToolStripLabelClick);
            this.toolStripLabel2.MouseEnter += new System.EventHandler(this.OnToolStripLabelMouseEnter);
            this.toolStripLabel2.MouseLeave += new System.EventHandler(this.OnToolStripLabelMouseLeave);
            // 
            // toolStripLabel3
            // 
            this.toolStripLabel3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.toolStripLabel3.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
            this.toolStripLabel3.ForeColor = System.Drawing.Color.Black;
            this.toolStripLabel3.Name = "toolStripLabel3";
            this.toolStripLabel3.Size = new System.Drawing.Size(78, 25);
            this.toolStripLabel3.Text = "Об игре";
            this.toolStripLabel3.Click += new System.EventHandler(this.OnToolStripLabelClick);
            this.toolStripLabel3.MouseEnter += new System.EventHandler(this.OnToolStripLabelMouseEnter);
            this.toolStripLabel3.MouseLeave += new System.EventHandler(this.OnToolStripLabelMouseLeave);
            // 
            // btnStart
            // 
            this.btnStart.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btnStart.BackColor = System.Drawing.Color.SteelBlue;
            this.btnStart.FlatAppearance.BorderSize = 0;
            this.btnStart.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnStart.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btnStart.ForeColor = System.Drawing.SystemColors.Window;
            this.btnStart.Location = new System.Drawing.Point(281, 143);
            this.btnStart.Name = "btnStart";
            this.btnStart.Size = new System.Drawing.Size(242, 76);
            this.btnStart.TabIndex = 1;
            this.btnStart.Text = "Начать игру";
            this.btnStart.UseVisualStyleBackColor = false;
            this.btnStart.Click += new System.EventHandler(this.OnStartButtonClick);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.label1.Location = new System.Drawing.Point(12, 71);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(75, 25);
            this.label1.TabIndex = 2;
            this.label1.Text = "Песен:";
            // 
            // lblMusicCount
            // 
            this.lblMusicCount.AutoSize = true;
            this.lblMusicCount.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblMusicCount.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.lblMusicCount.Location = new System.Drawing.Point(86, 71);
            this.lblMusicCount.Name = "lblMusicCount";
            this.lblMusicCount.Size = new System.Drawing.Size(25, 26);
            this.lblMusicCount.TabIndex = 2;
            this.lblMusicCount.Text = "0";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label3.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.label3.Location = new System.Drawing.Point(276, 71);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(74, 25);
            this.label3.TabIndex = 2;
            this.label3.Text = "Титул:";
            // 
            // lblTitle
            // 
            this.lblTitle.AutoSize = true;
            this.lblTitle.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblTitle.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.lblTitle.Location = new System.Drawing.Point(349, 71);
            this.lblTitle.Name = "lblTitle";
            this.lblTitle.Size = new System.Drawing.Size(20, 26);
            this.lblTitle.TabIndex = 2;
            this.lblTitle.Text = "-";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label5.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.label5.Location = new System.Drawing.Point(12, 263);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(125, 25);
            this.label5.TabIndex = 2;
            this.label5.Text = "Сложность:";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label6.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.label6.Location = new System.Drawing.Point(283, 263);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(86, 25);
            this.label6.TabIndex = 2;
            this.label6.Text = "Режим:";
            // 
            // lblDifficulty
            // 
            this.lblDifficulty.AutoSize = true;
            this.lblDifficulty.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblDifficulty.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.lblDifficulty.Location = new System.Drawing.Point(134, 262);
            this.lblDifficulty.Name = "lblDifficulty";
            this.lblDifficulty.Size = new System.Drawing.Size(20, 26);
            this.lblDifficulty.TabIndex = 2;
            this.lblDifficulty.Text = "-";
            this.lblDifficulty.TextChanged += new System.EventHandler(this.OnLabelDifficultyTextChanged);
            // 
            // lblMode
            // 
            this.lblMode.AutoSize = true;
            this.lblMode.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblMode.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.lblMode.Location = new System.Drawing.Point(366, 263);
            this.lblMode.Name = "lblMode";
            this.lblMode.Size = new System.Drawing.Size(20, 26);
            this.lblMode.TabIndex = 2;
            this.lblMode.Text = "-";
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.btn6);
            this.panel1.Controls.Add(this.btn4);
            this.panel1.Controls.Add(this.btn5);
            this.panel1.Controls.Add(this.btn3);
            this.panel1.Controls.Add(this.btn2);
            this.panel1.Controls.Add(this.btn1);
            this.panel1.Location = new System.Drawing.Point(0, 310);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(800, 296);
            this.panel1.TabIndex = 3;
            // 
            // btn6
            // 
            this.btn6.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btn6.BackColor = System.Drawing.Color.SteelBlue;
            this.btn6.FlatAppearance.BorderSize = 0;
            this.btn6.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn6.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btn6.ForeColor = System.Drawing.SystemColors.Window;
            this.btn6.Location = new System.Drawing.Point(405, 195);
            this.btn6.Name = "btn6";
            this.btn6.Size = new System.Drawing.Size(366, 76);
            this.btn6.TabIndex = 1;
            this.btn6.Text = "6";
            this.btn6.UseVisualStyleBackColor = false;
            this.btn6.Visible = false;
            this.btn6.Click += new System.EventHandler(this.OnGameButtonClick);
            // 
            // btn4
            // 
            this.btn4.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btn4.BackColor = System.Drawing.Color.SteelBlue;
            this.btn4.FlatAppearance.BorderSize = 0;
            this.btn4.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn4.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btn4.ForeColor = System.Drawing.SystemColors.Window;
            this.btn4.Location = new System.Drawing.Point(405, 103);
            this.btn4.Name = "btn4";
            this.btn4.Size = new System.Drawing.Size(366, 76);
            this.btn4.TabIndex = 1;
            this.btn4.Text = "4";
            this.btn4.UseVisualStyleBackColor = false;
            this.btn4.Visible = false;
            this.btn4.Click += new System.EventHandler(this.OnGameButtonClick);
            // 
            // btn5
            // 
            this.btn5.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btn5.BackColor = System.Drawing.Color.SteelBlue;
            this.btn5.FlatAppearance.BorderSize = 0;
            this.btn5.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn5.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btn5.ForeColor = System.Drawing.SystemColors.Window;
            this.btn5.Location = new System.Drawing.Point(24, 195);
            this.btn5.Name = "btn5";
            this.btn5.Size = new System.Drawing.Size(366, 76);
            this.btn5.TabIndex = 1;
            this.btn5.Text = "5";
            this.btn5.UseVisualStyleBackColor = false;
            this.btn5.Visible = false;
            this.btn5.Click += new System.EventHandler(this.OnGameButtonClick);
            // 
            // btn3
            // 
            this.btn3.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btn3.BackColor = System.Drawing.Color.SteelBlue;
            this.btn3.FlatAppearance.BorderSize = 0;
            this.btn3.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btn3.ForeColor = System.Drawing.SystemColors.Window;
            this.btn3.Location = new System.Drawing.Point(24, 103);
            this.btn3.Name = "btn3";
            this.btn3.Size = new System.Drawing.Size(366, 76);
            this.btn3.TabIndex = 1;
            this.btn3.Text = "3";
            this.btn3.UseVisualStyleBackColor = false;
            this.btn3.Visible = false;
            this.btn3.Click += new System.EventHandler(this.OnGameButtonClick);
            // 
            // btn2
            // 
            this.btn2.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btn2.BackColor = System.Drawing.Color.SteelBlue;
            this.btn2.FlatAppearance.BorderSize = 0;
            this.btn2.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btn2.ForeColor = System.Drawing.SystemColors.Window;
            this.btn2.Location = new System.Drawing.Point(405, 12);
            this.btn2.Name = "btn2";
            this.btn2.Size = new System.Drawing.Size(366, 76);
            this.btn2.TabIndex = 1;
            this.btn2.Text = "2";
            this.btn2.UseVisualStyleBackColor = false;
            this.btn2.Visible = false;
            this.btn2.Click += new System.EventHandler(this.OnGameButtonClick);
            // 
            // btn1
            // 
            this.btn1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btn1.BackColor = System.Drawing.Color.SteelBlue;
            this.btn1.FlatAppearance.BorderSize = 0;
            this.btn1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btn1.ForeColor = System.Drawing.SystemColors.Window;
            this.btn1.Location = new System.Drawing.Point(24, 12);
            this.btn1.Name = "btn1";
            this.btn1.Size = new System.Drawing.Size(366, 76);
            this.btn1.TabIndex = 1;
            this.btn1.Text = "1";
            this.btn1.UseVisualStyleBackColor = false;
            this.btn1.Visible = false;
            this.btn1.Click += new System.EventHandler(this.OnGameButtonClick);
            // 
            // btnPlayMusic
            // 
            this.btnPlayMusic.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btnPlayMusic.BackColor = System.Drawing.Color.SteelBlue;
            this.btnPlayMusic.FlatAppearance.BorderSize = 0;
            this.btnPlayMusic.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPlayMusic.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btnPlayMusic.ForeColor = System.Drawing.SystemColors.Window;
            this.btnPlayMusic.Location = new System.Drawing.Point(177, 143);
            this.btnPlayMusic.Name = "btnPlayMusic";
            this.btnPlayMusic.Size = new System.Drawing.Size(82, 76);
            this.btnPlayMusic.TabIndex = 1;
            this.btnPlayMusic.Text = " ▷";
            this.btnPlayMusic.UseVisualStyleBackColor = false;
            this.btnPlayMusic.Visible = false;
            this.btnPlayMusic.Click += new System.EventHandler(this.OnButtonPlayMusicClick);
            // 
            // lblTimeMusic
            // 
            this.lblTimeMusic.AutoSize = true;
            this.lblTimeMusic.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblTimeMusic.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.lblTimeMusic.Location = new System.Drawing.Point(538, 165);
            this.lblTimeMusic.Name = "lblTimeMusic";
            this.lblTimeMusic.Size = new System.Drawing.Size(33, 36);
            this.lblTimeMusic.TabIndex = 2;
            this.lblTimeMusic.Text = "0";
            this.lblTimeMusic.Visible = false;
            // 
            // timer
            // 
            this.timer.Interval = 1000;
            this.timer.Tick += new System.EventHandler(this.OnTimerTick);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.ClientSize = new System.Drawing.Size(800, 602);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.lblMode);
            this.Controls.Add(this.lblDifficulty);
            this.Controls.Add(this.lblTitle);
            this.Controls.Add(this.lblTimeMusic);
            this.Controls.Add(this.lblMusicCount);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnPlayMusic);
            this.Controls.Add(this.btnStart);
            this.Controls.Add(this.toolStrip1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Blitz Music";
            this.Load += new System.EventHandler(this.OnMainFormLoad);
            this.toolStrip1.ResumeLayout(false);
            this.toolStrip1.PerformLayout();
            this.panel1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.ToolStripLabel toolStripLabel1;
        private System.Windows.Forms.ToolStripLabel toolStripLabel2;
        private System.Windows.Forms.ToolStripLabel toolStripLabel3;
        private System.Windows.Forms.Button btnStart;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lblMusicCount;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lblTitle;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label lblDifficulty;
        private System.Windows.Forms.Label lblMode;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Button btn4;
        private System.Windows.Forms.Button btn3;
        private System.Windows.Forms.Button btn2;
        private System.Windows.Forms.Button btn1;
        private System.Windows.Forms.Button btn6;
        private System.Windows.Forms.Button btn5;
        private System.Windows.Forms.Button btnPlayMusic;
        private System.Windows.Forms.Label lblTimeMusic;
        private System.Windows.Forms.Timer timer;
    }
}

