Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X99Sm-0007qK-Jj
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 09:00:52 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X99Sk-00005s-1o
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 09:00:52 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6L90fGk020945
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Jul 2014 17:00:41 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 21 Jul 2014 17:00:03 +0800
Message-ID: <1405933204-12601-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] remove meaningless TRETR flag
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Flag TRETR was introduced to indicate test case was no longer valid and had
been "retired". But if you grep "TRETR" in LTP, you will not find any test
case using this flag. And if test case is no longer valid, we can just remove
it form LTP, so remove this flag.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 doc/man3/tst_res.3           | 20 +++++++-------------
 include/tst_res_flags.h      |  1 -
 lib/tst_res.c                | 25 +++++++++++--------------
 testcases/lib/test.sh        |  6 ++----
 tools/apicmds/ltpapicmd.c    | 20 +++++++++-----------
 tools/genhtml.pl             |  7 -------
 tools/html_report_header.txt |  1 -
 7 files changed, 29 insertions(+), 51 deletions(-)

diff --git a/doc/man3/tst_res.3 b/doc/man3/tst_res.3
index 0754daf..c112ee3 100644
--- a/doc/man3/tst_res.3
+++ b/doc/man3/tst_res.3
@@ -104,7 +104,7 @@ The details are described below under the appropriate functions.
 .RS 5
 .TP 10
 .I ttype
-test result type; one of \fBTPASS, TFAIL, TBROK, TCONF, TRETR, TWARN\fR, or
+test result type; one of \fBTPASS, TFAIL, TBROK, TCONF, TWARN\fR, or
 \fBTINFO\fR (explained below).
 .TP 10
 .I fname
@@ -151,9 +151,6 @@ temporary file could not be opened).
 The test case was not appropriate for the current hardware or software
 configuration (e.g. MLS was not enabled).
 .TP 10
-.B TRETR
-The test case was no longer valid and has been "retired."
-.TP 10
 .B TWARN
 The testing procedure caused undesirable side effects that did not affect
 test results (e.g. a temporary file could not be removed after all test
@@ -184,10 +181,10 @@ this, a \fBtst_range\fR value > 1 is not valid for these types.
 \fBtst_brk()\fR and \fBtst_brkm()\fR are used to report results for all test
 cases remaining in the test, and then call a cleanup function.  The only
 result types that are valid for these functions are: \fBTFAIL, TBROK,
-TCONF\fR, and \fBTRETR\fR.  When called with a \fIttype\fR of \fBTFAIL\fR or
+and TCONF\fR.  When called with a \fIttype\fR of \fBTFAIL\fR or
 \fBTBROK\fR, one result of the specified \fIttype\fR will be printed,
 followed by results of type \fBTBROK\fR for the remaining test cases.  When
-called with a \fIttype\fR of \fBTCONF\fR or \fBTRETR\fR, the specified
+called with a \fIttype\fR of \fBTCONF\fR, the specified
 \fIttype\fR will be printed for all remaining test cases.  If \fIfunc\fR is
 not NULL, \fBtst_brk()\fR and \fBtst_brkm()\fR will call \fIfunc\fR after all
 results have been printed.  If the call to \fIfunc\fR returns,
@@ -223,17 +220,14 @@ TBROK
 TWARN
 0004	/* .... .1.. */
 .TP 10
-TRETR
-0010	/* .... 1... */
-.TP 10
 TINFO
-0020	/* ...1 .... */
+0010	/* .... 1... */
 .TP 10
 TCONF
-0040	/* ..1. .... */
+0020	/* ...1 .... */
 .RE
 .P
-NOTE: \fBTPASS, TRETR, TINFO\fR, and \fBTCONF\fR do not have an effect
+NOTE: \fBTPASS and TINFO\fR do not have an effect
 on the test program exit status.
 .P
 \fBtst_environ()\fR is used to ensure that results reported by this library
@@ -320,7 +314,7 @@ If an invalid test type is specified.
 If \fBtst_count\fR is negative.
 .P
 If one of the \fBtst_brk[m]()\fR routines is called with a test type
-other than \fBTFAIL, TBROK, TCONF\fR, or \fBTRETR\fR.
+other than \fBTFAIL, TBROK, TCONF\fR.
 .P
 If there are any problems opening/reading/writing the contents of \fIfname\fR.
 .RE
diff --git a/include/tst_res_flags.h b/include/tst_res_flags.h
index 5c5ab4c..1f3d06d 100644
--- a/include/tst_res_flags.h
+++ b/include/tst_res_flags.h
@@ -17,7 +17,6 @@
 #define TFAIL	1	/* Test failed flag */
 #define TBROK	2	/* Test broken flag */
 #define TWARN	4	/* Test warning flag */
-#define TRETR	8	/* Test retire flag */
 #define TINFO	16	/* Test information flag */
 #define TCONF	32	/* Test not appropriate for configuration flag */
 #define TTYPE_RESULT(ttype)	((ttype) & TTYPE_MASK)
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 31186e0..0383c98 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -207,7 +207,6 @@ const char *strttype(int ttype)
 		PAIR(TPASS)
 		PAIR(TFAIL)
 		PAIR(TBROK)
-		PAIR(TRETR)
 		PAIR(TCONF)
 		PAIR(TWARN)
 		PAIR(TINFO)
@@ -562,8 +561,8 @@ void tst_exit(void)
 	/* Call tst_flush() flush any output in the buffer. */
 	tst_flush();
 
-	/* Mask out TRETR, TINFO, and TCONF results from the exit status. */
-	exit(T_exitval & ~(TRETR | TINFO));
+	/* Mask out TINFO result from the exit status. */
+	exit(T_exitval & ~TINFO);
 }
 
 pid_t tst_fork(void)
