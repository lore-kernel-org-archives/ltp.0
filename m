Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XC5oj-00069O-Fk
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 11:43:41 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XC5oh-00011n-5c
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 11:43:41 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6TBhSmD010114
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jul 2014 19:43:28 +0800
Message-ID: <1406634179.3928.2.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 29 Jul 2014 19:42:59 +0800
In-Reply-To: <1406634124.3928.1.camel@G08JYZSD130126>
References: <1406634124.3928.1.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] network ssh: some cleanup
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
To: ltp-list <ltp-list@lists.sourceforge.net>

* Move do_setup and do_cleanup into the file of ssh_setup.

* Use test.sh instead of net_cmdlib.sh

* Define local exists function instead of which in cmdlib.sh

* Abandon trap and use tst_exit.

* Make the test like:
	(set TCID TST_TOTAL ...)
	setup
	do_test
	check_result
	tst_exit

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/tcp_cmds/ssh/ssh01     | 83 +++++++++-----------------------
 testcases/network/tcp_cmds/ssh/ssh01_s1  | 36 ++++++++------
 testcases/network/tcp_cmds/ssh/ssh02     | 83 +++++++++-----------------------
 testcases/network/tcp_cmds/ssh/ssh02_s1  | 36 ++++++++------
 testcases/network/tcp_cmds/ssh/ssh03     | 78 ++++++++----------------------
 testcases/network/tcp_cmds/ssh/ssh03_s1  | 36 ++++++++------
 testcases/network/tcp_cmds/ssh/ssh_setup | 63 ++++++++++++++++++++++++
 7 files changed, 192 insertions(+), 223 deletions(-)
 create mode 100755 testcases/network/tcp_cmds/ssh/ssh_setup

diff --git a/testcases/network/tcp_cmds/ssh/ssh01 b/testcases/network/tcp_cmds/ssh/ssh01
index a0c66f5..06a830a 100755
--- a/testcases/network/tcp_cmds/ssh/ssh01
+++ b/testcases/network/tcp_cmds/ssh/ssh01
@@ -25,69 +25,34 @@
 #  HISTORY:
 #    03/03 Jerone Young (jeroney@us.ibm.com)
 #
+# DESCRIPTION:
+#	Create test user
+#	Make sure test user can't login with invalid password
+#	Cleanup test user from system
+#	Exit with exit code of script called upon
 
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup()
+setup()
 {
-    export RHOST="localhost"
-    export TEST_USER="ssh_usr1"
-    export TEST_USER_PASSWD="now_this_is_a_good_ltp_test_password"
-    export TEST_USER_HOMEDIR="/home/$TEST_USER"
-
-    exists expect ssh ssh01_s1 useradd userdel
-
-    trap do_cleanup EXIT
-
-    # erase user if he/she already exists, so we can have a clean env
-    userdel -r $TEST_USER
-    [ -d "$TEST_USER_HOMEDIR" ] && rm -rf "$TEST_USER_HOMEDIR"
-    sleep 1
-
-    tst_setup
-
-    if ! useradd -m -d "$TEST_USER_HOMEDIR" $TEST_USER; then
-        end_testcase "Could not add test user $TEST_USER to system $RHOST."
-    fi
-
-    echo "$TEST_USER_PASSWD" | passwd --stdin $TEST_USER
-
-    # create users home diretory (SLES 8 does not do this, even when specified
-    # in adduser)
-    if [ ! -d "$TEST_USER_HOMEDIR" ]; then
-        USER_UID=$(id -u $TEST_USER)
-        USER_GID=$(id -g $TEST_USER)
-        if ! mkdir -p "$TEST_USER_HOMEDIR"; then
-            end_testcase "Failed to create $TEST_USER_HOMEDIR"
-        fi
-        chown -Rf $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
-    fi
+	exists ssh01_s1
+	export TEST_USER="ssh_usr1"
 }
 
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
+TCID="$0"
+TST_TOTAL=1
 
-do_cleanup()
-{
-    userdel -r $TEST_USER
-    [ -d "$TEST_USER_HOMEDIR" ] && rm -rf "$TEST_USER_HOMEDIR"
-    tst_cleanup
-}
+. test.sh
+. ssh_setup
 
-#-----------------------------------------------------------------------
-# FUNCTION:  MAIN
-#
-# DESCRIPTION: Create Test User
-#          Call upon script to make sure test user cannont log in with invalid password
-#          Cleanup Test User from system
-#          Exit with exit code of script called upon
-#-----------------------------------------------------------------------
-. net_cmdlib.sh
-
-read_opts $*
+setup
 do_setup
