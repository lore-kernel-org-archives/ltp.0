Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MujPr-0006qD-Ll
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 08:59:35 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MujPj-0005fY-0l
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 08:59:35 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 03B2212965B6E
	for <ltp-list@lists.sourceforge.net>;
	Mon,  5 Oct 2009 10:59:20 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314) id 1MujPb-0008DZ-00
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 10:59:19 +0200
Date: Tue, 21 Jul 2009 15:56:02 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u1bkmtrncfnueu@debian>
Subject: [LTP] [PATCH] Use plain open() call for creating temporary files in
 some Crackerjack tests, instead of function setup_file
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
Message-ID: <20090721135602.TMYO-i7CSyt-P1YtjtE-vHC2VIMwd3Y-Si4j4J-Mt5I@z>

Hello,

 This makes the tests create the temporary files in their temporary
 directory, instead of their program directory; also, it avoids having
 to track the pathname of the program and the path of the temporary
 file (it is constant)

 When applied, it would be possible to delete the setup_file/create_file function altogether.

 Also, this fixes the signal issue in ppoll01, whose last fix was unfortunately not applied.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/ppoll/ppoll01.c   |   37 ++++++++++++++------------
 testcases/kernel/syscalls/utimes/utimes01.c |   33 +++++++++++++-----------
 2 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index f76d61f..87b89f6 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -79,6 +79,16 @@ char *TCID = "ppoll01";  /* Test program identifier.*/
 int  testno;
 int  TST_TOTAL = 1;                   /* total number of tests in this file.   */
 
+static int fd = -1;
+static void sighandler(int sig);
+
+#define SUCCEED_OR_DIE(syscall, message, ...)														\
+	(errno = 0,																														\
+		({int ret=syscall(__VA_ARGS__);																			\
+			if(ret==-1)																												\
+				tst_brkm(TBROK, cleanup, message, __VA_ARGS__, strerror(errno)); \
+			ret;}))
+
 /* Extern Global Functions */
 /******************************************************************************/
 /*                                                                            */
@@ -129,6 +139,11 @@ void setup() {
         /* Create temporary directories */
         TEST_PAUSE;
         tst_tmpdir();
+
+        tst_sig(FORK, DEF_HANDLER, cleanup);
+        signal(SIGINT, sighandler);
+
+        fd = SUCCEED_OR_DIE(open, "open(%s, %x, %x) failed: %s", "test.file", O_CREAT|O_EXCL|O_RDONLY, 0600);
 }
 
 
