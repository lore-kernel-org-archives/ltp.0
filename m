Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <njoly@lanfeust.sis.pasteur.fr>) id 1WyjJp-0008IM-BD
	for ltp-list@lists.sourceforge.net; Sun, 22 Jun 2014 15:04:33 +0000
Received: from mail-interne2.pasteur.fr ([157.99.64.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WyjJl-0000y4-4u
	for ltp-list@lists.sourceforge.net; Sun, 22 Jun 2014 15:04:33 +0000
From: Nicolas Joly <njoly@pasteur.fr>
Date: Sun, 22 Jun 2014 17:03:57 +0200
Message-Id: <1403449437-25028-1-git-send-email-njoly@pasteur.fr>
Subject: [LTP] [PATCH] Consistently use tst_require_root() for root user
	check in syscalls.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Signed-off-by: Nicolas Joly <njoly@pasteur.fr>
---
 testcases/kernel/syscalls/adjtimex/adjtimex02.c                   | 6 +-----
 testcases/kernel/syscalls/chmod/chmod05.c                         | 6 +-----
 testcases/kernel/syscalls/fchmod/fchmod02.c                       | 8 ++------
 testcases/kernel/syscalls/fchmod/fchmod04.c                       | 4 +---
 testcases/kernel/syscalls/fchmod/fchmod05.c                       | 8 ++------
 testcases/kernel/syscalls/getresgid/getresgid02.c                 | 7 ++-----
 testcases/kernel/syscalls/getresgid/getresgid03.c                 | 7 ++-----
 testcases/kernel/syscalls/getresuid/getresuid02.c                 | 7 ++-----
 testcases/kernel/syscalls/getresuid/getresuid03.c                 | 7 ++-----
 testcases/kernel/syscalls/ioperm/ioperm01.c                       | 6 +-----
 testcases/kernel/syscalls/ioperm/ioperm02.c                       | 6 +-----
 testcases/kernel/syscalls/iopl/iopl01.c                           | 6 +-----
 testcases/kernel/syscalls/iopl/iopl02.c                           | 6 +-----
 testcases/kernel/syscalls/ipc/msgctl/msgctl04.c                   | 5 ++---
 testcases/kernel/syscalls/ipc/msgget/msgget04.c                   | 4 +---
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c                   | 5 ++---
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c                   | 4 +---
 testcases/kernel/syscalls/ipc/semctl/semctl02.c                   | 4 +---
 testcases/kernel/syscalls/ipc/semget/semget02.c                   | 5 ++---
 testcases/kernel/syscalls/ipc/shmctl/shmctl02.c                   | 5 ++---
 testcases/kernel/syscalls/ipc/shmget/shmget04.c                   | 4 +---
 testcases/kernel/syscalls/mkdir/mkdir02.c                         | 5 +----
 testcases/kernel/syscalls/mkdir/mkdir04.c                         | 5 +----
 testcases/kernel/syscalls/mkdir/mkdir05.c                         | 6 ++----
 testcases/kernel/syscalls/mknod/mknod02.c                         | 8 ++------
 testcases/kernel/syscalls/mknod/mknod03.c                         | 7 +------
 testcases/kernel/syscalls/mknod/mknod04.c                         | 7 +------
 testcases/kernel/syscalls/mknod/mknod05.c                         | 7 +------
 testcases/kernel/syscalls/mknod/mknod06.c                         | 8 ++------
 testcases/kernel/syscalls/mknod/mknod08.c                         | 7 +------
 testcases/kernel/syscalls/mknod/mknod09.c                         | 8 ++------
 testcases/kernel/syscalls/mlockall/mlockall01.c                   | 7 +------
 testcases/kernel/syscalls/move_pages/move_pages11.c               | 7 ++-----
 testcases/kernel/syscalls/munlock/munlock01.c                     | 6 +-----
 testcases/kernel/syscalls/munlockall/munlockall01.c               | 5 +----
 testcases/kernel/syscalls/munlockall/munlockall02.c               | 5 +----
 testcases/kernel/syscalls/nice/nice04.c                           | 4 +---
 testcases/kernel/syscalls/open/open05.c                           | 4 +---
 testcases/kernel/syscalls/open/open08.c                           | 5 ++---
 testcases/kernel/syscalls/reboot/reboot01.c                       | 6 +-----
 testcases/kernel/syscalls/reboot/reboot02.c                       | 6 +-----
 testcases/kernel/syscalls/rename/rename09.c                       | 5 +----
 testcases/kernel/syscalls/rename/rename12.c                       | 5 +----
 testcases/kernel/syscalls/rmdir/rmdir03.c                         | 5 +----
 .../kernel/syscalls/sched_setscheduler/sched_setscheduler02.c     | 5 +----
 testcases/kernel/syscalls/setdomainname/setdomainname01.c         | 6 +-----
 testcases/kernel/syscalls/setdomainname/setdomainname02.c         | 6 +-----
 testcases/kernel/syscalls/setdomainname/setdomainname03.c         | 4 +---
 testcases/kernel/syscalls/setgroups/setgroups03.c                 | 5 +----
 testcases/kernel/syscalls/setgroups/setgroups04.c                 | 6 +-----
 testcases/kernel/syscalls/sethostname/sethostname01.c             | 7 ++-----
 testcases/kernel/syscalls/sethostname/sethostname02.c             | 7 ++-----
 testcases/kernel/syscalls/sethostname/sethostname03.c             | 7 ++-----
 testcases/kernel/syscalls/setpriority/setpriority02.c             | 7 +++----
 testcases/kernel/syscalls/setpriority/setpriority05.c             | 5 ++---
 testcases/kernel/syscalls/setresgid/setresgid01.c                 | 7 ++-----
 testcases/kernel/syscalls/setresgid/setresgid02.c                 | 7 ++-----
 testcases/kernel/syscalls/setresgid/setresgid03.c                 | 7 ++-----
 testcases/kernel/syscalls/setresuid/setresuid01.c                 | 7 +------
 testcases/kernel/syscalls/setresuid/setresuid02.c                 | 7 +------
 testcases/kernel/syscalls/setresuid/setresuid03.c                 | 7 +------
 testcases/kernel/syscalls/setrlimit/setrlimit02.c                 | 4 +---
 testcases/kernel/syscalls/setrlimit/setrlimit03.c                 | 5 +----
 testcases/kernel/syscalls/settimeofday/settimeofday01.c           | 7 +------
 testcases/kernel/syscalls/settimeofday/settimeofday02.c           | 7 +------
 testcases/kernel/syscalls/stat/stat01.c                           | 4 ++--
 testcases/kernel/syscalls/stat/stat02.c                           | 5 ++---
 testcases/kernel/syscalls/stat/stat03.c                           | 5 ++---
 testcases/kernel/syscalls/stime/stime01.c                         | 6 +-----
 testcases/kernel/syscalls/stime/stime02.c                         | 4 +---
 testcases/kernel/syscalls/symlink/symlink03.c                     | 5 ++---
 testcases/kernel/syscalls/syslog/syslog11.c                       | 7 +------
 testcases/kernel/syscalls/syslog/syslog12.c                       | 7 +------
 testcases/kernel/syscalls/utime/utime01.c                         | 8 ++------
 testcases/kernel/syscalls/utime/utime02.c                         | 5 ++---
 testcases/kernel/syscalls/utime/utime03.c                         | 8 ++------
 testcases/kernel/syscalls/utime/utime04.c                         | 8 ++------
 testcases/kernel/syscalls/utime/utime05.c                         | 5 ++---
 testcases/kernel/syscalls/utime/utime06.c                         | 8 ++------
 79 files changed, 114 insertions(+), 359 deletions(-)

diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex02.c b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
index 0c5b69f..d686e39 100644
--- a/testcases/kernel/syscalls/adjtimex/adjtimex02.c
+++ b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
@@ -203,14 +203,10 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tim_save.modes = 0;
 
-	/* Check whether we are root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* set the expected errnos... */
diff --git a/testcases/kernel/syscalls/chmod/chmod05.c b/testcases/kernel/syscalls/chmod/chmod05.c
index 3293ee6..495d330 100644
--- a/testcases/kernel/syscalls/chmod/chmod05.c
+++ b/testcases/kernel/syscalls/chmod/chmod05.c
@@ -178,11 +178,7 @@ void setup(void)
 	struct passwd *nobody_u;
 	struct group *bin_group;
 
-//wjh Improper comment! This makes sure we _are_ "root" not "nobody"
-	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_require_root(NULL);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/fchmod/fchmod02.c b/testcases/kernel/syscalls/fchmod/fchmod02.c
index 0af95c9..11d45d3 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod02.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod02.c
@@ -167,16 +167,12 @@ void setup(void)
 	gid_t group1_gid;	/* user and process group id's */
 	uid_t user1_uid;
 
+	tst_require_root(NULL);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be super/root for this test!");
-		tst_exit();
-	}
-
 	tst_tmpdir();
 
 	/* Get the uid of guest user - ltpuser1 */
diff --git a/testcases/kernel/syscalls/fchmod/fchmod04.c b/testcases/kernel/syscalls/fchmod/fchmod04.c
index a69cf37..b3b311f 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod04.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod04.c
@@ -152,13 +152,11 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (seteuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "seteuid failed to "
diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index 1897c81..cdce1a2 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -170,13 +170,9 @@ void setup(void)
 	struct passwd *nobody_u;
 	struct group *bin_group;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_require_root(NULL);
 
-	/* Check that the test process id is not super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be super/root for this test!");
-		tst_exit();
-	}
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/getresgid/getresgid02.c b/testcases/kernel/syscalls/getresgid/getresgid02.c
index c3c69cf..2088ec7 100644
--- a/testcases/kernel/syscalls/getresgid/getresgid02.c
+++ b/testcases/kernel/syscalls/getresgid/getresgid02.c
@@ -147,15 +147,12 @@ void setup(void)
 {
 	struct passwd *user_id;	/* passwd struct for test user */
 
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, cleanup, "Must be super/root for this test!");
-	}
-
 	/* Real user-id of the calling process */
 	pr_gid = getgid();
 
