From: Han, NingX <ningx.han@intel.com>
Date: Fri, 2 Dec 2016 03:03:19 +0000
Subject: [LTP] [PATCH ltp] su01: do pre-checking to avoid annoying warnings
Message-ID: <AAAF599D7BFC7245B4AE22D9263FF7FB36C97CA3@shsmsx102.ccr.corp.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

do pre-checking of file/directory/user to avoid warnings like:
mkdir: cannot create directory '/home/su_usr1': File exists

Signed-off-by: Ning Han <ningx.han@intel.com>
---
testcases/commands/su/su01 | 12 ++++++------
1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/commands/su/su01 b/testcases/commands/su/su01
index dd1517f..9510f29 100755
--- a/testcases/commands/su/su01
+++ b/testcases/commands/su/su01
@@ -85,8 +85,8 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
 #Create 1st test user
     #erase user if he may exist , so we can have a clean en
-        rm -rf /home/$TEST_USER1
-        userdel $TEST_USER1
+        [ -e /home/$TEST_USER1 ] && rm -rf /home/$TEST_USER1
+        getent passwd $TEST_USER1 && userdel $TEST_USER1
               sleep 1
         useradd -m -g users $TEST_USER1
@@ -105,7 +105,7 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
               then {
           USER_UID=`id -u $TEST_USER1`
           USER_GID=`id -g $TEST_USER1`
-          mkdir $TEST_USER1_HOMEDIR
+          [ -e $TEST_USER1_HOMEDIR ] || mkdir $TEST_USER1_HOMEDIR
           chown -R $USER_UID.$USER_GID $TEST_USER1_HOMEDIR
               }
               fi
@@ -120,8 +120,8 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
 #Create 2nd test user
               #erase user if he may exist , so we can have a clean en
-        rm -rf /home/$TEST_USER2
-        userdel $TEST_USER2
+        [ -e /home/$TEST_USER2 ] && rm -rf /home/$TEST_USER2
+        getent passwd $TEST_USER2 && userdel $TEST_USER2
               sleep 1
         useradd -m -g users $TEST_USER2
@@ -141,7 +141,7 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
         then {
           USER_UID=`id -u $TEST_USER2`
           USER_GID=`id -g $TEST_USER2`
-          mkdir $TEST_USER2_HOMEDIR
+          [ -e $TEST_USER2_HOMEDIR ] || mkdir $TEST_USER2_HOMEDIR
           chown -R $USER_UID.$USER_GID $TEST_USER2_HOMEDIR
               }
               fi
--
2.7.4
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161202/bbdfed0e/attachment.html>
