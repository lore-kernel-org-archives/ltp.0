From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue, 29 Nov 2016 09:22:40 +0100
Subject: [LTP] [PATCH v3 4/4] shell: fix echo -e bashisms, simplify code
In-Reply-To: <20161129082240.16473-1-petr.vorel@gmail.com>
References: <20161129082240.16473-1-petr.vorel@gmail.com>
Message-ID: <20161129082240.16473-4-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Changes v2->v3:
* convert one more echo -e (slay)
* use printf consistently (tacl_xattr.sh, slay)

There could have been more cleanup done in (tacl_xattr.sh: print errors into
stderr, ...), but some script aren't called anywhere (tacl_xattr.sh,
statslogging, mixed_load.sh, slay), I suppose I should have delete them instead
of fixing.
---
 testcases/commands/sssd/sssd-lib.sh                |  10 +-
 testcases/kernel/fs/acl/tacl_xattr.sh              | 312 ++++++++-------------
 .../realtime/func/periodic_cpu_load/mixed_load.sh  |   2 +-
 testcases/realtime/perf/latency/run_auto.sh        |  14 +-
 testcases/realtime/run.sh                          |   6 +-
 testscripts/test_realtime.sh                       |  37 +--
 tools/pounder21/test_scripts/statslogging          |  14 +-
 tools/strace_test/slay                             |   8 +-
 8 files changed, 168 insertions(+), 235 deletions(-)

diff --git a/testcases/commands/sssd/sssd-lib.sh b/testcases/commands/sssd/sssd-lib.sh
index ab16fd4..be72e1f 100755
--- a/testcases/commands/sssd/sssd-lib.sh
+++ b/testcases/commands/sssd/sssd-lib.sh
@@ -1,4 +1,4 @@
-#! /bin/sh
+#!/bin/sh
 #
 #  Copyright (c) 2012 FUJITSU LIMITED
 #
@@ -161,10 +161,10 @@ restart_sssd_daemon()
 #id_provider = local
 make_config_file()
 {
-	echo -e "[sssd]\nconfig_file_version = 2" > $CONFIG_FILE
-	echo -e "services = nss, pam\ndomains = LOCAL" >> $CONFIG_FILE
-	echo -e "\n[nss]\n\n[pam]\n" >> $CONFIG_FILE
-	echo -e "[domain/LOCAL]\nid_provider = local" >> $CONFIG_FILE
+	printf "[sssd]\nconfig_file_version = 2\n" > $CONFIG_FILE
+	printf "services = nss, pam\ndomains = LOCAL\n" >> $CONFIG_FILE
+	printf "\n[nss]\n\n[pam]\n\n" >> $CONFIG_FILE
+	printf "[domain/LOCAL]\nid_provider = local\n" >> $CONFIG_FILE
 }
 
 . cmdlib.sh
diff --git a/testcases/kernel/fs/acl/tacl_xattr.sh b/testcases/kernel/fs/acl/tacl_xattr.sh
index 039bd17..c2383fd 100755
--- a/testcases/kernel/fs/acl/tacl_xattr.sh
+++ b/testcases/kernel/fs/acl/tacl_xattr.sh
@@ -83,9 +83,8 @@ chmod 777 tacl/blkext2
 losetup /dev/loop0 tacl/blkext2 >/dev/null 2>&1
 if [ $? != 0 ]
 then
-	echo ""
-	echo "FAILED:  [ losetup ] Must have loop device support by kernel"
-	echo -e "\t to execute this script"
+	printf "\nFAILED:  [ losetup ] Must have loop device support by kernel\n"
+	printf "\t to execute this script\n"
 	exit 1
 fi
 
@@ -97,10 +96,9 @@ then
 	mount -t ext3 -o defaults,acl,user_xattr /dev/loop0 tacl/mount-ext2
 	if [ $? != 0 ]
 	then
-		echo ""
-		echo "FAILED:  [ mount ] Make sure that ACL (Access Control List)"
-		echo -e "\t and Extended Attribute are built into the kernel"
-		echo -e "\t Can not mount ext2 file system with acl and user_xattr options"
+		printf "\nFAILED:  [ mount ] Make sure that ACL (Access Control List)\n"
+		printf "\t and Extended Attribute are built into the kernel\n"
+		printf "\t Can not mount ext2 file system with acl and user_xattr options\n"
 		exit 1
 	fi
 
@@ -110,10 +108,9 @@ else
 	mount -t ext2 -o defaults,acl,user_xattr /dev/loop0 tacl/mount-ext2
 	if [ $? != 0 ]
 	then
-		echo ""
-		echo "FAILED:  [ mount ] Make sure that ACL (Access Control List)"
-		echo -e "\t and Extended Attribute are built into the kernel"
-		echo -e "\t Can not mount ext2 file system with acl and user_xattr options"
+		printf "\nFAILED:  [ mount ] Make sure that ACL (Access Control List)\n"
+		printf "\t and Extended Attribute are built into the kernel\n"
+		printf "\t Can not mount ext2 file system with acl and user_xattr options\n"
 		exit 1
 	fi
 fi
