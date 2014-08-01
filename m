Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XD3Gk-0005bl-RO
	for ltp-list@lists.sourceforge.net; Fri, 01 Aug 2014 03:12:34 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XD3Gh-00032v-B9
	for ltp-list@lists.sourceforge.net; Fri, 01 Aug 2014 03:12:34 +0000
Message-ID: <1406862709.2835.1.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 1 Aug 2014 11:11:49 +0800
In-Reply-To: <53DA2E9A.5030902@oracle.com>
References: <1406634124.3928.1.camel@G08JYZSD130126>
	<53DA2E9A.5030902@oracle.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] network ftp: some cleanup
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
To: Alexey <alexey.kodanev@oracle.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

* Move do_setup and do_cleanup into ftp_setup.

* Delete ftp02_s1 and add do_test function for it.

* Delete ftp_set_passwd and ftp_setup_vsftp_conf, since they are not be used.

* Use test.sh instead of net_cmdlib.sh

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
 testcases/network/tcp_cmds/ftp/ftp02               |  99 +++++++-----
 testcases/network/tcp_cmds/ftp/ftp02_s1            |  71 ---------
 testcases/network/tcp_cmds/ftp/ftp03               | 175 +++++++--------------
 testcases/network/tcp_cmds/ftp/ftp04               | 109 ++++++-------
 testcases/network/tcp_cmds/ftp/ftp05               | 146 ++++++++---------
 testcases/network/tcp_cmds/ftp/ftp_set_passwd      |  28 ----
 testcases/network/tcp_cmds/ftp/ftp_setup           |  73 +++++++++
 .../network/tcp_cmds/ftp/ftp_setup_vsftp_conf      |   5 -
 8 files changed, 304 insertions(+), 402 deletions(-)
 delete mode 100755 testcases/network/tcp_cmds/ftp/ftp02_s1
 delete mode 100755 testcases/network/tcp_cmds/ftp/ftp_set_passwd
 create mode 100644 testcases/network/tcp_cmds/ftp/ftp_setup
 delete mode 100755 testcases/network/tcp_cmds/ftp/ftp_setup_vsftp_conf

diff --git a/testcases/network/tcp_cmds/ftp/ftp02 b/testcases/network/tcp_cmds/ftp/ftp02
index 6d6e021..bb3139e 100755
--- a/testcases/network/tcp_cmds/ftp/ftp02
+++ b/testcases/network/tcp_cmds/ftp/ftp02
@@ -28,59 +28,72 @@
 #  NOTE:
 #       This version is intended for EAL certification, it will need modification
 #       to conform with LTP standards in the offical LTP tree.
+#
+# DESCRIPTION:
+#	Create Test User
+#	Make sure test user cannont log in with invalid password
+#	Cleanup Test User from system
+#	Exit with exit code of script called upon
+#
 
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup()
+setup()
 {
+	tst_check_cmds expect ftp useradd userdel
+	export TEST_USER="ftpuser2"
+}
 
