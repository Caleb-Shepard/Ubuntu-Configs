# ~/.oh-my-zsh/themes/windows-cmd-mod.zsh-theme
clear;
echo "Not Windows Version [1337.420.69]"
echo "<c> 2021 Just kidding XD! No rights reserved.\n"

not_windows_path() {
  pwd | sed 's/\//\\/g'
}

PROMPT="C:"'$(not_windows_path)'"> "