@@ -179,23 +176,19 @@ su - tacluser1 << TACL_USER1
 	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfil1 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile1 ]
 	then
-		echo ""
-		echo "FAILED:  [ touch ] Create file must be denied by file permission bits"
-		echo -e "\t [ Physical Directory ]"
+		printf "\nFAILED:  [ touch ] Create file must be denied by file permission bits\n"
+		printf "\t [ Physical Directory ]\n"
 	else
-		echo ""
-		echo "SUCCESS: Create file denied by file permission bits [ Physical directory ]"
+		printf "\nSUCCESS: Create file denied by file permission bits [ Physical directory ]\n"
 	fi
 
 	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfil2 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile2 ]
 	then
-		echo ""
-		echo "FAILED:  [ touch ] Create file must be denied by file permission bits"
-		echo -e "\t [ Symlink Directory ]"
+		printf "\nFAILED:  [ touch ] Create file must be denied by file permission bits\n"
+		printf "\t [ Symlink Directory ]\n"
 	else
-		echo ""
-		echo "SUCCESS: Create file denied by file permission bits [ Symlink directory ]"
+		printf "\nSUCCESS: Create file denied by file permission bits [ Symlink directory ]\n"
 	fi
 
 TACL_USER1
@@ -216,25 +209,21 @@ su - tacluser1 << TACL_USER1
 	cd $CUR_PATH/tacl/mount-ext2/shared/team1/ 2> /dev/null
 	if [ $? != 0 ]
 	then
-		echo ""
-		echo "FAILED:  [ touch ] ACL_USER_OBJ  entry already contains the owner execute"
-		echo -e "\t permissions, but operation failed [ Physical Directory ]"
+		printf "\nFAILED:  [ touch ] ACL_USER_OBJ  entry already contains the owner execute\n"
+		printf "\t permissions, but operation failed [ Physical Directory ]\n"
 	else
-		echo ""
-		echo "SUCCESS: ACL_USER_OBJ  entry contains the owner execute permissions, "
-		echo -e "\t operation success [ Physical Directory ]"
+		printf "\nSUCCESS: ACL_USER_OBJ  entry contains the owner execute permissions,\n"
+		printf "\t operation success [ Physical Directory ]\n"
 	fi
 
 	cd $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/ 2> /dev/null
 	if [ $? != 0 ]
 	then
-		echo ""
-		echo "FAILED: [ touch ] ACL_USER_OBJ  entry already contains the owner execute"
-		echo -e "\t permissions, but operation failed [ Symlink Directory ]"
+		printf "\nFAILED: [ touch ] ACL_USER_OBJ  entry already contains the owner execute\n"
+		printf "\t permissions, but operation failed [ Symlink Directory ]\n"
 	else
-		echo ""
-		echo "SUCCESS: ACL_USER_OBJ  entry contains the owner execute permissions,"
-		echo -e "\t operation success [ Symlink Directory ]"
+		printf "\nSUCCESS: ACL_USER_OBJ  entry contains the owner execute permissions,\n"
+		printf "\t operation success [ Symlink Directory ]\n"
 	fi
 
 TACL_USER1
@@ -246,25 +235,21 @@ su - tacluser1 << TACL_USER1
 	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfil1 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile1 ]
 	then
-		echo ""
-		echo "FAILED:  [ touch ] ACL_USER_OBJ  entry already contains the owner write "
-		echo -e "\t permissions, but operation failed [ Physical Directory ]"
+		printf "\nFAILED:  [ touch ] ACL_USER_OBJ  entry already contains the owner write \n"
+		printf "\t permissions, but operation failed [ Physical Directory ]\n"
 	else
-		echo ""
-		echo "SUCCESS: ACL_USER_OBJ  entry contains the owner write permissions,"
-		echo -e "\t operation success [ Physical Directory ]"
+		printf "\nSUCCESS: ACL_USER_OBJ  entry contains the owner write permissions,\n"
+		printf "\t operation success [ Physical Directory ]\n"
 	fi
 
 	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfil2 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile2 ]
 	then
-		echo ""
-		echo "FAILED:  [ touch ] ACL_USER_OBJ  entry already contains the owner write "
-		echo -e "\t permissions, but operation failed [ Symlink Directory ]"
+		printf "\nFAILED:  [ touch ] ACL_USER_OBJ  entry already contains the owner write \n"
+		printf "\t permissions, but operation failed [ Symlink Directory ]\n"
 	else
