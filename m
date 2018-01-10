From: Steve Muckle <smuckle.linux@gmail.com>
Date: Tue,  9 Jan 2018 18:05:18 -0800
Subject: [LTP] [PATCH] syscalls/chdir03: remove dependency on bin user
Message-ID: <20180110020518.10909-1-smuckle.linux@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The bin user is not present on Android. Remove the dependency on it by
creating the test directory as root, since chdir03 already must be run
as root, and then attempt to chdir into it as nobody.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
---
 testcases/kernel/syscalls/chdir/chdir03.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/chdir/chdir03.c b/testcases/kernel/syscalls/chdir/chdir03.c
index aa0720626ca5..12924664e682 100644
--- a/testcases/kernel/syscalls/chdir/chdir03.c
+++ b/testcases/kernel/syscalls/chdir/chdir03.c
@@ -22,10 +22,9 @@
  *	Testcase for testing that chdir(2) sets EACCES errno
  *
  * ALGORITHM
- *	1.	create a child process, sets its uid to ltpuser1
- *	2.	this child creates a directory with perm 700, and exits
- *	3.	create another child process, sets its uid to ltpuser2
- *	4.	this child attempts to chdir(2) to the directory created in 2.
+ *	1.	running as root, create a directory with perm 700
+ *	2.	create a child process, sets its uid to nobody
+ *	3.	this child attempts to chdir(2) to the directory created in 1
  *		and expects to get an EACCES.
  */
 
@@ -36,7 +35,7 @@
 
 #define DIRNAME "chdir03_dir"
 
-static uid_t nobody_uid, bin_uid;
+static uid_t nobody_uid;
 
 void verify_chdir(void)
 {
@@ -44,7 +43,7 @@ void verify_chdir(void)
 
 	pid = SAFE_FORK();
 	if (!pid) {
-		SAFE_SETUID(bin_uid);
+		SAFE_SETUID(nobody_uid);
 
 		TEST(chdir(DIRNAME));
 
@@ -66,20 +65,11 @@ void verify_chdir(void)
 void setup(void)
 {
 	struct passwd *pw;
-	pid_t pid;
 
 	pw = SAFE_GETPWNAM("nobody");
 	nobody_uid = pw->pw_uid;
-	pw = SAFE_GETPWNAM("bin");
-	bin_uid = pw->pw_uid;
 
-	pid = SAFE_FORK();
-	if (!pid) {
-		SAFE_SETEUID(nobody_uid);
-		SAFE_MKDIR(DIRNAME, 0700);
-		exit(0);
-	}
-	tst_reap_children();
+	SAFE_MKDIR(DIRNAME, 0700);
 }
 
 static struct tst_test test = {
-- 
2.13.6