@@ -622,7 +621,7 @@ void tst_brk(int ttype, const char *fname, void (*func) (void), const char *arg_
 	 * Only FAIL, BROK, CONF, and RETR are supported by tst_brk().
 	 */
 	if (ttype_result != TFAIL && ttype_result != TBROK &&
-	    ttype_result != TCONF && ttype_result != TRETR) {
+	    ttype_result != TCONF) {
 		sprintf(Warn_mesg, "%s: Invalid Type: %d. Using TBROK",
 			__func__, ttype_result);
 		tst_print(TCID, 0, TWARN, Warn_mesg);
@@ -636,8 +635,6 @@ void tst_brk(int ttype, const char *fname, void (*func) (void), const char *arg_
 			tst_res(ttype, NULL,
 				"Remaining cases not appropriate for "
 				"configuration");
-		else if (ttype_result == TRETR)
-			tst_res(ttype, NULL, "Remaining cases retired");
 		else if (ttype_result == TBROK)
 			tst_res(TBROK, NULL, "Remaining cases broken");
 	}
@@ -828,13 +825,13 @@ int main(void)
 	       %2i : call tst_res(TFAIL, ...)\n\
 	       %2i : call tst_res(TBROK, ...)\n\
 	       %2i : call tst_res(TWARN, ...)\n\
-	       %2i : call tst_res(TRETR, ...)\n\
 	       %2i : call tst_res(TINFO, ...)\n\
-	       %2i : call tst_res(TCONF, ...)\n\n", TPASS, TFAIL, TBROK, TWARN, TRETR, TINFO, TCONF);
+	       %2i : call tst_res(TCONF, ...)\n\n", TPASS, TFAIL, TBROK,
+	       TWARN, TINFO, TCONF);
 
 	while (1) {
-		printf("Enter ttype (-5,-4,-3,-2,-1,%i,%i,%i,%i,%i,%i,%i): ",
-		       TPASS, TFAIL, TBROK, TWARN, TRETR, TINFO, TCONF);
+		printf("Enter ttype(-5, -4, -3, -2, -1, %i, %i, %i, %i, %i, %i)"
+		       " : ", TPASS, TFAIL, TBROK, TWARN, TINFO, TCONF);
 		scanf("%d%c", &ttype, &chr);
 
 		switch (ttype) {
@@ -848,8 +845,8 @@ int main(void)
 
 		case -3:
 			printf
-			    ("Enter the current type (%i=FAIL, %i=BROK, %i=RETR, %i=CONF): ",
-			     TFAIL, TBROK, TRETR, TCONF);
+			    ("Enter the current type (%i=FAIL, %i=BROK, "
+			     "%i=CONF): ", TFAIL, TBROK, TCONF);
 			scanf("%d%c", &ttype, &chr);
 			printf("Enter file name (<cr> for none): ");
 			gets(fname);
@@ -862,8 +859,8 @@ int main(void)
 
 		case -4:
 			printf
-			    ("Enter the current type (%i,%i,%i,%i,%i,%i,%i): ",
-			     TPASS, TFAIL, TBROK, TWARN, TRETR, TINFO, TCONF);
+			    ("Enter the current type (%i,%i,%i,%i,%i,%i): ",
+			     TPASS, TFAIL, TBROK, TWARN, TINFO, TCONF);
 			scanf("%d%c", &ttype, &chr);
 		default:
 			printf("Enter file name (<cr> for none): ");
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index b6eb5e8..e26c132 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -33,7 +33,6 @@ tst_flag2mask()
 	TFAIL) return 1;;
 	TBROK) return 2;;
 	TWARN) return 4;;