-		echo ""
-		echo "SUCCESS: ACL_USER_OBJ  entry contains the owner write permissions,"
-		echo -e "\t operation success [ Symlink Directory ]"
+		printf "\nSUCCESS: ACL_USER_OBJ  entry contains the owner write permissions,\n"
+		printf "\t operation success [ Symlink Directory ]\n"
 	fi
 
 TACL_USER1
@@ -286,25 +271,21 @@ su - tacluser3 << TACL_USER3
 	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile3 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile3 ]
 	then
-		echo ""
-		echo "SUCCESS: ACL_USER entry contains the user permissions, "
-		echo -e "\t operation success [ Physical Directory ]"
+		printf "\nSUCCESS: ACL_USER entry contains the user permissions,\n"
+		printf "\t operation success [ Physical Directory ]\n"
 	else
-		echo ""
-		echo "FAILED:  ACL_USER entry contains the user permissions,"
-		echo -e "\t but operation denied [ Physical Directory ]"
+		printf "\nFAILED:  ACL_USER entry contains the user permissions,\n"
+		printf "\t but operation denied [ Physical Directory ]\n"
 	fi
 
 	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile4 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile4 ]
 	then
-		echo ""
-		echo "SUCCESS: ACL_USER entry contains the user permissions, "
-		echo -e "\t operation success [ Symlink Directory ]"
+		printf "\nSUCCESS: ACL_USER entry contains the user permissions,\n"
+		printf "\t operation success [ Symlink Directory ]\n"
 	else
-		echo ""
-		echo "FAILED:  ACL_USER entry contains the user permissions,"
-		echo -e "\t but operation denied [ Symlink Directory ]"
+		printf "\nFAILED:  ACL_USER entry contains the user permissions,\n"
+		printf "\t but operation denied [ Symlink Directory ]\n"
 	fi
 
 TACL_USER3
@@ -316,29 +297,25 @@ su - tacluser3 << TACL_USER3
 	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile5 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile5 ]
 	then
-		echo ""
-		echo "FAILED:  [ touch ] ACL_USER entry contains the user permissions"
-		echo -e "\t but ACL_MASK are set --- , "
-		echo -e "\t operation must be denied [ Physical Directory ]"
+		printf "\nFAILED:  [ touch ] ACL_USER entry contains the user permissions\n"
+		printf "\t but ACL_MASK are set --- ,\n"
+		printf "\t operation must be denied [ Physical Directory ]\n"
 	else
-		echo ""
-		echo "SUCCESS: ACL_USER entry contains the user permissions,"
-		echo -e "\t but ACL_MASK are set ___ ,"
-		echo -e "\t operation success [ Physical Directory ]"
+		printf "\nSUCCESS: ACL_USER entry contains the user permissions,\n"
+		printf "\t but ACL_MASK are set ___ ,\n"
+		printf "\t operation success [ Physical Directory ]\n"
 	fi
 
 	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile6 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile6 ]
 	then
-		echo ""
-		echo "FAILED:  [ touch ] ACL_USER entry contains the user permissions"
-		echo -e "\t but ACL_MASK are set --- ,"
-		echo -e "\t operation must be denied [ Symlink Directory ]"
+		printf "\nFAILED:  [ touch ] ACL_USER entry contains the user permissions\n"
+		printf "\t but ACL_MASK are set --- ,\n"
+		printf "\t operation must be denied [ Symlink Directory ]\n"
 	else
-		echo ""
-		echo "SUCCESS: ACL_USER entry contains the user permissions,"
-		echo -e "\t but ACL_MASK are set ___ ,"
-		echo -e "\t operation success [ Symlink Directory ]"
+		printf "\nSUCCESS: ACL_USER entry contains the user permissions,\n"
+		printf "\t but ACL_MASK are set ___ ,\n"
+		printf "\t operation success [ Symlink Directory ]\n"
 	fi
 
 TACL_USER3
@@ -370,25 +347,21 @@ su - tacluser2 << TACL_USER2
 	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile7 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile7 ]
 	then
-		echo ""
-		echo "SUCCESS: ACL_GROUP entry contains the group permissions,"
-		echo -e "\t option success [ Physical Directory ]"
+		printf "\nSUCCESS: ACL_GROUP entry contains the group permissions,\n"
+		printf "\t option success [ Physical Directory ]\n"
 	else
-		echo ""
-		echo "FAILED:  [ touch ] ACL_GROUP entry already contains the group permissions,"
-		echo -e "\t but option success [ Physical Directory ]"
+		printf "\nFAILED:  [ touch ] ACL_GROUP entry already contains the group permissions,\n"
+		printf "\t but option success [ Physical Directory ]\n"
 	fi
 
 	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile8 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile8 ]
 	then
-		echo ""
-		echo "SUCCESS: ACL_GROUP entry contains the group permissions,"
-		echo -e "\t option success [ Symlink Directory ]"
+		printf "\nSUCCESS: ACL_GROUP entry contains the group permissions,\n"
+		printf "\t option success [ Symlink Directory ]\n"
 	else
