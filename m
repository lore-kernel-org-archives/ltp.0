Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UcxC6-0000D4-5d
	for ltp-list@lists.sourceforge.net; Thu, 16 May 2013 12:22:02 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UcxC5-0007tY-CG
	for ltp-list@lists.sourceforge.net; Thu, 16 May 2013 12:22:02 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r4GCLsMd023662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 16 May 2013 12:21:55 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r4GCLsso016161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 16 May 2013 12:21:54 GMT
Received: from abhmt106.oracle.com (abhmt106.oracle.com [141.146.116.58])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r4GCLrKi016147
	for <ltp-list@lists.sourceforge.net>; Thu, 16 May 2013 12:21:53 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 16 May 2013 16:20:11 +0400
Message-Id: <1368706811-14497-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] Create a function tst_resm_hexd to print a buffer in
	hex values
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
 include/test.h |    2 ++
 lib/tst_res.c  |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/include/test.h b/include/test.h
index e36ca38..17b8e39 100644
--- a/include/test.h
+++ b/include/test.h
@@ -191,6 +191,8 @@ void tst_res(int ttype, char *fname, char *arg_fmt, ...)
 	__attribute__ ((format (printf, 3, 4)));
 void tst_resm(int ttype, char *arg_fmt, ...)
 	__attribute__ ((format (printf, 2, 3)));
+void tst_resm_hexd(int ttype, const char *buf, size_t size, char *arg_fmt, ...)
+	__attribute__ ((format (printf, 4, 5)));
 void tst_brk(int ttype, char *fname, void (*func)(void), char *arg_fmt, ...)
 	__attribute__ ((format (printf, 4, 5)));
 void tst_brkm(int ttype, void (*func)(void), char *arg_fmt, ...)
diff --git a/lib/tst_res.c b/lib/tst_res.c
index ffac6d7..e7c9d5d 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -675,6 +675,40 @@ void tst_resm(int ttype, char *arg_fmt, ...)
 }
 
 /*
+ * tst_resm_hexd() - Interface to tst_res(), with no filename.
+ * Also, dump specified buffer in hex.
+ */
+void tst_resm_hexd(int ttype, const char *buf, size_t size, char *arg_fmt, ...)
+{
+	char tmesg[USERMESG];
+
+#if DEBUG
+	printf("IN tst_resm_hexd\n");
+	fflush(stdout);
+	fflush(stdout);
+#endif
+
+	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
+
+	static const size_t symb_num = 3; /* space + xx */
+
+	size_t offset = strlen(tmesg);
+
+	if ((offset + symb_num * size + 1) >= USERMESG) {
+		printf("%s: %i: line too long\n", __func__, __LINE__);
+		abort();
+	}
+
+	size_t i;
+	for (i = 0; i < size; ++i) {
+		sprintf(tmesg + offset + i * symb_num,
+			" %02x", (unsigned char)buf[i]);
+	}
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