diff --git a/testcases/kernel/syscalls/getresgid/getresgid03.c b/testcases/kernel/syscalls/getresgid/getresgid03.c
index c96e227..ab5733d 100644
--- a/testcases/kernel/syscalls/getresgid/getresgid03.c
+++ b/testcases/kernel/syscalls/getresgid/getresgid03.c
@@ -151,15 +151,12 @@ void setup(void)
 {
 	struct passwd *user_id;	/* passwd struct for test user */
 
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, cleanup, "Must be super/root for this test!");
-	}
-
 	/* Real user-id of the calling process */
 	pr_gid = getgid();
 
diff --git a/testcases/kernel/syscalls/getresuid/getresuid02.c b/testcases/kernel/syscalls/getresuid/getresuid02.c
index 01b7ec3..4bea0ff 100644
--- a/testcases/kernel/syscalls/getresuid/getresuid02.c
+++ b/testcases/kernel/syscalls/getresuid/getresuid02.c
@@ -144,15 +144,12 @@ void setup(void)
 {
 	struct passwd *user_id;	/* passwd struct for test user */
 
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, cleanup, "Must be super/root for this test!");
-	}
-
 	/* Real user-id of the calling process */
 	pr_uid = getuid();
 
diff --git a/testcases/kernel/syscalls/getresuid/getresuid03.c b/testcases/kernel/syscalls/getresuid/getresuid03.c
index b5aab6d..95ae7e8 100644
--- a/testcases/kernel/syscalls/getresuid/getresuid03.c
+++ b/testcases/kernel/syscalls/getresuid/getresuid03.c
@@ -146,15 +146,12 @@ void setup(void)
 {
 	struct passwd *user_id;	/* passwd struct for test user */
 
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, cleanup, "Must be super/root for this test!");
-	}
-
 	/* Real user-id of the calling process */
 	pr_uid = getuid();
 