-		echo ""
-		echo "FAILED:  [ touch ] ACL_GROUP entry already contains the group permissions,"
-		echo -e "\t but option success [ Symlink Directory ]"
+		printf "\nFAILED:  [ touch ] ACL_GROUP entry already contains the group permissions,\n"
+		printf "\t but option success [ Symlink Directory ]\n"
 	fi
 
 TACL_USER2
@@ -399,29 +372,25 @@ su - tacluser2 << TACL_USER2
 	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile9 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile9 ]
 	then
-		echo ""
-		echo "FAILED:  [ touch ] ACL_GROUP entry contains the group permissions"
-		echo -e "\t and ACL_MASK entry are set ---,"
-		echo -e "\t option must no be success [ Physical Directory ]"
+		printf "\nFAILED:  [ touch ] ACL_GROUP entry contains the group permissions\n"
+		printf "\t and ACL_MASK entry are set ---,\n"
+		printf "\t option must no be success [ Physical Directory ]\n"
 	else
-		echo ""
-		echo "SUCCESS: ACL_GROUP entry already contains the group permissions"
-		echo -e "\t and ACL_MASK entry are set ---,"
-		echo -e "\t option success [ Physical Directory ]"
+		printf "\nSUCCESS: ACL_GROUP entry already contains the group permissions\n"
+		printf "\t and ACL_MASK entry are set ---,\n"
+		printf "\t option success [ Physical Directory ]\n"
 	fi
 
 	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile10 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile10 ]
 	then
-		echo ""
-		echo "FAILED:  [ touch ] ACL_GROUP entry contains the group permissions"
-		echo -e "\t and ACL_MASK entry are set ---, "
-		echo -e "\t option must no be success [ Symlink Directory ]"
+		printf "\nFAILED:  [ touch ] ACL_GROUP entry contains the group permissions\n"
+		printf "\t and ACL_MASK entry are set ---,\n"
+		printf "\t option must no be success [ Symlink Directory ]\n"
 	else
-		echo ""
-		echo "SUCCESS: ACL_GROUP entry already contains the group permissions"
-		echo -e "\t and ACL_MASK entry are set ---,"
-		echo -e "\t option success [ Symlink Directory ]"
+		printf "\nSUCCESS: ACL_GROUP entry already contains the group permissions\n"
+		printf "\t and ACL_MASK entry are set ---,\n"
+		printf "\t option success [ Symlink Directory ]\n"
 	fi
 
 TACL_USER2
@@ -434,25 +403,21 @@ su - tacluser2 << TACL_USER2
 	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile11 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile11 ]
 	then
-		echo ""
-		echo "SUCCESS: ACL_GROUP_OBJ entry contains the group owner permissions,"
-		echo -e "\t option success [ Physical Directory ]"
+		printf "\nSUCCESS: ACL_GROUP_OBJ entry contains the group owner permissions,\n"
+		printf "\t option success [ Physical Directory ]\n"
 	else
-		echo ""
-		echo "FAILED:  [ touch ] ACL_GROUP_OBJ entry already contains the group owner,"
-		echo -e "\t but option denied [ Physical Directory ]"
+		printf "\nFAILED:  [ touch ] ACL_GROUP_OBJ entry already contains the group owner,\n"
+		printf "\t but option denied [ Physical Directory ]\n"
 	fi
 
 	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile12 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile12 ]
 	then
-		echo ""
-		echo "SUCCESS: ACL_GROUP_OBJ entry contains the group owner permissions,"
-		echo -e "\t option success [ Symlink Directory ]"
+		printf "\nSUCCESS: ACL_GROUP_OBJ entry contains the group owner permissions,\n"
+		printf "\t option success [ Symlink Directory ]\n"
 	else
-		echo ""
-		echo "FAILED:  [ touch ] ACL_GROUP_OBJ entry already contains the group owner,"
-		echo -e "\t but option denied [ Symlink Directory ]"
+		printf "\nFAILED:  [ touch ] ACL_GROUP_OBJ entry already contains the group owner,\n"
+		printf "\t but option denied [ Symlink Directory ]\n"
 	fi
 
 TACL_USER2
@@ -463,29 +428,25 @@ su - tacluser2 << TACL_USER2
 	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile13 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile13 ]
 	then
-		echo ""
-		echo "FAILED:  [ touch ] ACL_GROUP_OBJ entry contains the group owner permissions"
-		echo -e "\t and ACL_MASK entry are set ---,"
-		echo -e "\t option must no be success [ Physical Directory ]"
+		printf "\nFAILED:  [ touch ] ACL_GROUP_OBJ entry contains the group owner permissions\n"
+		printf "\t and ACL_MASK entry are set ---,\n"
+		printf "\t option must no be success [ Physical Directory ]\n"
 	else
