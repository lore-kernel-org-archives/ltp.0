Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YuI3D-00082w-2Q
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2015 10:13:35 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YuI3B-0008Ax-QV
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2015 10:13:35 +0000
Message-ID: <1431944048.27486.14.camel@G08FNSTD140232>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 18 May 2015 18:14:08 +0800
In-Reply-To: <1429621507-23503-1-git-send-email-alexey.kodanev@oracle.com>
References: <1429621507-23503-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fallocate04: another check if SEEK_HOLE is not
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

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fallocate/fallocate04.c | 49 ++++++++++++++++++-----
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index 911bbe8..9d9587b 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -50,6 +50,8 @@ static const option_t options[] = {
 	{NULL, NULL, NULL}
 };
 
+static off_t check_file_hole(int, off_t, off_t);
+
 static void help(void)
 {
 	printf("  -v      Verbose\n");
@@ -150,17 +152,12 @@ static void test02(void)
 	}
 
 	tst_resm(TINFO, "check that file has a hole with lseek(,,SEEK_HOLE)");
-	off_t ret = lseek(fd, 0, SEEK_HOLE);
 
-	if (ret != (ssize_t)block_size) {
-		/* exclude error when kernel doesn't have SEEK_HOLE support */
-		if (errno != EINVAL) {
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "fallocate() or lseek() failed");
-		}
-		tst_resm(TWARN | TERRNO, "lseek() doesn't support SEEK_HOLE");
-	}
-	tst_resm(TINFO, "found a hole at '%ld' offset", ret);
+	off_t ret = check_file_hole(fd, block_size, block_size);
+	if (ret != (ssize_t)block_size)
+		tst_resm(TWARN | TERRNO, "No file hole found");
+	else
+		tst_resm(TINFO, "found a hole at '%ld' offset", ret);
 
 	size_t alloc_size1 = get_allocsize();
 
@@ -275,3 +272,35 @@ int main(int argc, char *argv[])
 
 	tst_exit();
 }
+
+static off_t check_file_hole(int fd, off_t offset, off_t len)
+{
+	off_t ret;
+
+	ret = lseek(fd, 0, SEEK_HOLE);
+	if (ret < 0) {
+		/* exclude error when kernel doesn't have SEEK_HOLE support */
+		if (errno != EINVAL)
+			tst_brkm(TFAIL | TERRNO, cleanup, "lseek() failed");
+
+		int i;
+		char *buf;
+
+		SAFE_LSEEK(cleanup, fd, offset, SEEK_SET);
+
+		buf = SAFE_MALLOC(cleanup, len);
+
+		SAFE_READ(cleanup, 1, fd, buf, len);
+
+		for (i = 0; i < len; i++) {
+			if (buf[i] != '\0')
+				break;
+		}
+
+		free(buf);
+
+		return i;
+	}
+
+	return ret;
+}
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