diff --git a/testcases/kernel/syscalls/ioperm/ioperm01.c b/testcases/kernel/syscalls/ioperm/ioperm01.c
index 176e0f0..016155f 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm01.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm01.c
@@ -127,14 +127,10 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check whether we are root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-	}
-
 	/*
 	 * The value of IO_BITMAP_BITS (include/asm-i386/processor.h) changed
 	 * from kernel 2.6.8 to permit 16-bits ioperm
diff --git a/testcases/kernel/syscalls/ioperm/ioperm02.c b/testcases/kernel/syscalls/ioperm/ioperm02.c
index eeb4983..f4fb22d 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm02.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm02.c
@@ -194,14 +194,10 @@ void cleanup1(void)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check whether we are root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-	}
-
 	/* Check if "nobody" user id exists */
 	if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
 		tst_brkm(TBROK, NULL, "\"nobody\" user id doesn't exist");
diff --git a/testcases/kernel/syscalls/iopl/iopl01.c b/testcases/kernel/syscalls/iopl/iopl01.c
index a146efa..f86f3be 100644
--- a/testcases/kernel/syscalls/iopl/iopl01.c
+++ b/testcases/kernel/syscalls/iopl/iopl01.c
@@ -125,14 +125,10 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check whether we are root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-	}
-
 	TEST_PAUSE;
 
 }