-		echo ""
-		echo "SUCCESS: ACL_GROUP_OBJ entry already contains the group owner permissions"
-		echo -e "\t and ACL_MASK entry are set ---,"
-		echo -e "\t option success [ Physical Directory ]"
+		printf "\nSUCCESS: ACL_GROUP_OBJ entry already contains the group owner permissions\n"
+		printf "\t and ACL_MASK entry are set ---,\n"
+		printf "\t option success [ Physical Directory ]\n"
 	fi
 
 	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile14 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile14 ]
 	then
-		echo ""
-		echo "FAILED:  [ touch ] ACL_GROUP_OBJ entry contains the group owner permissions"
-		echo -e "\t and ACL_MASK entry are set ---,"
-		echo -e "\t option must no be success [ Symlink Directory ]"
+		printf "\nFAILED:  [ touch ] ACL_GROUP_OBJ entry contains the group owner permissions\n"
+		printf "\t and ACL_MASK entry are set ---,\n"
+		printf "\t option must no be success [ Symlink Directory ]\n"
 	else
-		echo ""
-		echo "SUCCESS: ACL_GROUP_OBJ entry already contains the group owner permissions"
-		echo -e "\t and ACL_MASK entry are set ---, "
-		echo -e "\t option success [ Symlink Directory ]"
+		printf "\nSUCCESS: ACL_GROUP_OBJ entry already contains the group owner permissions\n"
+		printf "\t and ACL_MASK entry are set ---,\n"
+		printf "\t option success [ Symlink Directory ]\n"
 	fi
 
 TACL_USER2
@@ -505,25 +466,21 @@ su - tacluser4 << TACL_USER4
 	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile15 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile15 ]
 	then
-		echo ""
-		echo "SUCCESS: ACL_OTHER entry contains the user permissions,"
-		echo -e "\t operation success [ Physical Directory ]"
+		printf "\nSUCCESS: ACL_OTHER entry contains the user permissions,\n"
+		printf "\t operation success [ Physical Directory ]\n"
 	else
-		echo ""
-		echo "FAILED:  ACL_OTHER entry contains the user permissions,"
-		echo -e "\t but operation denied [ Physical Directory ]"
+		printf "\nFAILED:  ACL_OTHER entry contains the user permissions,\n"
+		printf "\t but operation denied [ Physical Directory ]\n"
 	fi
 
 	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile16 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile16 ]
 	then
-		echo ""
-		echo "SUCCESS: ACL_OTHER entry contains the user permissions,"
-		echo -e "\t operation success [ Symlink Directory ]"
+		printf "\nSUCCESS: ACL_OTHER entry contains the user permissions,\n"
+		printf "\t operation success [ Symlink Directory ]\n"
 	else
-		echo ""
-		echo "FAILED:  ACL_OTHER entry contains the user permissions,"
-		echo -e "\t but operation denied [ Symlink Directory ]"
+		printf "\nFAILED:  ACL_OTHER entry contains the user permissions,\n"
+		printf "\t but operation denied [ Symlink Directory ]\n"
 	fi
 
 TACL_USER4
@@ -535,21 +492,17 @@ su - tacluser4 << TACL_USER4
 	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile17 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile17 ]
 	then
-		echo ""
-		echo "SUCCESS: [ touch ] ACL_OTHER do not strick by ACL_MASK [ Physical Directory ]"
+		printf "\nSUCCESS: [ touch ] ACL_OTHER do not strick by ACL_MASK [ Physical Directory ]\n"
 	else
-		echo ""
-		echo "FAILED:  ACL_OTHER do not strick by ACL_MASK [ Physical Directory ]"
+		printf "\nFAILED:  ACL_OTHER do not strick by ACL_MASK [ Physical Directory ]\n"
 	fi
 
 	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile18 2> /dev/null
 	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile18 ]
 	then
-		echo ""
-		echo "SUCCESS: [ touch ] ACL_OTHER do not strick by ACL_MASK [ Symlink Directory ]"
+		printf "\nSUCCESS: [ touch ] ACL_OTHER do not strick by ACL_MASK [ Symlink Directory ]\n"
 	else
-		echo ""
-		echo "FAILED:  ACL_OTHER do not strick by ACL_MASK [ Symlink Directory ]"
+		printf "\nFAILED:  ACL_OTHER do not strick by ACL_MASK [ Symlink Directory ]\n"
 	fi
 
 TACL_USER4
@@ -583,11 +536,9 @@ RES=`echo $CONTENT | grep ".r--r--r--" | awk '{print $1}'`
 
 if [ $RES != "" ]
 then
-	echo ""
-	echo "SUCCESS: With default ACLs set , new file permission set correct."
+	printf "\nSUCCESS: With default ACLs set, new file permission set correct.\n"
 else