-	TRETR) return 8;;
 	TINFO) return 16;;
 	TCONF) return 32;;
 	*) tst_brkm TBROK "Invalid resm type '$1'";;
@@ -60,7 +59,6 @@ tst_brkm()
 	TFAIL) ;;
 	TBROK) ;;
 	TCONF) ;;
-	TRETR) ;;
 	*) tst_brkm TBROK "Invalid tst_brkm type '$1'";;
 	esac
 
@@ -81,8 +79,8 @@ tst_exit()
 		$TST_CLEANUP
 	fi
 
-	# Mask out TRETR, TINFO and TCONF
-	exit $((LTP_RET_VAL & ~(8 | 16)))
+	# Mask out TINFO
+	exit $((LTP_RET_VAL & ~16))
 }
 
 tst_tmpdir()
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index 220edae..c7bffa1 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -93,7 +93,7 @@ static char *tst_cntstr;	/* sets the value of tst_count with this value */
  *              the string that is entered by the user to an integer value that
  *              is understood by the API's.
  *
- * Return:      test type TPASS, TFAIL, TBROK, TCONF, TRETR, TWARN, or TINFO
+ * Return:      test type TPASS, TFAIL, TBROK, TCONF, TWARN, or TINFO
  *              on success
  *              -1 on failure
  */
@@ -108,8 +108,6 @@ int ident_ttype(char *tstype)
 		return TPASS;
 	else if (strcmp(tstype, "TCONF") == 0)
 		return TCONF;
-	else if (strcmp(tstype, "TRETR") == 0)
-		return TRETR;
 	else if (strcmp(tstype, "TWARN") == 0)
 		return TWARN;
 	else if (strcmp(tstype, "TINFO") == 0)
