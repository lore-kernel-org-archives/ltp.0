Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MJCpe-0000cW-Bj
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 20:43:06 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJCpa-0008Gz-Nn
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 20:43:06 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id A953210118622
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Jun 2009 22:43:01 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #277) id 1MJCpX-0000Mr-00
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 22:42:59 +0200
Date: Sun, 31 May 2009 23:27:51 +0200
From: "Jiri Palecek >" <"<jirka"@suse.de>(none)
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvzvzjzrlwynca@debian>
Subject: [LTP] [PATCH] Fix some bashisms
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20090531212751.bC1faOxXNPy9EnkHMJUPp8YKCD7zHOf7ARk-i6B6ZqY@z>

Hello,

this patch removes another load of bashisms.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 runalltests.sh                                  |   60 +++++++++++-----------
 testcases/commands/cron/cron02                  |    4 +-
 testcases/commands/cron/cron03                  |    2 +-
 testcases/commands/cron/cron_allow01            |   10 ++--
 testcases/commands/cron/cron_deny01             |   14 +++---
 testcases/commands/su/su01                      |   18 +++---
 testcases/commands/unzip/unzip_tests.sh         |    2 -
 testcases/kernel/containers/netns/child.sh      |    2 +-
 testcases/kernel/containers/netns/child_1.sh    |    2 +-
 testcases/kernel/containers/netns/childipv6.sh  |    4 +-
 testcases/kernel/containers/netns/childns.sh    |    4 +-
 testcases/kernel/containers/netns/delchild.sh   |    8 ++--
 testcases/kernel/containers/netns/par_ftp.sh    |    2 +-
 testcases/kernel/containers/netns/parent.sh     |    2 +-
 testcases/kernel/containers/netns/parent_1.sh   |    2 +-
 testcases/kernel/containers/netns/parent_2.sh   |    2 +-
 testcases/kernel/containers/netns/parentns.sh   |    4 +-
 testcases/kernel/containers/netns/paripv6.sh    |    4 +-
 testcases/kernel/containers/netns/rename_net.sh |    6 +-
 testcases/kernel/syscalls/ioctl/test_ioctl      |    4 +-
 testcases/misc/tcore_patch_test_suites/tcore.sh |   11 ++--
 testcases/network/iproute/ip_tests.sh           |   62 +++++++++++-----------
 testcases/network/nfs/nfs03/nfs03               |   26 +++++-----
 23 files changed, 128 insertions(+), 127 deletions(-)

diff --git a/runalltests.sh b/runalltests.sh
index aa7a7d5..db80777 100755
--- a/runalltests.sh
+++ b/runalltests.sh
@@ -29,17 +29,17 @@
 ##                                                                            ##
 ################################################################################
 
-echo -e  "*******************************************************************"
-echo -e  "*******************************************************************"
-echo -e  "**                                                               **"
-echo -e "** This script is being re-written to cover all aspects of    **"
-echo -e "** testing LTP, which includes running all those tests which  **"
-echo -e "** are not run by default with ./runltp script. Special setup **"
-echo -e "** in system environment will be done to run all those tests  **"
-echo -e "** like the File System tests, SELinuxtest, etc               **"
-echo -e  "**                                                               **"
-echo -e  "*******************************************************************"
-echo -e  "*******************************************************************"
+echo  "*******************************************************************"
+echo  "*******************************************************************"
+echo  "**                                                               **"
+echo "** This script is being re-written to cover all aspects of    **"
+echo "** testing LTP, which includes running all those tests which  **"
+echo "** are not run by default with ./runltp script. Special setup **"
+echo "** in system environment will be done to run all those tests  **"
+echo "** like the File System tests, SELinuxtest, etc               **"
+echo  "**                                                               **"
+echo  "*******************************************************************"
+echo  "*******************************************************************"
 
 export LTPROOT=${PWD}
 export RUN_BALLISTA=0
@@ -210,19 +210,21 @@ export HTML_OUTPUT_FILE_NAME=$LTP_VERSION_$HOSTNAME_$KERNEL_VERSION_$HARDWARE_TY
 
 ## The First one i plan to run is the default LTP run ##
 ## START => Test Series 1                             ##
-echo -e "Running Default LTP..."
+echo "Running Default LTP..."
 ./runltp -g $HTML_OUTPUT_FILE_NAME
-echo -e "Completed running Default LTP\n\n"
+echo "Completed running Default LTP"
+echo
+echo
 ## END => Test Series 1                               ##
 
 ## The next one i plan to run is ballista             ##
 ## START => Test Series 2                             ##
 if [ $RUN_BALLISTA -eq 1 ]
 then
-    echo -e "Running Ballista..."
+    echo "Running Ballista..."
     export TEST_START_TIME=`date +"%Y_%b_%d-%Hh_%Mm_%Ss"`
     ./runltp -f ballista -o $LTP_VERSION-BALLISTA_RUN_ON-$HOSTNAME-$KERNEL_VERSION-$HARDWARE_TYPE-$TEST_START_TIME.out
-    echo -e "Completed running Ballista\n\n"
+    echo "Completed running Ballista"; echo; echo
 fi
 ## END => Test Series 2                               ##
 
@@ -230,9 +232,9 @@ fi
 ## START => Test Series 3                             ##
 if [ $RUN_OPENPOSIX -eq 1 ]
 then
-    echo -e "Running Open Posix Tests..."
+    echo "Running Open Posix Tests..."
     (cd testcases/open_posix_testsuite; make)
-    echo -e "Completed running Open Posix Tests\n\n"
+    echo "Completed running Open Posix Tests"; echo; echo
 fi
 ## END => Test Series 3                               ##
 
@@ -242,9 +244,9 @@ fi
 ## START => Test Series 4                             ##
 if [ $RUN_MM_CORE_APIS -eq 1 ]
 then
-    echo -e "Initializing ltp/testcases/kernel/mem/libmm/mm_core_apis ..."
+    echo "Initializing ltp/testcases/kernel/mem/libmm/mm_core_apis ..."
     # Check to see if User is Root