-	echo ""
-	echo "FAILED:  With default ACLs set , new file permission set not correct"
+	printf "\nFAILED:  With default ACLs set, new file permission set not correct\n"
 fi
 
 
@@ -611,11 +562,9 @@ RES=`echo $CONTENT | grep ".r--rw-r--" | awk '{print $1}'`
 
 if [ $RES != "" ]
 then
-	echo ""
-	echo "SUCCESS: With default ACLs set , new file permission set correct."
+	printf "\nSUCCESS: With default ACLs set, new file permission set correct.\n"
 else
-	echo ""
-	echo "FAILED:  With default ACLs set , new file permission set not correct"
+	printf "\nFAILED:  With default ACLs set, new file permission set not correct\n"
 fi
 
 #
@@ -638,11 +587,9 @@ RES=`echo $CONTENT | grep ".rw-rw-rw-" | awk '{print \$1}'`
 
 if [ $RES != "" ]
 then
-	echo ""
-	echo "SUCCESS: With default ACLs set , new file permission set correct."
+	printf "\nSUCCESS: With default ACLs set, new file permission set correct.\n"
 else
-	echo ""
-	echo "FAILED:  With default ACLs set , new file permission set not correct"
+	printf "\nFAILED:  With default ACLs set, new file permission set not correct\n"
 fi
 
 
@@ -673,19 +620,15 @@ then
 	then
 		if [ $OTHER_PERMISSION = "other::rwx" ]
 		then
-			echo ""
-			echo "SUCCESS: Chmod with ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER are correct"
+			printf "\nSUCCESS: Chmod with ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER are correct\n"
 		else
-			echo ""
-			echo "FAILED:  Chmod with ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER are not correct"
+			printf "\nFAILED:  Chmod with ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER are not correct\n"
 		fi
 	else
-		echo ""
-		echo "FAILED:  Chmod with ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER are not correct"
+		printf "\nFAILED:  Chmod with ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER are not correct\n"
 	fi
 else
-	echo ""
-	echo "FAILED:  Chmod with ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER are not correct"
+	printf "\nFAILED:  Chmod with ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER are not correct\n"
 fi
 
 
@@ -706,11 +649,9 @@ if [ $ITEM_OWNER = "tacluser2" ]
 then
 	if [ $ITEM_GROUP = "tacluser2" ]
 	then
-		echo ""
-		echo "SUCCESS: Chown correct"
+		printf "\nSUCCESS: Chown correct\n"
 	else
-		echo ""
-		echo "FAILED:  Chown are not correct"
+		printf "\nFAILED:  Chown are not correct\n"
 	fi
 else
 	echo "FAILED:  Chown are not correct"
@@ -729,15 +670,12 @@ getfacl -RL tacl/mount-ext2/ > tacl/tmp2
 
 if [ `diff tacl/tmp1 tacl/tmp2` ]
 then
-	echo ""
-	echo "FAILED:  ACLs backup and restore are not correct"
+	printf "\nFAILED:  ACLs backup and restore are not correct\n"
 else
-	echo ""
-	echo "SUCCESS: ACLs backup and restore are correct"
+	printf "\nSUCCESS: ACLs backup and restore are correct\n"
 fi
 
-echo ""
-echo -e "\tEnd ACLs Test"
+printf "\n\tEnd ACLs Test\n"
 
 #####################################################
 #
@@ -745,13 +683,10 @@ echo -e "\tEnd ACLs Test"
 #
 #####################################################
 
-echo
-echo "Now begin Extend Attribute Test"
+printf "\nNow begin Extend Attribute Test\n"
 
 # dir
-echo
-echo "Attach name:value pair to object dir "
-echo ""
+printf "\nAttach name:value pair to object dir\n\n"
 attr -s attrname1 -V attrvalue1 tacl/mount-ext2/shared/team2
 if [ $? != 0 ]
 then
@@ -849,15 +784,12 @@ setfattr -h --restore=tacl/backup.ea
 getfattr -dhR -m- -e hex tacl/mount-ext2 > tacl/backup.ea1
 if [ `diff  tacl/backup.ea1  tacl/backup.ea` ]
 then
-        echo ""
-        echo "FAILED:  EAs backup and restore are not correct"
+        printf "\nFAILED:  EAs backup and restore are not correct\n"
 else
-        echo ""
-        echo "SUCCESS: EAs backup and restore are correct"
+        printf "\nSUCCESS: EAs backup and restore are correct\n"
 fi
 
-echo ""
-echo -e "\tEnd EAs Test"
+printf "\n\tEnd EAs Test\n"
 
 
 