diff --git a/testcases/kernel/syscalls/iopl/iopl02.c b/testcases/kernel/syscalls/iopl/iopl02.c
index 5d9a4d0..42a9774 100644
--- a/testcases/kernel/syscalls/iopl/iopl02.c
+++ b/testcases/kernel/syscalls/iopl/iopl02.c
@@ -190,14 +190,10 @@ void cleanup1(void)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check whether we are root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-	}
-
 	/* Check if "nobody" user id exists */
 	if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
 		tst_brkm(TBROK, NULL, "\"nobody\" user id doesn't exist");
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
index 13aa167..bcf2aa4 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
@@ -155,6 +155,8 @@ void setup(void)
 {
 	key_t msgkey2;
 
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* Set up the expected error numbers for -e option */
@@ -163,9 +165,6 @@ void setup(void)
 	TEST_PAUSE;
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1)
 		tst_resm(TINFO, "setuid(%d) failed", ltpuser->pw_uid);
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget04.c b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
index 019fd7a..05643a4 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget04.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
@@ -130,6 +130,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -139,9 +140,6 @@ void setup(void)
 	TEST_PAUSE;
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
index 3e5a38b..2bd5f5f 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
@@ -149,6 +149,8 @@ void setup(void)
 {
 	key_t msgkey2;
 
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* Set up the expected error numbers for -e option */
@@ -157,9 +159,6 @@ void setup(void)
 	TEST_PAUSE;
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
index e714290..5b5a81f 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
@@ -135,6 +135,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -144,9 +145,6 @@ void setup(void)
 	TEST_PAUSE;
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl02.c b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
index dacda62..5df31bc 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl02.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
@@ -119,6 +119,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -128,9 +129,6 @@ void setup(void)
 	TEST_PAUSE;
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/ipc/semget/semget02.c b/testcases/kernel/syscalls/ipc/semget/semget02.c
index 4f7284d..9b78729 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget02.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget02.c
@@ -127,10 +127,9 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
+
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (seteuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setreuid failed to "
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
index b59a0cb..5f4b92a 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
@@ -164,10 +164,9 @@ void setup(void)
 {
 	key_t shmkey2;
 
+	tst_require_root(NULL);
+
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget04.c b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
index 2ec1c30..29ba773 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget04.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
@@ -114,6 +114,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -123,9 +124,6 @@ void setup(void)
 	TEST_PAUSE;
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/mkdir/mkdir02.c b/testcases/kernel/syscalls/mkdir/mkdir02.c
index 43814ad..4dae30e 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir02.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir02.c
@@ -312,10 +312,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-	/* must run as root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, cleanup, "Must run this as root");
-	}
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/mkdir/mkdir04.c b/testcases/kernel/syscalls/mkdir/mkdir04.c
index a6eb167..b1739d6 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir04.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir04.c
@@ -219,10 +219,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-	/* must run as root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must run this as root");
-	}
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/mkdir/mkdir05.c b/testcases/kernel/syscalls/mkdir/mkdir05.c
index b76dcad..5dd432e 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir05.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir05.c
@@ -121,10 +121,8 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_require_root(NULL);
+
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/mknod/mknod02.c b/testcases/kernel/syscalls/mknod/mknod02.c
index 9b93fba..107b139 100644
--- a/testcases/kernel/syscalls/mknod/mknod02.c
+++ b/testcases/kernel/syscalls/mknod/mknod02.c
@@ -201,15 +201,11 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
+
 	/* Capture unexpected signals */
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be super/root for this test!");
-		tst_exit();
-	}
-
 	TEST_PAUSE;
 
 	/* Make a temp dir and cd to it */
diff --git a/testcases/kernel/syscalls/mknod/mknod03.c b/testcases/kernel/syscalls/mknod/mknod03.c
index 1e80f33..a1fe1cd 100644
--- a/testcases/kernel/syscalls/mknod/mknod03.c
+++ b/testcases/kernel/syscalls/mknod/mknod03.c
@@ -201,16 +201,11 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	/* Capture unexpected signals */
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be super/root for this test!");
-		tst_exit();
-	}
-
 	TEST_PAUSE;
 
 	/* Make a temp dir and cd to it */
diff --git a/testcases/kernel/syscalls/mknod/mknod04.c b/testcases/kernel/syscalls/mknod/mknod04.c
index 023c8ba..7ac2932 100644
--- a/testcases/kernel/syscalls/mknod/mknod04.c
+++ b/testcases/kernel/syscalls/mknod/mknod04.c
@@ -202,16 +202,11 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	/* Capture unexpected signals */
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be super/root for this test!");
-		tst_exit();
-	}
-
 	TEST_PAUSE;
 
 	/* Make a temp dir and cd to it */
diff --git a/testcases/kernel/syscalls/mknod/mknod05.c b/testcases/kernel/syscalls/mknod/mknod05.c
index b23bb67..4b6a509 100644
--- a/testcases/kernel/syscalls/mknod/mknod05.c
+++ b/testcases/kernel/syscalls/mknod/mknod05.c
@@ -199,16 +199,11 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	/* Capture unexpected signals */
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be super/root for this test!");
-		tst_exit();
-	}
-
 	TEST_PAUSE;
 
 	/* Make a temp dir and cd to it */
diff --git a/testcases/kernel/syscalls/mknod/mknod06.c b/testcases/kernel/syscalls/mknod/mknod06.c
index 3e99a5f..a272ee5 100644
--- a/testcases/kernel/syscalls/mknod/mknod06.c
+++ b/testcases/kernel/syscalls/mknod/mknod06.c
@@ -220,15 +220,11 @@ void setup(void)
 {
 	int ind;
 
+	tst_require_root(NULL);
+
 	/* Capture unexpected signals */
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be super/root for this test!");
-		tst_exit();
-	}
-
 	TEST_PAUSE;
 
 	/* Make a temp dir and cd to it */
diff --git a/testcases/kernel/syscalls/mknod/mknod08.c b/testcases/kernel/syscalls/mknod/mknod08.c
index 1fc6631..05999bd 100644
--- a/testcases/kernel/syscalls/mknod/mknod08.c
+++ b/testcases/kernel/syscalls/mknod/mknod08.c
@@ -198,16 +198,11 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	/* Capture unexpected signals */
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be super/root for this test!");
-		tst_exit();
-	}
-
 	TEST_PAUSE;
 
 	/* Make a temp dir and cd to it */
diff --git a/testcases/kernel/syscalls/mknod/mknod09.c b/testcases/kernel/syscalls/mknod/mknod09.c
index 18f3275..6ab6770 100644
--- a/testcases/kernel/syscalls/mknod/mknod09.c
+++ b/testcases/kernel/syscalls/mknod/mknod09.c
@@ -139,15 +139,11 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
+
 	/* Capture unexpected signals */
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be super/root for this test!");
-		tst_exit();
-	}
-
 	TEST_PAUSE;
 
 	/* Make a temp dir and cd to it */
diff --git a/testcases/kernel/syscalls/mlockall/mlockall01.c b/testcases/kernel/syscalls/mlockall/mlockall01.c
index 42ab67d..f80348b 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall01.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall01.c
@@ -151,16 +151,11 @@ int main(void)
 
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check whether we are root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-
 	/* set the expected errnos... */
