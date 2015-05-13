Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YsUiF-0007bQ-6N
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 11:20:31 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YsUiE-0002oq-3w
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 11:20:31 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4DBJ4em004328
	for <ltp-list@lists.sourceforge.net>; Wed, 13 May 2015 19:19:04 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 13 May 2015 19:19:44 +0800
Message-ID: <1431515986-22287-3-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1431515986-22287-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1431515986-22287-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/5] testcases/kernel: replace umount() with
	tst_umount()
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

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/io/direct_io/dma_thread_diotest.c | 2 +-
 testcases/kernel/syscalls/ftruncate/ftruncate04.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/io/direct_io/dma_thread_diotest.c b/testcases/kernel/io/direct_io/dma_thread_diotest.c
index 877b707..6ac1dec 100644
--- a/testcases/kernel/io/direct_io/dma_thread_diotest.c
+++ b/testcases/kernel/io/direct_io/dma_thread_diotest.c
@@ -429,7 +429,7 @@ static void cleanup(void)
 {
 	free(buffer);
 
-	if (mount_flag && umount(MNT_POINT) < 0)
+	if (mount_flag && tst_umount(MNT_POINT) < 0)
 		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
 
 	free(worker);
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate04.c b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
index 99aebfe..2136227 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -248,7 +248,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (mount_flag && umount(MOUNT_DIR))
+	if (mount_flag && tst_umount(MOUNT_DIR))
 		tst_resm(TWARN | TERRNO, "umount(%s) failed", device);
 
 	if (device)
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