diff --git a/testcases/realtime/func/periodic_cpu_load/mixed_load.sh b/testcases/realtime/func/periodic_cpu_load/mixed_load.sh
index 931d18f..173c2c0 100644
--- a/testcases/realtime/func/periodic_cpu_load/mixed_load.sh
+++ b/testcases/realtime/func/periodic_cpu_load/mixed_load.sh
@@ -226,7 +226,7 @@ else
     RET=1
 fi
 
-echo -e "\nTest complete, see logs pcl-\$CONCURRENTx-t\$THREAD-\$NUM.log for detailed results."
+printf "\nTest complete, see logs pcl-\$CONCURRENTx-t\$THREAD-\$NUM.log for detailed results.\n"
 echo "Criteria: < 10% Difference in average runs"
 echo "Result: $RESULT"
 
diff --git a/testcases/realtime/perf/latency/run_auto.sh b/testcases/realtime/perf/latency/run_auto.sh
index 2c0d203..3311c1e 100755
--- a/testcases/realtime/perf/latency/run_auto.sh
+++ b/testcases/realtime/perf/latency/run_auto.sh
@@ -8,9 +8,9 @@ fi
 source $SCRIPTS_DIR/setenv.sh
 LOG_FILE="$LOG_DIR/$LOG_FORMAT-pthread_cond_many.log"
 
-echo -e "Logging to: " | tee -a $LOG_FILE
-echo -e "$LOG_FILE " | tee -a $LOG_FILE
-echo -e "and to local individual .out files " | tee -a $LOG_FILE
+echo "Logging to: " | tee -a $LOG_FILE
+echo "$LOG_FILE " | tee -a $LOG_FILE
+echo "and to local individual .out files " | tee -a $LOG_FILE
 
 #
 # make will eventually go away from here, as will the above echoes
@@ -26,10 +26,10 @@ nthread=5000
 iter=400
 nproc=5
 
-echo -e "pthread_cond_many configuration:" | tee -a $LOG_FILE
-echo -e "number of threads = $nthread " | tee -a $LOG_FILE
-echo -e "number of iterations = $iter " | tee -a $LOG_FILE
-echo -e "number of processes = $nproc " | tee -a $LOG_FILE
+echo "pthread_cond_many configuration:" | tee -a $LOG_FILE
+echo "number of threads = $nthread " | tee -a $LOG_FILE
+echo "number of iterations = $iter " | tee -a $LOG_FILE
+echo "number of processes = $nproc " | tee -a $LOG_FILE
 
 # Remove any existing local log files
 rm -f $nthread.$iter.$nproc.*.out
diff --git a/testcases/realtime/run.sh b/testcases/realtime/run.sh
index 07bdc83..174b36d 100755
--- a/testcases/realtime/run.sh
+++ b/testcases/realtime/run.sh
@@ -71,9 +71,9 @@ list_tests()
 	pushd $TESTS_DIR >/dev/null
 	for file in `find -name run_auto.sh`
 	do
-		echo -e " `dirname  $file `"
+		echo " `dirname  $file `"
 	done
-		echo -e " \n"
+		printf " \n\n"
 }
 
 run_test()
@@ -103,7 +103,7 @@ run_test()
 		fi
 		pushd $TESTS_DIR >/dev/null
 	else
-		echo -e "\n $test is not a valid test subdirectory "
+		printf "\n $test is not a valid test subdirectory \n"
 		usage
 		exit 1
 	fi
diff --git a/testscripts/test_realtime.sh b/testscripts/test_realtime.sh
index e741309..a50f479 100755
--- a/testscripts/test_realtime.sh
+++ b/testscripts/test_realtime.sh
@@ -41,38 +41,39 @@ fi
 
 function usage()
 {
-	echo -e "\nUsage: test_realtime.sh  -t test-argument [-l loop num_of_iterations] [-t test-argument1 [-l loop ...]] ..."
-	echo -e "\nWhere test-argument = func | stress | perf | all | list | clean | test_name"
-	echo -e "\nand:\n"
-	echo -e " func = 	all functional tests will be run "
-	echo -e " stress = 	all stress tests will be run "
-	echo -e " perf = 	all perf tests will be run "
-	echo -e " all =		all tests will be run "
-	echo -e " list = 	all available tests will be listed "
-	echo -e " clean = 	all logs deleted, make clean performed "
-	echo -e " test_name = 	only test_name subdir will be run (e.g: func/pi-tests) "
-	echo -e "\n"
+	cat <<EOF
+Usage: test_realtime.sh  -t test-argument [-l loop num_of_iterations] [-t test-argument1 [-l loop ...]] ...
+
+ test-argument: func | stress | perf | all | list | clean | test_name
+ func:	 	all functional tests will be run
+ stress: 	all stress tests will be run
+ perf:		all perf tests will be run
+ all:		all tests will be run
+ list:	 	all available tests will be listed
+ clean: 	all logs deleted, make clean performed
+ test_name:	only test_name subdir will be run (e.g: func/pi-tests)
+EOF
 	exit 1;
 }
 
 function check_error()
 {
         if [ $? -gt 0 ]; then
-        echo -e "\n $1 Failed\n"
+        printf "\n $1 Failed\n\n"
         exit 1
         fi
 }
 
 list_tests()
 {
-	echo -e "\nAvailable tests are:\n"
+	printf "\nAvailable tests are:\n\n"
 
 	cd $TESTS_DIR
 	for file in `find -name run_auto.sh`
 	do
-		echo -e " `dirname  $file `"
+		printf " `dirname  $file `\n"
 	done
-		echo -e " \n"
+		printf " \n\n"
 }
 
 function run_test()