-    export RHOST="localhost"
-    export TEST_USER="ftpuser2"
-    export TEST_USER_PASSWD="eal"
-    export TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
-    export TEST_USER_HOMEDIR="/home/$TEST_USER"
-
-    # erase user if he may exist, so we can have a clean env
-    TCtmp="/home/$TEST_USER"
-
-    tst_setup
+do_test()
+{
+	CONNECTION_FAILED="Connection failed; test FAILED"
+	EXPECTED="Login failed as expected; test PASSED"
+	UNEXPECTED="Login succeeded unexpectedly; test FAILED"
 
-    exists expect ftp ftp02_s1 useradd userdel
+	set PASSWD "invaild_password?!!"
+	set timeout 90
 
-    userdel $TEST_USER
-    sleep 1
+	expect -c "
+		#ftp to host
+		spawn ftp $RHOST
+		sleep 1
+		# Check if connection succeeded.
+		expect {
+			\"Name\" {}
+			timeout {send_user \"\n$CONNECTION_FAILED\n\";exit 1}
+		}
 
-    if ! useradd -m -p $TEST_USER_ENCRYPTED_PASSWD $TEST_USER; then
-        end_testcase "Could not add test user $TEST_USER to system $RHOST."
-    fi
+		send \"$RUSER\r\"
+		sleep 1
+		expect -re \"Password:\"
+		send \"$PASSWD\r\"
+		sleep 1
 
-    trap do_cleanup EXIT
+		expect {
+			# 530 - Login failed
+			\"530\" {send_user \"$EXPECTED\n\";exit 0}
+			# 230 - Login successful
+			\"230\" {send_user \"$UNEXPECTED\n\"; exit 1}
+		}
 
+		expect \"ftp>\"
+		send \"exit\r\"
+	"
 }
 
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
+TCID="$0"
+TST_TOTAL=1
 
-do_cleanup()
-{
-    userdel $TEST_USER
-    tst_cleanup
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION:  MAIN
-#
-# DESCRIPTION: Create Test User
-#              Call upon script to make sure test user cannont log in with invalid password
-#	       Cleanup Test User from system
-#              Exit with exit code of script called upon
-#-----------------------------------------------------------------------
-. net_cmdlib.sh
+. test.sh
+. ftp_setup
 
-read_opts $*
+setup
 do_setup
-ftp02_s1 || end_testcase "Testcase failed."
-end_testcase
+TST_CLEANUP=do_cleanup
+
+do_test
+if [ $? -ne 0 ]; then
+	tst_resm TFAIL "Test $TCID FAIL"
+else
+	tst_resm TPASS "Test $TCID PASS"
+fi
+
+tst_exit
diff --git a/testcases/network/tcp_cmds/ftp/ftp02_s1 b/testcases/network/tcp_cmds/ftp/ftp02_s1
deleted file mode 100755
index 18b08da..0000000
--- a/testcases/network/tcp_cmds/ftp/ftp02_s1
+++ /dev/null
@@ -1,71 +0,0 @@
-#! /usr/bin/expect -f
-#*********************************************************************
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
-#  PURPOSE: Test to see if ftp rejects a user with an invalid password
-#
-#  SETUP: The program `/usr/bin/expect' MUST be installed.
-#
-#  HISTORY:
-# 	03/04/03 Jerone Young (jeroney@us.ibm.com)
-#       09/21/05 Kris Wilson (krisw@us.ibm.com) Check for connection failure.
-#                (If WS system, no vsftpd; connection will fail.)
-
-set RHOST $env(RHOST)
-set TEST_USER $env(TEST_USER)
-set TEST_USER_PASSWD $env(TEST_USER_PASSWD)
-set TEST_USER_HOMEDIR $env(TEST_USER_HOMEDIR)
-
-#RUSER
-set RUSER $TEST_USER
-
-#set PASSWD to be an invalid Password
-set PASSWD "invaild_password?!!"
-
-set timeout 90
-
-#ftp to host
-spawn ftp $RHOST
-sleep 1
-# Check if connection succeeded.
-expect {
-    "Name" {}
-    timeout {send_user "\nConnection failed; test FAILED\n";exit 1}
-}
-
-send "$RUSER\r"
-sleep 1
-expect -re "Password:"
-send "$PASSWD\r"
-sleep 1
-
-expect {
-    # 530 - Login failed
-    "530" {send_user "Login failed as expected; test PASSED\n"}
-    # 230 - Login successful
-    "230" {send_user "Login succeeded unexpectedly; test FAILED\n"; exit 1}
-}
-
-expect "ftp>"
-send "exit\r"
-
-send_user "\nTest Successful\n\n"
-exit 0
diff --git a/testcases/network/tcp_cmds/ftp/ftp03 b/testcases/network/tcp_cmds/ftp/ftp03
index a99a1a0..5d0d1c6 100755
--- a/testcases/network/tcp_cmds/ftp/ftp03
+++ b/testcases/network/tcp_cmds/ftp/ftp03
@@ -31,130 +31,77 @@
 #	This version is intended for EAL certification, it will need modification
 #	to conform with LTP standards in the offical LTP tree.
 
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup()
+setup()
 {
-
-    RHOST="localhost"
-    TEST_USER="ftpuser1"
-    TCtmp=/home/$TEST_USER
-    TEST_USER_PASSWD="eal"
-    TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
-    TEST_USER_HOMEDIR="/home/$TEST_USER"
-    VSFTP_CONF=
-
-    tst_setup
-
-    exists ftp useradd userdel vftpd
-
-    for vsftp_conf in /etc/vsftpd /etc; do
-
-        if [ -r "$vsftp_confdir/vsftp.conf" ]; then
-            VSFTP_CONF="$vsftp_confdir/vsftp.conf"
-            break
-        fi
-
-    done
-    if [ ! -r "$VSFTP_CONF" ] ; then
-        end_testcase "vsftpd.conf not found."
-    fi
-    LOCAL_ENABLE=$(awk -F= '/^local_enable=/ {print $2}' "$VSFTP_CONF")
-
-    [ "$LOCAL_ENABLE" != "YES" ] && LOCAL_ENABLE="NO"
-
-    userdel $TEST_USER
-    sleep 1
-
-    if ! useradd -m -p $TEST_USER_ENCRYPTED_PASSWD $TEST_USER; then
-        end_testcase "Could not add test user $TEST_USER on system $RHOST."
-    fi
-
-    trap do_cleanup QUIT
-
-    # create users home diretory (SLES 8 does not do this, even when specified
-    # in adduser)
-    USER_UID=$(id -u $TEST_USER)
-    USER_GID=$(id -g $TEST_USER)
-    mkdir -p "$TEST_USER_HOMEDIR"
-    chown -R $USER_UID:$USER_GID $TEST_USER_HOMEDIR
-
+	tst_check_cmds ftp useradd userdel vsftpd
+	export TEST_USER="ftpuser3"
 }
 
-#-----------------------------------------------------------------------
-# FUNCTION:  do_cleanup
-#-----------------------------------------------------------------------
-
-do_cleanup()
+do_test()
 {
-    userdel $TEST_USER
-    tst_cleanup
-}
+	FAIL_530="==> TEST : FAIL (ftp rejected login attempt)"
+	PASS_230="==> TEST : PASS (ftp allowed login attempt)"
+	FAIL_230="==> TEST : FAIL (ftp allowed login attempt)"
+	PASS_500="==> TEST : PASS (ftp rejected login attempt)"
+	PASS_530="==> TEST : PASS (ftp rejected login attempt)"
 
-#-----------------------------------------------------------------------
-# FUNCTION:  do_test
-#
-# DESCRIPTION: The test user will ftp in and create a directory in his home directory on the remote host.
-#              The directory is then checked on the remote hosts to see if it is owned
-#	       by the test user.
-#-----------------------------------------------------------------------
-
-do_test(){
-    tst_resm TINFO "TEST: Ftp into a remote host as a local user (other than root), LOCAL_ENABLE=$LOCAL_ENABLE"
+	echo "TEST: Ftp into a remote host as a local user (other than root),"
+	echo "LOCAL_ENABLE=$LOCAL_ENABLE"
 
-    if [ "$LOCAL_ENABLE" = "YES" ]; then
+	if [ "$LOCAL_ENABLE" = "YES" ]; then
 	expect -c "
-            spawn ftp $RHOST
-            sleep 1
-            expect -re \": \"
-            send \"$TEST_USER\r\"
-            expect -re \"Password:\"
-            send \"$TEST_USER_PASSWD\r\"
-            expect {
-                # 530 - Login failed
-                \"530\" {send_user \"==> TEST \#$TEST : FAIL (ftp rejected login attempt)\n\";exit 1}
-                # 230 - Login successful
-                \"230\" {send_user \"==> TEST \#$TEST : PASS (ftp allowed login attempt)\n\";exit 0}
-            }
-            expect \"ftp> \"
-            send \"quit\r\"
+		spawn ftp $RHOST
+		sleep 1
+		expect -re \": \"
+		send \"$TEST_USER\r\"
+		expect -re \"Password:\"
+		send \"$TEST_USER_PASSWD\r\"
+		expect {
+			# 530 - Login failed
+			\"530\" {send_user \"$FAIL_530\n\";exit 1}
+			# 230 - Login successful
+			\"230\" {send_user \"$PASS_230\n\";exit 0}
+		}
+		expect \"ftp> \"
+		send \"quit\r\"
 	"
-    else
-        expect -c "
-            spawn ftp $RHOST
-            sleep 1
-            expect -re \": \"
-            send \"$TEST_USER\r\"
-            expect -re \"Password:\"
-            send \"$TEST_USER_PASSWD\r\"
-            expect {
-                # 230 - Login successful
-                \"230\" {send_user \"==> TEST \#$TEST : FAIL (ftp allowed login attempt)\n\";exit 1}
-                # 500 - Login failed
-                \"500\" {send_user \"==> TEST \#$TEST : PASS (ftp rejected login attempt)\n\";exit 0}
-                # 530 - Login failed
-                \"530\" {send_user \"==> TEST \#$TEST : PASS (ftp rejected login attempt)\n\";exit 0}
-            }
-            expect \"ftp> \"
-            send \"quit\r\"
-        "
-    fi
-
-    if [ $? != 0 ]; then
-        end_testcase "Testcase failed"
-    fi
+	else
+	expect -c "
+		spawn ftp $RHOST
+		sleep 1
+		expect -re \": \"
+		send \"$TEST_USER\r\"
+		expect -re \"Password:\"
+		send \"$TEST_USER_PASSWD\r\"
+		expect {
+			# 230 - Login successful
+			\"230\" {send_user \"$FAIL_230\n\";exit 1}
+			# 500 - Login failed
+			\"500\" {send_user \"$PASS_500\n\";exit 0}
+			# 530 - Login failed
+			\"530\" {send_user \"$PASS_530\n\";exit 0}
+		}
+		expect \"ftp> \"
+		send \"quit\r\"
+	"
+	fi
 }
 
-#----------------------------------------------------------------------
-# FUNCTION: MAIN
-# PURPOSE:  To invoke the functions to perform the tasks described in
-#           the prologue.
-#----------------------------------------------------------------------
-. net_cmdlib.sh
+TCID="$0"
+TST_TOTAL=1
+
+. test.sh
+. ftp_setup
 
-read_opts $*
+setup
 do_setup
+TST_CLEANUP=do_cleanup
+
 do_test
-end_testcase
+if [ $? -ne 0 ]; then
+	tst_resm TFAIL "Test $TCID FAIL"
+else
+	tst_resm TPASS "Test $TCID PASS"
+fi
+
+tst_exit
diff --git a/testcases/network/tcp_cmds/ftp/ftp04 b/testcases/network/tcp_cmds/ftp/ftp04
index 8329eb0..f3625d3 100755
--- a/testcases/network/tcp_cmds/ftp/ftp04
+++ b/testcases/network/tcp_cmds/ftp/ftp04
@@ -28,77 +28,64 @@
 #   03/04/03 Jerone Young (jeroney@us.ibm.com)
 #   09/21/05 Kris Wilson (krisw@us.ibm.com) Check if vsftpd is on system.
 
-#-----------------------------------------------------------------------
-# FUNCTION:  do_setup
-#-----------------------------------------------------------------------
-
-do_setup()
+setup()
 {
+	tst_check_cmds awk expect ftp vsftpd
 
-    tvar=${MACHTYPE%-*}
-    tvar=${tvar#*-}
-
-    RHOST=localhost
-    TEST_USER=root
-
-    tst_setup
+	TEST_USER=root
 
-    if [ -n "$PASSWD" ]; then
-        TEST_USER_PASSWORD=$PASSWD
-    else
-        end_testcase "You must set your password via the PASSWD variable."
-        exit 1
-    fi
-
-    exists awk expect ftp vsftpd
-
-    if [ $tvar = "redhat" -o $tvar = "redhat-linux" ]; then
-        echo "Verifying test user $TEST_USER is in /etc/vsftpd.ftpusers database..."
-        FTPUSERS=$(awk "/$TEST_USER/" /etc/vsftpd.ftpusers)
-    else
-        echo "Verifying test user $TEST_USER is in /etc/ftpusers database..."
-        FTPUSERS=$(awk "/$TEST_USER/" /etc/ftpusers)
-    fi
-    if [ -z "$FTPUSERS" ] ; then
-        end_testcase "Test user $TEST_USER not found in /etc/ftpusers unable to run TEST, exiting 0 ..."
-    fi
+	tvar=${MACHTYPE%-*}
+	tvar=${tvar#*-}
 
+	if [ $tvar = "redhat" -o $tvar = "redhat-linux" ]; then
+		ftpusers="/etc/vsftpd/ftpusers"
+	else
+		ftpusers="/etc/ftpusers"
+	fi
+	echo "Verifying test user $TEST_USER is in ${ftpusers} database..."
+	FTPUSERS=$(awk "/$TEST_USER/" ${ftpusers})
+	if [ -z "$FTPUSERS" ] ; then
+		tst_brkm TBROK "$TEST_USER not found in $ftpusers exiting 0 ..."
+	fi
 }
 
-#-----------------------------------------------------------------------
-# FUNCTION:  do_test
-#-----------------------------------------------------------------------
 do_test()
 {
-
-    tst_resm TINFO "Ftp should reject $TEST_USER from loging in successfully"
-    expect -c "
-        spawn ftp $RHOST
-        sleep 1
-        expect -re \": \"
-        send \"$TEST_USER\r\"
-        expect -re \"Password:\"
-        send \"$TEST_USER_PASSWD\r\"
-        expect {
-            # 230 - Login successful
-            \"230\" {send_user \"==> TEST \#$TEST : FAIL (ftp allowed login attempt)\n\";exit 1}
-            # 530 - Login failed
-            \"530\" {send_user \"==> TEST \#$TEST : PASS (ftp rejected login attempt)\n\";exit 0}
-        }
-        expect \"ftp> \"
-        send \"quit\r\"
-    "
-
-    [ $? -eq 0 ] || end_testcase "Testcase failed."
-
+	FAIL_230="==> TEST : FAIL (ftp allowed login attempt)"
+	PASS_530="==> TEST : PASS (ftp rejected login attempt)"
+	echo "Ftp should reject $TEST_USER from loging in successfully"
+	expect -c "
+		spawn ftp $RHOST
+		sleep 1
+		expect -re \": \"
+		send \"$TEST_USER\r\"
+		expect -re \"Password:\"
+		send \"$TEST_USER_PASSWD\r\"
+		expect {
+			# 230 - Login successful
+			\"230\" {send_user \"$FAIL_230\n\";exit 1}
+			# 530 - Login failed
+			\"530\" {send_user \"$PASS_530\n\";exit 0}
+		}
+		expect \"ftp> \"
+		send \"quit\r\"
+	"
 }
 
-#----------------------------------------------------------------------
-# FUNCTION: MAIN
-#----------------------------------------------------------------------
-. net_cmdlib.sh
+TCID="$0"
+TST_TOTAL=1
+
+. test.sh
+. ftp_setup
 
-read_opts $*
+setup
 do_setup
+
 do_test
-end_testcase
+if [ $? -ne 0 ]; then
+	tst_resm TFAIL "Test $TCID FAIL"
+else
+	tst_resm TPASS "Test $TCID PASS"
+fi
+
+tst_exit
diff --git a/testcases/network/tcp_cmds/ftp/ftp05 b/testcases/network/tcp_cmds/ftp/ftp05
index 4f91334..fcad182 100755
--- a/testcases/network/tcp_cmds/ftp/ftp05
+++ b/testcases/network/tcp_cmds/ftp/ftp05
@@ -30,96 +30,82 @@
 #  NOTE:
 #	This version is intended for EAL certification, it will need modification
 #	to conform with LTP standards in the offical LTP tree.
+#
+# DESCRIPTION:
+#	The anonymous user will ftp in and create a directory in his/her
+#	home directory on the remote host.
+#
 
-do_setup()
+setup()
 {
-    RHOST="localhost"
-    TEST_USER="anonymous"
-    TEST_USER_PASSWD="noone@nowhere.com"
-    VSFTP_CONF=
-
-    tst_setup
-
-    exists expect ftp vsftpd
-
-    for vsftp_conf in /etc/vsftpd /etc; do
-
-        if [ -r "$vsftp_confdir/vsftp.conf" ]; then
-            VSFTP_CONF="$vsftp_confdir/vsftp.conf"
-            break
-        fi
-
-    done
-    if [ ! -r "$VSFTP_CONF" ] ; then
-        end_testcase "vsftpd.conf not found."
-    fi
-    ANONYMOUS_ENABLE=$(awk -F= '/^anonymous_enable=/ {print $2}' "$VSFTP_CONF")
-    if [ "$ANONYMOUS_ENABLE" != "NO" ]; then
-        ANONYMOUS_ENABLE="YES"
-    fi
+	tst_check_cmds expect ftp vsftpd
+	TEST_USER="anonymous"
 }
 
-#-----------------------------------------------------------------------
-# FUNCTION   : do_test
-#
-# DESCRIPTION: The anonymous user will ftp in and create a directory in his/her
-#              home directory on the remote host.
-#-----------------------------------------------------------------------
-
 do_test()
 {
-    tst_resm TINFO "Ftp into a remote host as anonymous user; ANONYMOUS_ENABLE=$ANONYMOUS_ENABLE"
-
-    if [ "$ANONYMOUS_ENABLE" = "YES" ]; then
-        expect -c "
-            spawn ftp $RHOST
-            sleep 1
-            expect -re \": \"
-            send \"$TEST_USER\r\"
-            expect -re \"Password:\"
-            send \"$TEST_USER_PASSWD\r\"
-            expect {
-                # 530 - Login failed
-                \"530\" {send_user \"==> TEST \#$TEST : FAIL (ftp rejected login attempt)\n\";exit 1}
-                # 230 - Login successful
-                \"230\" {send_user \"==> TEST \#$TEST : PASS (ftp allowed login attempt)\n\";exit 0}
-            }
-            expect \"ftp> \"
-            send \"quit\r\"
-	"
-    else
-        expect -c "
-            spawn ftp $RHOST
-            sleep 1
-            expect -re \": \"
-            send \"$TEST_USER\r\"
-            expect -re \"Password:\"
-            send \"$TEST_USER_PASSWD\r\"
-            expect {
-                # 230 - Login successful
-                \"230\" {send_user \"==> TEST \#$TEST : FAIL (ftp allowed login attempt)\n\";exit 1}
-                # 500 - Login failed
-                \"500\" {send_user \"==> TEST \#$TEST : PASS (ftp rejected login attempt)\n\";exit 0}
-                # 530 - Login failed
-                \"530\" {send_user \"==> TEST \#$TEST : PASS (ftp rejected login attempt)\n\";exit 0}
-            }
-            expect \"ftp> \"
-            send \"quit\r\"
-        "
-    fi
+	FAIL_530="==> TEST : FAIL (ftp rejected login attempt)"
+	PASS_230="==> TEST : PASS (ftp allowed login attempt)"
+	FAIL_230="==> TEST : FAIL (ftp allowed login attempt)"
+	PASS_500="==> TEST : PASS (ftp rejected login attempt)"
+	PASS_530="==> TEST : PASS (ftp rejected login attempt)"
 
-    [ $? -eq 0 ] || end_testcase "Testcase failed."
+	echo "Ftp into a remote host as anonymous user;"
+	echo "ANONYMOUS_ENABLE=$ANONYMOUS_ENABLE"
 
+	if [ "$ANONYMOUS_ENABLE" = "YES" ]; then
+	expect -c "
+		spawn ftp $RHOST
+		sleep 1
+		expect -re \": \"
+		send \"$TEST_USER\r\"
+		expect -re \"Password:\"
+		send \"$TEST_USER_PASSWD\r\"
+		expect {
+			# 530 - Login failed
+			\"530\" {send_user \"$FAIL_530\n\";exit 1}
+			# 230 - Login successful
+			\"230\" {send_user \"$PASS_230\n\";exit 0}
+		}
+		expect \"ftp> \"
+		send \"quit\r\"
+	"
+	else
+	expect -c "
+		spawn ftp $RHOST
+		sleep 1
+		expect -re \": \"
+		send \"$TEST_USER\r\"
+		expect -re \"Password:\"
+		send \"$TEST_USER_PASSWD\r\"
+		expect {
+			# 230 - Login successful
+			\"230\" {send_user \"$FAIL_230\n\";exit 1}
+			# 500 - Login failed
+			\"500\" {send_user \"$PASS_500\n\";exit 0}
+			# 530 - Login failed
+			\"530\" {send_user \"$PASS_530\n\";exit 0}
+		}
+		expect \"ftp> \"
+		send \"quit\r\"
+	"
+	fi
 }
 
-#----------------------------------------------------------------------
-# FUNCTION: MAIN
-# PURPOSE:  To invoke the functions to perform the tasks described in
-#           the prologue.
-#----------------------------------------------------------------------
-. net_cmdlib.sh
+TCID="$0"
+TST_TOTAL=1
+
+. test.sh
+. ftp_setup
 
-read_opts $*
+setup
 do_setup
+
 do_test
-end_testcase
+if [ $? -ne 0 ]; then
+	tst_resm TFAIL "Test $TCID FAIL"
+else
+	tst_resm TPASS "Test $TCID PASS"
+fi
+
+tst_exit
diff --git a/testcases/network/tcp_cmds/ftp/ftp_set_passwd b/testcases/network/tcp_cmds/ftp/ftp_set_passwd
deleted file mode 100755
index 7c275c9..0000000
--- a/testcases/network/tcp_cmds/ftp/ftp_set_passwd
+++ /dev/null
@@ -1,28 +0,0 @@
-#!/usr/bin/expect
-#
-# Set Password for a specific new user
-# This script should be run as 'root'
-#
-# Example:
-#		./set_passwd USER PASSWD
-#
-
-if { [llength $argv] < 2} {
-    exit 1
-}
-
-set USER [lindex $argv 0]
-set PASSWD [lindex $argv 1]
-
-set timeout 30
-
-spawn passwd $USER
-expect "Enter new password: "
-sleep 1
-exp_send "$PASSWD\r"
-expect "Re-type new password: "
-sleep 1
-exp_send "$PASSWD\r"
-expect success
-
-exit 0
diff --git a/testcases/network/tcp_cmds/ftp/ftp_setup b/testcases/network/tcp_cmds/ftp/ftp_setup
new file mode 100644
index 0000000..b7449ec
--- /dev/null
+++ b/testcases/network/tcp_cmds/ftp/ftp_setup
@@ -0,0 +1,73 @@
+#!/bin/sh
+###############################################################################
+## Copyright (c) International Business Machines  Corp., 2003                ##
+##                                                                           ##
+## This program is free software;  you can redistribute it and/or modify     ##
+## it under the terms of the GNU General Public License as published by      ##
+## the Free Software Foundation; either version 2 of the License, or         ##
+## (at your option) any later version.                                       ##
+##                                                                           ##
+## This program is distributed in the hope that it will be useful,           ##
+## but WITHOUT ANY WARRANTY;  without even the implied warranty of           ##
+## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                 ##
+## the GNU General Public License for more details.                          ##
+##                                                                           ##
+## You should have received a copy of the GNU General Public License         ##
+## along with this program;  if not, write to the Free Software Foundation,  ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA          ##
+##                                                                           ##
+###############################################################################
+
+do_setup()
+{
+
+	export RHOST="localhost"
+	export TEST_USER_PASSWD="eal"
+	export TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
+	export TEST_USER_HOMEDIR="/home/$TEST_USER"
+
+	for vsftp_confdir in /etc/vsftpd /etc; do
+		if [ -r "$vsftp_confdir/vsftpd.conf" ]; then
+			VSFTP_CONF="$vsftp_confdir/vsftpd.conf"
+			break
+		fi
+	done
+	if [ ! -r "$VSFTP_CONF" ] ; then
+		tst_brkm TBROK "vsftpd.conf not found."
+	fi
+
+	LOCAL_ENABLE=$(awk -F= '/^local_enable=/ {print $2}' "$VSFTP_CONF")
+	if [ "$LOCAL_ENABLE" != "YES" ]; then
+		LOCAL_ENABLE="NO"
+	fi
+
+	ANONYMOUS_ENABLE=$(awk -F= '/^anonymous_enable=/ {print $2}' "$VSFTP_CONF")
+	if [ "$ANONYMOUS_ENABLE" != "NO" ]; then
+		ANONYMOUS_ENABLE="YES"
+	fi
+
+	if [ $TEST_USER = "root" -o $TEST_USER = "anonymous" ]; then
+		return
+	fi
+
+	userdel -r $TEST_USER
+	sleep 1
+
+	if ! useradd -m -p $TEST_USER_ENCRYPTED_PASSWD $TEST_USER; then
+		tst_brkm TBROK "Could not add test user $TEST_USER to system $RHOST."
+	fi
+
+	# create users home diretory (SLES 8 does not do this, even when specified
+	# in adduser)
+	USER_UID=$(id -u $TEST_USER)
+	USER_GID=$(id -g $TEST_USER)
+	mkdir -p "$TEST_USER_HOMEDIR"
+	chown -R $USER_UID:$USER_GID $TEST_USER_HOMEDIR
+}
+
+do_cleanup()
+{
+	if [ $TEST_USER != "root" -a $TEST_USER != "anonymous" ]; then
+		userdel -r $TEST_USER
+	fi
+}
diff --git a/testcases/network/tcp_cmds/ftp/ftp_setup_vsftp_conf b/testcases/network/tcp_cmds/ftp/ftp_setup_vsftp_conf
deleted file mode 100755
index 7e496f6..0000000
--- a/testcases/network/tcp_cmds/ftp/ftp_setup_vsftp_conf
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/sh
-
-grep -v "local_enable" /etc/vsftpd.conf > /tmp/vsftpd.conf
-mv -f /tmp/vsftpd.conf /etc/vsftpd.conf
-echo "local_enable=YES" >> /etc/vsftpd.conf
-- 
1.9.3




------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
