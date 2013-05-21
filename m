Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Uenik-0003t1-LL
	for ltp-list@lists.sourceforge.net; Tue, 21 May 2013 14:39:22 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Uenij-0006mg-O0
	for ltp-list@lists.sourceforge.net; Tue, 21 May 2013 14:39:22 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r4LEdDRj006690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 21 May 2013 14:39:14 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r4LEdElv029173
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 21 May 2013 14:39:14 GMT
Received: from abhmt120.oracle.com (abhmt120.oracle.com [141.146.116.72])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r4LEdE7k008446
	for <ltp-list@lists.sourceforge.net>; Tue, 21 May 2013 14:39:14 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 21 May 2013 18:38:38 +0400
Message-Id: <1369147118-6458-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] Create a function tst_resm_hexd() to print a buffer
	in hex
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
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

This new function behave like the tst_resm() function. The difference is,
it in addition takes a buffer, its size and prints the buffer in hexadecimal
format in the end of the message.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 doc/man3/tst_res.3 |   17 ++++++++++++++---
 include/test.h     |    2 ++
 lib/tst_res.c      |   41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/doc/man3/tst_res.3 b/doc/man3/tst_res.3
index 0c1fe6c..0754daf 100644
--- a/doc/man3/tst_res.3
+++ b/doc/man3/tst_res.3
@@ -37,6 +37,8 @@ tst_res \- Print result message, including file contents
 .sp
 tst_resm \- Print result message
 .sp
+tst_resm_hexd \- Print result message, including specified buffer in hexadecimal format
+.sp
 tst_brk \- Print result message, including file contents, and break remaining test cases
 .sp
 tst_brkm \- Print result message and break remaining test cases
@@ -54,6 +56,9 @@ tst_environ \- Keep results coming to original stdout
 .P
 \fBvoid tst_resm(int \fIttype\fB, char *\fItmesg, [arg ...]\fR)
 .P
+\fBvoid tst_resm_hexd(int \fIttype\fB, const void *\fIbuf\fB, size_t \fIsize\fB,
+char *\fItmesg, [arg ...]\fR)
+.P
 \fBvoid tst_brk(int \fIttype\fB, char *\fIfname\fB, void (*\fIfunc\fB)(),
 char *\fItmesg, [arg ...]\fR)
 .P
@@ -121,6 +126,12 @@ expanded message.  The maximum size allowed for an expanded message is
 pointer to a function which performs either the cleanup necessary prior to
 exiting the test or some function executed at the end of each iteration of a
 loop.
+.TP 10
+.I buf
+pointer to a buffer whose contents will be printed in hexadecimal format.
+.TP 10
+.I size
+size of the buffer.
 .RE
 .SS Result Types
 The possible test result types defined in \fBtest.h\fR are as follows:
@@ -153,9 +164,9 @@ An informative message about the execution of the test that does not
 correspond to a test case result and does not indicate a problem.
 .RE
 .SS Function Descriptions
-\fBtst_res()\fR and \fBtst_resm()\fR are the basic result reporting
-functions.  They report 1 or more test case results of the specified
-\fIttype\fR.  All result types are valid for these functions.  The
+\fBtst_res()\fR, \fBtst_resm()\fR and \fBtst_resm_hexd()\fR are the basic
+result reporting functions. They report 1 or more test case results of the
+specified \fIttype\fR.  All result types are valid for these functions.  The
 \fBtst_range\fR global variable indicates the number of results that will be
 reported for each call to one of these functions.  It is initialized by the
 library to 1, but may be set to a value > 1 by the test.  Each call to one of
diff --git a/include/test.h b/include/test.h
index e36ca38..c922230 100644
--- a/include/test.h
+++ b/include/test.h
@@ -191,6 +191,8 @@ void tst_res(int ttype, char *fname, char *arg_fmt, ...)
 	__attribute__ ((format (printf, 3, 4)));
 void tst_resm(int ttype, char *arg_fmt, ...)
 	__attribute__ ((format (printf, 2, 3)));
+void tst_resm_hexd(int ttype, const void *buf, size_t size, char *arg_fmt, ...)
+	__attribute__ ((format (printf, 4, 5)));
 void tst_brk(int ttype, char *fname, void (*func)(void), char *arg_fmt, ...)
 	__attribute__ ((format (printf, 4, 5)));
 void tst_brkm(int ttype, void (*func)(void), char *arg_fmt, ...)
diff --git a/lib/tst_res.c b/lib/tst_res.c
index ffac6d7..a52c500 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -40,6 +40,7 @@
  *    FUNCTION NAME     :
  *      tst_res() -       Print result message (include file contents)
  *      tst_resm() -      Print result message
+ *      tst_resm_hexd() - Print result message (add buffer contents in hex)
  *      tst_brk() -       Print result message (include file contents)
  *                        and break remaining test cases
  *      tst_brkm() -      Print result message and break remaining test
@@ -675,6 +676,46 @@ void tst_resm(int ttype, char *arg_fmt, ...)
 }
 
 /*
+ * tst_resm_hexd() - Interface to tst_res(), with no filename.
+ * Also, dump specified buffer in hex.
+ */
+void tst_resm_hexd(int ttype, const void *buf, size_t size, char *arg_fmt, ...)
+{
+	char tmesg[USERMESG];
+
+#if DEBUG
+	printf("IN tst_resm_hexd\n");
+	fflush(stdout);
+#endif
+
+	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
+
+	static const char msg_end[] = " ...";
+	static const size_t symb_num = 3; /* space + xx */
+	size_t offset = strlen(tmesg);
+
+	int size_changed = 0;
+
+	if ((offset + symb_num * size + 1) >= USERMESG) {
+		size = (USERMESG - offset - sizeof(msg_end)) / symb_num;
+		size_changed = 1;
+	}
+
+	char *pmesg = tmesg + offset;
+
+	size_t i;
+	for (i = 0; i < size; ++i) {
+		sprintf(pmesg, " %02x", ((unsigned char *)buf)[i]);
+		pmesg += symb_num;
+	}
+
+	if (size_changed)
+		strcpy(pmesg, msg_end);
+
+	tst_res(ttype, NULL, "%s", tmesg);
+}
+
+/*
  * tst_brkm() - Interface to tst_brk(), with no filename.
  */
 void tst_brkm(int ttype, void (*func) (void), char *arg_fmt, ...)
-- 
1.7.1


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
