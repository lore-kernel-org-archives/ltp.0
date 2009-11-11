Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1N82Pg-0005xG-7k
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 01:54:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N82Pa-0001Z6-PA
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 01:54:24 +0000
Message-ID: <4AFA18A6.50005@cn.fujitsu.com>
Date: Wed, 11 Nov 2009 09:51:34 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] ext4: fix script error of ext4_nsec_timestamps_test.sh
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
To: subrata@linux.vnet.ibm.com, Miao Xie <miaox@cn.fujitsu.com>, ltp-list@lists.sourceforge.net

Execute test case of ext4_nsec_timestamps_test.sh had some errors:
./ext4_nsec_timestamps_test.sh: line 183: [0: command not found
./ext4_nsec_timestamps_test.sh: line 189: [0: command not found

This patch fix them.

Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>
---
 .../ext4_nsec_timestamps_test.sh                   |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
index ad7729e..ced6576 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
@@ -180,13 +180,13 @@ ext4_setup
 RET=0
 
 ext4_test_sec_timestamps
-if [$? -ne 0 ]; then
+if [ $? -ne 0 ]; then
 	RET=1
 fi
 : $((TST_COUNT++))
 
 ext4_test_nsec_timestamps
-if [$? -ne 0 ]; then
+if [ $? -ne 0 ]; then
 	RET=1
 fi
 : $((TST_COUNT++))
-- 
1.6.4




------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
