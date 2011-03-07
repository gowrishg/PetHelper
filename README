PetHelper

This is a TurboGears (http://www.turbogears.org) project. 
To start server execute start-pethelper.py script.

Language - Python 

Rule engine - clips 

Database - sqlite3

Mac OS X user -
-------------
	install gcc - xcode
	install turbogears - use easy_install	
	install turbokid - use easy_install 
	install pyclips -
		Download source of pyclips
		Replace the multifunction.c and multifunction.h files with the one of CLIPSv6.30
		Then install pyclips - 'python setup.py install'

Windows 7 server deployment-
---------------------------
install python -
	Download python from http://www.python.org/ftp/python/2.5.4/python-2.5.4.msi
	Install msi to a specific path (say 'c:/Development/Python25')
	Add the folder path (here it's 'c:/Development/Python25') to environment variable 'PATH'
install easy_install -
	Download python script http://peak.telecommunity.com/dist/ez_setup.py
	Install the script by typing 'ez_setup.py -U setuptools'
	Add 'c:\Development\Python2.5\Scripts' to environment variable 'PATH'
install Python for windows extension - 
	Download it at http://sourceforge.net/projects/pywin32/files/pywin32/Build%20214/pywin32-214.win32-py2.5.exe/download
	Install the exe
install virtual environment - 
	execute the command 'easy_install virtualenv'
install turbogears -
	Download script from  http://www.turbogears.org/2.0/downloads/current/tg2-bootstrap.py
	OPEN COMMAND PROMPT WITH Administrator privilege
	Run script 'python tg2-bootstrap.py --no-site-packages tg2env'
	Add environment variable to 'PATH'. (here its 'C:\Development\Python25\tg2env\tg2env\Scripts')

To setup run the following command - 
	Type 'paster quickstart'
	Fill in the details as appropriate. (name the ProjectName as 'TEST').
	Go to 'TEST' folder and then run 'type setup.py develop'
	System will automatically download install if there are any missed out dependencies.
install tg.devtools -
	Run 'easy_install tg.devtools'
	Run 'easy_install TurboGears'

install turbokid -
	Run 'easy_install turbokid'
install jsonpickle -
	Run command - 'easy_install jsonpickle'

install pyclips -
	Download source code - http://sourceforge.net/projects/pyclips/files/pyclips/pyclips-1.0/pyclips-1.0.7.348.tar.gz/download
	(to untar use 7-zip. you need mingw to compile the clips source. So make sure Mingw is installed)

	A important bug fix for additional functionality in pyclips - 
		First download CLIPSv6.3 - http://sourceforge.net/projects/clipsrules/files/CLIPS/6.30/CLIPS_6.30_Beta_Windows_Source_Code_Installer_R3.msi/download
		install the CLIPS6.3
		locate projects.zip and unzip it
		Locate 'multifunc.h' and 'multifunc.c' (COPY THESE TWO FILES)
		
		NOW Under pyclips folder - 
			Go to directory 'clipssrc'
			PASTE 'multifunc.c' and 'multifunc.h' here
	
	compile and install pyclips with these commands
		Under pyclips directory run 
		'python setup.py build --compiler=mingw32' and
		'python setup.py bdist_wininst --skip-build'
		This will create a executable in pyclips\dist. Install this executable

***End of deployment instructions***

Once you have done with all this Restart computer
Then extract our Project source file and then execute script - 'start-pethelper.py'