-    if [ $EUID -ne 0 ]
+    if [ $(id -u) -ne 0 ]
     then
         echo You need to be root to Install libmm and run mem/libmm/mm_core_apis
         echo Aborting ltp/testcases/kernel/mem/libmm/mm_core_apis
@@ -262,13 +264,13 @@ then
         else
             echo libmm-1.4.2 already installed in your system
         fi
-        echo -e "Running ltp/testcases/kernel/mem/libmm/mm_core_apis ..."
+        echo "Running ltp/testcases/kernel/mem/libmm/mm_core_apis ..."
         (cd testcases/kernel/mem/libmm; \
          make; \
          make install; \
          $LTPROOT/testcases/bin/mm_core_apis; )
     fi
-    echo -e "Completed running ltp/testcases/kernel/mem/libmm/mm_core_apis...\n\n"
+    echo "Completed running ltp/testcases/kernel/mem/libmm/mm_core_apis..."; echo; echo
 fi
 ## END => Test Series 4                               ##
 
@@ -278,9 +280,9 @@ fi
 ## START => Test Series 5                             ##
 if [ $RUN_AIOTESTS -eq 1 ]
     then
-    echo -e "Initializing ltp/testcases/kernel/io/aio ..."
+    echo "Initializing ltp/testcases/kernel/io/aio ..."
     # Check to see if User is Root
-    if [ $EUID -ne 0 ]
+    if [ $(id -u) -ne 0 ]
     then
         echo You need to be root to Install libaio-0.3.92 and run ltp/testcases/kernel/io/aio
         echo Aborting ltp/testcases/kernel/io/aio
@@ -298,13 +300,13 @@ if [ $RUN_AIOTESTS -eq 1 ]
         else
              echo libaio-0.3.92 already installed in your system
         fi
-        echo -e "Building & Running ltp/testcases/kernel/io/aio..."
+        echo "Building & Running ltp/testcases/kernel/io/aio..."
         (cd testcases/kernel/io/aio; \
          make > /dev/null; \
          ./aio01/aio01; \
          ./aio02/runfstests.sh -a aio02/cases/aio_tio; \
          make clean 1>&2 > /dev/null )
-         echo -e "Completed running ltp/testcases/kernel/io/aio...\n\n"
+         echo "Completed running ltp/testcases/kernel/io/aio..."; echo; echo
     fi
 fi
 ## END => Test Series 5                               ##
@@ -316,9 +318,9 @@ fi
 ## START => Test Series 6                             ##
 if [ $RUN_FILECAPS -eq 1 ]
 then
-    echo -e "Initializing ltp/testcases/kernel/security/filecaps ..."
+    echo "Initializing ltp/testcases/kernel/security/filecaps ..."
     # Check to see if User is Root
-    if [ $EUID -ne 0 ]
+    if [ $(id -u) -ne 0 ]
     then
         echo You need to be root to Install libcaps and run ltp/testcases/kernel/security/filecaps
         echo Aborting ltp/testcases/kernel/security/filecaps
@@ -336,11 +338,11 @@ then
         else
              echo libcaps already installed in your system
         fi
-        echo -e "Building & Running ltp/testcases/kernel/security/filecaps"
+        echo "Building & Running ltp/testcases/kernel/security/filecaps"
         (cd ltp/testcases/kernel/security/filecaps; \
          make && make install > /dev/null; )
          ./runltp -f filecaps
-         echo -e "Completed running ltp/testcases/kernel/io/aio...\n\n"
+         echo "Completed running ltp/testcases/kernel/io/aio..."; echo; echo
     fi
 fi
 ## END => Test Series 6                               ##
