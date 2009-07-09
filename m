Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MqpI3-0007KI-7t
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 14:27:23 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MqpHy-0001TX-Oz
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 14:27:23 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 17C9B124569D8
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Sep 2009 16:27:13 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314) id 1MqpHq-0000PP-00
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 16:27:10 +0200
Date: Thu, 09 Jul 2009 02:33:24 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u0rmf1v8cfnueu@debian>
Subject: [LTP] [PATCH] Fix the logic of ppoll01 test
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20090709003324.eJZ-EQmsyyZlLDzCRrQKC1EyyCR6R9aPUVe9jTUNiZw@z>

 According to POSIX, a file descriptor is considered ready for writing
 when a call to write() would not block, even when it returns an error
 (other than EAGAIN). Thus, a file descriptor opened for reading is
 ready for writing. This patch reflects that in the test.

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/ppoll/ppoll01.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 79334c1..87b89f6 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -206,7 +206,7 @@ struct test_case {
 static struct test_case tcase[] = {
 	{ // case00
                 .ttype          = NORMAL,
-                .expect_revents = POLLOUT,
+                .expect_revents = POLLIN | POLLOUT,
                 .ret            = 0,
                 .err            = 0,
         },
-- 
1.6.4.3




------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