-ssh01_s1 || end_testcase "Testcase failed"
-do_cleanup
+TST_CLEANUP=do_cleanup
+
+ssh01_s1
+ret=$?
+if [ $ret -ne 0 ]; then
+	tst_resm TFAIL "Test $TCID FAIL"
+else
+	tst_resm TPASS "Test $TCID PASS"
+fi
+
+tst_exit
diff --git a/testcases/network/tcp_cmds/ssh/ssh01_s1 b/testcases/network/tcp_cmds/ssh/ssh01_s1
index c1cc127..ab86e2a 100755
--- a/testcases/network/tcp_cmds/ssh/ssh01_s1
+++ b/testcases/network/tcp_cmds/ssh/ssh01_s1
@@ -45,22 +45,28 @@ set PASSWD "invalid_password!"
 spawn ssh -l $RUSER $RHOST whoami
 
 while 1 {
-    sleep 2
-    expect {
+	sleep 2
+	expect {
 
-        "Are you sure you want to continue connecting (yes/no)?" { exp_send "yes\r"}
-        "assword:" {exp_send "$PASSWD\r"}
-        -re "Permission denied (.*)\." {
-            send_user "SSH would not allow $RUSER to login with invalid password, Test Passed \n"
-            send_user "\nTEST_PASSED\n"
-            exit 0
-        }
-        "$RUSER" {
-            send_user "SSH allowed $RUSER to login with invalid pass, Test Failed \n"
-            exit 1
-        }
-    }
-    sleep 1
+		"Are you sure you want to continue connecting (yes/no)?" {
+			exp_send "yes\r"
+		}
+		"assword:" {
+			exp_send "$PASSWD\r"
+		}
+		-re "Permission denied (.*)\." {
+			send_user "SSH would not allow $RUSER to login with\
+				   invalid password, Test Passed \n"
+			send_user "\nTEST_PASSED\n"
+			exit 0
+		}
+		"$RUSER" {
+			send_user "SSH allowed $RUSER to login with invalid\
+				   pass, Test Failed \n"
+			exit 1
+		}
+	}
+	sleep 1
 }
 
 exit 1
diff --git a/testcases/network/tcp_cmds/ssh/ssh02 b/testcases/network/tcp_cmds/ssh/ssh02
index 2d82acb..edf7434 100755
--- a/testcases/network/tcp_cmds/ssh/ssh02
+++ b/testcases/network/tcp_cmds/ssh/ssh02
@@ -25,69 +25,34 @@
 #  HISTORY:
 #    03/03 Jerone Young (jeroney@us.ibm.com)
 #
+# DESCRIPTION:
+#	Create Test User
+#	Make sure an invalid user can not have access
+#	Cleanup Test User from system
+#	Exit with exit code of script called upon
 
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup()
+setup()
 {
-    export RHOST="localhost"
-    export TEST_USER="ssh_usr2"
-    export TEST_USER_PASSWD="now_this_is_a_good_ltp_test_password"
-    export TEST_USER_HOMEDIR="/home/$TEST_USER"
-
-    exists expect ssh ssh02_s1 useradd userdel
-
-    trap do_cleanup EXIT
-
-    # erase user if he/she already exists, so we can have a clean env
-    userdel -r $TEST_USER
-    [ -d "$TEST_USER_HOMEDIR" ] && rm -rf "$TEST_USER_HOMEDIR"
-    sleep 1
-
-    tst_setup
-
-    if ! useradd -m -d "$TEST_USER_HOMEDIR" $TEST_USER; then
-        end_testcase "Could not add test user $TEST_USER to system $RHOST."
-    fi
-
-    echo "$TEST_USER_PASSWD" | passwd --stdin $TEST_USER
-
-    # create users home diretory (SLES 8 does not do this, even when specified
-    # in adduser)
-    if [ ! -d "$TEST_USER_HOMEDIR" ]; then
-        USER_UID=$(id -u $TEST_USER)
-        USER_GID=$(id -g $TEST_USER)
-        if ! mkdir -p "$TEST_USER_HOMEDIR"; then
-            end_testcase "Failed to create $TEST_USER_HOMEDIR"
-        fi
-        chown -Rf $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
-    fi
+	exists ssh02_s1
+	export TEST_USER="ssh_usr2"
 }
 
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
+TCID="$0"
+TST_TOTAL=1
 
-do_cleanup()
-{
-    userdel -r $TEST_USER
-    [ -d "$TEST_USER_HOMEDIR" ] && rm -rf "$TEST_USER_HOMEDIR"
-    tst_cleanup
-}
+. test.sh
+. ssh_setup
 
