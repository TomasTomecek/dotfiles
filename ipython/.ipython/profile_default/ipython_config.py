# Configuration file for ipython.
c = get_config()
c.InteractiveShellApp.exec_lines = [
	'import os',
	'import sys',
	'import re',
	'import json',
	'import subprocess',
]
c.InteractiveShellApp.extensions = ['autoreload',]
c.InteractiveShellApp.exec_files = ['init.ipy']
c.TerminalInteractiveShell.history_length = 100000
c.TerminalInteractiveShell.colors = 'Linux'
c.TerminalInteractiveShell.autoindent = True
c.TerminalInteractiveShell.confirm_exit = False
c.TerminalInteractiveShell.pdb = True
