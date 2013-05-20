Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UeSoH-0002Ka-N2
	for ltp-list@lists.sourceforge.net; Mon, 20 May 2013 16:19:41 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UeSoG-0002S9-PK
	for ltp-list@lists.sourceforge.net; Mon, 20 May 2013 16:19:41 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r4KGJYJi016839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 20 May 2013 16:19:34 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r4KGJVew013135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 20 May 2013 16:19:33 GMT
Received: from abhmt110.oracle.com (abhmt110.oracle.com [141.146.116.62])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r4KGJV3W025767
	for <ltp-list@lists.sourceforge.net>; Mon, 20 May 2013 16:19:31 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 20 May 2013 20:18:54 +0400
Message-Id: <1369066734-17683-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] Create a function tst_resm_hexd to print a buffer in
	hex
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 doc/man3/tst_res.3 |   17 ++++++++++++++---
 include/test.h     |    2 ++
 lib/tst_res.c      |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 3 deletions(-)

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
index ffac6d7..7e65117 100644
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
@@ -62,6 +63,12 @@
  *      int  ttype;
  *      char *tmesg;
  *
+ *      void tst_resm_hexd(ttype, buf, size, tmesg [,arg]...)
+ *      int  ttype;
+ *      const void *buf;
+ *      size_t size;
+ *      char *tmesg;
+ *
  *      void tst_brk(ttype, fname, cleanup, tmesg, [,argv]...)
  *      int  ttype;
  *      char *fname;
@@ -675,6 +682,47 @@ void tst_resm(int ttype, char *arg_fmt, ...)
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
+	size_t end_num = strlen(msg_end);
+	size_t offset = strlen(tmesg);
+
+	int size_changed = 0;
+
+	if ((offset + symb_num * size + 1) >= USERMESG) {
+		size = (USERMESG - offset) / symb_num - end_num - 1;
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
+		strcat(pmesg, msg_end);
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
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
