Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MDcta-0001Lv-Jn
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 11:20:06 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MDcsw-00016t-0L
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 11:20:01 +0000
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4DECCFF0FE8F
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Jun 2009 13:19:24 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian.localnet)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277) id 1MDcsu-0003Z6-00
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 13:19:24 +0200
From: Jiri Palecek <jpalecek@web.de>
Date: Mon, 8 Jun 2009 13:22:58 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200906081322.58916.jpalecek@web.de>
Subject: [LTP] [PATCH] Don't create the message queue in mq_open01 when the
	test specifies O_CREAT flag
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

 The tests need to create the message queue themselves to specify the
 creation attributes

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/mq_open/mq_open01.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_open/mq_open01.c b/testcases/kernel/syscalls/mq_open/mq_open01.c
index 205de66..f9c2f08 100644
--- a/testcases/kernel/syscalls/mq_open/mq_open01.c
+++ b/testcases/kernel/syscalls/mq_open/mq_open01.c
@@ -315,7 +315,7 @@ static int do_test(struct test_case *tc)
          * Execute system call
          */
 
-	if (tc->ttype != NO_SPACE) {
+	if (tc->ttype != NO_SPACE && !(tc->oflag & O_CREAT)) {
                 errno = 0;
                 TEST(sys_ret = mq_open(QUEUE_NAME, O_CREAT|O_EXCL|O_RDWR, S_IRWXU, NULL));
                 sys_errno = errno;
-- 
1.6.2.4


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
