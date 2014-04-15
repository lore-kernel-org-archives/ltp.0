Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Wa2hU-0006Tg-Dd
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 12:42:56 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wa2hT-00038I-EP
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 12:42:56 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3FCgmkW012214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Apr 2014 12:42:49 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3FCglRK011729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Apr 2014 12:42:48 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s3FCglgc010596
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Apr 2014 12:42:47 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 15 Apr 2014 16:42:42 +0400
Message-Id: <1397565762-11015-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] doc: test-writing-guidelines: fixed the C test example
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
Cc: vasily.isaenko@oracle.com

This example had some typos and other basic mistakes that prevented
it from being built.

Fixed it.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---

I thing it's a canditate to be applied before the release.
What do you think?

 doc/test-writing-guidelines.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 6e79d1a..91edbf0 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -218,6 +218,7 @@ Let's start with an example, following code is a simple test for a getenv().
  */
 
 #include "test.h"
+#include "usctest.h"
 
 char *TCID = "getenv01";
 int TST_TOTAL = 2;
@@ -236,7 +237,7 @@ static void test(void)
 {
 	char *ret;
 
-	ret = getenv(TEST_EVN);
+	ret = getenv(TEST_ENV);
 
 	if (ret) {
 		if (!strcmp(ret, TEST_ENV_VAL))
@@ -254,7 +255,7 @@ static void test(void)
 	if (ret)
 		tst_resm(TFAIL, "getenv(" TEST_NE_ENV ") = '%s'", ret);
 	else
-		tst_resm(TPASS, "getenv(" TEST_NE_ENV ")" = NULL);
+		tst_resm(TPASS, "getenv(" TEST_NE_ENV ") = NULL");
 }
 
 int main(int argc, char *argv[])
@@ -262,7 +263,7 @@ int main(int argc, char *argv[])
 	const char *msg;
 	int lc;
 
-	if ((msg = parse_opts(argc, argv, NULL, NULL))
+	if ((msg = parse_opts(argc, argv, NULL, NULL)))
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	setup();
-- 
1.7.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
