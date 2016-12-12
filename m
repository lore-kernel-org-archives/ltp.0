From: Ning,Han <ningx.han@intel.com>
Date: Mon, 12 Dec 2016 08:56:34 +0800
Subject: [LTP] [PATCH ltp] su01: do pre-checking to avoid annoying warnings
Message-ID: <1481504194-30726-1-git-send-email-ningx.han@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Ning Han <ningx.han@intel.com>

Signed-off-by: Ning Han <ningx.han@intel.com>
---
 testcases/commands/su/su01 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/commands/su/su01 b/testcases/commands/su/su01
index dd1517f..5e59eff 100755
--- a/testcases/commands/su/su01
+++ b/testcases/commands/su/su01
@@ -86,7 +86,7 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
 #Create 1st test user
     #erase user if he may exist , so we can have a clean en
         rm -rf /home/$TEST_USER1
-        userdel $TEST_USER1
+        getent passwd $TEST_USER1 && userdel $TEST_USER1
 	sleep 1
 
         useradd -m -g users $TEST_USER1
@@ -105,7 +105,7 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
 	then {
           USER_UID=`id -u $TEST_USER1`
           USER_GID=`id -g $TEST_USER1`
-          mkdir $TEST_USER1_HOMEDIR
+          mkdir -p $TEST_USER1_HOMEDIR
           chown -R $USER_UID.$USER_GID $TEST_USER1_HOMEDIR
 	}
 	fi
@@ -121,7 +121,7 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
 #Create 2nd test user
 	#erase user if he may exist , so we can have a clean en
         rm -rf /home/$TEST_USER2
-        userdel $TEST_USER2
+        getent passwd $TEST_USER2 && userdel $TEST_USER2
 	sleep 1
 
         useradd -m -g users $TEST_USER2
@@ -141,7 +141,7 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
         then {
           USER_UID=`id -u $TEST_USER2`
           USER_GID=`id -g $TEST_USER2`
-          mkdir $TEST_USER2_HOMEDIR
+          mkdir -p $TEST_USER2_HOMEDIR
           chown -R $USER_UID.$USER_GID $TEST_USER2_HOMEDIR
 	}
 	fi
-- 
2.7.4

