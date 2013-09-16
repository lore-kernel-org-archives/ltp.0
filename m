Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VLaZL-0002pA-Sm
	for ltp-list@lists.sourceforge.net; Mon, 16 Sep 2013 15:18:31 +0000
Date: Mon, 16 Sep 2013 17:18:47 +0200
From: chrubis@suse.cz
Message-ID: <20130916151847.GA30140@rei.suse.cz>
References: <1379066350-20317-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <1379066350-20317-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] setfsgid,
 setfsuid: clean up and 16-bit version fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/syscalls/setfsgid/setfsgid01.c |   97 ++++--------
>  testcases/kernel/syscalls/setfsgid/setfsgid02.c |   95 ++++--------
>  testcases/kernel/syscalls/setfsgid/setfsgid03.c |  118 ++++++---------
>  testcases/kernel/syscalls/setfsuid/setfsuid01.c |   97 ++++--------
>  testcases/kernel/syscalls/setfsuid/setfsuid02.c |   96 ++++--------
>  testcases/kernel/syscalls/setfsuid/setfsuid03.c |  118 +++++----------
>  testcases/kernel/syscalls/setfsuid/setfsuid04.c |  183 +++++++++-------------
>  testcases/kernel/syscalls/utils/compat_16.h     |   13 ++
>  8 files changed, 297 insertions(+), 520 deletions(-)

It's usually better to split the patches between cleanup and functional
changes but in this case the functional changes are simple enough...

I've amended a few more fixes over this patches mostly another missing
void in function parameters and cosmetic changes.

Note that for TEST_ERRNO you must use TTERRNO not TERRNO.

Also notice that I've basically reverted the changes in
run_master_child() in setfsuid04. You must not use tst_* interface from
child, it's not designed to work this way and it may lead to unexpected
results.

See attached patch (that is combined with your patch in the final one)
for details.

Thanks!

-- 
Cyril Hrubis
chrubis@suse.cz

--d6Gm4EdcadzBjdND
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="fixes.patch"

diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid01.c b/testcases/kernel/syscalls/setfsgid/setfsgid01.c
index da21cd3..f87bace 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid01.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid01.c
@@ -44,9 +44,8 @@ int main(int ac, char **av)
 
 	gid_t gid;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();
 
@@ -59,7 +58,7 @@ int main(int ac, char **av)
 		TEST(SETFSGID(cleanup, gid));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TERRNO,
+			tst_resm(TFAIL | TTERRNO,
 				"setfsgid() failed unexpectedly");
 			continue;
 		}
@@ -83,14 +82,14 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-static void setup()
+static void setup(void)
 {
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-static void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 }
diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid02.c b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
index 296adc1..250d677 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid02.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
@@ -29,9 +29,6 @@
 #include <pwd.h>
 #include <sys/types.h>
 #include <errno.h>
-#ifdef __GLIBC__
-#include <sys/fsuid.h>
-#endif
 
 #include "test.h"
 #include "usctest.h"
@@ -50,9 +47,8 @@ int main(int ac, char **av)
 
 	gid_t gid;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();
 
@@ -60,15 +56,15 @@ int main(int ac, char **av)
 		tst_count = 0;
 
 		gid = 1;
-		while (getgrgid(gid)) {
+		while (getgrgid(gid))
 			gid++;
-		}
+
 		GID16_CHECK(gid, setfsgid, cleanup);
 
 		TEST(SETFSGID(cleanup, gid));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TERRNO,
+			tst_resm(TFAIL | TTERRNO,
 				"setfsgid() failed unexpectedly");
 			continue;
 		}
@@ -91,14 +87,14 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-static void setup()
+static void setup(void)
 {
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-static void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 }
diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid03.c b/testcases/kernel/syscalls/setfsgid/setfsgid03.c
index a38b685..ae351b8 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid03.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid03.c
@@ -29,9 +29,6 @@
 #include <errno.h>
 #include <pwd.h>
 #include <grp.h>
-#ifdef __GLIBC__
-#include <sys/fsuid.h>
-#endif
 
 #include "test.h"
 #include "usctest.h"
@@ -53,9 +50,8 @@ int main(int ac, char **av)
 
 	gid_t gid;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();
 
