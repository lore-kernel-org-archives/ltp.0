Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lgliang@linux.vnet.ibm.com>) id 1QrdFu-0004Vh-KU
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 21:57:34 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QrdFs-0002eI-C1
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 21:57:34 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7BLgMat018559
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Aug 2011 15:42:22 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p7BLvQP6118054
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Aug 2011 15:57:26 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p7BLvQxR020084
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Aug 2011 15:57:26 -0600
Received: from taco.beaverton.ibm.com ([9.47.29.114])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p7BLvPVW020069
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Aug 2011 15:57:25 -0600
Date: Thu, 11 Aug 2011 14:57:30 -0700
From: Lucy Liang <lgliang@linux.vnet.ibm.com>
Message-ID: <20110811215730.GA9444@us.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH 1/7] Updated pounder's documentation
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Updated the README and SCHEDULER doc files. Merged QUICKSTART
with README. README gives an overview of building/running pounder
and how its files/subdirectories are organized. SCHEDULER goes
into detail about how to create, modify, build, and run tests and
test schedulers. Also added a new CONFIGURATION document that
explains pounder's environment variables. CONFIGURATION and
SCHEDULER are now located in a newly created doc/ directory.

Signed-off-by: Lucy Liang <lgliang@linux.vnet.ibm.com>
---
 tools/pounder21/CHANGELOG         |   59 ++++++
 tools/pounder21/QUICKSTART        |   20 --
 tools/pounder21/README            |  272 ++++++++++++++++++++---------
 tools/pounder21/SCHEDULER         |  150 ----------------
 tools/pounder21/doc/CONFIGURATION |  107 +++++++++++
 tools/pounder21/doc/SCHEDULER     |  352 +++++++++++++++++++++++++++++++++++++
 6 files changed, 711 insertions(+), 249 deletions(-)
 delete mode 100644 tools/pounder21/QUICKSTART
 delete mode 100644 tools/pounder21/SCHEDULER
 create mode 100644 tools/pounder21/doc/CONFIGURATION
 create mode 100644 tools/pounder21/doc/SCHEDULER


--------------1.7.4.1
Content-Type: text/x-patch; name="0001-Updated-pounder-s-documentation.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-Updated-pounder-s-documentation.patch"

diff --git a/tools/pounder21/CHANGELOG b/tools/pounder21/CHANGELOG
index c248d96..4543f3a 100644
--- a/tools/pounder21/CHANGELOG
+++ b/tools/pounder21/CHANGELOG
@@ -1,5 +1,64 @@
 This is a log of changes to pounder21.
 
+pounder30-2011-08-09
+- Created new documentation CONFIGURATION and moved it and SCHEDULER
+  into a newly created doc/ directory
+- Deleted the test-all test scheduler
+- Created /schedulers directory and moved the remaining test schedulers there
+- Removed option to specify "NONE" when asked to unpack test scheduler during build
+- Removed check for existing kernel directory in /tmp in test_scripts/build_kernel
+  since it appears that some files get lost after running build_kernel once; Instead
+  just untar the kernel each time we run the test script to be on the safe side
+- ltp test script would pass even if it didn't build currently, fixed this in
+  test_scripts/ltp
+- changed ltp build_script to install ltp to $POUNDER_TMPDIR
+- removed QUICKSTART and included it in README instead
+- removed trailing "/" from POUNDER_LOGLOCAL export in libpounder.sh
+- Added functionality for automatic skipping of subtests (see README)
+- Created xterm_stress build script and merged 00xbonkers with it
+- Created ide_cdrom_copy build script and merged 00check_cdrom_presence with it
+- Merged nasm and schedutils build scripts with the lame build script
+- Merged time_test build script with the time_consistency and time_drift build
+  scripts
+- Created test_repo/ directory
+- Uncommented a piece of code in time_drift that allowed it to always pass
+- Added pounder -c option for creating new test schedulers
+- Modified POUNDER_VERSION in libpounder.sh
+
+pounder30-2011-07-21
+- Updated bonnie++, ipmitool, kernel (used in build_kernel), and memtest script to latest versions
+- Updated memtest build scripts and $POUNDER_HOME/src/memtest.patch
+- Added functionality for skipping of subtests
+  - Added functionality for automating the skipping of subtests (see README)
+- Removed unnecessary 00checklatest test
+- Moved checking for system requirements from test run to build phase
+  - Affects bonnie++, memtest, cpufreq, and ide_cdrom_copy
+- Added environment variable MAX_FAILURES that, if defined, sets
+  an upper bound on the number of failures a looped test will allow
+  before aborting the test altogether (see SCHEDULER)
+- Added functionality for removing and re-adding subtests to the test scheduler (see SCHEDULER)
+- Updated README, SCHEDULER, and config files
+
+pounder21-2011-04-08:
+- LTP: Updated to LTP 20101031 release.
+- Build kernel testcase - Updated kernel from 2.6.18 to 2.6.38.
+- Updated 2.6.38 kernel source tar in pounder cache.
+- Did corresponding kernel changes i.e for 2.6.38 in "memtest" testcase too.
+- Files modified are:-
+  -$POUNDER_HOME/test_scripts/memtest.
+  -$POUNDER_HOME/test_scripts/build_kernel .
+  -$POUNDER_HOME/build_scripts/memtest.
+  -$POUNDER_HOME/build_scripts/build_kernel.
+  -$POUNDER_HOME/opt/memtest.sh. [Actually this file need to get changed in tux1 cache].
+
+pounder21-2011-04-12
+-Integrated bash-memory testcase in pounder21
+-Files added/modified are:-
+ -Copied bash-memory test case tar to pounder cache.
+ -Added file $POUNDER_HOME/build_scripts/bash-memory
+ -Added file $POUNDER_HOME/test_scripts/bash_memory
+ -Added file $POUNDER_HOME/tests/T10single/T03bashmemory
+
 pounder21-2006-11-07:
 - Fix a bug in randasys on x86-64 where we had insufficient random bits and
   would truncate whatever we got, leading to all 0 arguments by simply