-#-----------------------------------------------------------------------
-# FUNCTION:  MAIN
-#
-# DESCRIPTION: Create Test User
-#          Call upon script to make sure an invalid user can not have access
-#          Cleanup Test User from system
-#          Exit with exit code of script called upon
-#-----------------------------------------------------------------------
-. net_cmdlib.sh
-
-read_opts $*
+setup
 do_setup
-ssh02_s1 || end_testcase "Testcase failed"
-do_cleanup
+TST_CLEANUP=do_cleanup
+
+ssh02_s1
+ret=$?
+if [ $ret -ne 0 ]; then
+	tst_resm TFAIL "Test $TCID FAIL"
+else
+	tst_resm TPASS "Test $TCID PASS"
+fi
+
+tst_exit
diff --git a/testcases/network/tcp_cmds/ssh/ssh02_s1 b/testcases/network/tcp_cmds/ssh/ssh02_s1
index d49e1e9..cf95709 100755
--- a/testcases/network/tcp_cmds/ssh/ssh02_s1
+++ b/testcases/network/tcp_cmds/ssh/ssh02_s1
@@ -46,22 +46,28 @@ set RUSER "Invaild_User"
 spawn ssh -l $RUSER $RHOST whoami
 
 while 1 {
-    sleep 2
-    expect {
+	sleep 2
+	expect {
 
-        "Are you sure you want to continue connecting (yes/no)?" { exp_send "yes\r"}
-        "assword:" {exp_send "$PASSWD\r"}
-        -re "Permission denied (.*)\." {
-            send_user "SSH would not allow $RUSER to login with invalid password, Test Passed \n"
-            send_user "\nTEST_PASSED\n"
-            exit 0
-        }
-        "$RUSER" {
-            send_user "SSH allowed $RUSER to login with invalid pass, Test Failed \n"
-            exit 1
-        }
-    }
-    sleep 1
+		"Are you sure you want to continue connecting (yes/no)?" {
+			exp_send "yes\r"
+		}
+		"assword:" {
+			exp_send "$PASSWD\r"
+		}
+		-re "Permission denied (.*)\." {
+			send_user "SSH would not allow $RUSER to login with\
+				   invalid password, Test Passed \n"
+			send_user "\nTEST_PASSED\n"
+			exit 0
+		}
+		"$RUSER" {
+			send_user "SSH allowed $RUSER to login with invalid\
+				   pass, Test Failed \n"
+			exit 1
+		}
+	}
+	sleep 1
 }
 
 exit 1
diff --git a/testcases/network/tcp_cmds/ssh/ssh03 b/testcases/network/tcp_cmds/ssh/ssh03
index 49b6527..b50c9aa 100755
--- a/testcases/network/tcp_cmds/ssh/ssh03
+++ b/testcases/network/tcp_cmds/ssh/ssh03
@@ -26,68 +26,28 @@
 #    03/03 Jerone Young (jeroney@us.ibm.com)
 #
 
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup()
+setup()
 {
-    export RHOST="localhost"
-    export TEST_USER="ssh_usr3"
-    export TEST_USER_PASSWD="now_this_is_a_good_ltp_test_password"
-    export TEST_USER_HOMEDIR="/home/$TEST_USER"
-
-    exists expect ssh ssh03_s1 useradd userdel
-
-    trap do_cleanup EXIT
-
-    # erase user if he/she already exists, so we can have a clean env
-    userdel -r $TEST_USER
-    [ -d "$TEST_USER_HOMEDIR" ] && rm -rf "$TEST_USER_HOMEDIR"
-    sleep 1
-
-    tst_setup
-
-    if ! useradd -m -d "$TEST_USER_HOMEDIR" $TEST_USER; then
-        end_testcase "Could not add test user $TEST_USER to system $RHOST."
-    fi
-
-    echo "$TEST_USER_PASSWD" | passwd --stdin $TEST_USER
-
-    # create users home diretory (SLES 8 does not do this, even when specified
-    # in adduser)
-    if [ ! -d "$TEST_USER_HOMEDIR" ]; then
-        USER_UID=$(id -u $TEST_USER)
-        USER_GID=$(id -g $TEST_USER)
-        if ! mkdir -p "$TEST_USER_HOMEDIR"; then
-            end_testcase "Failed to create $TEST_USER_HOMEDIR"
-        fi
-        chown -Rf $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
-    fi
+	exists ssh03_s1
+	export TEST_USER="ssh_usr3"
 }
 
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
+TCID="$0"
+TST_TOTAL=1
 
-do_cleanup()
-{
-    userdel -r $TEST_USER
-    [ -d "$TEST_USER_HOMEDIR" ] && rm -rf "$TEST_USER_HOMEDIR"
-    tst_cleanup
-}
+. test.sh
+. ssh_setup
 