@@ -97,11 +98,11 @@ function run_test()
                 ./run_auto.sh
                 done
             else
-                echo -e "\n Failed to find run script in $test \n"
+                printf "\n Failed to find run script in $test \n\n"
             fi
             pushd $TESTS_DIR >/dev/null
         else
-                echo -e "\n $test is not a valid test subdirectory "
+                printf "\n $test is not a valid test subdirectory \n"
                 usage
                 exit 1
         fi
@@ -156,7 +157,7 @@ find_test()
             done
                 pushd $TESTS_DIR >/dev/null
         else
-            echo -e "\n $subdir not found; check name/path with run.sh list "
+            printf "\n $subdir not found; check name/path with run.sh list \n"
         fi
     done
 
diff --git a/tools/pounder21/test_scripts/statslogging b/tools/pounder21/test_scripts/statslogging
index 5185054..f1774ec 100755
--- a/tools/pounder21/test_scripts/statslogging
+++ b/tools/pounder21/test_scripts/statslogging
@@ -38,13 +38,13 @@ INFOFILE=info
 #generic system info
 function sysinfo() {
 	uname -a >> $INFOFILE
-	echo -e "\n[cpuinfo]=================" >>$INFOFILE
+	printf "\n[cpuinfo]=================\n" >>$INFOFILE
 	cat /proc/cpuinfo >> $INFOFILE
-	echo -e "\n[meminfo]=================" >>$INFOFILE
+	printf "\n[meminfo]=================\n" >>$INFOFILE
 	cat /proc/meminfo >> $INFOFILE
-	echo -e "\n[ifinfo]=================" >>$INFOFILE
+	printf "\n[ifinfo]=================\n" >>$INFOFILE
 	/sbin/ifconfig >> $INFOFILE
-	echo -e "\n[sysctl]=================" >>$INFOFILE
+	printf "\n[sysctl]=================\n" >>$INFOFILE
 	sysctl -a >> $INFOFILE
 }
 
@@ -55,7 +55,7 @@ function procinfo() {
 	for i in $PROC_ENTRIES
 	do
 		logfile=`basename $i`
-		echo -e "\n$NOW" >> $logfile.log
+		printf "\n$NOW\n" >> $logfile.log
 		cat /proc/$i >> $logfile.log
 		sleep 1
 	done
@@ -73,7 +73,7 @@ function singleshots(){
 	while true; do
 		vmstat $DELAY $COUNT >> vmstat.log
 		NOW=`date`
-		echo -e "\n$NOW\n" >> vmstat.log
+		printf "\n$NOW\n\n" >> vmstat.log
 	done &
 
 	IOSTAT=`which iostat 2> /dev/null`
@@ -81,7 +81,7 @@ function singleshots(){
 		while true; do
 			iostat -x $DELAY $COUNT >> iostat.log
 			NOW=`date`
-			echo -e "\n$NOW\n" >> iostat.log
+			printf "\n$NOW\n\n" >> iostat.log
 		done &
 	fi
 }
diff --git a/tools/strace_test/slay b/tools/strace_test/slay
index a68e8c9..d3571c0 100755
--- a/tools/strace_test/slay
+++ b/tools/strace_test/slay
@@ -115,11 +115,11 @@ do
   COOL="1"
   if [ "$SLAY_BUTTHEAD" = "on" ]
   then
-    echo "${ME}: $SIGSHOW is kicking $1's butt!"
-    echo -e "\\n\\n\\nI'm kicking your butt.\\n\\n\\n" | write $1 2>/dev/null
+    printf "${ME}: $SIGSHOW is kicking $1's butt!\n"
+    printf "\\n\\n\\nI'm kicking your butt.\\n\\n\\n\n" | write $1 2>/dev/null
   else
-    echo "${ME}: Sending $SIGSHOW signal to $1's process(es)..."
-    echo -e "\\n\\n\\nYour current session has been terminated.\\n\\n\\n" | \
+    printf "${ME}: Sending $SIGSHOW signal to $1's process(es)...\n"
+    printf "\\n\\n\\nYour current session has been terminated.\\n\\n\\n\n" | \
     	write $1 2>/dev/null
   fi
   if [ "$SIGNAL" = "-clean" ]
-- 
2.10.2

