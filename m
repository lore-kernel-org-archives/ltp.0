Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UAFtq-0004jp-Uk
	for ltp-list@lists.sourceforge.net; Tue, 26 Feb 2013 08:28:34 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UAFtp-00078Q-CY
	for ltp-list@lists.sourceforge.net; Tue, 26 Feb 2013 08:28:34 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r1Q8R937020299
	for <ltp-list@lists.sourceforge.net>; Tue, 26 Feb 2013 16:27:10 +0800
Message-ID: <512C716B.9020600@cn.fujitsu.com>
Date: Tue, 26 Feb 2013 16:25:15 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] pthread_kill/1-2.c: fix a trivial typo miss
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
To: LTP list <ltp-list@lists.sourceforge.net>


fix a trivial typo miss

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 .../open_posix_testsuite/conformance/interfaces/pthread_kill/1-2.c      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/1-2.c
b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/1-2.c
index 3876bd1..cad281e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/1-2.c
@@ -127,7 +127,7 @@ int main(int argc, char *argv[])
 		UNRESOLVED(ret, "Failed to empty signal set");
 	}

-	sigaction(SIGUSR2, &sa, 0);
+	ret = sigaction(SIGUSR2, &sa, 0);

 	if (ret != 0) {
 		UNRESOLVED(ret, "Failed to set signal handler");
-- 
1.7.12

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
