Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1SD4Lc-0006to-4Y
	for ltp-list@lists.sourceforge.net; Thu, 29 Mar 2012 01:40:20 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SD4La-0002GZ-FQ
	for ltp-list@lists.sourceforge.net; Thu, 29 Mar 2012 01:40:20 +0000
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q2T1e95P003227
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Mar 2012 09:40:10 +0800
Message-ID: <4F73BD76.7050505@cn.fujitsu.com>
Date: Thu, 29 Mar 2012 09:40:06 +0800
From: lidan <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH]pthread_join:4-1.c:ignore detached thread
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

Case pthread_join/4-1.c aims to check the following assertion
"If the thread calling pthread_join is canceled, the joined 
thread remains joinable."
It uses array scenarii defined in "threads_scenarii.c" which
sets attribute of some threads as detached.
This patch ignores the detached threads since once
a thread has been detached, it can't be joined with
pthread_join(3) or be made joinable again.


Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 .../conformance/interfaces/pthread_join/4-1.c      |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c
index fb8c8d3..16ac7e8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c
@@ -91,6 +91,9 @@ int main(int argc, char *argv[])
 	scenar_init();
 
 	for (sc = 0; sc < NSCENAR; sc++) {
+		if (scenarii[sc].detached == 1)
+			continue;
+
 #if VERBOSE > 0
 		output("-----\n");
 		output("Starting test with scenario (%i): %s\n",
-- 
1.7.7.2

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
