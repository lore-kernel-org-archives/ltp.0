Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hong.gyu.kim@lge.com>) id 1VadAA-0005WT-8n
	for ltp-list@lists.sourceforge.net; Mon, 28 Oct 2013 03:06:42 +0000
Received: from lgemrelse1q.lge.com ([156.147.1.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VadA8-0003fs-Bm
	for ltp-list@lists.sourceforge.net; Mon, 28 Oct 2013 03:06:42 +0000
From: "Honggyu Kim" <hong.gyu.kim@lge.com>
Date: Mon, 28 Oct 2013 12:06:32 +0900
Message-ID: <00e501ced38a$b4b19e90$1e14dbb0$@gyu.kim@lge.com>
MIME-Version: 1.0
Content-Language: ko
Subject: [LTP] [PATCH] ext4-new-features: fix syntax error in configure
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

In configure, string comparison is done using double assignment.
/bin/sh doesn't allow to compare strings using "==".
So "==" is modified to "=".

Signed-off-by: Honggyu Kim <hong.gyu.kim@lge.com>
---
 testcases/kernel/fs/ext4-new-features/configure |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/ext4-new-features/configure b/testcases/kernel/fs/ext4-new-features/configure
index 13f43f9..12849e5 100755
--- a/testcases/kernel/fs/ext4-new-features/configure
+++ b/testcases/kernel/fs/ext4-new-features/configure
@@ -14,9 +14,9 @@ read EXT4_DEV
 
 echo "The partition is: $EXT4_DEV, Are you sure(Y/N)?"
 read RESULT
-if [ "$RESULT" == "Y" ] || [ "$RESULT" == "y" ]; then
+if [ "$RESULT" = "Y" ] || [ "$RESULT" = "y" ]; then
 	echo "EXT4_DEV=$EXT4_DEV" > ./ext4-test-config
-elif [ "$RESULT" == "N" ]; then
+elif [ "$RESULT" = "N" ]; then
 	echo "Give up specifing a partition!"
 else
 	echo "Your input is wrong($RESULT)."
-- 
1.7.9.5



------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
