From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 24 Sep 2018 10:51:50 +0200
Subject: [LTP] [RFC PATCH 3/3] Remove cron tests
In-Reply-To: <20180924085150.17555-1-pvorel@suse.cz>
References: <20180924085150.17555-1-pvorel@suse.cz>
Message-ID: <20180924085150.17555-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Removing them as they don't really fit into "kernel testing",
it'd be better to have them in some "LTP userspace" project.

+ remove admin_tools runtest file which run them (as a part of EAL2
testsuite).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/admin_tools                           |   9 -
 runtest/commands                              |   1 -
 scenario_groups/default                       |   1 -
 testcases/commands/.gitignore                 |   1 -
 testcases/commands/cron/00_Descriptions.txt   |   4 -
 testcases/commands/cron/Makefile              |  29 --
 testcases/commands/cron/README.tests          |  25 --
 testcases/commands/cron/cron02                |  80 -----
 testcases/commands/cron/cron03                |  83 ------
 testcases/commands/cron/cron_allow01          | 202 -------------
 testcases/commands/cron/cron_deny01           | 192 ------------
 testcases/commands/cron/cron_dirs_check.c     |  44 ---
 testcases/commands/cron/cron_dirs_checks01    |  46 ---
 .../commands/cron/cron_illegal_cron_lines     |  39 ---
 testcases/commands/cron/cron_neg_tests.sh     | 141 ---------
 testcases/commands/cron/cron_pos_tests.sh     | 118 --------
 testcases/commands/cron/cron_tests.sh         | 276 ------------------
 17 files changed, 1291 deletions(-)
 delete mode 100644 runtest/admin_tools
 delete mode 100644 testcases/commands/cron/00_Descriptions.txt
 delete mode 100644 testcases/commands/cron/Makefile
 delete mode 100644 testcases/commands/cron/README.tests
 delete mode 100755 testcases/commands/cron/cron02
 delete mode 100755 testcases/commands/cron/cron03
 delete mode 100755 testcases/commands/cron/cron_allow01
 delete mode 100755 testcases/commands/cron/cron_deny01
 delete mode 100644 testcases/commands/cron/cron_dirs_check.c
 delete mode 100755 testcases/commands/cron/cron_dirs_checks01
 delete mode 100644 testcases/commands/cron/cron_illegal_cron_lines
 delete mode 100755 testcases/commands/cron/cron_neg_tests.sh
 delete mode 100755 testcases/commands/cron/cron_pos_tests.sh
 delete mode 100644 testcases/commands/cron/cron_tests.sh

diff --git a/runtest/admin_tools b/runtest/admin_tools
deleted file mode 100644
index 0a46468c8..000000000
--- a/runtest/admin_tools
+++ /dev/null
@@ -1,9 +0,0 @@
-su01 export TCbin=$LTPROOT/testcases/bin;su01
-#cron01 cron01
-cron02 cron02
-cron_deny01 cron_deny01
-cron_allow01 cron_allow01
-cron_dirs_checks01 cron_dirs_checks01
-at_deny01 at_deny01
-at_allow01 at_allow01
-acl_test01 acl_test01
diff --git a/runtest/commands b/runtest/commands
index ee7e9f440..462633017 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -5,7 +5,6 @@ ldd01 ldd01
 nm01 nm01
 file01 file01.sh
 tar01  tar_tests.sh
-cron cron_tests.sh
 logrotate export TCdat=$LTPROOT/testcases/bin; logrotate_tests.sh
 cpio01 cpio_tests.sh
 unzip01 unzip01.sh
diff --git a/scenario_groups/default b/scenario_groups/default
index 5658a618b..b1739b77e 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -17,7 +17,6 @@ filecaps
 cap_bounds
 fcntl-locktests
 connectors
-admin_tools
 timers
 power_management_tests
 numa