-#-----------------------------------------------------------------------
-# FUNCTION:  MAIN
-#
-# DESCRIPTION: Create Test User
-#          Call upon script to make sure a valid user can have access
-#          Cleanup Test User from system
-#          Exit with exit code of script called upon
-#-----------------------------------------------------------------------
-. net_cmdlib.sh
-
-read_opts $*
+setup
 do_setup
-ssh03_s1 || end_testcase "Testcase failed"
-do_cleanup
+TST_CLEANUP=do_cleanup
+
+ssh03_s1
+ret=$?
+if [ $ret -ne 0 ]; then
+	tst_resm TFAIL "Test $TCID FAIL"
+else
+	tst_resm TPASS "Test $TCID PASS"
+fi
+
+tst_exit
diff --git a/testcases/network/tcp_cmds/ssh/ssh03_s1 b/testcases/network/tcp_cmds/ssh/ssh03_s1
index bf6aada..e3f8ceb 100755
--- a/testcases/network/tcp_cmds/ssh/ssh03_s1
+++ b/testcases/network/tcp_cmds/ssh/ssh03_s1
@@ -39,25 +39,29 @@ set timeout 90
 
 send_user "TEST: SSH allow (non-root) valid User \n"
 
-
 spawn ssh -l $RUSER $RHOST whoami
 
 while 1 {
-    sleep 2
-    expect {
-
-        "Are you sure you want to continue connecting (yes/no)?" { exp_send "yes\r"}
-        "assword:" {exp_send "$PASSWD\r"}
-        -re "Permission denied (.*)\." {
-            send_user "\nSSH would not allow $RUSER to login, Test FAILED \n"
-            exit 1
-        }
-        "$RUSER" {
-            send_user "SSH allowed $RUSER to login, Test PASSED \n"
-            exit 0
-        }
-    }
-    sleep 1
+	sleep 2
+	expect {
+
+		"Are you sure you want to continue connecting (yes/no)?" {
+			exp_send "yes\r"
+		}
+		"assword:" {
+			exp_send "$PASSWD\r"
+		}
+		-re "Permission denied (.*)\." {
+			send_user "\nSSH would not allow $RUSER to login, Test\
+				   FAILED \n"
+			exit 1
+		}
+		"$RUSER" {
+			send_user "SSH allowed $RUSER to login, Test PASSED \n"
+			exit 0
+		}
+	}
+	sleep 1
 }
 
 exit 1
diff --git a/testcases/network/tcp_cmds/ssh/ssh_setup b/testcases/network/tcp_cmds/ssh/ssh_setup
new file mode 100755
index 0000000..f0d6f7c
--- /dev/null
+++ b/testcases/network/tcp_cmds/ssh/ssh_setup
@@ -0,0 +1,63 @@
+#!/bin/sh
+################################################################################
+## Copyright (c) International Business Machines  Corp., 2000                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and/or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful,            ##
+## but WITHOUT ANY WARRANTY;  without even the implied warranty of            ##
+## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  ##
+## the GNU General Public License for more details.                           ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
+##                                                                            ##
+################################################################################
+
+exists()
+{
+	for cmd in $*; do
+		if ! command -v $cmd > /dev/null 2>&1; then
+			tst_brkm TBROK "$cmd: command not found"
+		fi
+	done
+}
+
+do_setup()
+{
+	export RHOST="localhost"
+	export TEST_USER_PASSWD="now_this_is_a_good_ltp_test_password"
+	export TEST_USER_HOMEDIR="/home/$TEST_USER"
+
+	exists expect ssh useradd userdel
+
+	# erase user if he/she already exists, so we can have a clean env
+	do_cleanup
+	sleep 1
+
+	if ! useradd -m -d "$TEST_USER_HOMEDIR" $TEST_USER; then
+		tst_brkm TBROK "Failed to add user $TEST_USER to system $RHOST."
+	fi
+
+	echo "$TEST_USER_PASSWD" | passwd --stdin $TEST_USER
+
+	# create users home diretory (SLES 8 does not do this, even when
+	# specified in adduser)
+	if [ ! -d "$TEST_USER_HOMEDIR" ]; then
+		USER_UID=$(id -u $TEST_USER)
+		USER_GID=$(id -g $TEST_USER)
+		if ! mkdir -p "$TEST_USER_HOMEDIR"; then
+			tst_brkm TBROK "Failed to create $TEST_USER_HOMEDIR"
+		fi
+		chown -Rf $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
+	fi
+}
+
+do_cleanup()
+{
+	userdel -r $TEST_USER 2> /dev/null
+}
-- 
1.9.3




------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
