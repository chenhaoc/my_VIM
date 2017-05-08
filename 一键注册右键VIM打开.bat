@echo off
echo Windows Registry Editor Version 5.00 >reg_VIM.reg
echo [HKEY_CLASSES_ROOT\*\shell\Edit with VIM] >>reg_VIM.reg
echo [HKEY_CLASSES_ROOT\*\shell\Edit with VIM\command] >>reg_VIM.reg
echo @="%cd:\=\\%\\vim74\\gvim.exe -p \"%%1\"" >>reg_VIM.reg
echo register the option "Edit With VIM" ...
regedit reg_VIM.reg
echo done.
del reg_VIM.reg
pause