@@ -125,8 +123,8 @@ void apicmd_brk(int argc, char *argv[])
 
 	if (argc < 5) {
 		fprintf(stderr, "Usage: %s TTYPE FNAME FUNC STRING\n"
-			"\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
-			"and TRETR.\n"
+			"\tTTYPE  - Test Result Type; one of TFAIL, TBROK "
+			"and TCONF.\n"
 			"\tFNAME  - Print contents of this file after the message\n"
 			"\tFUNC   - Cleanup function (ignored), but MUST be provided\n"
 			"\tSTRING - Message explaining the test result\n",
@@ -146,8 +144,8 @@ void apicmd_res(int argc, char *argv[])
 
 	if (argc < 4) {
 		fprintf(stderr, "Usage: %s TTYPE FNAME STRING\n"
-			"\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
-			"and  TRETR.\n"
+			"\tTTYPE  - Test Result Type; one of TFAIL, TBROK "
+			"and  TCONF.\n"
 			"\tFNAME  - Print contents of this file after the message\n"
 			"\tSTRING - Message explaining the test result\n",
 			cmd_name);
@@ -164,8 +162,8 @@ void apicmd_brkm(int argc, char *argv[])
 
 	if (argc < 4) {
 		fprintf(stderr, "Usage: %s TTYPE FUNC STRING\n"
-			"\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
-			"and TRETR.\n"
+			"\tTTYPE  - Test Result Type; one of TFAIL, TBROK "
+			"and TCONF.\n"
 			"\tFUNC   - Cleanup function (ignored), but MUST be provided\n"
 			"\tSTRING - Message explaining the test result\n",
 			cmd_name);
@@ -182,8 +180,8 @@ void apicmd_resm(int argc, char *argv[])
 
 	if (argc < 3) {
 		fprintf(stderr, "Usage: %s TTYPE STRING\n"
-			"\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
-			"and TRETR.\n"
+			"\tTTYPE  - Test Result Type; one of TFAIL, TBROK"
+			"and TCONF.\n"
 			"\tSTRING - Message explaining the test result\n",
 			cmd_name);
 		exit(1);
diff --git a/tools/genhtml.pl b/tools/genhtml.pl
index 50c66f7..7e9bdd4 100644
--- a/tools/genhtml.pl
+++ b/tools/genhtml.pl
@@ -197,12 +197,6 @@ foreach my $file (@ARGV) {
 				    $warn_test_counter++;
 				    $warn_test_counter_flag=1;
 				}
-			    } elsif ($line =~ /\ TRETR\ / ) {
-				$detected_retr = 1;
-				if ( $retr_test_counter_flag == 0 ) {
-				    $retr_test_counter++;
-				    $retr_test_counter_flag=1;
-				}
 			    } elsif ($line =~ /\ TCONF\ / ) {
 				$detected_conf = 1;
 				if ( $conf_test_counter_flag == 0 ) {
@@ -244,7 +238,6 @@ print "<tr><td><strong>Total Test TPASS:</strong></td><td><strong> $test_passed
 print "<tr><td><strong>Total Test TFAIL:</strong></td><td><strong> $failed_test_counter </strong></td></tr>\n";
 print "<tr><td><strong>Total Test TBROK</strong></td><td><strong> $brok_test_counter </strong></td></tr>\n";
 print "<tr><td><strong>Total Test TWARN</strong></td><td><strong> $warn_test_counter </strong></td></tr>\n";
-print "<tr><td><strong>Total Test TRETR</strong></td><td><strong> $retr_test_counter </strong></td></tr>\n";
 print "<tr><td><strong>Total Test TCONF</strong></td><td><strong> $conf_test_counter </strong></td></tr>\n";
 print "<tr><td><strong>Kernel Version</strong></td><td><strong> $ENV{KERNEL_VERSION}  </strong></td></tr>\n";
 print "<tr><td><strong>Machine Architecture</strong></td><td><strong> $ENV{MACHINE_ARCH} </strong></td></tr>\n";
diff --git a/tools/html_report_header.txt b/tools/html_report_header.txt
index 98176ba..b3da2c5 100644
--- a/tools/html_report_header.txt
+++ b/tools/html_report_header.txt
@@ -25,7 +25,6 @@
 <li><b>TFAIL -</b> Indicates that the test case had an unexpected result and failed.</li>
 <li><b>TBROK -</b> Indicates that the remaining test cases are broken and will not execute correctly, because some precondition not met, such as a resource not being available.</li>
 <li><b>TCONF -</b> Indicates that the test case was not written to run on the current harware or software configuration such as machine type, or, kernel version.</li>
-<li><b>TRETR -</b> Indicates that the test cases has been retired and should not be executed any longer.</li>
 <li><b>TWARN -</b> Indicates that the test case experienced an unexpected or undesirable event that should not affect the test itself such as being unable to cleanup resources after the test finished.</li>
 <li><b>TINFO -</b> Specifies useful information about the status of the test that does not affect the result and does not indicate a problem.</li>
 <hr>
-- 
1.8.2.1


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
