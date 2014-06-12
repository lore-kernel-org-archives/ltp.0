Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WuxpH-0008FV-6I
	for ltp-list@lists.sourceforge.net; Thu, 12 Jun 2014 05:45:27 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WuxpF-0006Gf-91
	for ltp-list@lists.sourceforge.net; Thu, 12 Jun 2014 05:45:27 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5C5jEKd002293
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Jun 2014 13:45:14 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 12 Jun 2014 13:42:34 +0800
Message-ID: <1402551754-19942-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fs/ext4-new-features: fix wrong test point when
	running ext4-persist-prealloc
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

ext4-persist-prealloc test will call test cases under 'testcases/kernel/syscalls
/fallocate' to have persist prealloc test for ext4 filesystem. But currently
fallocate[0-3] cases will have tests in a different filesystem, which the directory
created by tst_tmpdir() is in. This is wrong, fix it.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 .../ext4-persist-prealloc/ext4_persist_prealloc_test.sh                | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
index 20b66f8..063a701 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
@@ -46,6 +46,8 @@ ext4_test_persist_prealloc()
 
 	ret=1
 
+	temp_tmpdir=$TMPDIR
+	export TMPDIR=mnt_point
 	for ((i = 1; i <= 3; i++))
 	{
 		if ! command -v fallocate0${i} > /dev/null 2>&1; then
@@ -63,6 +65,7 @@ ext4_test_persist_prealloc()
 			return
 		fi
 	}
+	TMPDIR=$temp_tmpdir
 
 	umount mnt_point
 	if [ $? -ne 0 ]; then
-- 
1.8.2.1


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