diff --git a/tools/pounder21/QUICKSTART b/tools/pounder21/QUICKSTART
deleted file mode 100644
index d2a0ef4..0000000
--- a/tools/pounder21/QUICKSTART
+++ /dev/null
@@ -1,20 +0,0 @@
-Quick and Dirty Guide to Setting Up Pounder
-Copyright (C) 2003-2006 IBM.
-
-0. Install system.  gcc and related development packages are required by
-   pounder; for extra stress testing, enable X too.
-1. Download and unpack the LTP tarball.  You've already done this.
-2. cd testcases/pounder21/.  You've already done this too.
-3. Set up a NFS server to export "/pounder".
-4. Add the following to "config":
-
-export DO_X_TESTS=1
-export NFS_SERVER=<your NFS server here>
-export NTP_SERVER=pool.ntp.org
-
-5. ./Install
-6. ./pounder
-
-This should take approximately two days to run to completion.  If your machine
-hangs, you can use the magic SysRq key (if you built it into the kernel) to
-obtain debugging information, kdumps, etc.
diff --git a/tools/pounder21/README b/tools/pounder21/README
index fd5a252..6621a14 100644
--- a/tools/pounder21/README
+++ b/tools/pounder21/README
@@ -1,46 +1,211 @@
-This is pounder21, as of 2006-01-24.  Copyright (C) 2003-2006 IBM.
-The above line is used to detect the pounder release version.  If
-you change the line, be sure to update build_scripts/00checklatest.
+This is pounder30 as of 2011-08-09.  Copyright (C) 2003-2011 IBM.
+(Do not delete top line. It is used for version checking.)
+
+It would be a good idea to read this README file and the SCHEDULER and
+CONFIGURATION files (in the doc/ directory) prior to dabbling with pounder!
 
 Licensing
 =========
 All files in this tarball are licensed under the GPL.  Please see
 the file COPYING for more details.
 
-Overview
+Contents
 ========
-This package is a system stress test.
-
-Unlike the original pounder, pounder21 *does* report pass/fail and
-it is NOT infinite.  There is a -k option to kill the tests manually,
-though ^C in the pounder terminal works.  With the new scheduler,
-one can enforce an order in which tests are run, and even control
-which ones get run in parallel.  See SCHEDULER for details.
-
-There are only two prerequisites:
-
-    - Get a CD with some data on it and put in the drive.
-      This is used to test optical drives, which are typically
-      the only IDE devices on a server.
-    - Make sure you can mount an NFS server.  See libpounder.sh for
-      config details.
+1. Overview
+2. Getting Started
+3. Files and Directories
+4. The Install Script
+5. Configuration
+6. The Pounder Script
+7. Credits
 