@@ -147,7 +162,6 @@ void setup() {
  */
 static int opt_debug;
 static char *progname;
-static char *progdir;
 
 enum test_type {
 	NORMAL,
@@ -263,8 +277,7 @@ static int do_test(struct test_case *tc)
         int sys_ret;
         int sys_errno;
         int result = RESULT_OK;
-	int fd = -1 , cmp_ok = 1;
-	char fpath[PATH_MAX];
+	int cmp_ok = 1;
 	struct pollfd *p_fds, fds[NUM_TEST_FDS];
         unsigned int nfds = NUM_TEST_FDS;
         struct timespec *p_ts, ts;
@@ -272,9 +285,6 @@ static int do_test(struct test_case *tc)
         size_t sigsetsize = 0;
         pid_t pid = 0;
 
-	TEST(fd = setup_file(progdir, "test.file", fpath));
-        if (fd < 0)
-                return 1;
         fds[0].fd = fd;
         fds[0].events = POLLIN | POLLPRI | POLLOUT | POLLRDHUP;
         fds[0].revents = 0;
@@ -290,13 +300,12 @@ static int do_test(struct test_case *tc)
                 p_ts = &ts;
                 break;
 	case FD_ALREADY_CLOSED:
-                TEST(close(fd));
-                fd = -1;
-                TEST(cleanup_file(fpath));
+                fds[0].fd = SUCCEED_OR_DIE(dup, "dup(%d) failed: %s", fd);
+                SUCCEED_OR_DIE(close, "couldn't close duplicated fd (%d): %s", fds[0].fd);
                 break;
         case MASK_SIGNAL:
-                TEST(sigemptyset(&sigmask));
-                TEST(sigaddset(&sigmask, SIGINT));
+                sigemptyset(&sigmask);
+                sigaddset(&sigmask, SIGINT);
                 p_sigmask = &sigmask;
                 //sigsetsize = sizeof(sigmask);
                 sigsetsize = 8;
@@ -390,9 +399,6 @@ TEST_END:
         PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,
                          cmp_ok);
  cleanup:
-        if (fd >= 0)
-                cleanup_file(fpath);
-
         sigemptyset(&sigmask);
         sigprocmask(SIG_SETMASK, &sigmask, NULL);
         if (pid > 0) {
@@ -454,9 +460,6 @@ int main(int ac, char **av) {
 	progname = strchr(av[0], '/');
         progname = progname ? progname + 1 : av[0];	
 
-	progdir = strdup(av[0]);
-        progdir = dirname(progdir);
-	
         /* parse standard options */
         if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
              tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index 390b572..7705269 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -74,6 +74,16 @@ char *TCID = "utimes01";  /* Test program identifier.*/
 int  testno;
 int  TST_TOTAL = 1;                   /* total number of tests in this file.   */
 
+#define FNAME "test.file"
+#define FNAME_NX "test.file_nonexistant"
+
+#define SUCCEED_OR_DIE(syscall, message, ...)														\
+	(errno = 0,																														\
+		({int ret=syscall(__VA_ARGS__);																			\
+			if(ret==-1)																												\
+				tst_brkm(TBROK, cleanup, message, __VA_ARGS__, strerror(errno)); \
+			ret;}))
+
 /* Extern Global Functions */
 /******************************************************************************/
 /*                                                                            */
@@ -126,6 +136,10 @@ void setup() {
         /* Create temporary directories */
         TEST_PAUSE;
         tst_tmpdir();
+
+        SUCCEED_OR_DIE(close, "close(%d): %s",
+                       SUCCEED_OR_DIE(open, "creating temporary file failed: open(%s, %x, %x): %s",
+                                      FNAME, O_CREAT|O_EXCL, 0600));
 }
 
 
@@ -225,18 +239,13 @@ static struct test_case tcase[] = {
 static int do_test(struct test_case *tc)
 {
         int sys_ret;
-        int sys_errno;
         int result = RESULT_OK;
 	struct timeval tv[2];
-        char fpath[PATH_MAX], c = '\0';
-        int rc, len, cmp_ok = 1;
+        const char *fpath = FNAME;
+        int rc, cmp_ok = 1;
         struct stat st;
         uid_t old_uid;
 
-        TEST(rc = setup_file(TESTDIR, "test.file", fpath));
-        if (rc < 0)
-                return 1;
-
 	/*
          * Change effective user id
          */
@@ -252,10 +261,8 @@ static int do_test(struct test_case *tc)
 	memset(tv, 0, 2 * sizeof(struct timeval));
         tv[0].tv_sec = tc->a_sec;
         tv[1].tv_sec = tc->m_sec;
-        TEST(len = strlen(fpath));
         if (tc->ttype == FILE_NOT_EXIST) {
-                c = fpath[len - 1];
-                fpath[len - 1] = '\0';
+                fpath=FNAME_NX;
         }
         errno = 0;
         if (tc->ttype == NO_FNAME) {
@@ -273,15 +280,13 @@ static int do_test(struct test_case *tc)
 	else
                 TEST(sys_ret = utimes(fpath, tv));
         sys_errno = errno;
-        if (tc->ttype == FILE_NOT_EXIST)
-                fpath[len - 1] = c;
         if (sys_ret < 0)
                 goto TEST_END;
 
 	/*
          * Check test file's time stamp
          */
-        rc = stat(fpath, &st);
+        rc = stat(FNAME, &st);
         if (rc < 0) {
                 EPRINTF("stat failed.\n");
                 result = 1;
@@ -307,8 +312,6 @@ EXIT1:
                         return 1;
         }
 EXIT2:
-        TEST(cleanup_file(fpath));
-
         return result;
 }
 
-- 
1.6.4.3




------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
