Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WzLjv-0006Gn-6B
	for ltp-list@lists.sourceforge.net; Tue, 24 Jun 2014 08:06:03 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WzLju-0004LS-4p
	for ltp-list@lists.sourceforge.net; Tue, 24 Jun 2014 08:06:03 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5O85sZq003010
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Jun 2014 16:05:54 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 24 Jun 2014 16:03:02 +0800
Message-ID: <1403596982-21645-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] fs/ext4-new-features: fix wrong test point when
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
 .../ext4-persist-prealloc/ext4_persist_prealloc_test.sh              | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
index 20b66f8..d577bb5 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
@@ -46,6 +46,7 @@ ext4_test_persist_prealloc()
 
 	ret=1
 
+	temp_tmpdir=$TMPDIR
 	for ((i = 1; i <= 3; i++))
 	{
 		if ! command -v fallocate0${i} > /dev/null 2>&1; then
@@ -56,13 +57,15 @@ ext4_test_persist_prealloc()
 			return
 		fi
 
-		fallocate0${i} | grep -q "CONF"
+		TMPDIR=mnt_point; fallocate0${i} | grep -q "CONF"
 		if [ $? -ne $ret ]; then
 			tst_resm TFAIL "fallocate's return value is not expected"
 			umount mnt_point
+			TMPDIR=$temp_tmpdir
 			return
 		fi
 	}
+	TMPDIR=$temp_tmpdir
 
 	umount mnt_point
 	if [ $? -ne 0 ]; then
-- 
1.8.2.1


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