@@ -63,15 +59,15 @@ int main(int ac, char **av)
 		tst_count = 0;
 
 		gid = 1;
-		while (!getgrgid(gid)) {
+		while (!getgrgid(gid))
 			gid++;
-		}
+
 		GID16_CHECK(gid, setfsgid, cleanup);
 
 		TEST(SETFSGID(cleanup, gid));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TERRNO,
+			tst_resm(TFAIL | TTERRNO,
 				"setfsgid() failed unexpectedly");
 			continue;
 		}
@@ -95,7 +91,7 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-static void setup()
+static void setup(void)
 {
 	tst_require_root(NULL);
 
@@ -114,7 +110,7 @@ static void setup()
 	TEST_PAUSE;
 }
 
-static void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 }
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid01.c b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
index 3d3896d..0f1828e 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid01.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
@@ -44,9 +44,8 @@ int main(int ac, char **av)
 
 	uid_t uid;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();
 
@@ -60,7 +59,7 @@ int main(int ac, char **av)
 		TEST(SETFSUID(cleanup, uid));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TERRNO,
+			tst_resm(TFAIL | TTERRNO,
 				"setfsuid() failed unexpectedly");
 			continue;
 		}
@@ -84,14 +83,14 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-static void setup()
+static void setup(void)
 {
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-static void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 }
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid02.c b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
index baf1993..666dd32 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid02.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
@@ -26,9 +26,6 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <pwd.h>
-#ifdef __GLIBC__
-#include <sys/fsuid.h>
-#endif
 #include <sys/types.h>
 #include <errno.h>
 
@@ -49,16 +46,15 @@ int main(int ac, char **av)
 
 	uid_t uid;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();
 
 	uid = 1;
-	while (getpwuid(uid)) {
+	while (getpwuid(uid))
 		uid++;
-	}
+
 	UID16_CHECK(uid, setfsuid, cleanup);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -68,7 +64,7 @@ int main(int ac, char **av)
 		TEST(SETFSUID(cleanup, uid));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TERRNO,
+			tst_resm(TFAIL | TTERRNO,
 				"setfsuid() failed unexpectedly");
 			continue;
 		}
@@ -91,14 +87,14 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-static void setup()
+static void setup(void)
 {
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-static void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 }
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid03.c b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
index a065d78..b194f00 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid03.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
@@ -25,9 +25,6 @@
 
 #include <stdio.h>
 #include <unistd.h>
-#ifdef __GLIBC__
-#include <sys/fsuid.h>
-#endif
 #include <sys/types.h>
 #include <errno.h>
 #include <pwd.h>
@@ -52,16 +49,15 @@ int main(int ac, char **av)
 
 	uid_t uid;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();
 
 	uid = 1;
-	while (!getpwuid(uid)) {
+	while (!getpwuid(uid))
 		uid++;
-	}
+
 	UID16_CHECK(uid, setfsuid, cleanup);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -71,7 +67,7 @@ int main(int ac, char **av)
 		TEST(SETFSUID(cleanup, uid));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TERRNO,
+			tst_resm(TFAIL | TTERRNO,
 				"setfsuid() failed unexpectedly");
 			continue;
 		}
@@ -95,7 +91,7 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-static void setup()
+static void setup(void)
 {
 	tst_require_root(NULL);
 
@@ -113,7 +109,7 @@ static void setup()
 	TEST_PAUSE;
 }
 
-static void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 }
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid04.c b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
index 03ea551..0b41426 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid04.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
@@ -27,9 +27,6 @@
  */
 
 #include <sys/types.h>
-#ifdef __GLIBC__
-#include <sys/fsuid.h>
-#endif
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include <errno.h>
@@ -49,13 +46,13 @@ int TST_TOTAL = 1;
 
 static char nobody_uid[] = "nobody";
 static char testfile[] = "setfsuid04_testfile";
-struct passwd *ltpuser;
+static struct passwd *ltpuser;
 
 static int fd = -1;
 
 static void setup(void);
 static void cleanup(void);
-static void do_master_child();
+static void do_master_child(void);
 
 int main(int ac, char **av)
 {
@@ -79,71 +76,74 @@ int main(int ac, char **av)
 		tst_resm(TBROK | TERRNO, "waitpid failed");
 	if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
 		tst_resm(TFAIL, "child process terminated abnormally");
+	else
+		tst_resm(TPASS, "Test passed");
 
 	cleanup();
 	tst_exit();
 }
 
