Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1Sf1EB-0002kX-1z
	for ltp-list@lists.sourceforge.net; Thu, 14 Jun 2012 04:00:11 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sf1EA-000867-36
	for ltp-list@lists.sourceforge.net; Thu, 14 Jun 2012 04:00:11 +0000
From: Zhouping Liu <zliu@redhat.com>
Date: Thu, 14 Jun 2012 12:01:49 +0800
Message-Id: <7e5ef3dd14f0c86e24df50bdf809e69bbdac6903.1339645403.git.zliu@redhat.com>
In-Reply-To: <4a17ab14caea979b15264705158a639e0879cb96.1339645403.git.zliu@redhat.com>
References: <4a17ab14caea979b15264705158a639e0879cb96.1339645403.git.zliu@redhat.com>
Subject: [LTP] [PATCH 2/2] lib/mem.c: using read_file to replace the
	redundant code
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Cai Qian <caiqian@redhat.com>, LTP List <ltp-list@lists.sourceforge.net>

inside _check function, using read_file func to replace
the redundant code.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/lib/mem.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 5ead938..aa3f215 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -132,18 +132,16 @@ void testoom(int mempolicy, int lite, int numa)
 static void _check(char *path, long int value)
 {
 	FILE *fp;
-	char buf[BUFSIZ];
+	char buf[BUFSIZ], fullpath[BUFSIZ];
+	long tmp;
 
-	snprintf(buf, BUFSIZ, "%s%s", PATH_KSM, path);
-	fp = fopen(buf, "r");
-	if (fp == NULL)
-		tst_brkm(TBROK|TERRNO, tst_exit, "fopen");
-	if (fgets(buf, BUFSIZ, fp) == NULL)
-		tst_brkm(TBROK|TERRNO, tst_exit, "fgets");
-	fclose(fp);
 
-	tst_resm(TINFO, "%s is %ld.", path, atol(buf));
-	if (atol(buf) != value)
+	snprintf(fullpath, BUFSIZ, "%s%s", PATH_KSM, path);
+	read_file(fullpath, buf);
+	tmp = SAFE_STRTOL(cleanup, buf, LONG_MIN, LONG_MAX);
+
+	tst_resm(TINFO, "%s is %ld.", path, tmp);
+	if (tmp != value)
 		tst_resm(TFAIL, "%s is not %ld.", path, value);
 }
 
-- 
1.7.10.2


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
