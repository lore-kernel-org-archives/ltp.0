Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NYHfW-00066I-1Q
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 11:27:14 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NYHfU-0006Pa-FJ
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 11:27:13 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id E92C513C71396
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 Jan 2010 12:27:04 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314) id 1NYHfM-0003q5-00
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 12:27:04 +0100
Date: Fri, 22 Jan 2010 13:26:17 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u6xov5u7cfnueu@debian>
Subject: [LTP] [PATCH] Don't read errno unless the syscall failed in
 mq_notify01 test
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
Message-ID: <20100122122617.bF8FycUj4BkDcWcznyuF6hto6F7_i8PJvwjLmpWoC20@z>

Hello,

 I've seen failures reporting "return value=0, errno=EACCESS" in the
mq_notify01 test. This is because the syscall actually succeeded (as
expected by the test), but, as it is implemented by a library
function, some of the (more) syscalls it invoked failed. The POSIX
specification of errno says it should only be read when the call in
question failed - therefore, this patch hardcodes errno 0 when return
value is 0.

 Also, this patch removes a useless TEST macro usage in a place the
TEST_RETURN nor TEST_ERRNO variables are never checked.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/mq_notify/mq_notify01.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index 6004373..b796bc3 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -270,7 +270,7 @@ static int do_test(struct test_case *tc)
          * When test ended with SIGTERM etc, mq discriptor is left remains.
          * So we delete it first.
          */
-        TEST(mq_unlink(QUEUE_NAME));
+        mq_unlink(QUEUE_NAME);
 
         switch (tc->ttype) {
         case FD_NOT_EXIST:
@@ -336,7 +336,7 @@ static int do_test(struct test_case *tc)
          */
         errno = 0;
         sys_ret = mq_notify(fd, &ev);
-        sys_errno = errno;
+        sys_errno = sys_ret != 0 ? errno : 0;
         if (sys_ret < 0)
                 goto TEST_END;
 
-- 
1.6.4.3




------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