-If you downloaded the source tarball, then do this to get started:
+Overview
+========
+Pounder provides a framework for building, running, and logging results
+for user-defined sets of tests.  Almost any test or test suite may be run
+as a subtest from within this framework, including the LTP test suite.
+(For more guidelines on building, scheduling, and running user-defined
+subtests, see doc/SCHEDULER)
+
+Getting Started
+===============
+
+Some sample test "schedules" comprised of various publically available
+tests, including LTP, are provided. The default test schedule illustrates
+how one might use pounder and is also a useful general purpose stress test.
+
+The following steps describe how to build and run the default schedule:
+
+	0. Install your operating system.  gcc and related development packages are
+		required to build pounder.  Missing dependencies will be identified at
+		build time. X development packages are needed for the included video test.
+
+	1. Download and unpack the LTP tarball.  You've already done this.
+
+	2. cd tools/pounder21/.  You've already done this too.
+
+	3. (optional) Set up a NFS server to export "/pounder21" (unless you wish 
+		to skip nfs tests).
+
+	4. (optional) Modify any variables in "config" (see doc/CONFIGURATION for details).
+
+	5. Run "make install" to build tests for your machine
+		The Install script will attempt to build all the subtests in the
+		build_scripts folder. It will prompt you for the test scheduler
+		you want to unpack. Go ahead of type "default" or simply press
+		enter. It will then ask if you want to automate skipping of
+		failed subtests. If you enter "y", the script will automatically
+		delete any subtests from the test scheduler that fail to build.
+		If you enter "n", the script will prompt you each time a test
+		fails to build on whether or not to skip the failed test.
+       
+	6. Run "./pounder" to start the tests (run "./pounder -h" for usage options).
+
+	7. Press ^C or run "./pounder -k" to stop the tests
+		The default scheduler runs tests for 48 hours, but you can set a new
+		duration in seconds by modifying config (see doc/CONFIGURATION for details)
+		or by using the -d option when starting pounder (./pounder -d <duration in seconds>)
+
+	8. Run "make mrclean" to restore everything to the state before the tarball 
+		was unpacked (running this command will of course require you to 
+		rebuild with "make install" for the next pounder run)
+
+See doc/SCHEDULER for details on defining the order in which tests are run, and whether they
+are run serially or in parallel.
+
+A few of the sample subtests have prerequisites:
+
+	- ide_cdrom_copy: Requires a CD with some data on it to be put in the drive.
+
+	- nfs, ping_nfs: Make sure you can mount an NFS server. Specify NFS in config
+		or run "./pounder -n ipaddr"
+
+	- xterm_stress: Make sure you can start X sessions. Enable X testing by setting
+		the DO_X_TESTS flag in config or run "./pounder -x"
+
+These tests can be skipped during the build phase if reqs aren't met though.
+
+Files and Directories
+=====================
+Below are brief descriptions of the files and directories found under the pounder/
+directory.
+
+Files:
+
+	CHANGELOG
+		- A log of changes made to pounder
+	COPYING
+		- GNU general public license info
+	Install
+		- The script used to build pounder
+	Makefile
+		- Makefile for pounder
+	debug.c
+		- Debugging routines used for logging pounder results
+	infinite_loop.c, timed_loop.c, fancy_timed_loop.c
+		- Procedures used to run tests repeatedly (see doc/SCHEDULER for more
+		information)
+	config
+		- Environment variables used for customizing pounder run are defined
+		here (see doc/CONFIGURATION for details)
+	libpounder.sh
+		- More environment variables defined here. Unlike the ones in config,
+		these are not meant to be modified by the user. (see doc/CONFIGURATION
+		for details)
+	nfs_logging
+		- Script that sets up user-defined NFS server for logging pounder output.
+		This script is executed when pounder is run with $NFS_LOGGING enabled in
+		config (see doc/CONFIGURATION) or when "pounder -r" is used. Normally when
+		running pounder, test output will be directly logged to $POUNDER_LOGLOCAL,
+		but with NFS logging enabled, output will instead be logged to user-specified
+		remote directory of an NFS server, $NFS_LOGSERVER:$NFS_LOGDIR.
+		See doc/CONFIGURATION for more information on these variables.
+	pounder
+		- Script used to run pounder. (see "The Pounder Script" section below
+		for details)
+	proclist.c
+		- Manages list of processes during pounder run.
+	README
+		- This file, which gives an overview of pounder's structure and how to
+		build and start pounder.
+	run.c
+		- Program to run the tests in the test scheduler.
+
+Directories:
+
+	build_scripts/
+		- Scripts to build your subtests go here. (see doc/SCHEDULER for details)
+	doc/
+		- Contains the SCHEDULER file, which describes how to create, build,
+		schedule, and run your own tests with pounder.
+		- Contains the CONFIGURATION file, which describes pounder's environment
+		variables.
+	schedulers/
+		- Test scheduler tarballs are in here. (see doc/SCHEDULER for details)
+	src/
+		- Sources packaged with pounder are in here.
+	test_repo/
+		- This directory is a copy of the default test scheduler. It provides an
+		example of what an test scheduler should look like after unpacking.
+	test_scripts/
+		- Scripts to run your subtests go here. (see doc/SCHEDULER for details)
+	tests/
+		- Symlinks to run the tests in a particular order. (see doc/SCHEDULER for
+		details)
+
+After running "make install," you will see three additional directories:
+
+	opt/
+		- Third party packages (LTP, kernel, etc) go here.
+	tmp/
+		- Temporary directory to hold files that a test needs.
+	log/
+		- Logs of output from pounder runs go here.
+
+Note that for the provided tests, third party test packages (bonnie, kernel, etc) aren't
+packaged with pounder. The build scripts should download them to opt/ (stored in
+$POUNDER_OPTDIR) and build them as necessary. The use of a cache might come in handy here
+(see doc/CONFIGURATION for details regarding the $POUNDER_CACHE variable).
 
-    1. Run "./Install" - this builds tests for your machine
-       Proceed to step 2.
+The Install Script
+==================
+The Install script has no options.  Run it to build whatever tests have been
+imported into the pounder package.
 
-If you downloaded a binary tarball, then do this to start testing:
+Configuration
+=============
+See doc/CONFIGURATION documentation file for details.
 
-    2. Run "./pounder" (see pounder script for usage options) to 
-        start the tests
+The Pounder Script
+==================
+The pounder script has the following syntax:
 
-    3. When you want to stop the tests press ^C or run "./pounder -k"
+Usage: ./pounder [-g logdir] [-x] [-d duration] [-n ipaddr] [-m max_failures] [-f] [-h|-u|-r|-k|-l|-e subtests|-i subtests|-c scheduler] [-s]
+
+-h              Brings up this menu
+-c scheduler    Creates a new test scheduler called scheduler-tests.tar.gz in the pounder/schedulers folder.
+                All subtests to be packaged with this scheduler must first be placed in the pounder/tests folder.
+-x              Enable X stress tests.
+-d duration     Run pounder for duration seconds.
+-n ipaddr       Use ipaddr for NFS tests.
+-f              Remove pounder pid file before running.
+-u              Unmount NFS log storage.
+-r              Remount NFS log storage.
+-g logdir       Use logdir as the log directory. (You probably want -s too.)
+-s              Store logs locally.
+-l              List (both included and excluded) subtests that came with the test scheduler
+-e subtests     Exclude subtests from next pounder run
+-i subtests     Include previously excluded subtests in the next pounder run
+-k              Kill pounder.
+
+run "./pounder" to run all subtests
+run "./pounder subtest" to run just one particular subtest
+        (example: ./pounder tests/T90ramp/D02build_kernel)
 
 Credits
 =======
 o Inspired by Sammy Benjamin (sammy@us.ibm.com).  None of his code remains
-  in pounder21 today.
+  in this version of pounder today.
 o Modifications and additions by members of the LTC xSeries Kernel Team:
     Darrick Wong (djwong@us.ibm.com)
     Chris McDermott (lcm@us.ibm.com)
@@ -56,6 +221,7 @@ o Modifications and additions by members of the LTC xSeries Kernel Team:
     Pradeep Kumar (pradeepkumars@in.ibm.com)
     Bhaskar Rangaswamy (bharanga@in.ibm.com)
     Manikandan Chidambaram (cmanikandan@in.ibm.com)
