From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 27 Sep 2018 16:57:19 +0200
Subject: [LTP] [RFC PATCH v2 2/3] net: Remove network_commands (ftp, ssh)
In-Reply-To: <20180927145720.31014-1-pvorel@suse.cz>
References: <20180927145720.31014-1-pvorel@suse.cz>
Message-ID: <20180927145720.31014-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

network_commands contains ftp and ssh login tests as a part of EAL2
testsuite. Removing them as they don't really fit into "kernel testing",
it'd be better to have them in some "LTP userspace" project.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
No change.
---
 runtest/network_commands                 |   8 --
 scenario_groups/network                  |   1 -
 testcases/network/tcp_cmds/ftp/ftp02     |  98 --------------------
 testcases/network/tcp_cmds/ftp/ftp03     | 106 ----------------------
 testcases/network/tcp_cmds/ftp/ftp04     |  81 -----------------
 testcases/network/tcp_cmds/ftp/ftp05     | 110 -----------------------
 testcases/network/tcp_cmds/ssh/Makefile  |  31 -------
 testcases/network/tcp_cmds/ssh/ssh01     |  57 ------------
 testcases/network/tcp_cmds/ssh/ssh01_s1  |  72 ---------------
 testcases/network/tcp_cmds/ssh/ssh02     |  57 ------------
 testcases/network/tcp_cmds/ssh/ssh02_s1  |  73 ---------------
 testcases/network/tcp_cmds/ssh/ssh03     |  52 -----------
 testcases/network/tcp_cmds/ssh/ssh03_s1  |  67 --------------
 testcases/network/tcp_cmds/ssh/ssh_setup |  54 -----------
 14 files changed, 867 deletions(-)
 delete mode 100644 runtest/network_commands
 delete mode 100755 testcases/network/tcp_cmds/ftp/ftp02
 delete mode 100755 testcases/network/tcp_cmds/ftp/ftp03
 delete mode 100755 testcases/network/tcp_cmds/ftp/ftp04
 delete mode 100755 testcases/network/tcp_cmds/ftp/ftp05
 delete mode 100644 testcases/network/tcp_cmds/ssh/Makefile
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh01
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh01_s1
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh02
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh02_s1
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh03
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh03_s1
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh_setup

diff --git a/runtest/network_commands b/runtest/network_commands
deleted file mode 100644
index c2eb142b3..000000000
--- a/runtest/network_commands
+++ /dev/null
@@ -1,8 +0,0 @@
-ftp02 ftp02
-ftp03 ftp03
-ftp04 ftp04
-ftp05 ftp05
-
-ssh01 ssh01
-ssh02 ssh02
-ssh03 ssh03
diff --git a/scenario_groups/network b/scenario_groups/network
index d447daf88..46829501f 100644
--- a/scenario_groups/network
+++ b/scenario_groups/network
@@ -9,7 +9,6 @@ net.nfs
 net.rpc_tests
 net.tirpc_tests
 net.sctp
-network_commands
 net_stress.appl
 net_stress.broken_ip
 net_stress.interface
