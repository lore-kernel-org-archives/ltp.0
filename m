From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:31 +0100
Subject: [LTP] [COMMITTED] [PATCH 09/23] syscalls/fmtmsg01: Small cleanup
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-9-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Get rid of useless comments

* Get rid of UCLINUX ifdefs

* Make use of tst_parse_opts()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fmtmsg/fmtmsg01.c | 40 +++++++----------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/testcases/kernel/syscalls/fmtmsg/fmtmsg01.c b/testcases/kernel/syscalls/fmtmsg/fmtmsg01.c
index b41f6b2..6ed4a1c 100644
--- a/testcases/kernel/syscalls/fmtmsg/fmtmsg01.c
+++ b/testcases/kernel/syscalls/fmtmsg/fmtmsg01.c
@@ -21,16 +21,10 @@
 /* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
 
 /*
- * NAME
- *      fmtmsg -- test fmtmsg(3C) and addseverity(3C)
- *
- * CALLS
- *      fmtmsg(3), addseverity(3C)
+ * fmtmsg(3C) and addseverity(3C)
  *
  * ALGORITHM
  *      Check basic functionality using various messages and severity levels.
- *
- * RESTRICTIONS
  */
 
 #include <sys/types.h>
@@ -38,12 +32,11 @@
 #include <fcntl.h>
 #include <ctype.h>
 #include <stdio.h>
-#if !defined(UCLINUX) && !defined(__UCLIBC__)
+#if !defined(__UCLIBC__)
 #include <fmtmsg.h>		/* interface definition */
 #endif
 #include <string.h>
 
-/*****	LTP Port	*****/
 #include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
@@ -63,9 +56,6 @@ int blenter();
 int blexit();
 void setup();
 
-/*****	**	**	*****/
-//char progname[]= "fmtmsg1()";
-
 char ch;
 char buf[80];
 char *str1 = "LTP:fmtmsg: INFO: LTP fmtmsg() test1 message, NOT an error";
@@ -80,15 +70,16 @@ void clearbuf(void)
 		buf[i] = '\0';
 }
 
-#if !defined(UCLINUX) && !defined(__UCLIBC__)
+#if !defined(__UCLIBC__)
 
-/*--------------------------------------------------------------*/
 int main(int argc, char *argv[])
 {
 	int fd, ret_val;
 	FILE *fp;
 
-	setup();		/* temp file is now open */
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+	setup();
 /*--------------------------------------------------------------*/
 	blenter();
 
@@ -218,18 +209,10 @@ int main(int argc, char *argv[])
 	}
 
 	blexit();
-/*--------------------------------------------------------------*/
-/* Clean up any files created by test before call to anyfail.   */
-
-	anyfail();		/* THIS CALL DOES NOT RETURN - EXITS!!  */
+	anyfail();
 	tst_exit();
 }
 
-/*--------------------------------------------------------------*/
-
-/*****	LTP Port	*****/
-/* FUNCTIONS GO HERE */
-
 int anyfail(void)
 {
 	(local_flag == FAILED) ? tst_resm(TFAIL,
@@ -247,14 +230,12 @@ void setup(void)
 
 int blenter(void)
 {
-	//tst_resm(TINFO, "Enter block %d", block_number);
 	local_flag = PASSED;
 	return 0;
 }
 
 int blexit(void)
 {
-	//tst_resm(TINFO, "Exitng test");
 	(local_flag == FAILED) ? tst_resm(TFAIL,
 					  "Test failed") : tst_resm(TPASS,
 								    "Test passed");
@@ -265,10 +246,7 @@ int blexit(void)
 
 int main(void)
 {
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
+	tst_brkm(TCONF, NULL, "test is not available on uClibc");
 }
 
-#endif /* if !defined(UCLINUX) */
-
-/*****	**	**	*****/
+#endif /* if !defined(__UCLIBC__) */
-- 
2.10.2