-
 	TEST_EXP_ENOS(exp_enos);
 
 	TEST_PAUSE;
diff --git a/testcases/kernel/syscalls/move_pages/move_pages11.c b/testcases/kernel/syscalls/move_pages/move_pages11.c
index 8a74487..732e092 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages11.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages11.c
@@ -207,15 +207,12 @@ void setup(void)
 {
 	struct passwd *ltpuser;
 
+	tst_require_root(NULL);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	check_config(TEST_NODES);
 
-	if (geteuid() != 0) {
-		tst_resm(TBROK, "test must be run as root");
-		tst_exit();
-	}
-
 	if ((ltpuser = getpwnam("nobody")) == NULL) {
 		tst_resm(TBROK, "'nobody' user not present");
 		tst_exit();
diff --git a/testcases/kernel/syscalls/munlock/munlock01.c b/testcases/kernel/syscalls/munlock/munlock01.c
index bf95e6c..c2ef1fc 100644
--- a/testcases/kernel/syscalls/munlock/munlock01.c
+++ b/testcases/kernel/syscalls/munlock/munlock01.c
@@ -155,14 +155,10 @@ void setup1(int i)
 /* setup() - performs all ONE TIME setup for this test. */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check whether we are root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
diff --git a/testcases/kernel/syscalls/munlockall/munlockall01.c b/testcases/kernel/syscalls/munlockall/munlockall01.c
index 6a2d17b..91db50a 100644
--- a/testcases/kernel/syscalls/munlockall/munlockall01.c
+++ b/testcases/kernel/syscalls/munlockall/munlockall01.c
@@ -124,16 +124,13 @@ int main(void)
 /* setup() - performs all ONE TIME setup for this test. */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/*set the expected errnos */
 	TEST_EXP_ENOS(exp_enos);
 
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be tested as root");
-	}
-
 	TEST_PAUSE;
 }
 
diff --git a/testcases/kernel/syscalls/munlockall/munlockall02.c b/testcases/kernel/syscalls/munlockall/munlockall02.c
index 3dcd1e1..0f29253 100644
--- a/testcases/kernel/syscalls/munlockall/munlockall02.c
+++ b/testcases/kernel/syscalls/munlockall/munlockall02.c
@@ -125,6 +125,7 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test. */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -132,10 +133,6 @@ void setup(void)
 	TEST_EXP_ENOS(exp_enos);
 
 	/* switch to nobody user */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-
 	if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
 		tst_brkm(TBROK, NULL, "\"nobody\"user not present");
 	}