diff --git a/testcases/network/tcp_cmds/ftp/ftp02 b/testcases/network/tcp_cmds/ftp/ftp02
deleted file mode 100755
index 131610903..000000000
--- a/testcases/network/tcp_cmds/ftp/ftp02
+++ /dev/null
@@ -1,98 +0,0 @@
-#!/bin/sh
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
-#
-#
-#  FILE   : ftp
-#
-#  PURPOSE: Test to see if ftp rejects a user with an invalid password
-#
-#  HISTORY:
-#     03/03  Jerone Young (jeroney@us.ibm.com)
-#
-#  NOTE:
-#       This version is intended for EAL certification, it will need modification
-#       to conform with LTP standards in the offical LTP tree.
-#
-# DESCRIPTION:
-#	Create Test User
-#	Make sure test user cannont log in with invalid password
-#	Cleanup Test User from system
-#	Exit with exit code of script called upon
-#
-
-setup()
-{
-	export TEST_USER="ftpuser2"
-}
-
-do_test()
-{
-	CONNECTION_FAILED="Connection failed; test FAILED"
-	EXPECTED="Login failed as expected; test PASSED"
-	UNEXPECTED="Login succeeded unexpectedly; test FAILED"
-
-	set PASSWD "invaild_password?!!"
-	set timeout 90
-
-	expect -c "
-		#ftp to host
-		spawn ftp $RHOST
-		sleep 1
-		# Check if connection succeeded.
-		expect {
-			\"Name\" {}
-			timeout {send_user \"\n$CONNECTION_FAILED\n\";exit 1}
-		}
-
-		send \"$RUSER\r\"
-		sleep 1
-		expect -re \"Password:\"
-		send \"$PASSWD\r\"
-		sleep 1
-
-		expect {
-			# 530 - Login failed
-			\"530\" {send_user \"$EXPECTED\n\";exit 0}
-			# 230 - Login successful
-			\"230\" {send_user \"$UNEXPECTED\n\"; exit 1}
-		}
-
-		expect \"ftp>\"
-		send \"exit\r\"
-	"
-}
-
-TCID="ftp02"
-TST_TOTAL=1
-
-. test.sh
-. ftp_setup
-
-setup
-do_setup
-TST_CLEANUP=do_cleanup
-
-do_test
-if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Test $TCID FAIL"
-else
-	tst_resm TPASS "Test $TCID PASS"
-fi
-
-tst_exit
diff --git a/testcases/network/tcp_cmds/ftp/ftp03 b/testcases/network/tcp_cmds/ftp/ftp03
deleted file mode 100755
index e2925e8e6..000000000
--- a/testcases/network/tcp_cmds/ftp/ftp03
+++ /dev/null
@@ -1,106 +0,0 @@
-#!/bin/sh
-#
-#   Copyright (c) International Business Machines  Corp., 2003, 2005
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
-#
-#
-#  FILE   : ftp
-#
-#  PURPOSE: Ftp into a remote hosts successfully as a vaild user (other than root)
-#
-#  HISTORY:
-#     03/03  Jerone Young (jeroney@us.ibm.com)
-#     04/03  Dustin Kirkland (k1rkland@us.ibm.com)
-#     09/05  Kris Wilson (krisw@us.ibm.com) Check if vsftpd.conf was found.
-#
-#  NOTE:
-#	This version is intended for EAL certification, it will need modification
-#	to conform with LTP standards in the offical LTP tree.
-
-setup()
-{
-	export TEST_USER="ftpuser3"
-}
-
-do_test()
-{
-	FAIL_530="==> TEST : FAIL (ftp rejected login attempt)"
-	PASS_230="==> TEST : PASS (ftp allowed login attempt)"
-	FAIL_230="==> TEST : FAIL (ftp allowed login attempt)"
-	PASS_500="==> TEST : PASS (ftp rejected login attempt)"
-	PASS_530="==> TEST : PASS (ftp rejected login attempt)"
-
-	echo "TEST: Ftp into a remote host as a local user (other than root),"
-	echo "LOCAL_ENABLE=$LOCAL_ENABLE"
-
-	if [ "$LOCAL_ENABLE" = "YES" ]; then
-	expect -c "
-		spawn ftp $RHOST
-		sleep 1
-		expect -re \": \"
-		send \"$TEST_USER\r\"
-		expect -re \"Password:\"
-		send \"$TEST_USER_PASSWD\r\"
-		expect {
-			# 530 - Login failed
-			\"530\" {send_user \"$FAIL_530\n\";exit 1}
-			# 230 - Login successful
-			\"230\" {send_user \"$PASS_230\n\";exit 0}
-		}
-		expect \"ftp> \"
-		send \"quit\r\"
-	"
-	else
-	expect -c "
-		spawn ftp $RHOST
-		sleep 1
-		expect -re \": \"
-		send \"$TEST_USER\r\"
-		expect -re \"Password:\"
-		send \"$TEST_USER_PASSWD\r\"
-		expect {
-			# 230 - Login successful
-			\"230\" {send_user \"$FAIL_230\n\";exit 1}
-			# 500 - Login failed
-			\"500\" {send_user \"$PASS_500\n\";exit 0}
-			# 530 - Login failed
-			\"530\" {send_user \"$PASS_530\n\";exit 0}
-		}
-		expect \"ftp> \"
-		send \"quit\r\"
-	"
-	fi
-}
-
-TCID="ftp03"
-TST_TOTAL=1
-
-. test.sh
-. ftp_setup
-
-setup
-do_setup
-TST_CLEANUP=do_cleanup
-
-do_test
-if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Test $TCID FAIL"
-else
-	tst_resm TPASS "Test $TCID PASS"
-fi
-
-tst_exit
diff --git a/testcases/network/tcp_cmds/ftp/ftp04 b/testcases/network/tcp_cmds/ftp/ftp04
deleted file mode 100755
index beb90cf40..000000000
--- a/testcases/network/tcp_cmds/ftp/ftp04
+++ /dev/null
@@ -1,81 +0,0 @@
-#!/bin/sh
-#
-#   Copyright (c) International Business Machines  Corp., 2003, 2005
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
-#
-#
-#  FILE   : ftp
-#
-#  PURPOSE: Tests to see if ftp rejects a 'root' login attempt.
-#
-#  SETUP: The program `/usr/bin/expect' MUST be installed.
-#
-#  HISTORY:
-#   03/04/03 Jerone Young (jeroney@us.ibm.com)
-#   09/21/05 Kris Wilson (krisw@us.ibm.com) Check if vsftpd is on system.
-
-setup()
-{
-	TEST_USER=root
-
-	ftpusers="/etc/ftpusers"
-	[ -f "$ftpusers" ] || ftpusers="/etc/vsftpd/ftpusers"
-
-	grep -q ^${TEST_USER}$ $ftpusers || \
-		tst_brkm TCONF "user '$TEST_USER' not found in $ftpusers file"
-}
-
-do_test()
-{
-	FAIL_230="==> TEST : FAIL (ftp allowed login attempt)"
-	PASS_530="==> TEST : PASS (ftp rejected login attempt)"
-	echo "Ftp should reject $TEST_USER from loging in successfully"
-	expect -c "
-		spawn ftp $RHOST
-		sleep 1
-		expect -re \": \"
-		send \"$TEST_USER\r\"
-		expect -re \"Password:\"
-		send \"$TEST_USER_PASSWD\r\"
-		expect {
-			# 230 - Login successful
-			\"230\" {send_user \"$FAIL_230\n\";exit 1}
-			# 530 - Login failed
-			\"530\" {send_user \"$PASS_530\n\";exit 0}
-		}
-		expect \"ftp> \"
-		send \"quit\r\"
-	"
-}
-
-TCID="ftp04"
-TST_TOTAL=1
-
-. test.sh
-. ftp_setup
-
-setup
-do_setup
-
-do_test
-if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Test $TCID FAIL"
-else
-	tst_resm TPASS "Test $TCID PASS"
-fi
-
-tst_exit
diff --git a/testcases/network/tcp_cmds/ftp/ftp05 b/testcases/network/tcp_cmds/ftp/ftp05
deleted file mode 100755
index e9e42725e..000000000
--- a/testcases/network/tcp_cmds/ftp/ftp05
+++ /dev/null
@@ -1,110 +0,0 @@
-#!/bin/sh
-#
-#   Copyright (c) International Business Machines  Corp., 2003, 2005
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
-#
-#
-#  FILE   : ftp
-#
-#  PURPOSE: Ftp into a remote hosts successfully as a vaild user (other than root)
-#
-#  HISTORY:
-#     03/03  Jerone Young (jeroney@us.ibm.com)
-#     04/03  Dustin Kirkland (k1rkland@us.ibm.com)
-#     09/05  Kris Wilson (krisw@us.ibm.com) Check if vsftpd is on system.
-#
-#  NOTE:
-#	This version is intended for EAL certification, it will need modification
-#	to conform with LTP standards in the offical LTP tree.
-#
-# DESCRIPTION:
-#	The anonymous user will ftp in and create a directory in his/her
-#	home directory on the remote host.
-#
-
-setup()
-{
-	TEST_USER="anonymous"
-}
-
-do_test()
-{
-	FAIL_530="==> TEST : FAIL (ftp rejected login attempt)"
-	PASS_230="==> TEST : PASS (ftp allowed login attempt)"
-	FAIL_230="==> TEST : FAIL (ftp allowed login attempt)"
-	PASS_500="==> TEST : PASS (ftp rejected login attempt)"
-	PASS_530="==> TEST : PASS (ftp rejected login attempt)"
-
-	echo "Ftp into a remote host as anonymous user;"
-	echo "ANONYMOUS_ENABLE=$ANONYMOUS_ENABLE"
-
-	if [ "$ANONYMOUS_ENABLE" = "YES" ]; then
-	expect -c "
-		spawn ftp $RHOST
-		sleep 1
-		expect -re \": \"
-		send \"$TEST_USER\r\"
-		expect -re \"Password:\"
-		send \"$TEST_USER_PASSWD\r\"
-		expect {
-			# 530 - Login failed
-			\"530\" {send_user \"$FAIL_530\n\";exit 1}
-			# 230 - Login successful
-			\"230\" {send_user \"$PASS_230\n\";exit 0}
-		}
-		expect \"ftp> \"
-		send \"quit\r\"
-	"
-	else
-	expect -c "
-		spawn ftp $RHOST
-		sleep 1
-		expect -re \": \"
-		send \"$TEST_USER\r\"
-		expect -re \"Password:\"
-		send \"$TEST_USER_PASSWD\r\"
-		expect {
-			# 230 - Login successful
-			\"230\" {send_user \"$FAIL_230\n\";exit 1}
-			# 500 - Login failed
-			\"500\" {send_user \"$PASS_500\n\";exit 0}
-			# 530 - Login failed
-			\"530\" {send_user \"$PASS_530\n\";exit 0}
-		}
-		expect \"ftp> \"
-		send \"quit\r\"
-	"
-	fi
-}
-
-TCID="ftp05"
-TST_TOTAL=1
-
-. test.sh
-. ftp_setup
-
-setup
-do_setup
-
-do_test
-if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Test $TCID FAIL"
-else
-	tst_resm TPASS "Test $TCID PASS"
-fi
-
-tst_exit
diff --git a/testcases/network/tcp_cmds/ssh/Makefile b/testcases/network/tcp_cmds/ssh/Makefile
deleted file mode 100644
index 8ce99e068..000000000
--- a/testcases/network/tcp_cmds/ssh/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    network/tcp_cmds/ssh testcases Makefile.
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
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= ssh*
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cmds/ssh/ssh01 b/testcases/network/tcp_cmds/ssh/ssh01
deleted file mode 100755
index e2f2c9c0f..000000000
--- a/testcases/network/tcp_cmds/ssh/ssh01
+++ /dev/null
@@ -1,57 +0,0 @@
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
-#  FILE   : ssh
-#
-#  PURPOSE: Tests to see that ssh rejects an invalid password
-#
-#  SETUP: The program `/usr/bin/expect' MUST be installed.
-#
-#  HISTORY:
-#    03/03 Jerone Young (jeroney@us.ibm.com)
-#
-# DESCRIPTION:
-#	Create test user
-#	Make sure test user can't login with invalid password
-#	Cleanup test user from system
-#	Exit with exit code of script called upon
-
-setup()
-{
-	tst_test_cmds ssh01_s1
-	export TEST_USER="ssh_usr1"
-}
-
-TCID="ssh01"
-TST_TOTAL=1
-
-. test.sh
-. ssh_setup
-
-setup
-do_setup
-TST_CLEANUP=do_cleanup
-
-ssh01_s1
-if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Test $TCID FAIL"
-else
-	tst_resm TPASS "Test $TCID PASS"
-fi
-
-tst_exit
diff --git a/testcases/network/tcp_cmds/ssh/ssh01_s1 b/testcases/network/tcp_cmds/ssh/ssh01_s1
deleted file mode 100755
index ab86e2ae0..000000000
--- a/testcases/network/tcp_cmds/ssh/ssh01_s1
+++ /dev/null
@@ -1,72 +0,0 @@
-#! /usr/bin/expect -f
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
-#  FILE   : ssh
-#
-#  PURPOSE: Tests to see that ssh rejects an invalid password
-#
-#  SETUP: The program `/usr/bin/expect' MUST be installed.
-#
-#  HISTORY:
-#    03/03 Jerone Young (jeroney@us.ibm.com)
-#
-#
-set RHOST $env(RHOST)
-set TEST_USER $env(TEST_USER)
-set TEST_USER_PASSWD $env(TEST_USER_PASSWD)
-
-set RUSER $TEST_USER
-set PASSWD $TEST_USER_PASSWD
-
-set timeout 90
-
-#test invalid password
-
-send_user "TEST: SSH Test Invalid Password \n"
-
-# Set PASSWD to an invalid password
-set PASSWD "invalid_password!"
-
-spawn ssh -l $RUSER $RHOST whoami
-
-while 1 {
-	sleep 2
-	expect {
-
-		"Are you sure you want to continue connecting (yes/no)?" {
-			exp_send "yes\r"
-		}
-		"assword:" {
-			exp_send "$PASSWD\r"
-		}
-		-re "Permission denied (.*)\." {
-			send_user "SSH would not allow $RUSER to login with\
-				   invalid password, Test Passed \n"
-			send_user "\nTEST_PASSED\n"
-			exit 0
-		}
-		"$RUSER" {
-			send_user "SSH allowed $RUSER to login with invalid\
-				   pass, Test Failed \n"
-			exit 1
-		}
-	}
-	sleep 1
-}
-
-exit 1
diff --git a/testcases/network/tcp_cmds/ssh/ssh02 b/testcases/network/tcp_cmds/ssh/ssh02
deleted file mode 100755
index 815168118..000000000
--- a/testcases/network/tcp_cmds/ssh/ssh02
+++ /dev/null
@@ -1,57 +0,0 @@
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
-#  FILE   : ssh
-#
-#  PURPOSE: Tests to see that ssh rejects an invalid username
-#
-#  SETUP: The program `/usr/bin/expect' MUST be installed.
-#
-#  HISTORY:
-#    03/03 Jerone Young (jeroney@us.ibm.com)
-#
-# DESCRIPTION:
-#	Create Test User
-#	Make sure an invalid user can not have access
-#	Cleanup Test User from system
-#	Exit with exit code of script called upon
-
-setup()
-{
-	tst_test_cmds ssh02_s1
-	export TEST_USER="ssh_usr2"
-}
-
-TCID="ssh02"
-TST_TOTAL=1
-
-. test.sh
-. ssh_setup
-
-setup
-do_setup
-TST_CLEANUP=do_cleanup
-
-ssh02_s1
-if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Test $TCID FAIL"
-else
-	tst_resm TPASS "Test $TCID PASS"
-fi
-
-tst_exit
diff --git a/testcases/network/tcp_cmds/ssh/ssh02_s1 b/testcases/network/tcp_cmds/ssh/ssh02_s1
deleted file mode 100755
index cf95709e5..000000000
--- a/testcases/network/tcp_cmds/ssh/ssh02_s1
+++ /dev/null
@@ -1,73 +0,0 @@
-#! /usr/bin/expect -f
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
-#  FILE   : ssh
-#
-#  PURPOSE: Tests to see that ssh rejects an invalid username
-#
-#  SETUP: The program `/usr/bin/expect' MUST be installed.
-#
-#  HISTORY:
-#    03/03 Jerone Young (jeroney@us.ibm.com)
-#    05/03 Dustin Kirkland (k1rkland@us.ibm.com)
-#
-#
-set RHOST $env(RHOST)
-set TEST_USER $env(TEST_USER)
-set TEST_USER_PASSWD $env(TEST_USER_PASSWD)
-
-set RUSER $TEST_USER
-set PASSWD $TEST_USER_PASSWD
-
-set timeout 90
-
-#test invalid username
-
-send_user "TEST: Test to see if ssh rejects Invalid User \n"
-
-# Set RUSER to an invalid user
-set RUSER "Invaild_User"
-
-spawn ssh -l $RUSER $RHOST whoami
-
-while 1 {
-	sleep 2
-	expect {
-
-		"Are you sure you want to continue connecting (yes/no)?" {
-			exp_send "yes\r"
-		}
-		"assword:" {
-			exp_send "$PASSWD\r"
-		}
-		-re "Permission denied (.*)\." {
-			send_user "SSH would not allow $RUSER to login with\
-				   invalid password, Test Passed \n"
-			send_user "\nTEST_PASSED\n"
-			exit 0
-		}
-		"$RUSER" {
-			send_user "SSH allowed $RUSER to login with invalid\
-				   pass, Test Failed \n"
-			exit 1
-		}
-	}
-	sleep 1
-}
-
-exit 1
diff --git a/testcases/network/tcp_cmds/ssh/ssh03 b/testcases/network/tcp_cmds/ssh/ssh03
deleted file mode 100755
index a8d39ee81..000000000
--- a/testcases/network/tcp_cmds/ssh/ssh03
+++ /dev/null
@@ -1,52 +0,0 @@
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
-#  FILE   : ssh
-#
-#  PURPOSE: Tests to see that ssh allows a valid username (non-root)
-#
-#  SETUP: The program `/usr/bin/expect' MUST be installed.
-#
-#  HISTORY:
-#    03/03 Jerone Young (jeroney@us.ibm.com)
-#
-
-setup()
-{
-	tst_test_cmds ssh03_s1
-	export TEST_USER="ssh_usr3"
-}
-
-TCID="ssh03"
-TST_TOTAL=1
-
-. test.sh
-. ssh_setup
-
-setup
-do_setup
-TST_CLEANUP=do_cleanup
-
-ssh03_s1
-if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Test $TCID FAIL"
-else
-	tst_resm TPASS "Test $TCID PASS"
-fi
-
-tst_exit
diff --git a/testcases/network/tcp_cmds/ssh/ssh03_s1 b/testcases/network/tcp_cmds/ssh/ssh03_s1
deleted file mode 100755
index e3f8cebbe..000000000
--- a/testcases/network/tcp_cmds/ssh/ssh03_s1
+++ /dev/null
@@ -1,67 +0,0 @@
-#! /usr/bin/expect -f
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
-#  FILE   : ssh
-#
-#  PURPOSE: Tests to see that ssh accepts a valid user (non-root)
-#
-#  SETUP: The program `/usr/bin/expect' MUST be installed.
-#
-#  HISTORY:
-#    03/03 Jerone Young (jeroney@us.ibm.com)
-#
-#
-set RHOST $env(RHOST)
-set TEST_USER $env(TEST_USER)
-set TEST_USER_PASSWD $env(TEST_USER_PASSWD)
-
-set RUSER $TEST_USER
-set PASSWD $TEST_USER_PASSWD
-
-set timeout 90
-
-#test valid username
-
-send_user "TEST: SSH allow (non-root) valid User \n"
-
-spawn ssh -l $RUSER $RHOST whoami
-
-while 1 {
-	sleep 2
-	expect {
-
-		"Are you sure you want to continue connecting (yes/no)?" {
-			exp_send "yes\r"
-		}
-		"assword:" {
-			exp_send "$PASSWD\r"
-		}
-		-re "Permission denied (.*)\." {
-			send_user "\nSSH would not allow $RUSER to login, Test\
-				   FAILED \n"
-			exit 1
-		}
-		"$RUSER" {
-			send_user "SSH allowed $RUSER to login, Test PASSED \n"
-			exit 0
-		}
-	}
-	sleep 1
-}
-
-exit 1
diff --git a/testcases/network/tcp_cmds/ssh/ssh_setup b/testcases/network/tcp_cmds/ssh/ssh_setup
deleted file mode 100755
index 3e8ab8b3f..000000000
--- a/testcases/network/tcp_cmds/ssh/ssh_setup
+++ /dev/null
@@ -1,54 +0,0 @@
-#!/bin/sh
-################################################################################
-## Copyright (c) International Business Machines  Corp., 2000                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and/or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful,            ##
-## but WITHOUT ANY WARRANTY;  without even the implied warranty of            ##
-## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  ##
-## the GNU General Public License for more details.                           ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
-
-do_setup()
-{
-	export RHOST="localhost"
-	export TEST_USER_PASSWD="now_this_is_a_good_ltp_test_password"
-	export TEST_USER_HOMEDIR="/home/$TEST_USER"
-
-	tst_test_cmds expect ssh useradd userdel
-
-	# erase user if he/she already exists, so we can have a clean env
-	do_cleanup
-	sleep 1
-
-	if ! useradd -m -d "$TEST_USER_HOMEDIR" $TEST_USER; then
-		tst_brkm TBROK "Failed to add user $TEST_USER to system $RHOST."
-	fi
-
-	echo "$TEST_USER:$TEST_USER_PASSWD" | chpasswd
-
-	# create users home diretory (SLES 8 does not do this, even when
-	# specified in adduser)
-	if [ ! -d "$TEST_USER_HOMEDIR" ]; then
-		USER_UID=$(id -u $TEST_USER)
-		USER_GID=$(id -g $TEST_USER)
-		if ! mkdir -p "$TEST_USER_HOMEDIR"; then
-			tst_brkm TBROK "Failed to create $TEST_USER_HOMEDIR"
-		fi
-		chown -Rf $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
-	fi
-}
-
-do_cleanup()
-{
-	userdel -r $TEST_USER 2> /dev/null
-}
-- 
2.19.0

