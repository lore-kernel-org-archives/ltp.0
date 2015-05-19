Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YudDf-0004Ry-HV
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2015 08:49:47 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YudDe-0002Yx-DU
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2015 08:49:47 +0000
Message-ID: <1432025422.16347.6.camel@G08FNSTD140232>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 19 May 2015 16:50:22 +0800
In-Reply-To: <5559F134.7040705@oracle.com>
References: <1429621507-23503-1-git-send-email-alexey.kodanev@oracle.com>
	<1431944048.27486.14.camel@G08FNSTD140232>
	<5559F134.7040705@oracle.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] fallocate04: another check if SEEK_HOLE is not
	supported
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

SEEK_HOLE is only supported since version 3.1. Check the specified
range blocks are zeroed while the kernel does not supported SEEK_HOLE.

Signed-off-by: Zhang Jin <jy_zhangjin@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fallocate/fallocate04.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index 911bbe8..e94c572 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -98,13 +98,13 @@ static void setup(void)
 	get_blocksize();
 }
 
-static void check_file_data(const char exp_buf[], size_t size)
+static void check_file_data_(const char exp_buf[], size_t size, off_t offset)
 {
 	char rbuf[size];
 
 	tst_resm(TINFO, "reading the file, compare with expected buffer");
 
-	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
+	SAFE_LSEEK(cleanup, fd, offset, SEEK_SET);
 	SAFE_READ(cleanup, 1, fd, rbuf, size);
 
 	if (memcmp(exp_buf, rbuf, size)) {
@@ -116,6 +116,11 @@ static void check_file_data(const char exp_buf[], size_t size)
 	}
 }
 
+static inline void check_file_data(const char exp_buf[], size_t size)
+{
+	check_file_data_(exp_buf, size, 0);
+}
+
 static void test01(void)
 {
 	tst_resm(TINFO, "allocate '%zu' bytes", buf_size);
@@ -158,7 +163,9 @@ static void test02(void)
 			tst_brkm(TFAIL | TERRNO, cleanup,
 				 "fallocate() or lseek() failed");
 		}
-		tst_resm(TWARN | TERRNO, "lseek() doesn't support SEEK_HOLE");
+		char zeros[block_size];
+		memset(zeros, 0, block_size);
+		check_file_data_(zeros, block_size, block_size);
 	}
 	tst_resm(TINFO, "found a hole at '%ld' offset", ret);
 
-- 
1.9.3




------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
