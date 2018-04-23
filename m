From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Mon, 23 Apr 2018 11:46:31 +0200
Subject: [LTP] [RFC PATCH 1/9] testcases: su: Fix userdel use
In-Reply-To: <20180423094639.14612-1-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
Message-ID: <20180423094639.14612-2-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

In case "getent" command is not available in the system,
the userdel command will never be executed and for the
second use, the test will fail with:
     useradd: user 'su_usr1' already exists

Fix that by moving "userdel" command in a new line.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/commands/su/su01 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/su/su01 b/testcases/commands/su/su01
index 34386d937..1eedcb636 100755
--- a/testcases/commands/su/su01
+++ b/testcases/commands/su/su01
@@ -86,7 +86,8 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
 #Create 1st test user
     #erase user if he may exist , so we can have a clean en
         rm -rf /home/$TEST_USER1
-        getent passwd $TEST_USER1 > /dev/null 2>&1 && userdel $TEST_USER1
+        getent passwd $TEST_USER1 > /dev/null 2>&1
+	userdel $TEST_USER1
 	sleep 1
=20
         useradd -m -g users $TEST_USER1
@@ -121,7 +122,8 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
 #Create 2nd test user
 	#erase user if he may exist , so we can have a clean en
         rm -rf /home/$TEST_USER2
-        getent passwd $TEST_USER2 > /dev/null 2>&1 && userdel $TEST_USER2
+        getent passwd $TEST_USER2 > /dev/null 2>&1
+	userdel $TEST_USER2
 	sleep 1
=20
         useradd -m -g users $TEST_USER2
--=20
2.11.0