+    Lucy Liang (lgliang@us.ibm.com)
 o Other contributers:
 
 Also utilizes:
@@ -71,55 +237,3 @@ o schedutils, to test CPU affinity (with lame)
 
 (note that the above packages are not distributed with pounder
  and are simply installed by the installer script)
-
-Improvements in pounder2
-========================
-This iteration of pounder you're looking at has been reworked a bit.
-First, pounder environment variables are defined in libpounder.sh.
-There are a lot more of them than there used to be.
-
-Second, I've attempted to make test integration a bit easier than it
-used to be.  There are several new directories; they are detailed below.
-
-build_scripts/   Put a script to build your test in here.
-config/          Put config files for your test in here.
-src/             Sources packaged with pounder go in here.
-opt/             Third party packages (LTP, kernel, etc) go here.
-tmp/             Temporary directory for files that a test needs.
-test_scripts/    Put a script to run your test in here.
-tests/           Symlinks to run the tests in a particular order.
-                 See the SCHEDULER documentation file for details.
-log/             Logs from pounder runs go here.
-
-Like before, all the tests are run in parallel.
-
-Note that third party test packages (LTP, kernel, etc) aren't packaged
-with pounder; the build scripts should download them and build them
-as necessary.
-
-The Install Script
-==================
-The Install script has no options.  Run it to build whatever tests have been
-imported into the pounder package.
-
-Configuration
-=============
-See the Configuration section of the SCHEDULER documentation file for details.
-See libpounder.sh for the actual configuration variables.
-
-The pounder Script
-==================
-The pounder script has the following syntax:
-
-Usage: ./pounder [-l logdir] [-x] [-d duration] [-n ipaddr] [-f] [-u|-r|-k] [-s]
-
--x      Enable X stress tests.
--d      Run pounder for duration seconds.
--n      Use ipaddr for NFS tests.
--f      Remove pounder pid file before running.
--u      Unmount NFS log storage.
--r      Remount NFS log storage.
--l      Use logdir as the log directory. (You probably want -s too.)
--s      Store logs locally.
--k      Kill pounder.
-
diff --git a/tools/pounder21/SCHEDULER b/tools/pounder21/SCHEDULER
deleted file mode 100644
index 92ace7b..0000000
--- a/tools/pounder21/SCHEDULER
+++ /dev/null
@@ -1,150 +0,0 @@
-This document describes the operation and configuration of the test scheduling
-framework in the pounder2 package.  This document reflects pounder21 as of
-2004-12-20, though the scheduler isn't likely to change much.
-
-Author: Darrick Wong <djwong@us.ibm.com>
-Copyright (C) 2004 IBM.
-
-Overview
-========
-The scheduler in the original pounder release was too simplistic--it would kick
-off every test at once, simultaneously.  There was no attempt to ramp up the
-machine's stress levels test by test, or to run only certain combinations, or
-even run the tests one by one before beginning the real load testing.
-
-In addition, the test scripts had a very simple pass/fail mechanism--failure
-was defined by a kernel panic/oops/bug, and passing was defined by the lack of
-that condition.  There was no attempt to find soft failures--situations where
-a test program would fail, but without bringing the machine down.  The test
-suite would not alert the user that these failures had occurred.
-
-Consequently, Darrick Wong rewrote the test scheduling framework to achieve
-several goals--first, to separate the test automation code from the tests
-themselves, to allow for more intelligent scheduling of tests, to give better
-summary reports of what passed (and what didn't), and finally to improve the
-load testing that this suite could do.
-
-Configuration File
-==================
-The test suite's configuration file is $POUNDER_HOME/libpounder.sh.  That file
-defines several variables that are referenced throughout the rest of this 
-document.  Obviously, these variables should be customized for your particular
-machine's set up.
-
-Files
-=====
-Each test has to provide at a bare minimum, two files:
-
-build_scripts/<testname> and test_scripts/<testname>.
-
-Temporary files should go in $POUNDER_TMPDIR; source and binaries should go
-in $POUNDER_OPTDIR.
-
-Build Scripts
-=============
-As the name implies, the script in build_scripts is in charge of downloading
-and building whatever bits of code are necessary to make the test run.  The
-variable $POUNDER_CACHE defines a web-accessible directory containing cached
-tarballs of whatever it is you're trying to build.
-
-Should there be a failure in the build script that is essential to the ability
-to run a test, the build script should return 0 to halt the main build process
-immediately.
-
-Also, be aware that distributing pre-built binary tarballs is not always a good
-idea because distros are not always good at ABI/library path compatibility,
-despite the efforts of LSB, FHS, etc.  These will go away in the (very) long
-term, however.
-
-Anatomy of a Test Script
-========================
-The requirements on test scripts are pretty light.  First, the building of the
-test ought to go in the build script unless it's absolutely necessary to build
-a test component at run time.
-
-Second, the script must catch SIGTERM and clean up after itself.  SIGTERM is
-used by the test scheduler to stop tests.
-
-The third requirement is much more stringent: Return codes.  The script should
-return 0 to indicate success, 1-254 to indicate failure (the common use is to
-signify the number of failures), and -1 or 255 to indicate that the there was
-a failure that cannot be fixed.
-
-Note: If a test is being run in a timed or infinite loop, returning -1 or 255
-has the effect of cancelling all subsequent loops.
-
-Quick map of return codes to what gets reported:
-0             = "PASS"
--1            = "ABORT"
-255           = "ABORT"
-anything else = "FAIL"
-
-Also note: If a test is killed by an unhandled signal, the test is reported as
-failing.
-
-Scheduling Tests
-================
-The current test scheduler borrows a System V rc script-like structure for
-specifying how and when tests should be run.  Everything under the tests/
-directory is used for scheduling purposes; files under that tree should have
-names that follow the following standard:
-
-   [type][sequence number][name]
-
-"type" is the type of test.  Currently, there are two types, 'D' and 'T'.  'T'
-signifies a test, which means that the scheduler starts the test, waits for the
-test to complete, and reports on its exit status.  'D' signifies a daemon
-"test", which is to say that the scheduler will start the test, let it run in
-the background, and kill it when it's done running all the tests in that
-directory.
-
-The "sequence number" dictates the order in which the test are run.  00 goes
-first, 99 goes last.  Tests with the same number are started simultaneously,
-regardless of the type.
-
-"name" is just a convenient mnemonic to distinguish between tests.
-
-File system objects under the tests/ directory can be nearly anything--
-directories, symbolic links, or files.  The test scheduler will not run
-anything that doesn't have the execute bit set.  If a FS object is a
-directory, then the contents of the directory are executed sequentially.
-
-Running Tests Repeatedly
-========================
-Two helper programs are provided to run tests repeatedly:
-
-    timed_loop duration command [arguments]
-
-This program will run "command" repeated until the number of seconds given
-as "duration" has passed.
-
-    infinite_loop command [arguments]
-
-This program runs "command" repeatedly until sent SIGTERM.
-
-Examples
-========
-
-Let's examine the following test scheduler hierarchy:
-
-tests/
-    D00stats
-    T01foo
-    T01bar
-    T02dir/
-        T00gav -> ../../test_scripts/gav
-        T01hic -> ../../test_scripts/hic
-    T03lat
-
-Let's see how the tests are run.  The test scheduler will start off by scanning
-the tests/ directory.  First it spawns D00stats and lets it run in the
-background.  Next, T01foo and T01bar are launched at the same time; the
-scheduler will wait for both of them to complete before proceeding.  Since T01foo
-is a file and not just a symbolic link, there is a fair chance that T01foo runs
-some test in a loop for a certain amount of time.  In any case, the scheduler
-next sees T02dir and proceeds into it.
-
-In the T02dir/, we find two test scripts.  First T00gav runs, followed by
-T01hic.  Now there are no more tests to run in T02dir/, so the scheduler heads
-back up to the parent directory.  T03lat is forked and allowed to run to
-completion, after which D00stats is killed, and the test suite exits.
diff --git a/tools/pounder21/doc/CONFIGURATION b/tools/pounder21/doc/CONFIGURATION
new file mode 100644
index 0000000..8557ea9
--- /dev/null
+++ b/tools/pounder21/doc/CONFIGURATION
@@ -0,0 +1,107 @@
+This document describes the environment variables found in the pounder30 package
+as of 2011-8-09.
+
+Author:
+Lucy Liang <lgliang@us.ibm.com>
+	
+Copyright (C) 2011 IBM.
+
+Contents
+========
+1. The libpounder.sh File
+2. The config File
+
+The libpounder.sh File
+======================
+The "libpounder.sh" file defines most of the environment variables used in the test
+suite and referenced throughout the documentation. These variables are not
+intended to be modified by the user, although they can be if customization is desired.
+Below is a brief description of these variables (see libpounder.sh for details):
+
+	DATE			- the current date, used for logging
+	DEFAULT_SCHEDPACK	- name of the default test scheduler, "default"
+	TESTS			- list of scripts from the test_scripts/ directory
+	BUILDS			- list of scripts from the build_scripts/ directory
+	POUNDER_HOME		- the pounder/ directory
+	POUNDER_PIDFILE		- pid file created when running pounder
+	POUNDER_LOGLOCAL	- the log/ directory where output of ALL pounder runs
+				get logged
+	POUNDER_LOGDIR		- the log/$DATE directory where output of only the
+				current pounder run get logged
+	POUNDER_TMPDIR		- the tmp/ directory used for storing temporary files
+				used for test runs
+	POUNDER_OPTDIR		- the opt/ directory used for storing third party packages
+				used by subtests, which can be fetched from web or from
+				a user-created cache (see $POUNDER_CACHE below)
+	POUNDER_SRCDIR		- the src/ directory containing source files packaged with
+				pounder
+	POUNDER_VERSION		- the pounder version
+	NR_CPUS			- the number of cpus on the system
+
+The config File
+===============
+The "config" file defines a few environment variables that ARE intended to be modified
+by the user for customizing pounder runs. The variables are described below:
+
+	DURATION		- Time in seconds for pounder to run. Setting this variable
+				to 0 will not put an upper bound on pounder run time.
+
+	MAX_FAILURES		- Maximum number of test failures allowed for each subtest
+				using infinite_loop or timed_loop (see the "Running Tests Repeatedly"
+				section in SCHEDULER for more info on these two procedures) before aborting.
+				Setting this variable to 0 will not put an upper bound on any
+				subtest failures.
+
+
+	NFS_LOGGING             - Enables/disables NFS logging. Setting this variable to
+				1 will enable NFS logging of pounder output; pounder will
+                             	log output to remote directory on NFS server specified
+                                by $NFS_LOGDIR and  $NFS_LOGSERVER (see below), which
+                                will be mounted on $POUNDER_LOGLOCAL (see libpounder.sh).
+                                Setting this variable to 0 will disable this feature; all
+				output for pounder runs will be stored locally directly in
+				$POUNDER_LOGLOCAL instead.
+
+	NFS_LOGSERVER           - IP address of the NFS server to use for logging pounder results.
+				NFS_LOGGING should be enabled to use this feature.
+
+	NFS_LOGDIR		- Path to the log directory on $NFS_LOGSERVER; If $NFS_LOGGING
+				is enabled, pounder will attempt to mount $NFS_LOGSERVER:$NFS_LOGDIR/
+				on $POUNDER_LOGLOCAL (see libpounder.sh).
+
+	POUNDER_CACHE  		- Address of the cache to use for fetching outside packages,
+                        	The cache is a user-created web-accessible directory
+                        	containing cached tarballs/scripts/etc. used for
+                        	the various tests you intend to build. This is optional
+                        	but useful for saving download time and keeping everything in one place.
+
+				For instance, the build_kernel subtest requires downloading a
+				linux kernel tarball during build time (see build_scripts/build_kernel).
+				Instead of calling "wget http://www.kernel.org/pub/linux/kernel/v2.6/$TARNAME"
+				to retrieve the tarball, we can pre-download and store it in a user-created online
+				directory, then call "wget ${POUNDER_CACHE}${TARNAME}," where POUNDER_CACHE
+				is the address of the directory. Other provided subtests: bonnie++, lame, ipmitool,
+				and memtest also make use of this cache.
+
+				Examples of some things you may want to include in your cache for building
+				the provided tests:
+					bonnie++-1.03e.tgz	(for the bonnie++ subtest)
+					linux-2.6.39.tar.gz	(for the build_kernel subtest)
+					ipmitool-1.8.9.tar.gz	(for the ipmitool subtest)
+					...
+
+				These can be found in $POUNDER_OPTDIR after you run "make install" on the
+				default package.
+
+	[These variables below are used by specific subtests contained in the provided default
+	test scheduler, but they can be incorporated into other user-defined subtests as well.]
+
+	DO_X_TESTS		- 0 disables X system testing, 1 enables X system testing.
+				Used by the xterm_stress subtest.
+
+
+	NFS_SERVER=0		- IP address of the NFS server to use for nfs and ping_nfs
+				subtests. Setting this variable to 0 disables nfs testing.
+
+	NTP_SERVER		The NTP server to use. By default, it's set to pool.ntp.org.
+				Used by the time_drift subtest.
diff --git a/tools/pounder21/doc/SCHEDULER b/tools/pounder21/doc/SCHEDULER
new file mode 100644
index 0000000..2df082a
--- /dev/null
+++ b/tools/pounder21/doc/SCHEDULER
@@ -0,0 +1,352 @@
+This document describes the operation of the test scheduling framework in
+the pounder30 package.  This document reflects pounder30 as of 2011-8-09.
+
+Authors:
+Darrick Wong <djwong@us.ibm.com>
+Lucy Liang <lgliang@us.ibm.com>
+	
+Copyright (C) 2011 IBM.
+
+Contents
+========
+1. Overview
+2. Test Files
+3. Build Scripts
+4. Test Scripts
+5. Scheduling Tests
+6. Running Tests Repeatedly
+7. The Provided Test Schedulers
+8. Creating Your Own Test Scheduler
+9. Including and Excluding Tests
+
+Overview
+========
+The scheduler in the original pounder release was too simplistic--it would kick
+off every test at once, simultaneously.  There was no attempt to ramp up the
+machine's stress levels test by test, or to run only certain combinations, or
+even run the tests one by one before beginning the real load testing.
+
+In addition, the test scripts had a very simple pass/fail mechanism--failure
+was defined by a kernel panic/oops/bug, and passing was defined by the lack of
+that condition.  There was no attempt to find soft failures--situations where
+a test program would fail, but without bringing the machine down.  The test
+suite would not alert the user that these failures had occurred.
+
+Consequently, Darrick Wong rewrote the test scheduling framework to achieve
+several goals--first, to separate the test automation code from the tests
+themselves, to allow for more intelligent scheduling of tests, to give better
+summary reports of what passed (and what didn't), and finally to improve the
+load testing that this suite could do.
+
+Test Files
+==========
+Each test should only need to provide three files:
+
+1) build_scripts/<testname>
+	- The build_scripts/ directory contains scripts that take care of checking for
+	system requirements, downloading the relevant packages and binaries, and building
+	any code necessary to run the subtests. See the "Build Scripts" section below for
+	more information.
+
+2) test_scripts/<testname>
+	- The test_script/ directory contains scripts that take care of running the actual tests.
+	See the "Test Scripts" section below for more information.
+
+3) tests/.../[T|D]XX<testname>
+	- The tests/ directory represents our unpackaged "test scheduler" (if your tests/
+	directory is empty, that means you haven't unpacked any test schedulers yet and will
+	need run "make install" to unpack a scheduler - see "The Provided Test Schedulers"
+	section for more information. The test_repo/ directory also provides an example of what
+	an unpacked test scheduler should look like). The files in the tests/ directory are
+	usually symlinks that point to files in test_scripts/. The order in which the subtests are
+	run upon starting pounder depends on how the files in tests/ are named and organized.
+	See the "Scheduling Tests" section below for more information.
+
+Note: <testname> should be the same in the build_scripts/, test_scripts/, and tests/ folders.
+(Example: build_scripts/subtest1, test_scripts/subtest1, and tests/D99subtest1 would be valid.
+build_scripts/subtest1, test_scripts/subtest1_different, and tests/D99subtest1 would not.)
+See "Scheduling Tests" below for a detailed description of naming rules for files in the tests/
+directory.
+
+Build Scripts
+=============
+As the name implies, a script in build_scripts/ is in charge of downloading
+and building whatever bits of code are necessary to make the test run.
+
+Temporary files needed to run a test should go in $POUNDER_TMPDIR. Third party source,
+packages, binaries should go in $POUNDER_OPTDIR. Third party packages can be fetched
+from the web or from a user-created cache, a web-accessible directory containing
+cached tarballs and files used for whatever it is you'll need to build.
+(see "$POUNDER_CACHE" in doc/CONFIGURATION for more information)
+
+Should there be a failure in the build script that is essential to the ability
+to run a test, the build script should exit with error to halt the main build 
+process immediately.
+
+Also, be aware that distributing pre-built binary tarballs is not always a good
+idea. Though one could cache pre-built binary tarballs rather than source, it may 
+not be a good idea because distros are not always good at ABI/library path compatibility,
+despite the efforts of LSB, FHS, etc.  It is always safest to build your
+subtests from source on your target system.
+
+The build_scripts/ directory provides some examples.
+
+Test Scripts
+============
+A script in test_scripts/ is in charge of running the actual test.
+
+The requirements on test scripts are pretty light.  First, the building of the
+test ought to go in the build script unless it's absolutely necessary to build
+a test component at run time. Any checking for system requirements should also
+go in the build script.
+
+Second, the script must catch SIGTERM and clean up after itself.  SIGTERM is
+used by the test scheduler to stop tests.
+
+The third requirement is much more stringent: Return codes.  The script should
+return 0 to indicate success, 1-254 to indicate failure (the common use is to
+signify the number of failures), and -1 or 255 to indicate that the there was
+a failure that cannot be fixed.
+
+Note: If a test is being run in a timed or infinite loop (see the
+"Running Tests Repeatedly" section below for details), returning -1 or 255
+has the effect of cancelling all subsequent loops.
+
+Quick map of return codes to what gets reported:
+0             = "PASS"
+-1            = "ABORT"
+255           = "ABORT"
+anything else = "FAIL"
+
+Also note: If a test is killed by an unhandled signal, the test is reported as
+failing.
+
+Put any temporary files created during test run in $POUNDER_TMPDIR.
+
+The test_scripts/ directory provides some examples.
+
+Scheduling Tests
+================
+Everything under the tests/ directory is used for scheduling purposes. The current
+test scheduler borrows a System V rc script-like structure for specifying how and
+when tests should be run. Files under tests/ should have names that follow the this
+standard:
+
+   [type][sequence number][name]
+
+"type" is the type of test. Currently, there are two types, 'D' and 'T'.  'T'
+signifies a test, which means that the scheduler starts the test, waits for the
+test to complete, and reports on its exit status.  'D' signifies a daemon
+"test", which is to say that the scheduler will start the test, let it run in
+the background, and kill it when it's done running all the tests in that
+directory.
+
+The "sequence number" dictates the order in which the test are run. 00 goes
+first, 99 goes last.  Tests with the same number are started simultaneously,
+regardless of the type.
+
+"name" is just a convenient mnemonic to distinguish between tests. However,
+it should be the same as the corresponding name using in build_scripts and
+test_scripts. (A test with build script "build_scripts/subtest" and
+test script "test_scripts/subtest" should be defined as  something like
+"tests/T00subtest" as opposed to "tests/T00whatever_i_feel_like")
+
+Test names must be unique!
+
+File system objects under the tests/ directory can be nearly anything--
+directories, symbolic links, or files.  The test scheduler will not run
+anything that doesn't have the execute bit set.  If a FS object is a
+directory, then the contents of the directory are executed sequentially.
+
+Example:
+
+Let's examine the following test scheduler hierarchy:
+
+tests/
+    D00stats
+    T01foo
+    T01bar
+    T02dir/
+        T00gav -> ../../test_scripts/gav
+        T01hic -> ../../test_scripts/hic
+    T03lat
+
+Let's see how the tests are run.  The test scheduler will start off by scanning
+the tests/ directory.  First it spawns D00stats and lets it run in the
+background.  Next, T01foo and T01bar are launched at the same time; the
+scheduler will wait for both of them to complete before proceeding.  Since T01foo
+is a file and not just a symbolic link, there is a fair chance that T01foo runs
+some test in a loop for a certain amount of time.  In any case, the scheduler
+next sees T02dir and proceeds into it.
+
+In the T02dir/, we find two test scripts.  First T00gav runs, followed by
+T01hic.  Now there are no more tests to run in T02dir/, so the scheduler heads
+back up to the parent directory.  T03lat is forked and allowed to run to
+completion, after which D00stats is killed, and the test suite exits.
+
+Running Tests Repeatedly
+========================
+Two helper programs are provided to run tests repeatedly, timed_loop and infinite_loop.
+(This version of pounder currently also includes a fancy_timed_loop.c file, but it's only
+meant to be used for the random_syscall and will most likely be merged with timed_loop.c
+in the future, so we will ignore it here for now.)
+
+1. timed_loop
+
+    timed_loop [-m max_failures] duration_in_seconds command [arguments]
+
+This program will run "command" with the given arguments repeated
+until the number of seconds given as "duration" has passed or the
+command has failed a total of "max_failures" times, whichever comes first.
+If the $MAX_FAILURES variable is set (defined in config, see CONFIGURATION
+for details), then the program will run until command has failed a total of
+$MAX_FAILURES time (as long as it's not overridden by the -m option).
+
+2. infinite_loop
+
+    infinite_loop [-m max_failures] command [arguments]
+
+This program runs "command" repeatedly until sent SIGTERM or the
+command has failed a total of "max_failures" times. If the $MAX_FAILURES
+variable is set (defined in config, see CONFIGURATION for details), then
+the program will run until command has failed a total of $MAX_FAILURES time
+(as long as it's not overridden by the -m option).
+
+Examples:
+
+1. test_repo/T90ramp/D02build_kernel contains the following line:
+
+	"$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/build_kernel"
+
+	which will run the build_kernel test script repeatedly until sent SIGTERM
+	or until it has failed a total of $MAX_FAILURES times.
+
+	"$POUNDER_HOME/infinite_loop -m 10 $POUNDER_HOME/test_scripts/build_kernel"
+
+	would run the build_kernel test script repeatedly until sent SIGTERM or
+	until it has failed 10 times, regardless of what $MAX_FAILURES is.
+
+2. test_scripts/time_drift contains the following line:
+       
+	"$POUNDER_HOME/timed_loop 900 "$POUNDER_SRCDIR/time_tests/drift-test.py" $NTP_SERVER $FREQ"
+
+	which will run the drift-test.py script ($NTP_SERVER and $FREQ are some args passed to drift-test.py)
+	for 15 minutes or until it has failed a total of $MAX_FAILURES times.
+
+	"$POUNDER_HOME/timed_loop -m 10 900 "$POUNDER_SRCDIR/time_tests/drift-test.py" $NTP_SERVER $FREQ"
+
+	would run the drift-test.py script for 15 minutes or until it has failed 10 times, regardless of
+	what $MAX_FAILURES is.
+
+The Provided Test Schedulers
+============================
+This version of pounder provides 3 test schedulers: the "default," "fast," and "test" test schedulers.
+The tarred versions can be found in the schedulers/ directory as default-tests.tar.gz, fast-tests.tar.gz,
+and test-tests.tar.gz respectively.
+
+To unpack a test scheduler, run "make install" in the pounder/ directory and enter the name of the
+scheduler you would like to unpack at the first prompt.
+
+Example of unpacking the "fast" test scheduler:
+
+	# make install
+	./Install
+	Looking for tools...make g++ lex gcc python wget sudo diff patch egrep rm echo test which cp mkdir .
+	All tools were found.
+	WHICH TEST SCHEDULER SETUP DO YOU WANT TO UNPACK?
+	[Choose from:
+	default-tests.tar.gz
+	fast-tests.tar.gz
+	test-tests.tar.gz]
+	[Or simply press ENTER for the default scheduler]
+	Scheduler selection: fast
+
+Descriptions of the provided test schedulers:
+
+1. default - provides a general purpose stress test, runs for 48 hours unless the -d option
+		is used when starting pounder.
+2. fast - basically the same as default, except it runs for 12 hours by default.
+3. test - provides a set of useless tests. Each test simply passes, fails, aborts, or sleeps for
+		some period of time. They don't do anything useful but can be used to see how
+		the test scheduling setup works.
+
+Creating Your Own Test Schedulers
+=================================
+From the pounder directory, place the desired tests in the tests/ directory according to
+the rules described in the "Scheduling Tests" section above. Then run the following command:
+
+./pounder -c name_of_scheduler
+
+to create a new test scheduler, which will be tarred as name_of_scheduler-tests.tar.gz and
+placed in the schedulers/ directory.
+
+Example Usage:
+
+	# ls ./schedulers
+	default-tests.tar.gz  fast-tests.tar.gz     test-tests.tar.gz
+
+	# ls ./tests
+	T00hwinfo
+
+	# ./pounder -c new_sched
+
+	# ls ./schedulers
+	default-tests.tar.gz  fast-tests.tar.gz     new_sched-tests.tar.gz      test-tests.tar.gz
+
+	After unpacking the "new_sched" test scheduler during install, the tests/ directory should
+	contain the T00hwinfo subtest along with a tests/excluded/ directory (see the "Including and
+	Excluding Tests" section below for details regarding the tests/excluded directory).
+
+Including and Excluding Tests
+=============================
+After unpacking the test scheduler and building each individual test, running
+"./pounder" will automatically run every test included in the tests folder. If you
+would like to run only ONE test, run "./pounder ./tests/<some subtest>". If you would
+like to run a portion of tests, you can use the "./pounder -e" option to exclude
+certain subtests from subsequent pounder runs:
+
+Example:
+
+Suppose you have already ran "make install" and unpacked the default test scheduler.
+The tests/ directory should now contain the subtests to be run
+
+1) ./pounder -l
+	- lists all of the subtests that came with the currently active test scheduler.
+	The output should look something like:
+
+	------------------	
+	#./pounder -l
+	Included subtests:
+	...
+	.../ltp-full-xxxxxxxx/tools/pounder/tests/T10single/T00xterm_stress
+	.../ltp-full-xxxxxxxx/tools/pounder/tests/T00hwinfo
+	...
+
+	Excluded subtests:
+	[NONE]
+	------------------
+
+2) ./pounder -e "tests/T10single/T00xterm_stress tests/T00hwinfo"
+	- will exclude T00xterm_stress and T00hwinfo from any subsequent pounder runs.
+	This command essentially moves the two tests from the "tests" folder to the
+	"tests/excluded" folder for temporary storage, where they will remain until
+	re-included back into the test scheduler (this is also why all test names
+	should be unique). A file "tests/excluded/testlist" keeps track of which tests
+	have been excluded from the test scheduler and what their original paths were.
+
+3) ./pounder -l
+	- should now output something like:
+
+	------------------
+	#./pounder -l
+	Included subtests:
+	...
+
+	Excluded subtests:
+	T00xterm_stress
+	T00hwinfo
+	------------------
+
+4) ./pounder -i "T00xterm_stress T00hwinfo" - will re-include these subtests back into
+	the test scheduler. They will be moved from the tests/excluded folder back into
+	the tests folder under their original paths.

--------------1.7.4.1--



------------------------------------------------------------------------------
FREE DOWNLOAD - uberSVN with Social Coding for Subversion.
Subversion made easy with a complete admin console. Easy 
to use, easy to manage, easy to install, easy to extend. 
Get a Free download of the new open ALM Subversion platform now.
http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
