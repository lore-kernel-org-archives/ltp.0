Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1ZZqGC-0001Ik-Mm
	for ltp-list@lists.sourceforge.net; Thu, 10 Sep 2015 01:02:44 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZZqG9-0005zS-OV
	for ltp-list@lists.sourceforge.net; Thu, 10 Sep 2015 01:02:44 +0000
From: Cui Bixuan <cuibixuan@huawei.com>
Date: Thu, 10 Sep 2015 01:02:15 +0000
Message-ID: <1441846935-44787-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH]  [PATCH] rmdir/rmdir05: Delete unnecessary if
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
Cc: zhuyanpeng@huawei.com, zhanyongming@huawei.com

Delete unnecessary if in testcase

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/rmdir/rmdir05.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/rmdir/rmdir05.c b/testcases/kernel/syscalls/rmdir/rmdir05.c
index 10037c7..2f0f102 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir05.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir05.c
@@ -81,9 +81,6 @@ int main(int argc, char **argv)
 		TEST(rmdir("."));
 
 		if (TEST_RETURN == -1) {
-		}
-
-		if (TEST_RETURN == -1) {
 			if (TEST_ERRNO & (EBUSY | ENOTEMPTY)) {
 				/* For functionality tests, verify that the
 				 * directory wasn't removed.
-- 
1.6.0.2


------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