diff --git a/testcases/commands/.gitignore b/testcases/commands/.gitignore
index 9aa1caf6c..0ed343881 100644
--- a/testcases/commands/.gitignore
+++ b/testcases/commands/.gitignore
@@ -1,5 +1,4 @@
 /ldd/datafiles/lddfile.out
 /ldd/datafiles/*.obj.so
-/cron/cron_dirs_check
 /eject/eject_check_tray
 /insmod/ltp_insmod01.ko
diff --git a/testcases/commands/cron/00_Descriptions.txt b/testcases/commands/cron/00_Descriptions.txt
deleted file mode 100644
index 9566e0aaa..000000000
--- a/testcases/commands/cron/00_Descriptions.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-cron01
-	Test that crontab <filename> installs the cron-job-file and cron will
-	schedule the job correctly.
-
diff --git a/testcases/commands/cron/Makefile b/testcases/commands/cron/Makefile
deleted file mode 100644
index 4969ec7bb..000000000
--- a/testcases/commands/cron/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    commands/cron testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= cron0[23] cron_illegal_cron_lines cron_allow01 cron_deny01 cron_dirs_checks01 *.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/cron/README.tests b/testcases/commands/cron/README.tests
deleted file mode 100644
index 0d5db7113..000000000
--- a/testcases/commands/cron/README.tests
+++ /dev/null
@@ -1,25 +0,0 @@
-This directory contains two scripts and one data file to test cron. Both
-shouldn't be run as root but they warn for themselves. If a username is
-given as parameter they run as this user.
-
-Both scripts save the current crontab and restore it after finishing.
-
-* Positive tests
-
-	cron_pos_tests.sh [username]
-
-	- add new job
-	- check correct execution of job
-	- delete job
-
-* Negative tests
-
-	cron_neg_tests.sh [username]
-
-	- try to edit the crontab of root
-	- try to set illegal or nondefined execution times
-	  Here the script uses file illegal_cron_lines which contains two
-	  fields per line: the cron line to be tested (without script name),
-	  and the description of this test. The description is written to
-	  stdout during execution of the test.
-	- try to do things you aren't allowed as non-root (cron runs as root)
diff --git a/testcases/commands/cron/cron02 b/testcases/commands/cron/cron02
deleted file mode 100755
index 16b425de3..000000000
--- a/testcases/commands/cron/cron02
+++ /dev/null
@@ -1,80 +0,0 @@
-#!/bin/sh
-#*********************************************************************
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#  FILE   : cron02
-#
-#  PURPOSE: Test a postive cron job
-#			- add new job
-#   		- check correct execution of job
-#   		- delete job
-#
-#  HISTORY:
-#     	SUSE
-#
-
-TEST_USER="c01_user"
-TEST_USER_GROUP="users"
-TEST_USER_HOMEDIR="/home/$TEST_USER"
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup(){
-	#erase any data from potential defunt cron test
-	rm -rf /tmp/crontest > /dev/null 2>&1
-
-    #erase user if he may exist , so we can have a clean env
-        rm -rf /home/$TEST_USER
-        userdel $TEST_USER
-	sleep 1
-
-        useradd -m -g $TEST_USER_GROUP $TEST_USER
-        if [ $? != 0 ]
-        then {
-                echo "Could not add test user $TEST_USER to system $RHOST."
-                exit 1
-        }
-        fi
-
-	if [ -n "$CROND_DAEMON" ]; then
-		restart_daemon $CROND_DAEMON
-	else
-		tst_brkm TBROK "Couldn't find crond or cron"
-	fi
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
-
-do_cleanup(){
-        rm -rf /home/$TEST_USER
-        userdel $TEST_USER
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  MAIN
-#-----------------------------------------------------------------------
-. cmdlib.sh
-
-do_setup
-cron_pos_tests.sh $TEST_USER
-EXIT_CODE=$?
-do_cleanup
-exit $EXIT_CODE
diff --git a/testcases/commands/cron/cron03 b/testcases/commands/cron/cron03
deleted file mode 100755
index 7ba7bf40c..000000000
--- a/testcases/commands/cron/cron03
+++ /dev/null
@@ -1,83 +0,0 @@
-#!/bin/sh
-#*********************************************************************
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#  FILE   : cron
-#
-#  PURPOSE: Test a bad (negative) cron job
-#			- try to edit the crontab of root
-#   		- try to set illegal or nondefined execution times
-#      	 	  Here the script uses file illegal_cron_lines which contains two
-#      		  fields per line: the cron line to be tested (without script name),
-#      		  and the description of this test. The description is written to
-#      		  stdout during execution of the test.
-#    		- try to do things you aren't allowed as non-root (cron runs as root)
-
-#
-#  HISTORY:
-#     	SUSE
-#
-
-
-TEST_USER="c02_user"
-TEST_USER_GROUP="users"
-TEST_USER_HOMEDIR="/home/$TEST_USER"
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup(){
-
-    #erase user if he may exist , so we can have a clean env
-        rm -rf /home/$TEST_USER
-        userdel $TEST_USER
-	sleep 1
-
-        useradd -m -g $TEST_USER_GROUP $TEST_USER
-        if [ $? != 0 ]
-        then {
-                echo "Could not add test user $TEST_USER to system $RHOST."
-                exit 1
-        }
-        fi
-        # restart cron daemon
-	# Red Hat uses crond, SuSE/Other uses cron.
-	if [ -f /etc/init.d/crond ]; then
-		/etc/init.d/crond restart
-	else
-		/etc/init.d/cron restart
-	fi
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
-
-do_cleanup(){
-        rm -rf /home/$TEST_USER
-        userdel $TEST_USER
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  MAIN
-#-----------------------------------------------------------------------
-do_setup
-cron_neg_tests.sh $TEST_USER
-EXIT_CODE=$?
-do_cleanup
-exit $EXIT_CODE
diff --git a/testcases/commands/cron/cron_allow01 b/testcases/commands/cron/cron_allow01
deleted file mode 100755
index 9a5e4d240..000000000
--- a/testcases/commands/cron/cron_allow01
+++ /dev/null
@@ -1,202 +0,0 @@
-#!/bin/bash
-#
-#   Copyright (c) International Business Machines  Corp., 2003
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#	FILE: /var/spool/cron/allow
-#
-#	PURPOSE: Test that /var/spool/cron/allow , only allows those in the file to run cron jobs.
-#
-#	HISTORY:
-#		04/03 Jerone Young (jyoung5@us.ibm.com)
-#
-
-echo "This script contains bashism that needs to be fixed!"
-
-iam=`whoami`
-
-tvar=${MACHTYPE%-*}
-tvar=${tvar#*-}
-
-if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ]
-then
-CRON_ALLOW="/etc/cron.allow"
-else
-CRON_ALLOW="/var/spool/cron/allow"
-fi
-
-TEST_USER1="ca_user1"
-TEST_USER1_HOME="/home/$TEST_USER1"
-TEST_USER2="ca_user2"
-TEST_USER2_HOME="/home/$TEST_USER2"
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup() {
-	#move any files that may get in the way
-	rm /tmp/cron_allow_test > /dev/null 2>&1
-	rm /tmp/cron_allow_test1 > /dev/null 2>&1
-	mv $CRON_ALLOW $CRON_ALLOW.old > /dev/null 2>&1
-
-	#remove users for clean enviroment
-    su $TEST_USER1 -c "crontab -r"
-    su $TEST_USER2 -c "crontab -r"
-        rm -rf /home/$TEST_USER1
-        rm -rf /home/$TEST_USER2
-	userdel $TEST_USER1
-	userdel $TEST_USER2
-	sleep 1
-
-#create 1st user
-	useradd -m -g users $TEST_USER1
-	if [ $? != 0 ]
-    then {
-        echo "Could not add test user $TEST_USER1 to system."
-        exit 1
-    }
-    fi
-
-#create 2nd user
-	useradd -m -g users $TEST_USER2
-    if [ $? != 0 ]
-    then {
-        echo "Could not add test user $TEST_USER2 to system."
-        exit 1
-    }
-    fi
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
-do_cleanup(){
-    su $TEST_USER1 -c "crontab -r"
-    su $TEST_USER2 -c "crontab -r"
-        rm -rf /home/$TEST_USER1
-        rm -rf /home/$TEST_USER2
-	userdel $TEST_USER1
-	userdel $TEST_USER2
-	rm $CRON_ALLOW
-	mv $CRON_ALLOW.old $CRON_ALLOW > /dev/null 2>&1
-	rm /tmp/cron_allow_test >/dev/null 2>&1
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  run_test
-#-----------------------------------------------------------------------
-run_test() {
-
-if [ $iam = $TEST_USER1 ]
-then
-	echo "TEST: $CRON_ALLOW should only allow those in the file to
-run cron jobs."
-
-	echo "(1) TEST THAT PERSON IN $CRON_ALLOW IS ABLE TO RUN JOB."
-
-	echo "backup crontab...."
-    crontab -l | grep '^[^#]' > /tmp/crontab-cronallow-save-$iam
-
-	crontab - << EOF
-        `date '+%M' | awk '{ORS=""; print ($1+2)%60 " * * * * "}'` echo "TEST JOB RAN" >> /tmp/cron_allow_test 2>&1
-EOF
-	if [ $? != 0 ]; then
-	echo Error while adding crontab for user $TEST_USER1
-	exit 1
-	fi
-
-	echo "sleeping for 130 seconds...."
-	sleep 130
-
-	EXIT_CODE=1
-	test -e /tmp/cron_allow_test && EXIT_CODE=0
-
-	if [ $EXIT_CODE = 1 ]; then
-		echo "Cron did not allow user to execute job , TEST FAILED"
-	else
-		echo "Cron allowed user to execute test job, TEST PASSED"
-	fi
-
-	 echo "restore old crontab..."
-     crontab /tmp/crontab-cronallow-save-$iam
-     rm -f /tmp/crontab-cronallow-save-$iam
-
-
-	rm -f /tmp/cron_allow_test
-
-	exit $EXIT_CODE
-fi
-
-if [ $iam = $TEST_USER2 ]
-then
-        echo "(2) TEST THAT PERSON NOT IN $CRON_ALLOW IS NOT ABLE TO RUN JOB."
-
-		echo "backup crontab...."
-    	crontab -l | grep '^[^#]' > /tmp/crontab-cronallow-save-$iam
-
-        crontab - << EOF
-        `date '+%M' | awk '{ORS=""; print ($1+2)%60 " * * * * "}'` echo "TEST JOB RAN" >> /tmp/cron_allow_test1 2>&1
-EOF
-        if [ $? != 0 ]; then
-        echo Error while adding crontab for user $TEST_USER2
-        fi
-
-        echo "sleeping for 130 seconds...."
-        sleep 130
-
-        EXIT_CODE=0
-        test -e /tmp/cron_allow_test1 && EXIT_CODE=1
-
-        if [ $EXIT_CODE = 0 ]; then
-                echo "Cron did not allow user to execute job , TEST PASSED"
-        else
-                echo "Cron allowed user to execute test job, TEST FAILED"
-        fi
-
-		echo "restore old crontab..."
-     	crontab /tmp/crontab-cronallow-save-$iam
-     	rm -f /tmp/crontab-cronallow-save-$iam
-
-        rm -f /tmp/cron_allow_test1
-
-        exit $EXIT_CODE
-fi
-
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION: main
-#-----------------------------------------------------------------------
-if [ $iam = "root" ]
-then
-	do_setup
-	echo $TEST_USER1 > $CRON_ALLOW
-	EXIT_CODE=0
-	su $TEST_USER1 -c "$0"
-	if [ $? != 0 ]
-	then
-	   EXIT_CODE=1
-	fi
-	su $TEST_USER2 -c "$0"
-	if [ $? != 0 ]
-	then EXIT_CODE=1
-	fi
-	do_cleanup
-	exit $EXIT_CODE
-else
-	run_test
-fi
diff --git a/testcases/commands/cron/cron_deny01 b/testcases/commands/cron/cron_deny01
deleted file mode 100755
index 9d3203925..000000000
--- a/testcases/commands/cron/cron_deny01
+++ /dev/null
@@ -1,192 +0,0 @@
-#!/bin/bash
-#
-#   Copyright (c) International Business Machines  Corp., 2003
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#	FILE: /var/spool/cron/allow
-#
-#	PURPOSE: Test that /var/spool/cron/deny , does not allow those in the file to run cron jobs.
-#
-#	HISTORY:
-#		04/03 Jerone Young (jyoung5@us.ibm.com)
-#
-
-echo "This script contains bashism that needs to be fixed!"
-
-iam=`whoami`
-
-tvar=${MACHTYPE%-*}
-tvar=${tvar#*-}
-
-if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ]
-then
-CRON_DENY="/etc/cron.deny"
-CRON_ALLOW="/etc/cron.allow"
-else
-CRON_DENY="/var/spool/cron/deny"
-CRON_ALLOW="/var/spool/cron/allow"
-fi
-
-TEST_USER1="cd_user1"
-TEST_USER1_HOME="/home/$TEST_USER1"
-TEST_USER2="cd_user2"
-TEST_USER2_HOME="/home/$TEST_USER2"
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup() {
-	#move any files that may get in the way
-	rm /tmp/cron_deny_test > /dev/null 2>&1
-        rm /tmp/cron_deny_test1 > /dev/null 2>&1
-
-	mv $CRON_DENY $CRON_DENY.old > /dev/null 2>&1
-	mv $CRON_ALLOW $CRON_ALLOW.old > /dev/null 2>&1
-
-	#remove users for clean enviroment
-    su $TEST_USER1 -c "crontab -r"
-    su $TEST_USER2 -c "crontab -r"
-        rm -rf /home/$TEST_USER1
-        rm -rf /home/$TEST_USER2
-	userdel $TEST_USER1
-	userdel $TEST_USER2
-	sleep 1
-
-#create 1st user
-	useradd -m -g users $TEST_USER1
-	if [ $? != 0 ]
-    then {
-        echo "Could not add test user $TEST_USER1 to system."
-        exit 1
-    }
-    fi
-
-#create 2nd user
-	useradd -m -g users $TEST_USER2
-    if [ $? != 0 ]
-    then {
-        echo "Could not add test user $TEST_USER2 to system."
-        exit 1
-    }
-    fi
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
-do_cleanup(){
-    su $TEST_USER1 -c "crontab -r"
-    su $TEST_USER2 -c "crontab -r"
-        rm -rf /home/$TEST_USER1
-        rm -rf /home/$TEST_USER2
-	userdel $TEST_USER1
-	userdel $TEST_USER2
-	rm $CRON_DENY
-	mv $CRON_DENY.old $CRON_DENY > /dev/null 2>&1
-	mv $CRON_ALLOW.old $CRON_ALLOW > /dev/null 2>&1
-	rm /tmp/cron_allow_test >/dev/null 2>&1
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  run_test
-#-----------------------------------------------------------------------
-run_test() {
-
-if [ $iam = $TEST_USER1 ]
-then
-	echo "TEST: $CRON_DENY should allow only allow those who are not in the file to
-run cron jobs."
-
-	echo "(1) TEST THAT PERSON NOT IN $CRON_DENY IS ABLE TO RUN JOB."
-
-	crontab - << EOF
-	`date '+%M' | awk '{ORS=""; print ($1+2)%60" * * * * "}'` echo "TEST JOB RAN" >> /tmp/cron_deny_test 2>&1
-EOF
-	if [ $? != 0 ]; then
-	echo Error while adding crontab for user $TEST_USER1
-	exit 1
-	fi
-
-	echo "sleeping for 130 seconds...."
-	sleep 130
-
-	EXIT_CODE=1
-	test -e /tmp/cron_deny_test && EXIT_CODE=0
-
-	if [ $EXIT_CODE = 1 ]; then
-		echo "Cron did not allow user to execute job , TEST FAILED"
-	else
-		echo "Cron allowed user to execute test job, TEST PASSED"
-	fi
-
-	rm -f /tmp/cron_deny_test
-
-	exit $EXIT_CODE
-fi
-
-if [ $iam = $TEST_USER2 ]
-then
-        echo "(2) TEST THAT PERSON IN $CRON_DENY IS NOT ABLE TO RUN JOB."
-
-        crontab - << EOF
-        `date '+%M' | awk '{ORS=""; print ($1+2)%60 " * * * * "}'` echo "TEST JOB RAN" >> /tmp/cron_deny_test 2>&1
-EOF
-        if [ $? != 0 ]; then
-        echo Error while adding crontab for user $TEST_USER2
-        fi
-
-        echo "sleeping for 130 seconds...."
-        sleep 130
-
-        EXIT_CODE=0
-        test -e /tmp/cron_deny_test1 && EXIT_CODE=1
-
-        if [ $EXIT_CODE = 0 ]; then
-                echo "Cron did not allow user to execute job , TEST PASSED"
-        else
-                echo "Cron allowed user to execute test job, TEST FAILED"
-        fi
-
-        rm -f /tmp/cron_deny_test1
-
-        exit $EXIT_CODE
-fi
-
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION: main
-#-----------------------------------------------------------------------
-if [ $iam = "root" ]
-then
-	do_setup
-	echo $TEST_USER2 > $CRON_DENY
-	EXIT_CODE=0
-	su $TEST_USER1 -c "$0"
-	if [ $? != 0 ]
-	then
-	   EXIT_CODE=1
-	fi
-	su $TEST_USER2 -c "$0"
-	if [ $? != 0 ]
-	then EXIT_CODE=1
-	fi
-	do_cleanup
-	exit $EXIT_CODE
-else
-	run_test
-fi
diff --git a/testcases/commands/cron/cron_dirs_check.c b/testcases/commands/cron/cron_dirs_check.c
deleted file mode 100644
index cc9e0ad25..000000000
--- a/testcases/commands/cron/cron_dirs_check.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include <sys/types.h>
-#include <sys/param.h>
-#include <sys/stat.h>
-#include <stdio.h>
-#include <unistd.h>
-
-/* Check directory Access */
-int check_directory_access(char *directory)
-{
-
-	struct stat statbuf;
-
-	printf("Checking %s\n", directory);
-
-	if (stat(directory, &statbuf) == -1) {
-		printf("FAIL: %s. Could not obtain directory status\n",
-		       directory);
-		return 1;
-	}
-
-	if (statbuf.st_uid != 0) {
-		printf("FAIL: %s. Invalid owner\n", directory);
-		return 1;
-	}
-
-	if ((statbuf.st_mode & S_IWGRP) || (statbuf.st_mode & S_IWOTH)) {
-		printf("FAIL: %s. Invalid write access\n", directory);
-		return 1;
-	}
-
-	printf("PASS: %s\n", directory);
-	return 0;
-}
-
-int main(int argc, char *argv[])
-{
-
-	if (argc != 2) {
-		printf("Please enter target directory");
-		return 1;
-	}
-
-	return check_directory_access(argv[1]);
-}
diff --git a/testcases/commands/cron/cron_dirs_checks01 b/testcases/commands/cron/cron_dirs_checks01
deleted file mode 100755
index ea1215e8d..000000000
--- a/testcases/commands/cron/cron_dirs_checks01
+++ /dev/null
@@ -1,46 +0,0 @@
-#!/bin/sh
-#*********************************************************************
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#  FILE   : cron
-#
-#  PUROPOSE: Ensure that the following directories only have root write access
-#			/etc/cron.d
-#			/etc/cron.daily
-#			/etc/cron.hourly
-#			/etc/cron.monthly
-#			/etc/cron.weekly
-#			/var/spool/cron
-#	HISTORY:
-#		Jerone Young (jyoung5@us.ibm.com)
-#
-
-DIRS="/etc/cron.d /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly /var/spool/cron"
-
-EXIT_CODE=0
-for i in $DIRS
-do
-	cron_dirs_check $i
-	if [ $? != 0 ]
-	then
-		echo "$i FAILED TEST!!!!!"
-		EXIT_CODE=1
-	fi
-
-done
-
-exit $EXIT_CODE
diff --git a/testcases/commands/cron/cron_illegal_cron_lines b/testcases/commands/cron/cron_illegal_cron_lines
deleted file mode 100644
index 3b32dc844..000000000
--- a/testcases/commands/cron/cron_illegal_cron_lines
+++ /dev/null
@@ -1,39 +0,0 @@
-# Collection of illegal cron lines
-# Comment lines must habe its '#' as first character.
-# The cron conf line and its description is seperated by '|'.
-# cron job command 'true' is appended automatically
-
-# Illegal Minutes
-61 * * * * | Minute 61
--1 * * * * | Minute -1 (might be interpreted as range)
-0.5 * * * * | Minute 0.5
--1-10 * * * *| Minute Range -1-10
-0-61 * * * * | Minute Range 0-61
-
-# Illegal hours
-0 25 * * * | Hour 25
-0 -2 * * * | Hour -2
-0 3.5 * * *| Hour 3.5
-0 -4-10 * * *| Hour Range -4-10
-0 0-25 * * * | Hour Range 0-25
-
-# Illegal day of month
-0 0 32 * * | Day 32
-0 0 -1 * * | Day -1
-0 0 3.5 * *| Day 3.5
-0 0 -3-3 * *| Day Range -3-3
-0 0 0-32 * *| Day Range 0-32
-
-# Illegal month
-0 0 1 13 * | Month 13
-0 0 1 -1 * | Month -1
-0 0 1 2.5 * | Month 2.5
-0 0 1 -2-3 * | Month Range -2-3
-0 0 1 0-13 * | Month Range 0-13
-
-# Illegal day of week
-0 0 * * 8 | Day of Week 8
-0 0 * * -2 | Day of Week -2
-0 0 * * 2.5 | Day of Week 2.5
-0 0 * * -7-7 | Day of Week Range -7-7
-0 0 * * 0-8 | Day of Week Range 0-8
diff --git a/testcases/commands/cron/cron_neg_tests.sh b/testcases/commands/cron/cron_neg_tests.sh
deleted file mode 100755
index 9c3d6f6c7..000000000
--- a/testcases/commands/cron/cron_neg_tests.sh
+++ /dev/null
@@ -1,141 +0,0 @@
-#!/bin/bash
-########################################################
-#
-# CHANGE ACTIVITY
-#
-#    10/01/04  Kris Wilson    RHEL4 only allows super user
-#                               to use crontab.
-#                               to use crontab.
-#    12/03/04  Marty Ridgeway Pull RHEl4 tests out from script
-########################################################
-
-iam=`whoami`
-
-if [ $iam = "root" ]; then
-	if [ $# -lt 1 ] ; then
-		echo Either do not run this script as root or start it like
-		echo "  $0 <user>"
-		exit 1
-	fi
-
-	su $1 -c "$0 $*"
-	exit $?
-fi
-
-#
-# 1. root einen cronjob unterjubeln
-#
-
-finalrc=0
-
-
-crontab -u root - << EOF
-0 * * * * true
-EOF
-
-rc=$?
-
-if [ $rc = "0" ]; then
-	echo root has now an interesting cron job
-	echo "crontab has a severe security breach (FAIL)"
-	echo
-	finalrc=1
-else
-	echo "Editing a crontab of another user failed successfully (PASS)"
-	echo
-fi
-
-
-#
-# 2. write some illegal crontabs
-#
-
-# Save crontab
-
-#crontab -l > /dev/null 2> /dev/null
-#if [ $? = "0" ]; then
-#	echo Saving current crontab...
-#	echo
-#	crontab -l > /tmp/save-crontab-`whoami`
-#	savedcrontab=1
-#	crontab -r
-#fi
-
-#for line in `cat cron_illegal_cron_lines | grep '^[^#]' | sed -e 's/[ \t][ \t]*/_/g'` ; do
-#	line=`echo $line | sed -e 's/_/ /g'`
-	# echo Line: "$line"
-#	cronconf=`echo "$line" | cut -f 1 -d '|'`
-#	desc=`echo "$line" | cut -f 2 -d '|'`
-
-#	echo "Test: $desc"
-#	echo "$cronconf true" | crontab -
-	# echo "$cronconf"
-#	if [ $? = "0" ]; then
-#		echo 'Test FAILED (or crontab returned wrong exit code)'
-#		echo 'crontab -l:'
-#		crontab -l
-#		finalrc=1
-#	fi
-#	echo
-#done
-
-
-# Test whether cron uses setuid correctly
-
-echo
-echo setuid test
-echo
-
-tmpscript=cron_neg01_test
-rm -rf $tmpscript.out >/dev/null 2>&1
-
-
-cat > /tmp/$tmpscript << EOF
-touch /root/halloichwarhier
-sleep 1
-cat /root/halloichwarhier ; echo "res:$?"
-rm /root/halloichwarhier
-EOF
-
-chmod 755 /tmp/$tmpscript
-
-#
-cronline=`date '+%M' | awk '{print ($1+2)%60 " * * * * "}'`
-(echo "$cronline /tmp/$tmpscript >> /tmp/$tmpscript.out 2>> /tmp/$tmpscript.out" ; \
- echo "$cronline /tmp/$tmpscript >> /$tmpscript.out 2>> /$tmpscript.out") \
- | crontab -
-
-echo "sleeping 130 secs..."
-sleep 130
-
-echo
-echo "Results:"
-if [ "1" = `cat /tmp/$tmpscript.out | grep "res:0" | wc -l` ]; then
-	echo "setuid test part 1 successfully failed (PASS)"
-else
-	echo "cron executed scripts have root privileges! (FAIL)"
-	finalrc=1
-fi
-
-CODE=0
-test -e /tmp/$tmpscript.out && CODE=1
-if [ $CODE = "1" ]; then
-	echo "setuid test part 2 successfully failed (PASS)"
-else
-	echo "cron writes script output with root privileges! (FAIL)"
-	finalrc=1
-fi
-echo
-
-rm /tmp/$tmpscript* >/dev/null 2>&1
-crontab -r
-
-# Restore crontab
-
-if [ "$savedcrontab" = "1" ]; then
-	echo "Restoring crontab..."
-	cat /tmp/save-crontab-`whoami` | grep '^[^#]' | crontab -
-	# rm -r /tmp/save-crontab-`whoami`
-fi
-
-exit $finalrc
diff --git a/testcases/commands/cron/cron_pos_tests.sh b/testcases/commands/cron/cron_pos_tests.sh
deleted file mode 100755
index ece114c84..000000000
--- a/testcases/commands/cron/cron_pos_tests.sh
+++ /dev/null
@@ -1,118 +0,0 @@
-#!/bin/bash
-
-# Positive tests for cron, that means these tests have to pass
-
-iam=`whoami`
-
-tvar=${MACHTYPE%-*}
-tvar=${tvar#*-}
-
-if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ]
-then
-	CRON_ALLOW="/etc/cron.allow"
-else
-	CRON_ALLOW="/var/spool/cron/allow"
-fi
-
-
-if [ $iam = "root" ]; then
-	if [ $# -lt 1 ] ; then
-		echo Either do not run this script as root or start it like
-		echo "  $0 <user>"
-		exit 1
-	fi
-
-	mv $CRON_ALLOW $CRON_ALLOW.old >/dev/null 2>&1
-	su $1 -c "$0 $*"
-        RC=$?
-	mv $CRON_ALLOW.old $CRON_ALLOW >/dev/null 2>&1
-	exit $RC
-fi
-
-function restorecrontab () {
-	test -e /tmp/crontab-save-$iam && \
-		crontab /tmp/crontab-save-$iam && \
-		rm -f /tmp/crontab-save-$iam && \
-		echo restored old crontab
-}
-
-echo Running as user $iam...
-
-# Save current users crontab
-
-test -e /tmp/crontab-save-$iam && rm -f /tmp/crontab-save-$iam
-
-if [ "0" -lt `crontab -l 2>/dev/null | wc -l` ]; then
-
-	echo 'crontab of this user exists -> creating backup'
-	crontab -l | grep '^[^#]' > /tmp/crontab-save-$iam
-fi
-
-
-# Do tests
-
-# 1. Add new job
-
-rm -rf /tmp/crontest >/dev/null 2>&1
-mkdir -p /tmp/crontest
-
-cat > /tmp/crontest/testjob_cron01 << EOF
-echo Testjob running
-date
-EOF
-
-chmod 755 /tmp/crontest/testjob_cron01
-
-crontab - << EOF
-`date '+%M' | awk '{ print ($1+2)%60 " * * * * "
-}'` /tmp/crontest/testjob_cron01 >> /tmp/crontest/output_cron01 2>&1
-EOF
-
-rc=$?
-
-if [ $rc = "1" ]; then
-	echo Error while adding crontab for user $iam
-	restorecrontab
-	exit 1
-fi
-
-echo new job added successfully
-
-# 2. Wait for execution of job
-
-echo 'sleeping for 130 seconds...'
-sleep 130
-
-rc=1
-test -e /tmp/crontest/output_cron01 && rc=0
-
-if [ $rc = "1" ]; then
-	echo Job has not been executed
-	restorecrontab
-	exit 1
-fi
-
-grep "Testjob running" /tmp/crontest/output_cron01
-rc=$?
-if [ $rc = "1" ]; then
-	echo Job has not produced valid output
-	restorecrontab
-fi
-
-echo 'job has been executed :-)'
-echo "testjob's output:"
-echo
-
-rm -rf /tmp/crontest
-
-# 3. Delete crontab
-
-crontab -r
-
-echo removed crontab
-
-# Restore old crontab file
-
-restorecrontab
-
-exit $rc
diff --git a/testcases/commands/cron/cron_tests.sh b/testcases/commands/cron/cron_tests.sh
deleted file mode 100644
index 47614f9e3..000000000
--- a/testcases/commands/cron/cron_tests.sh
+++ /dev/null
@@ -1,276 +0,0 @@
-#!/bin/sh
-
-# Copyright (c) International Business Machines Corp., 2001
-# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-# Author: Manoj Iyer <manjo@mail.utexas.edu>
-
-TST_CNT=3
-TST_TESTFUNC=do_test
-TST_NEEDS_TMPDIR=1
-TST_SETUP=setup
-TST_CLEANUP=cleanup
-. tst_test.sh
-
-. daemonlib.sh
-
-SYSLOG_STARTED=
-CROND_STARTED=
-LOGS=
-
-grep_logs()
-{
-	local pattern="$1"
-	local fail_msg="$2"
-	local pass_msg="${3:-}"
-	local n="${4:-10}"
-
-	local lines=10
-	local out=out.$$
-	local err=err.$$
-	local i ret
-
-	for i in $(seq 1 $n); do
-		if [ "$LOGS" ]; then
-			tail -n $lines $LOGS | grep "$pattern" > $out 2> $err
-		else
-			journalctl -n $lines | grep "$pattern" > $out 2> $err
-		fi
-		ret=$?
-		[ $ret -eq 0 ] && break
-		sleep 1
-	done
-
-	if [ $ret -ne 0 ]; then
-		tst_res TFAIL "$fail_msg: `cat $err`"
-	else
-		[ "$pass_msg" ] && tst_res TPASS "$pass_msg"
-	fi
-}
-
-create_crontab()
-{
-	local crontab=cronjob.cron
-	local script=$1
-	local out=out.$$
-
-	tst_res TINFO "creating crontab: $script"
-
-	cat > $crontab <<EOF
-* * * * * $script
-EOF
-
-	tst_res TINFO "installing crontab file"
-	crontab $crontab > $out 2>&1
-	if [ $? -ne 0 ]; then
-		tst_brk TBROK "crontab: error while installing crontab file: `cat $out`"
-		return 1
-	fi
-	return 0
-}
-
-remove_crontab()
-{
-	local out=out.$$
-	tst_res TINFO "removing crontab file"
-	crontab -r > $out 2>&1
-	if [ $? -ne 0 ]; then
-		tst_brk TBROK "crontab: error while removing crontab file `cat $out`"
-		return 1
-	fi
-	return 0
-}
-
-create_hello_script()
-{
-	local script=$1
-
-	cat > $script <<EOF
-#!/bin/sh
-echo "Hello Hell"
-exit 0
-EOF
-	chmod +x $script
-}
-
-install_cron_test()
-{
-	local script=$PWD/cronprg.sh
-	local cron_out=$PWD/tst1_cron.out
-	local err=err.log
-	local sleep_sec
-	local ts_min1 ts_min2 fail
-
-	tst_res TINFO "test install cron job"
-
-	cat > $script <<EOF
-#! /bin/sh
-DATE=\`LC_ALL=C date\`
-echo "Hello Hell today is \$DATE" > $cron_out 2>&1
-exit 0
-EOF
-	chmod +x $script
-
-	create_crontab $script 2> $err
-
-	if [ $? -ne 0 ]; then
-		tst_brk TBROK "crontab: error while creating cron job: `cat $err`"
-	else
-		tst_res TINFO "cron job installed successfully"
-	fi
-
-	grep_logs 'crontab.*REPLACE' \
-		"cron activity not recorded" \
-		"cron activity logged"
-
-	# Sleep 3s after next minute since the loop below sleeps for 62 seconds, we
-	# should start this 5-iteration loop closely following the start of a
-	# minute.
-	sleep_sec=$((123-`date +%-S`))
-	tst_res TINFO "sleep for ${sleep_sec}s"
-	sleep $sleep_sec
-
-	# $script executed by the cron job will record the date and time into file
-	# $cron_out. Get the minute recorded by the program, sleep to allow the cron
-	# job to update file after 1m, and check if the value is advanced by 1.
-	for i in $(seq 1 5); do
-		tst_res TINFO "loop: $i: start"
-
-		if [ ! -f "$cron_out" ]; then
-			tst_res TFAIL "loop $i: file $cron_out doesn't exist"
-			fail=1
-			break
-		fi
-
-		ts_min1=$(awk '{print $8}' $cron_out | awk -F: '{printf("%d", $2);}')
-
-		# wait for the cron job to update output file
-		sleep 62
-
-		# Check the time recorded in output file, this should be 1 minute ahead of
-		# what was recored earlier.
-		ts_min2=$(awk '{print $8}' $cron_out | awk -F: '{printf("%d", $2);}')
-
-		if [ "x${ts_min1}" = "x" ] || [ "x${ts_min2}" = "x" ]; then
-			tst_res TFAIL "loop $i: failed to get time: ts_min1: $ts_min1, ts_min2: $ts_min2"
-			fail=1
-			break
-		fi
-
-		[ $ts_min1 -eq 59 ] && ts_min1=0 || ts_min1=$(( $ts_min1+1 ))
-
-		if [ $ts_min2 -ne $ts_min1 ]; then
-			tst_res TFAIL "loop $i: failed to update every minute: expected: $ts_min1, received: $ts_min2"
-			fail=1
-			break
-		fi
-	done
-
-	if [ ! "$fail" ]; then
-		grep_logs "CMD ($script)" \
-			"failed to install cron job installed and execute it" \
-			"cron job installed and executed" 1
-	fi
-
-	remove_crontab
-}
-
-remove_cron_job_test()
-{
-	local script=$PWD/cronprg.sh
-
-	tst_res TINFO "test remove cron job"
-
-	create_hello_script $script
-	create_crontab $script
-
-	grep_logs 'crontab.*REPLACE' \
-		"crontab activity not recorded"
-
-	remove_crontab && grep_logs DELETE \
-		"crontab activity not recorded" \
-		"crontab removed the cron job" 1
-}
-
-list_cron_jobs_test()
-{
-	local script=$PWD/cronprg.sh
-	local out=cron.out
-
-	tst_res TINFO "test list installed cron jobs"
-
-	create_hello_script $script
-	create_crontab $script
-
-	tst_res TINFO "crontab: listing cron jobs"
-	crontab -l | grep "$script" > $out 2>&1 || \
-		tst_brk TBROK "crontab failed while listing installed cron jobs: `cat $out`"
-
-	remove_crontab
-
-	crontab -l > $out 2>&1
-	if [ $? -ne 0 ]; then
-		grep -q "no crontab for" $out
-		if [ $? -ne 0 ]; then
-			tst_res TFAIL "crontab failed removing cron job: `cat $out`"
-		else
-			tst_res TPASS "crontab did not list any cron jobs"
-		fi
-	else
-		tst_res TFAIL "crontab failed removing cron job: `cat $out`"
-	fi
-}
-
-setup()
-{
-	if [ "$SYSLOG_DAEMON" ]; then
-		status_daemon $SYSLOG_DAEMON
-		if [ $? -ne 0 ]; then
-			restart_daemon $SYSLOG_DAEMON
-			SYSLOG_STARTED=1
-		fi
-	fi
-
-	if [ "$CROND_DAEMON" ]; then
-		status_daemon $CROND_DAEMON
-		if [ $? -ne 0 ]; then
-			restart_daemon $CROND_DAEMON
-			CROND_STARTED=1
-		fi
-	fi
-
-	for f in /var/log/syslog /var/log/messages /var/log/cron /var/log/cron.log; do
-		[ -f "$f" ] && LOGS="$f $LOGS"
-	done
-}
-
-cleanup()
-{
-	[ "$SYSLOG_STARTED" = "1" ] && stop_daemon $SYSLOG_DAEMON
-	[ "$CROND_STARTED" = "1" ] && stop_daemon $CROND_DAEMON
-}
-
-do_test()
-{
-	case $1 in
-	1) install_cron_test;;
-	2) remove_cron_job_test;;
-	3) list_cron_jobs_test;;
-	esac
-}
-
-tst_run
-- 
2.19.0

