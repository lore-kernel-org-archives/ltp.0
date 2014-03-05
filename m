Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WL1ZZ-00085S-Q5
	for ltp-list@lists.sourceforge.net; Wed, 05 Mar 2014 02:28:41 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WL1ZY-00046K-QG
	for ltp-list@lists.sourceforge.net; Wed, 05 Mar 2014 02:28:41 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s252SUC6012078
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Mar 2014 10:28:31 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 5 Mar 2014 10:26:51 +0800
Message-Id: <1393986411-29379-3-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1393986411-29379-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1393986411-29379-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2 3/3] fallocate/fallocate02.c: delete a invalid test
	item
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

fallocate02.c: delete this test item "{&fdw, FNAMEW, DEFAULT_TEST_MODE,
BLOCKS_WRITTEN-OFFSET, 1, 0}". Fallocate02 is to test various error
conditions for fallocate() syscall, usually these error conditions
can be checked in vfs layer. Here this test item, which the expected
return value is 0, is dependent on whether the underlying file systems
implement fallocate. So here we choose to remove it, or may specify a
block device, which contains a ext4 file system.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fallocate/fallocate02.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index fa63f3b..5eff903 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -75,7 +75,6 @@ static struct test_data_t {
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, 0, EINVAL},
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, -1, EINVAL},
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, -(BLOCKS_WRITTEN+OFFSET), 1, EINVAL},
-	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN-OFFSET, 1, 0},
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, MAX_FILESIZE, 1, EFBIG},
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, 1, MAX_FILESIZE, EFBIG},
 };
-- 
1.8.2.1


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