diff --git a/testcases/kernel/syscalls/nice/nice04.c b/testcases/kernel/syscalls/nice/nice04.c
index f82d7d8..927921d 100644
--- a/testcases/kernel/syscalls/nice/nice04.c
+++ b/testcases/kernel/syscalls/nice/nice04.c
@@ -143,13 +143,11 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/open/open05.c b/testcases/kernel/syscalls/open/open05.c
index 92164f8..03761a9 100644
--- a/testcases/kernel/syscalls/open/open05.c
+++ b/testcases/kernel/syscalls/open/open05.c
@@ -123,9 +123,7 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
-	/* test must be run as root */
-	if (geteuid() != 0)
-		tst_brkm(TBROK, NULL, "Must run test as root");
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index ef147f1..7ebf971 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -141,6 +141,8 @@ static void setup(void)
 {
 	int fildes;
 
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	umask(0);
@@ -148,9 +150,6 @@ static void setup(void)
 	TEST_PAUSE;
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0)
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-
 	ltpuser = getpwnam(nobody_uid);
 	if (setgid(ltpuser->pw_gid) == -1) {
 		tst_brkm(TBROK | TERRNO, NULL, "setgid(%d) failed",
diff --git a/testcases/kernel/syscalls/reboot/reboot01.c b/testcases/kernel/syscalls/reboot/reboot01.c
index a6ec0b5..a661918 100644
--- a/testcases/kernel/syscalls/reboot/reboot01.c
+++ b/testcases/kernel/syscalls/reboot/reboot01.c
@@ -127,14 +127,10 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check whether we are root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-
 	TEST_PAUSE;
 
 }
diff --git a/testcases/kernel/syscalls/reboot/reboot02.c b/testcases/kernel/syscalls/reboot/reboot02.c
index 66db369..1625936 100644
--- a/testcases/kernel/syscalls/reboot/reboot02.c
+++ b/testcases/kernel/syscalls/reboot/reboot02.c
@@ -184,17 +184,13 @@ int setup_test(void)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
-	/* Check whether we are root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-
 	TEST_PAUSE;
 
 }
diff --git a/testcases/kernel/syscalls/rename/rename09.c b/testcases/kernel/syscalls/rename/rename09.c
index d02a8c6..ef5d8e3 100644
--- a/testcases/kernel/syscalls/rename/rename09.c
+++ b/testcases/kernel/syscalls/rename/rename09.c
@@ -246,10 +246,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-	/* must run as root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must run test as root");
-	}
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/rename/rename12.c b/testcases/kernel/syscalls/rename/rename12.c
index ed823ae..d9a8529 100644
--- a/testcases/kernel/syscalls/rename/rename12.c
+++ b/testcases/kernel/syscalls/rename/rename12.c
@@ -186,10 +186,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-	/* must run as root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must run this as root");
-	}
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/rmdir/rmdir03.c b/testcases/kernel/syscalls/rmdir/rmdir03.c
index f341a36..3023c40 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir03.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir03.c
@@ -321,10 +321,7 @@ void dochild2(void)
  */
 void setup(void)
 {
-	/* test must be run as root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "test must be run as root");
-	}
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
index 0faa008..f3fb93f 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
@@ -143,10 +143,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-	/* must run test as root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must run test as root");
-	}
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname01.c b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
index 3f50bdd..a58ab87 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname01.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
@@ -124,14 +124,10 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check whether we are root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-
 	/* Save current domain name */
 	if ((getdomainname(old_domain_name, sizeof(old_domain_name))) < 0) {
 		tst_brkm(TBROK, NULL, "getdomainname() failed while"
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname02.c b/testcases/kernel/syscalls/setdomainname/setdomainname02.c
index 4be27ed..fa9caf4 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname02.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname02.c
@@ -160,16 +160,12 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_EXP_ENOS(exp_enos);
 
-	/* Check whether we are root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-
 	/* Save current domainname */
 	if ((getdomainname(old_domain_name, MAX_NAME_LEN)) < 0) {
 		tst_brkm(TBROK, NULL, "getdomainname() failed while"
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname03.c b/testcases/kernel/syscalls/setdomainname/setdomainname03.c
index 5c352d1..e93435c 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname03.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname03.c
@@ -145,6 +145,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	/* Capture unexpected signals */
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
@@ -153,9 +154,6 @@ void setup(void)
 	TEST_EXP_ENOS(exp_enos);
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
 		tst_brkm(TBROK, NULL, "\"nobody\" user not present");
 	}
diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcases/kernel/syscalls/setgroups/setgroups03.c
index 1a2977d..402b145 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups03.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups03.c
@@ -182,10 +182,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/setgroups/setgroups04.c b/testcases/kernel/syscalls/setgroups/setgroups04.c
index 885b07b..ac23e50 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups04.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups04.c
@@ -155,11 +155,7 @@ int main(void)
  */
 void setup(void)
 {
-
-	/* check root user */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/sethostname/sethostname01.c b/testcases/kernel/syscalls/sethostname/sethostname01.c
index 74af634..c766252 100644
--- a/testcases/kernel/syscalls/sethostname/sethostname01.c
+++ b/testcases/kernel/syscalls/sethostname/sethostname01.c
@@ -129,12 +129,9 @@ void setup(void)
 {
 	int ret;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_require_root(NULL);
 
-	/* Test should be executed as root user */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* Store the existing hostname to retain it before exiting */
 	if ((ret = gethostname(hname, sizeof(hname))) < 0) {
diff --git a/testcases/kernel/syscalls/sethostname/sethostname02.c b/testcases/kernel/syscalls/sethostname/sethostname02.c
index 553e7e2..d8b3a95 100644
--- a/testcases/kernel/syscalls/sethostname/sethostname02.c
+++ b/testcases/kernel/syscalls/sethostname/sethostname02.c
@@ -167,16 +167,13 @@ void setup(void)
 {
 	int ret;
 
+	tst_require_root(NULL);
+
 	TEST_EXP_ENOS(exp_enos);
 
 	/* capture the signals */
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Test should be executed as root user */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-
 	/* Keep the host name before starting the test */
 	if ((ret = gethostname(hname, sizeof(hname))) < 0) {
 		tst_brkm(TBROK, NULL, "gethostname() failed while"
diff --git a/testcases/kernel/syscalls/sethostname/sethostname03.c b/testcases/kernel/syscalls/sethostname/sethostname03.c
index f681d8d..f85770f 100644
--- a/testcases/kernel/syscalls/sethostname/sethostname03.c
+++ b/testcases/kernel/syscalls/sethostname/sethostname03.c
@@ -136,16 +136,13 @@ void setup(void)
 {
 	int ret;
 
+	tst_require_root(NULL);
+
 	/* set up expected errnos */
 	TEST_EXP_ENOS(exp_enos);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Test should be executed as root user */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-
 	/* Switch to nobody user for correct error code collection */
 	if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
 		tst_brkm(TBROK, NULL, "Required user \"nobody\" not"
diff --git a/testcases/kernel/syscalls/setpriority/setpriority02.c b/testcases/kernel/syscalls/setpriority/setpriority02.c
index a76d05b..696ed23 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority02.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority02.c
@@ -126,10 +126,9 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_require_root(NULL);
+
+	/* Switch to nobody user for correct error code collection */
 	ltpuser = getpwnam(nobody_uid);
 	if (seteuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setreuid failed to "
diff --git a/testcases/kernel/syscalls/setpriority/setpriority05.c b/testcases/kernel/syscalls/setpriority/setpriority05.c
index 7ecde1a..3122dc8 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority05.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority05.c
@@ -126,10 +126,9 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
+
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/setresgid/setresgid01.c b/testcases/kernel/syscalls/setresgid/setresgid01.c
index 31ce0f8..f9c62a0 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid01.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid01.c
@@ -186,12 +186,9 @@ void setup(void)
 {
 	struct passwd *passwd_p;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_require_root(NULL);
 
-	/* Check whether we are root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-	}
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	if ((passwd_p = getpwnam("root")) == NULL) {
 		tst_brkm(TBROK, NULL, "getpwnam() failed for root");
diff --git a/testcases/kernel/syscalls/setresgid/setresgid02.c b/testcases/kernel/syscalls/setresgid/setresgid02.c
index c62d7b0..754fca1 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid02.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid02.c
@@ -193,12 +193,9 @@ void setup(void)
 {
 	struct passwd *passwd_p;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_require_root(NULL);
 
-	/* Check whether we are root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-	}
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	if ((passwd_p = getpwnam("root")) == NULL) {
 		tst_brkm(TBROK, NULL, "getpwnam() failed for root");
diff --git a/testcases/kernel/syscalls/setresgid/setresgid03.c b/testcases/kernel/syscalls/setresgid/setresgid03.c
index 902f16b..32d7995 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid03.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid03.c
@@ -192,12 +192,9 @@ void setup(void)
 {
 	struct passwd *passwd_p;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_require_root(NULL);
 
-	/* Check whether we are root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-	}
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	if ((passwd_p = getpwnam("root")) == NULL) {
 		tst_brkm(TBROK, NULL, "getpwnam() failed for root");
diff --git a/testcases/kernel/syscalls/setresuid/setresuid01.c b/testcases/kernel/syscalls/setresuid/setresuid01.c
index c21b1bf..bdd77c9 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid01.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid01.c
@@ -169,15 +169,10 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	/* Check that the test process id is root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-		tst_exit();
-	}
-
 	if (getpwnam("nobody") == NULL) {
 		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
 		tst_exit();
diff --git a/testcases/kernel/syscalls/setresuid/setresuid02.c b/testcases/kernel/syscalls/setresuid/setresuid02.c
index 4e211b1..dcf91a9 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid02.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid02.c
@@ -183,6 +183,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
@@ -196,12 +197,6 @@ void setup(void)
 		tst_exit();
 	}
 
-	/* Check that the test process id is root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-		tst_exit();
-	}
-
 	nobody = *(getpwnam("nobody"));
 	nobody_pw_uid = nobody.pw_uid;
 
diff --git a/testcases/kernel/syscalls/setresuid/setresuid03.c b/testcases/kernel/syscalls/setresuid/setresuid03.c
index af3ebb4..c31c124 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid03.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid03.c
@@ -194,6 +194,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
@@ -207,12 +208,6 @@ void setup(void)
 		tst_exit();
 	}
 
-	/* Check that the test process id is root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-		tst_exit();
-	}
-
 	root = *(getpwnam("root"));
 	root_pw_uid = root.pw_uid;
 
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit02.c b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
index e48e54a..6f6f6e8 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit02.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
@@ -132,15 +132,13 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit03.c b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
index 0fd8991..665a95f 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit03.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
@@ -110,10 +110,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-	/* must run test as root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "must run test as root");
-	}
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday01.c b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
index 1975c5d..6b86bc9 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday01.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
@@ -160,15 +160,10 @@ int main(void)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	/* Check that the test process id is root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-		tst_exit();
-	}
-
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday02.c b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
index 7337557..f5dc5c7 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday02.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
@@ -148,15 +148,10 @@ int main(void)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	/* Check that the test process id is root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-		tst_exit();
-	}
-
 	/* Switch to nobody user for correct error code collection */
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
diff --git a/testcases/kernel/syscalls/stat/stat01.c b/testcases/kernel/syscalls/stat/stat01.c
index bac26e1..f0be527 100644
--- a/testcases/kernel/syscalls/stat/stat01.c
+++ b/testcases/kernel/syscalls/stat/stat01.c
@@ -137,11 +137,11 @@ void setup(void)
 	int wbytes;
 	int write_len = 0;
 
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0)
-		tst_brkm(TBROK, NULL, "Test must be run as root");
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/stat/stat02.c b/testcases/kernel/syscalls/stat/stat02.c
index 9ef08ec..f596746 100644
--- a/testcases/kernel/syscalls/stat/stat02.c
+++ b/testcases/kernel/syscalls/stat/stat02.c
@@ -168,12 +168,11 @@ void setup(void)
 	int wbytes;		/* no. of bytes written to file */
 	int write_len = 0;
 
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/stat/stat03.c b/testcases/kernel/syscalls/stat/stat03.c
index 623b538..83f9370 100644
--- a/testcases/kernel/syscalls/stat/stat03.c
+++ b/testcases/kernel/syscalls/stat/stat03.c
@@ -227,13 +227,12 @@ void setup(void)
 {
 	int ind;
 
+	tst_require_root(NULL);
+
 	/* Capture unexpected signals */
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/stime/stime01.c b/testcases/kernel/syscalls/stime/stime01.c
index 62b509a..53ac2d2 100644
--- a/testcases/kernel/syscalls/stime/stime01.c
+++ b/testcases/kernel/syscalls/stime/stime01.c
@@ -189,11 +189,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "you must be root to execute this test!");
-	}
+	tst_require_root(NULL);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/stime/stime02.c b/testcases/kernel/syscalls/stime/stime02.c
index eeeeeb4..b4ceb4c 100644
--- a/testcases/kernel/syscalls/stime/stime02.c
+++ b/testcases/kernel/syscalls/stime/stime02.c
@@ -146,13 +146,11 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/symlink/symlink03.c b/testcases/kernel/syscalls/symlink/symlink03.c
index a33d836..f55cbaf 100644
--- a/testcases/kernel/syscalls/symlink/symlink03.c
+++ b/testcases/kernel/syscalls/symlink/symlink03.c
@@ -233,6 +233,8 @@ void setup(void)
 {
 	int ind;
 
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* Pause if that option was specified
@@ -243,9 +245,6 @@ void setup(void)
 	TEST_PAUSE;
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1)
 		tst_resm(TINFO | TERRNO, "setuid(%d) failed", ltpuser->pw_uid);
diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel/syscalls/syslog/syslog11.c
index c85b988..1f803a1 100644
--- a/testcases/kernel/syscalls/syslog/syslog11.c
+++ b/testcases/kernel/syscalls/syslog/syslog11.c
@@ -191,18 +191,13 @@ void cleanup1(void)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check whether we are root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-	}
-
 	/* Check for nobody_uid user id */
 	if ((ltpuser = getpwnam("nobody")) == NULL) {
 		tst_brkm(TBROK, NULL, "nobody user id doesn't exist");
-
 	}
 
 	/* Pause if that option was specified
diff --git a/testcases/kernel/syscalls/syslog/syslog12.c b/testcases/kernel/syscalls/syslog/syslog12.c
index d4f6255..4721dd9 100644
--- a/testcases/kernel/syscalls/syslog/syslog12.c
+++ b/testcases/kernel/syscalls/syslog/syslog12.c
@@ -215,18 +215,13 @@ void cleanup1(void)
  */
 void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check whether we are root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-	}
-
 	/* Check for nobody_uid user id */
 	if ((ltpuser = getpwnam("nobody")) == NULL) {
 		tst_brkm(TBROK, NULL, "nobody user id doesn't exist");
-
 	}
 
 	/* set the expected errnos... */
diff --git a/testcases/kernel/syscalls/utime/utime01.c b/testcases/kernel/syscalls/utime/utime01.c
index 0e74d3b..3128965 100644
--- a/testcases/kernel/syscalls/utime/utime01.c
+++ b/testcases/kernel/syscalls/utime/utime01.c
@@ -201,13 +201,9 @@ void setup(void)
 {
 	int fildes;		/* file handle for temp file */
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_require_root(NULL);
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be super/root for this test!");
-		tst_exit();
-	}
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/utime/utime02.c b/testcases/kernel/syscalls/utime/utime02.c
index dcf50c2..cbd30da 100644
--- a/testcases/kernel/syscalls/utime/utime02.c
+++ b/testcases/kernel/syscalls/utime/utime02.c
@@ -207,12 +207,11 @@ void setup(void)
 {
 	int fildes;		/* file handle for temp file */
 
+	tst_require_root(NULL);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index 279a959..858f6ca 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -252,13 +252,9 @@ void setup(void)
 	int fildes;		/* file handle for temp file */
 	char *tmpd = NULL;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_require_root(NULL);
 
-	/* Check that the test process id is not super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-		tst_exit();
-	}
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	/* Pause if that option was specified
 	 * TEST_PAUSE contains the code to fork the test with the -i option.
diff --git a/testcases/kernel/syscalls/utime/utime04.c b/testcases/kernel/syscalls/utime/utime04.c
index b18f09a..73077e4 100644
--- a/testcases/kernel/syscalls/utime/utime04.c
+++ b/testcases/kernel/syscalls/utime/utime04.c
@@ -172,13 +172,9 @@ void setup(void)
 {
 	int fildes;		/* file handle for temp file */
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_require_root(NULL);
 
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be super/root for this test!");
-		tst_exit();
-	}
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/utime/utime05.c b/testcases/kernel/syscalls/utime/utime05.c
index f858100..636d8a7 100644
--- a/testcases/kernel/syscalls/utime/utime05.c
+++ b/testcases/kernel/syscalls/utime/utime05.c
@@ -177,12 +177,11 @@ void setup(void)
 {
 	int fildes;		/* file handle for temp file */
 
+	tst_require_root(NULL);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setuid failed to "
diff --git a/testcases/kernel/syscalls/utime/utime06.c b/testcases/kernel/syscalls/utime/utime06.c
index a1a9230..8407945 100644
--- a/testcases/kernel/syscalls/utime/utime06.c
+++ b/testcases/kernel/syscalls/utime/utime06.c
@@ -231,13 +231,9 @@ void setup(void)
 {
 	int ind;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_require_root(NULL);
 
-	/* Check that the test process id is non-super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-		tst_exit();
-	}
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
-- 
1.9.0


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