diff --git a/testcases/commands/cron/cron02 b/testcases/commands/cron/cron02
index c1dc245..7f45172 100755
--- a/testcases/commands/cron/cron02
+++ b/testcases/commands/cron/cron02
@@ -37,7 +37,7 @@ TEST_USER_HOMEDIR="/home/$TEST_USER"
 
 do_setup(){
 	#erase any data from potential defunt cron test
-	rm -rf /tmp/crontest &> /dev/null
+	rm -rf /tmp/crontest > /dev/null 2>&1
 
     #erase user if he may exist , so we can have a clean env
         rm -rf /home/$TEST_USER
@@ -56,7 +56,7 @@ do_setup(){
 # Red Hat uses crond, SuSE/Other uses cron. Check if this is Red Hat/SuSE/Other
 tvar=${MACHTYPE%-*}
 tvar=${tvar#*-}
-echo "Distro type is: $tvar \n"
+echo "Distro type is: $tvar"
 
 if [ $tvar != "redhat" -a $tvar != "redhat-linux" ]; then
 
diff --git a/testcases/commands/cron/cron03 b/testcases/commands/cron/cron03
index 58fbe1b..2573cc7 100755
--- a/testcases/commands/cron/cron03
+++ b/testcases/commands/cron/cron03
@@ -59,7 +59,7 @@ do_setup(){
 # Red Hat uses crond, SuSE/Other uses cron. Check if this is Red Hat/SuSE/Other
 tvar=${MACHTYPE%-*}
 tvar=${tvar#*-}
-echo "Distro type is: $tvar \n"
+echo "Distro type is: $tvar"
 
 if [ $tvar != "redhat" -a $tvar != "redhat-linux" ]; then
 
diff --git a/testcases/commands/cron/cron_allow01 b/testcases/commands/cron/cron_allow01
index 839ad81..266700a 100755
--- a/testcases/commands/cron/cron_allow01
+++ b/testcases/commands/cron/cron_allow01
@@ -47,9 +47,9 @@ TEST_USER2_HOME="/home/$TEST_USER2"
 
 do_setup() {
 	#move any files that may get in the way
-	rm /tmp/cron_allow_test &> /dev/null
-	rm /tmp/cron_allow_test1 &> /dev/null
-	mv $CRON_ALLOW $CRON_ALLOW.old &> /dev/null
+	rm /tmp/cron_allow_test > /dev/null 2>&1
+	rm /tmp/cron_allow_test1 > /dev/null 2>&1
+	mv $CRON_ALLOW $CRON_ALLOW.old > /dev/null 2>&1
 
 	#remove users for clean enviroment
     su $TEST_USER1 -c "crontab -r"
@@ -90,8 +90,8 @@ do_cleanup(){
 	userdel $TEST_USER1
 	userdel $TEST_USER2
 	rm $CRON_ALLOW
-	mv $CRON_ALLOW.old $CRON_ALLOW &> /dev/null
-	rm /tmp/cron_allow_test &>/dev/null
+	mv $CRON_ALLOW.old $CRON_ALLOW > /dev/null 2>&1
+	rm /tmp/cron_allow_test >/dev/null 2>&1
 }
 
 #-----------------------------------------------------------------------
diff --git a/testcases/commands/cron/cron_deny01 b/testcases/commands/cron/cron_deny01
index f7f8fd4..527d79c 100755
--- a/testcases/commands/cron/cron_deny01
+++ b/testcases/commands/cron/cron_deny01
@@ -49,11 +49,11 @@ TEST_USER2_HOME="/home/$TEST_USER2"
 
 do_setup() {
 	#move any files that may get in the way
-	rm /tmp/cron_deny_test &> /dev/null
-        rm /tmp/cron_deny_test1 &> /dev/null
+	rm /tmp/cron_deny_test > /dev/null 2>&1
+        rm /tmp/cron_deny_test1 > /dev/null 2>&1
 	
-	mv $CRON_DENY $CRON_DENY.old &> /dev/null
-	mv $CRON_ALLOW $CRON_ALLOW.old &> /dev/null
+	mv $CRON_DENY $CRON_DENY.old > /dev/null 2>&1
+	mv $CRON_ALLOW $CRON_ALLOW.old > /dev/null 2>&1
 
 	#remove users for clean enviroment
     su $TEST_USER1 -c "crontab -r"
@@ -94,9 +94,9 @@ do_cleanup(){
 	userdel $TEST_USER1
 	userdel $TEST_USER2
 	rm $CRON_DENY
-	mv $CRON_DENY.old $CRON_DENY &> /dev/null
-	mv $CRON_ALLOW.old $CRON_ALLOW &> /dev/null
-	rm /tmp/cron_allow_test &>/dev/null
+	mv $CRON_DENY.old $CRON_DENY > /dev/null 2>&1
+	mv $CRON_ALLOW.old $CRON_ALLOW > /dev/null 2>&1
+	rm /tmp/cron_allow_test >/dev/null 2>&1
 }
 
 #-----------------------------------------------------------------------
diff --git a/testcases/commands/su/su01 b/testcases/commands/su/su01
index e6b8a05..2a43f66 100755
--- a/testcases/commands/su/su01
+++ b/testcases/commands/su/su01
@@ -41,7 +41,7 @@ tvar=${tvar#*-}
 
 # need to export tvar for su01_s1
 export tvar
-echo "Machine type is: $tvar \n"
+echo "Machine type is: $tvar"
 
 if [ $tvar = "redhat" -o $tvar = "redhat-linux" ] 
 # Need to also set group for TEST_USER2
@@ -76,9 +76,9 @@ export TEST_ENV_FILE2="/tmp/TEST_ENV_FILE_ROOT2"
 do_setup(){
 
 #REMOVE ANY TEMPOARY FILES THAT MAY STILL BE AROUND
-rm -f $TEST_ENV_FILE_USER &> /dev/null
-rm -f $TEST_ENV_FILE2 &> /dev/null
-rm -f $TEST_ENV_FILE &> /dev/null
+rm -f $TEST_ENV_FILE_USER > /dev/null 2>&1
+rm -f $TEST_ENV_FILE2 > /dev/null 2>&1
+rm -f $TEST_ENV_FILE > /dev/null 2>&1
 
 
 #Create 1st test user
@@ -108,7 +108,7 @@ rm -f $TEST_ENV_FILE &> /dev/null
 	}
 	fi
 
-        usermod -p $TEST_USER1_ENCRYPTED_PASSWD $TEST_USER1 &> /dev/null
+        usermod -p $TEST_USER1_ENCRYPTED_PASSWD $TEST_USER1 > /dev/null 2>&1
         if [ $? != 0 ]
         then {
                 echo "Could not set password for test user $TEST_USER1"
@@ -144,7 +144,7 @@ rm -f $TEST_ENV_FILE &> /dev/null
 	}
 	fi
 
-        usermod -p $TEST_USER2_ENCRYPTED_PASSWD $TEST_USER2 &> /dev/null
+        usermod -p $TEST_USER2_ENCRYPTED_PASSWD $TEST_USER2 > /dev/null 2>&1
         if [ $? != 0 ]
         then {
                 echo "Could not set password for test user $TEST_USER2"
@@ -164,9 +164,9 @@ do_cleanup() {
 	userdel $TEST_USER1 
 	userdel $TEST_USER2
 	#REMOVE ANY TEMPOARY FILES THAT MAY STILL BE AROUND
-	rm -f $TEST_ENV_FILE_USER &> /dev/null
-	rm -f $TEST_ENV_FILE2 &> /dev/null
-	rm -f $TEST_ENV_FILE &> /dev/null
+	rm -f $TEST_ENV_FILE_USER > /dev/null 2>&1
+	rm -f $TEST_ENV_FILE2 > /dev/null 2>&1
+	rm -f $TEST_ENV_FILE > /dev/null 2>&1
 }
 
 #-----------------------------------------------------------------------
diff --git a/testcases/commands/unzip/unzip_tests.sh b/testcases/commands/unzip/unzip_tests.sh
index 5881ea4..5cf4f4c 100755
--- a/testcases/commands/unzip/unzip_tests.sh
+++ b/testcases/commands/unzip/unzip_tests.sh
@@ -62,7 +62,6 @@ chk_ifexists()
 # 				- non-zero on failure.
 cleanup()
 {
-	popd
 	# remove all the temporary files created by this test.
 	tst_resm TINFO "CLEAN: removing \"$LTPTMP\""
 	rm -fr "$LTPTMP"
@@ -90,7 +89,6 @@ init()
 	# create the temporary directory used by this testcase
 	LTPTMP=`mktemp -d -t $$.XXXXXX` || tst_resm TBROK "Unable to create temporary directory with: mktemp -d $$.XXXXXX"
 	trap "cleanup" 0
-	pushd "$LTPTMP"
 
 	# check if commands tst_*, unzip, awk, etc exists.
 	chk_ifexists INIT tst_resm  || return $RC
diff --git a/testcases/kernel/containers/netns/child.sh b/testcases/kernel/containers/netns/child.sh
index a7fbc4b..6e8ed62 100755
--- a/testcases/kernel/containers/netns/child.sh
+++ b/testcases/kernel/containers/netns/child.sh
@@ -34,7 +34,7 @@ export TST_TOTAL
     
     ping -qc 2 $IP1 >  /dev/null 
     
-    if [ $? == 0 ] ; then
+    if [ $? = 0 ] ; then
         tst_resm TINFO "PASS: Pinging ParentNS from ChildNS"
         status=0
     else
diff --git a/testcases/kernel/containers/netns/child_1.sh b/testcases/kernel/containers/netns/child_1.sh
index d44eebd..1fa71a7 100755
--- a/testcases/kernel/containers/netns/child_1.sh
+++ b/testcases/kernel/containers/netns/child_1.sh
@@ -65,7 +65,7 @@ export TST_TOTAL
         # Pinging CHILD2 from CHILD1
         debug "INFO: Trying for pinging CHILD2..."
         ping -qc 2 $IP4 > /dev/null
-        if [ $? == 0 ];
+        if [ $? = 0 ];
         then
             tst_resm TINFO "PASS: Child2 is pinging from CHILD1 !" 
         else 
diff --git a/testcases/kernel/containers/netns/childipv6.sh b/testcases/kernel/containers/netns/childipv6.sh
index 4e904be..54bd6e6 100755
--- a/testcases/kernel/containers/netns/childipv6.sh
+++ b/testcases/kernel/containers/netns/childipv6.sh
@@ -52,7 +52,7 @@ status=0
     
     #starting the sshd inside the child NS
     /usr/sbin/sshd -p $PORT 
-    if [ $? == 0 ]; then
+    if [ $? = 0 ]; then
         debug "INFO: started the sshd @ port no $PORT"
         sshpid=`ps -ef | grep "sshd -p $PORT" | awk '{ print $2 ; exit 0} ' `
     else
@@ -68,7 +68,7 @@ status=0
 
     # checking if parent ns responding
     ping6 -I $vnet1 -qc 2 $parIPv6 >/dev/null 2>&1 
-           if [ $? == 0 ] ; then
+           if [ $? = 0 ] ; then
                tst_resm TINFO "IPv6: Pinging Parent from Child: PASS"
             else
                tst_resm TFAIL "IPv6: Pinging Parent from Child: FAIL"
diff --git a/testcases/kernel/containers/netns/childns.sh b/testcases/kernel/containers/netns/childns.sh
index 6fe47ab..5a831ba 100755
--- a/testcases/kernel/containers/netns/childns.sh
+++ b/testcases/kernel/containers/netns/childns.sh
@@ -41,7 +41,7 @@ export TST_TOTAL
 .  initialize.sh
 status=0
     
-    if [ $# == 1 ] ; then
+    if [ $# = 1 ] ; then
         childscrpt=$1
         debug "INFO: The script to be executed in child NS is $childscrpt"
     fi
@@ -63,7 +63,7 @@ status=0
     
     #starting the sshd inside the child NS
     /usr/sbin/sshd -p $PORT
-    if [ $? == 0 ]; then
+    if [ $? = 0 ]; then
         debug "INFO: started the sshd @ port no $PORT"
         sshpid=`ps -ef | grep "sshd -p $PORT" | awk '{ print $2 ; exit 0} ' `
     else
diff --git a/testcases/kernel/containers/netns/delchild.sh b/testcases/kernel/containers/netns/delchild.sh
index 88822f2..d294e26 100755
--- a/testcases/kernel/containers/netns/delchild.sh
+++ b/testcases/kernel/containers/netns/delchild.sh
@@ -41,7 +41,7 @@ export TST_TOTAL
     newnet=`cat /tmp/FIFO4`
     debug "INFO: new dev is  $newnet"
 
-    if [ $newnet == -1 ] ; then
+    if [ $newnet = -1 ] ; then
         status=-1
     fi
     
@@ -50,17 +50,17 @@ export TST_TOTAL
     
     debug "INFO: Deleting the child NS created.. "
     debug "INFO: Killing processes $sshpid $pid"
-    kill -9 $sshpid $pid > /dev/null 2>&1
+    kill -s KILL $sshpid $pid > /dev/null 2>&1
     sleep 1
     
     ls /sys/class/net > /tmp/sys_aftr_child_killed
     diff -q /tmp/sys_b4_child_killed /tmp/sys_aftr_child_killed 
     
-    if [ $? == 0 ] ; then
+    if [ $? = 0 ] ; then
         debug "INFO: No difference in the contents of sysfs after deleting the child"
     else 
         grep -qw $newnet /tmp/sys_aftr_child_killed
-        if [ $? == 0 ]; then
+        if [ $? = 0 ]; then
             debug "INFO: Device $newnet is moved to ParentNS"
         else
             debug "INFO: Device $newnet is moved under diff name in ParentNS"
diff --git a/testcases/kernel/containers/netns/par_ftp.sh b/testcases/kernel/containers/netns/par_ftp.sh
index fa672a4..3bfb47b 100755
--- a/testcases/kernel/containers/netns/par_ftp.sh
+++ b/testcases/kernel/containers/netns/par_ftp.sh
@@ -35,7 +35,7 @@ export TST_TOTAL
 
     ping -q -c 2 $IP2 > /dev/null
     
-    if [ $? == 0 ] ; then
+    if [ $? = 0 ] ; then
         tst_resm TINFO "Pinging ChildNS from ParentNS"
     else
         tst_resm TFAIL "Error: Unable to ping ChildNS from ParentNS"
diff --git a/testcases/kernel/containers/netns/parent.sh b/testcases/kernel/containers/netns/parent.sh
index a12f284..61bb500 100755
--- a/testcases/kernel/containers/netns/parent.sh
+++ b/testcases/kernel/containers/netns/parent.sh
@@ -33,7 +33,7 @@ export TST_COUNT
 export TST_TOTAL
 
     ping -q -c 2 $IP2 > /dev/null
-    if [ $? == 0 ] ; then
+    if [ $? = 0 ] ; then
         tst_resm TINFO "PASS: Pinging ChildNS from ParentNS"
         status=0
     else
diff --git a/testcases/kernel/containers/netns/parent_1.sh b/testcases/kernel/containers/netns/parent_1.sh
index b42436e..1b91a58 100755
--- a/testcases/kernel/containers/netns/parent_1.sh
+++ b/testcases/kernel/containers/netns/parent_1.sh
@@ -38,7 +38,7 @@ export TST_TOTAL
     create_veth
     vnet0=$dev0
     vnet1=$dev1
-    if [[ -z $vnet0 || -z $vnet1 ]] ; then
+    if [ -z "$vnet0" ] || [ -z "$vnet1" ] ; then
         tst_resm TFAIL  "Error: unable to create veth pair in $0"
         exit -1
     else
diff --git a/testcases/kernel/containers/netns/parent_2.sh b/testcases/kernel/containers/netns/parent_2.sh
index 86eb172..c39bc7c 100755
--- a/testcases/kernel/containers/netns/parent_2.sh
+++ b/testcases/kernel/containers/netns/parent_2.sh
@@ -35,7 +35,7 @@ export TST_TOTAL
     vnet2=$dev0
     vnet3=$dev1
 
-    if [[ -z $vnet2 || -z $vnet3 ]] ; then
+    if [ -z "$vnet2" ] || [ -z "$vnet3" ] ; then
         tst_resm TFAIL  "Error: unable to create veth pair in $0"
         exit -1
     else
diff --git a/testcases/kernel/containers/netns/parentns.sh b/testcases/kernel/containers/netns/parentns.sh
index 43cdcdb..b6488a4 100755
--- a/testcases/kernel/containers/netns/parentns.sh
+++ b/testcases/kernel/containers/netns/parentns.sh
@@ -43,7 +43,7 @@ export TST_TOTAL
 status=0
 
     # Checks if any script is passed as argument.
-    if [ $# == 2 ]; then
+    if [ $# = 2 ]; then
         scrpt=$1
         debug "INFO: Script to be executed in parent NS is $scrpt"
     fi
@@ -56,7 +56,7 @@ status=0
     create_veth
     vnet0=$dev0
     vnet1=$dev1
-    if [[ -z $vnet0 || -z $vnet1 ]] ; then
+    if [ -z "$vnet0" ] || [ -z "$vnet1" ] ; then
         tst_resm TFAIL  "Error: unable to create veth pair"
         exit -1
     else
diff --git a/testcases/kernel/containers/netns/paripv6.sh b/testcases/kernel/containers/netns/paripv6.sh
index 568c86f..67c8636 100755
--- a/testcases/kernel/containers/netns/paripv6.sh
+++ b/testcases/kernel/containers/netns/paripv6.sh
@@ -49,7 +49,7 @@ status=0
     create_veth
     vnet0=$dev0
     vnet1=$dev1
-    if [[ -z $vnet0 || -z $vnet1 ]] ; then
+    if [ -z "$vnet0" ] || [ -z "$vnet1" ] ; then
         tst_resm TFAIL "Error: unable to create veth pair"
         exit -1
     else
@@ -76,7 +76,7 @@ status=0
     echo $parIPv6 > /tmp/FIFO4
     ping6 -I $vnet0 -qc 2 $childIPv6 >/dev/null 2>&1 
 
-    if [ $? == 0 ] ; then
+    if [ $? = 0 ] ; then
        tst_resm TINFO "IPv6: Pinging child from parent: PASS"
        status=0
     else
diff --git a/testcases/kernel/containers/netns/rename_net.sh b/testcases/kernel/containers/netns/rename_net.sh
index cadf7e2..ffbe07f 100755
--- a/testcases/kernel/containers/netns/rename_net.sh
+++ b/testcases/kernel/containers/netns/rename_net.sh
@@ -46,9 +46,9 @@ export TST_TOTAL
     ip link set $vnet1 name $newdev
     ifconfig $newdev $IP2/24 up > /dev/null 2>&1
 
-    if [ $? == 0 ] ; then
+    if [ $? = 0 ] ; then
         tst_resm TINFO "Successfully Renamed device to $newdev"
-        if [ DEBUG == 1 ]; then
+        if [ "$DEBUG" = 1 ]; then
                 ifconfig
         fi
     else
@@ -56,7 +56,7 @@ export TST_TOTAL
         status=-1
     fi
 
-    if [ $status == 0 ] ; then
+    if [ $status = 0 ] ; then
         echo $sshpid > /tmp/FIFO3
         echo $newdev > /tmp/FIFO4
     else
diff --git a/testcases/kernel/syscalls/ioctl/test_ioctl b/testcases/kernel/syscalls/ioctl/test_ioctl
index 2ea3e39..7ae9e71 100755
--- a/testcases/kernel/syscalls/ioctl/test_ioctl
+++ b/testcases/kernel/syscalls/ioctl/test_ioctl
@@ -25,7 +25,7 @@ export TST_COUNT=0
 
 for tttype in `ls /dev/tty*`
 do
-device_no=${tttype:8}
+device_no=${tttype##/dev/tty}
 case "$device_no" in
 [0-9]|[0-9][0-9])
     tst_resm TINFO "Testing ioctl01 with $tttype"
@@ -43,7 +43,7 @@ done
 
 for tttype in `ls /dev/tty*`
 do
-device_no=${tttype:8}
+device_no=${tttype##/dev/tty}
 case "$device_no" in
 [0-9]|[0-9][0-9])
     tst_resm TINFO "Testing ioctl02 with $tttype"
diff --git a/testcases/misc/tcore_patch_test_suites/tcore.sh b/testcases/misc/tcore_patch_test_suites/tcore.sh
index f087fa7..4b032dc 100755
--- a/testcases/misc/tcore_patch_test_suites/tcore.sh
+++ b/testcases/misc/tcore_patch_test_suites/tcore.sh
@@ -107,13 +107,13 @@ Test_gen_core()
 		rm -f core.*
 	fi
 	pid=`$BIN_DIR/tcore |grep "consumer pid"|awk '{print $2}'|cut -d = -f 2`
-	echo -e "Test whether we can generate the needed core file"
+	echo "Test whether we can generate the needed core file"
 	if [ -f core.* ];then
-		echo -e "PASS"
+		echo "PASS"
 		pass=`expr $pass + 1`
 		return 0
 	else
-		echo -e "FAIL"
+		echo "FAIL"
 		fail=`expr $fail + 1`
 		return 1
 	fi	
@@ -124,14 +124,14 @@ Test_core_file()
 	cd $TEST_DIR
 	prepare_gdb
 	mv -f $TEST_DIR/core.* $TEST_DIR/corefile >/dev/null 2>&1
-	echo -e "Test whether the core support bt,fpu and threads commands "
+	echo "Test whether the core support bt,fpu and threads commands "
 	expect $BIN_DIR/tcore.exp
 	return=$?
 	pass=`expr $pass + $return`
 	fail=`expr 3 - $return + $fail`
 }
 
-echo -e "Test Tcore patch "
+echo "Test Tcore patch "
 check_install
 Test_gen_core
 Test_core_file
@@ -142,3 +142,4 @@ cleanup $fail
 
 	
 	
+
diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
index c622700..59322b6 100755
--- a/testcases/network/iproute/ip_tests.sh
+++ b/testcases/network/iproute/ip_tests.sh
@@ -61,7 +61,7 @@ init()
 	trap "cleanup" 0
 
 	# create the tmp directory for this testcase.
-	mkdir -p $LTPTMP/ &>/dev/null || RC=$?
+	mkdir -p $LTPTMP/ >/dev/null 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then
 		tst_brkm TBROK "INIT: Unable to create temporary directory"
@@ -69,7 +69,7 @@ init()
 	fi	
 		
 	# Check to see if test harness functions are in the path.
-	which tst_resm  &>$LTPTMP/tst_ip.err || RC=$?
+	which tst_resm  >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then
 		tst_brkm TBROK NULL \
@@ -77,7 +77,7 @@ init()
 		return $RC
 	fi
 
-	which awk  &>$LTPTMP/tst_ip.err || RC=$?
+	which awk  >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then
 		tst_brkm TBROK NULL \
@@ -85,7 +85,7 @@ init()
 		return $RC
 	fi
 
-	which ip  &>$LTPTMP/tst_ip.err || RC=$?
+	which ip  >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then
 		tst_brkm TBROK NULL \
@@ -93,7 +93,7 @@ init()
 		return $RC
 	fi
 
-	which ifconfig  &>$LTPTMP/tst_ip.err || RC=$?
+	which ifconfig  >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then
 		tst_brkm TBROK NULL \
@@ -104,13 +104,13 @@ init()
 	tst_resm TINFO "INIT: Inititalizing tests."
 
 	# Aliasing eth0 to create private network.
-	/sbin/ifconfig eth0:1 10.1.1.12 &>$LTPTMP/tst_ip.err || RC=$?
+	/sbin/ifconfig eth0:1 10.1.1.12 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then
 		tst_brk TBROK "INIT: failed aliasing eth0:1 with IP 10.1.1.12"
 		return $RC
 	else
-		/sbin/route add -host 10.1.1.12 dev eth0:1 &>$LTPTMP/tst_ip.err \
+		/sbin/route add -host 10.1.1.12 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1 \
 			|| RC=$?
 		if [ $RC -ne 0 ]
 		then
@@ -153,10 +153,10 @@ cleanup()
 	TST_COUNT=0
 	RC=0
 
-	/sbin/ifconfig eth0:1 &>$LTPTMP/tst_ip.err || RC=$?
+	/sbin/ifconfig eth0:1 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 	if [ $RC -eq 0 ]
 	then
-		/sbin/ifconfig eth0:1 down &>$LTPTMP/tst_ip.err
+		/sbin/ifconfig eth0:1 down >$LTPTMP/tst_ip.err 2>&1
 	fi
 
 	rm -fr $LTPTMP
@@ -187,7 +187,7 @@ test01()
 
 	tst_resm TINFO "Test #1: changing mtu size of eth0:1 device."
 
-	ip link set eth0:1 mtu 300 &>$LTPTMP/tst_ip.err
+	ip link set eth0:1 mtu 300 >$LTPTMP/tst_ip.err 2>&1
 	if [ $RC -ne 0 ]
 	then
 		tst_res TFAIL $LTPTMP/tst_ip.err \
@@ -232,7 +232,7 @@ test02()
 	tst_resm TINFO \
 	 "Test #2: Installing dummy.o in kernel"
 
-	modprobe dummy &>$LTPTMP/tst_ip.out || RC=$?
+	modprobe dummy >$LTPTMP/tst_ip.out 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then 
 		tst_brk TBROK $LTPTMP/tst_ip.out NULL \
@@ -240,7 +240,7 @@ test02()
 		return $RC
 	fi
 
-	ip link show dummy0 | grep dummy0 &>$LTPTMP/tst_ip.err || RC=$?
+	ip link show dummy0 | grep dummy0 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then
 		tst_res TFAIL $LTPTMP/tst_ip.err "Test #2: ip command failed. Reason:"
@@ -278,7 +278,7 @@ test03()
 	tst_resm TINFO \
 	 "Test #3: ip addr add - adds a new protolcol address to the device"
 	
-	ip addr add 127.6.6.6 dev lo &>$LTPTMP/tst_ip.err || RC=$?
+	ip addr add 127.6.6.6 dev lo >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then
 		tst_res TFAIL $LTPTMP/tst_ip.err \
@@ -287,7 +287,7 @@ test03()
 	else
 		tst_resm TINFO \
 		 "Test #3: ip addr show dev <device> - shows protocol address."
-		ip addr show dev lo | grep 127.6.6.6 &>$LTPTMP/tst_ip.err || RC=$?
+		ip addr show dev lo | grep 127.6.6.6 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 		if [ $RC -ne 0 ]
 		then
 			tst_res TFAIL $LTPTMP/tst_ip.err \
@@ -297,14 +297,14 @@ test03()
 
 		tst_resm TINFO \
 		 "Test #3: ip addr del <ip> dev <device> - deletes protocol address."
-		ip addr del 127.6.6.6 dev lo &>$LTPTMP/tst_ip.err || RC=$?
+		ip addr del 127.6.6.6 dev lo >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 		if [ $RC -ne 0 ]
 		then
 			tst_res TFAIL $LTPTMP/tst_ip.err \
 				"Test #3: ip addr del command failed. Reason: "
 			return $RC
 		else
-			ip addr show dev lo | grep 127.6.6.6 &>$LTPTMP/tst_ip.err || RC=$?
+			ip addr show dev lo | grep 127.6.6.6 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 			if [ $RC -eq 0 ]
 			then
 				tst_res TFAIL $LTPTMP/tst_ip.err \
@@ -343,7 +343,7 @@ test04()
 	tst_resm TINFO \
 	 "Test #4: ip neigh add - adds a new neighbour to arp tables."
 	
-	ip neigh add 127.0.0.1 dev lo nud reachable &>$LTPTMP/tst_ip.err || RC=$?
+	ip neigh add 127.0.0.1 dev lo nud reachable >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then
 		tst_res TFAIL $LTPTMP/tst_ip.err \
@@ -357,7 +357,7 @@ test04()
 		127.0.0.1 dev lo lladdr 00:00:00:00:00:00 nud reachable
 		EOF
 
-		ip neigh show 127.0.0.1 | head -n1 &>$LTPTMP/tst_ip.out || RC=$?
+		ip neigh show 127.0.0.1 | head -n1 >$LTPTMP/tst_ip.out 2>&1 || RC=$?
 		if [ $RC -ne 0 ]
 		then
 			tst_res TFAIL $LTPTMP/tst_ip.err \
@@ -365,7 +365,7 @@ test04()
 			return $RC
 		else
 			diff -iwB  $LTPTMP/tst_ip.out $LTPTMP/tst_ip.exp \
-				&>$LTPTMP/tst_ip.err || RC=$?
+				>$LTPTMP/tst_ip.err 2>&1 || RC=$?
 			if [ $RC -ne 0 ]
 			then
 				tst_res FAIL $LTPTMP/tst_ip.err \
@@ -377,14 +377,14 @@ test04()
 		tst_resm TINFO \
 		 "Test #4: ip neigh del - deletes neighbour from the arp table."
 
-		ip neigh del 127.0.0.1 dev lo &>$LTPTMP/tst_ip.err || RC=$?
+		ip neigh del 127.0.0.1 dev lo >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 		if [ $RC -ne 0 ]
 		then
 			tst_res TFAIL $LTPTMP/tst_ip.err \
 				"Test #4: ip neigh del command failed return = $RC. Reason: "
 			return $RC
 		else
-			ip neigh show | grep 127.0.0.1 grep -v "nud failed$" &>$LTPTMP/tst_ip.err || RC=$?
+			ip neigh show | grep 127.0.0.1 grep -v "nud failed$" >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 			if [ $RC -eq 0 ]
 			then
 				tst_res TFAIL $LTPTMP/tst_ip.err \
@@ -426,7 +426,7 @@ test05()
 	tst_resm TINFO \
 	 "Test #5: create an interface with inet 10.6.6.6 alias to eth0"
 
-	ifconfig eth0:1 10.6.6.6 netmask 255.255.255.0 &>$LTPTMP/tst_ip.err || RC=$?
+	ifconfig eth0:1 10.6.6.6 netmask 255.255.255.0 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then
 		tst_brk TBROK $LTPTMP/tst_ip.err NULL \
@@ -434,7 +434,7 @@ test05()
 		return $RC
 	fi
 	
-	ip route add 10.6.6.6 via 127.0.0.1 &>$LTPTMP/tst_ip.err || RC=$?
+	ip route add 10.6.6.6 via 127.0.0.1 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then
 		tst_res TFAIL $LTPTMP/tst_ip.err \
@@ -449,7 +449,7 @@ test05()
 		10.6.6.6 via 127.0.0.1 dev lo
 		EOF
 
-		ip route show | head -n1 &>$LTPTMP/tst_ip.out || RC=$?
+		ip route show | head -n1 >$LTPTMP/tst_ip.out 2>&1 || RC=$?
 		if [ $RC -ne 0 ]
 		then
 			tst_res TFAIL $LTPTMP/tst_ip.err \
@@ -457,7 +457,7 @@ test05()
 			return $RC
 		else
 			diff -iwB  $LTPTMP/tst_ip.out $LTPTMP/tst_ip.exp \
-				&>$LTPTMP/tst_ip.err || RC=$?
+				>$LTPTMP/tst_ip.err 2>&1 || RC=$?
 			if [ $RC -ne 0 ]
 			then
 				tst_res FAIL $LTPTMP/tst_ip.err \
@@ -469,14 +469,14 @@ test05()
 		tst_resm TINFO \
 		 "Test #5: ip route del - deletes route from the route table."
 
-		ip route del 10.6.6.6 via 127.0.0.1 &>$LTPTMP/tst_ip.err || RC=$?
+		ip route del 10.6.6.6 via 127.0.0.1 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 		if [ $RC -ne 0 ]
 		then
 			tst_res TFAIL $LTPTMP/tst_ip.err \
 				"Test #5: ip route del command failed return = $RC. Reason: "
 			return $RC
 		else
-			ip route show | grep 127.0.0.1 &>$LTPTMP/tst_ip.err || RC=$?
+			ip route show | grep 127.0.0.1 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 			if [ $RC -eq 0 ]
 			then
 				tst_res TFAIL $LTPTMP/tst_ip.err \
@@ -514,7 +514,7 @@ test06()
 	tst_resm TINFO \
 	 "Test #6: ip maddr add - adds a new multicast addr"
 
-	ifconfig eth0:1 10.6.6.6 netmask 255.255.255.0 &>$LTPTMP/tst_ip.err || RC=$?
+	ifconfig eth0:1 10.6.6.6 netmask 255.255.255.0 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then
 		tst_brk TBROK $LTPTMP/tst_ip.err NULL \
@@ -522,7 +522,7 @@ test06()
 		return $RC
 	fi
 	
-	ip maddr add 66:66:00:00:00:66 dev eth0:1 &>$LTPTMP/tst_ip.err || RC=$?
+	ip maddr add 66:66:00:00:00:66 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 	if [ $RC -ne 0 ]
 	then
 		tst_res TFAIL $LTPTMP/tst_ip.err \
@@ -536,7 +536,7 @@ test06()
         link  66:66:00:00:00:66 static
 		EOF
 
-		ip maddr show | grep "66:66:00:00:00:66" &>$LTPTMP/tst_ip.out || RC=$?
+		ip maddr show | grep "66:66:00:00:00:66" >$LTPTMP/tst_ip.out 2>&1 || RC=$?
 		if [ $RC -ne 0 ]
 		then
 			tst_res TFAIL $LTPTMP/tst_ip.err \
@@ -556,7 +556,7 @@ test06()
 		tst_resm TINFO \
 		 "Test #6: ip maddr del - deletes multicast addr."
 
-		ip maddr del 66:66:00:00:00:66 dev eth0:1 &>$LTPTMP/tst_ip.err || RC=$?
+		ip maddr del 66:66:00:00:00:66 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
 		if [ $RC -ne 0 ]
 		then
 			tst_res TFAIL $LTPTMP/tst_ip.err \
diff --git a/testcases/network/nfs/nfs03/nfs03 b/testcases/network/nfs/nfs03/nfs03
index 8cbd3a4..f4fc6ee 100755
--- a/testcases/network/nfs/nfs03/nfs03
+++ b/testcases/network/nfs/nfs03/nfs03
@@ -91,10 +91,10 @@ fs_inod()
 #
 # RETURNS:              None.
 #=============================================================================
-function err_log
+err_log()
 {
     error "$1"
-    let step_errors="$step_errors + 1"
+    step_errors=$(($step_errors + 1))
 }
 
 
@@ -107,7 +107,7 @@ function err_log
 #
 # RETURNS:              None.
 #=============================================================================
-function make_subdirs
+make_subdirs()
 {
     i=0;
     while [ "$i" -lt "$numsubdirs" ]; do
@@ -115,7 +115,7 @@ function make_subdirs
             echo "$0: mkdir dir$i"
             mkdir -p dir$i || echo "mkdir dir$i FAILED"
         }
-        let i="$i + 1"
+        i=$(($i + 1))
     done;
 }
 
@@ -129,7 +129,7 @@ function make_subdirs
 #
 # RETURNS:              None.
 #=============================================================================
-function touch_files
+touch_files()
 {
     echo "$0: touch files [0-$numsubdirs]/file$numsubdirs[0-$numfiles]"
     j=0;
@@ -140,10 +140,10 @@ function touch_files
 
         while [ "$k" -lt "$numfiles" ]; do
             >file$j$k || err_log ">file$j$k FAILED"
-            let k="$k + 1"
+            k=$(($k + 1))
         done
 
-        let j="$j + 1"
+        j=$(($j + 1))
         cd ..
     done
 }
@@ -158,7 +158,7 @@ function touch_files
 #
 # RETURNS:      None.
 #=============================================================================
-function rm_files
+rm_files()
 {
     echo "$0: rm files [0-$numsubdirs]/file$numsubdirs[0-$numfiles]"
     j=0;
@@ -169,10 +169,10 @@ function rm_files
 
         while [ "$k" -lt "$numfiles" ]; do
             rm -f file$j$k || err_log "rm -f file$j$k FAILED"
-            let k="$k + 1"
+            k=$(($k + 1))
         done
 
-        let j="$j + 1"
+        j=$(($j + 1))
         cd ..
     done
 }
@@ -187,7 +187,7 @@ function rm_files
 #
 # RETURNS:              None.
 #=============================================================================
-function step1
+step1()
 {
     echo "=============================================="
     echo "MULTIPLE PROCESSES CREATING AND DELETING FILES"
@@ -240,7 +240,7 @@ function step1
         rm_files &
         pid2=$!
 
-        let i="$i + 1"
+        i=$(($i + 1))
     done
 
     # wait for all background processes to complete execution
@@ -376,7 +376,7 @@ $trace_logic
     echo "fs_inod starting on $TCtmp."
     fs_inod $TCtmp $DIR_NUM $FILE_NUM 1 
     retval=$?
-    echo $"fs_inod on $TCtmp finished."
+    echo "fs_inod on $TCtmp finished."
     
     if [ "$retval" != 0 ]; then
       end_testcase "Errors have resulted from this test: fs_inod returned $retval."
-- 
1.6.3.1




------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