-static void do_master_child()
+static void do_master_child(void)
 {
 	int pid;
 	int status;
-	int tst_fd;
 
-	if (SETFSUID(NULL, ltpuser->pw_uid) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "setfsuid failed");
+	if (SETFSUID(NULL, ltpuser->pw_uid) == -1) {
+		perror("setfsuid failed");
+		exit(1);
+	}
 
 	/* Test 1: Check the process with new uid cannot open the file
 	 *         with RDWR permissions.
 	 */
-	TEST(tst_fd = open(testfile, O_RDWR));
+	TEST(open(testfile, O_RDWR));
 
 	if (TEST_RETURN != -1) {
-		close(tst_fd);
-		tst_brkm(TFAIL, NULL, "open succeeded unexpectedly");
+		close(TEST_RETURN);
+		printf("open succeeded unexpectedly\n");
+		exit(1);
 	}
 
-	if (TEST_ERRNO == EACCES)
-		tst_resm(TPASS,
-			"open failed with EACCESS as expected");
-	else {
-		tst_brkm(TFAIL, NULL,
-			"open returned unexpected errno - %d",
-			TEST_ERRNO);
+	if (TEST_ERRNO == EACCES) {
+		printf("open failed with EACCESS as expected\n");
+	} else {
+		printf("open returned unexpected errno - %d\n", TEST_ERRNO);
+		exit(1);
 	}
 
 	/* Test 2: Check a son process cannot open the file
 	 *         with RDWR permissions.
 	 */
 	pid = FORK_OR_VFORK();
-	if (pid < 0)
-		tst_brkm(TBROK, NULL, "Fork failed");
+	if (pid < 0) {
+		perror("Fork failed");
+		exit(1);
+	}
 
 	if (pid == 0) {
-		int tst_fd2;
-
 		/* Test to open the file in son process */
-		TEST(tst_fd2 = open(testfile, O_RDWR));
+		TEST(open(testfile, O_RDWR));
 
 		if (TEST_RETURN != -1) {
-			close(tst_fd2);
-			tst_brkm(TFAIL, NULL,
-				"open succeeded unexpectedly");
+			close(TEST_RETURN);
+			printf("open succeeded unexpectedly\n");
+			exit(1);
 		}
 
-		if (TEST_ERRNO == EACCES)
-			tst_resm(TPASS,
-				"open failed with EACCESS as expected");
-		else {
-			tst_brkm(TFAIL, NULL,
-				"open returned unexpected errno - %d",
-				TEST_ERRNO);
+		if (TEST_ERRNO == EACCES) {
+			printf("open failed with EACCESS as expected\n");
+		} else {
+			printf("open returned unexpected errno - %d\n",
+			       TEST_ERRNO);
+			exit(1);
 		}
 	} else {
 		/* Wait for son completion */
 		if (waitpid(pid, &status, 0) == -1) {
-			tst_brkm(TFAIL, NULL, "waitpid failed");
+			perror("waitpid failed");
+			exit(1);
 		}
+
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 			exit(WEXITSTATUS(status));
 	}
@@ -152,17 +152,19 @@ static void do_master_child()
 	 *         the file with RDWR permissions.
 	 */
 	tst_count++;
-	if (SETFSUID(NULL, 0) == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "setfsuid failed");
+	if (SETFSUID(NULL, 0) == -1) {
+		perror("setfsuid failed");
+		exit(1);
+	}
 
-	TEST(tst_fd = open(testfile, O_RDWR));
+	TEST(open(testfile, O_RDWR));
 
 	if (TEST_RETURN == -1) {
-		tst_brkm(TFAIL | TERRNO, NULL,
-			"open failed unexpectedly");
+		perror("open failed unexpectedly");
+		exit(1);
 	} else {
-		tst_resm(TPASS, "open call succeeded");
-		close(tst_fd);
+		printf("open call succeeded\n");
+		close(TEST_RETURN);
 	}
 	exit(0);
 }

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk
--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--d6Gm4EdcadzBjdND--

