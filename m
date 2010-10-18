Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <guijianfeng@cn.fujitsu.com>) id 1P7m4q-0005ai-R6
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 09:32:20 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P7m4o-00051N-Vf
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 09:32:20 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 7911B170B45
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Oct 2010 17:32:07 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id o9I9S55V029457
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Oct 2010 17:28:05 +0800
Received: from [10.167.225.71] (unknown [10.167.225.71])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 370BD10C202
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Oct 2010 17:33:39 +0800 (CST)
Message-ID: <4CBC1431.1080808@cn.fujitsu.com>
Date: Mon, 18 Oct 2010 17:32:33 +0800
From: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] open_posix_testsuite: Fix variable type error
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

Hi

Currently, the variable "timeout" type is int, We should make it to be "unsigned long". 
Otherwise, we'll get an unexpected value in thread function, consequently, test fails.

Signed-off-by: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
---
 .../functional/threads/pi_test/pitest-1.c          |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/	/functional/threads/pi_test/pitest-1.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
index b8969a8..9fac992 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
@@ -296,7 +296,7 @@ int main(int argc, char **argv)
 
 	/* Start TB thread (boosting thread) */
 	DPRINTF(stderr,"Main Thread: start TB thread\n");
-	int timeout = multiplier * 20;
+	unsigned long timeout = multiplier * 20;
 	rc = pthread_create(&threadtb, &threadattr, thread_tb, 
 			    &timeout);
         if (rc != 0) {
-- 
1.7.0.4


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
