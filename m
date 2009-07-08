Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MqpHP-0007zD-Rg
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 14:26:43 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MqpHJ-0000y2-8n
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 14:26:43 +0000
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id E207911A17124
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Sep 2009 16:26:27 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314) id 1MqpH7-00045Z-00
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 16:26:25 +0200
Date: Thu, 09 Jul 2009 01:46:56 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u0rmesnocfnueu@debian>
Subject: [LTP] [PATCH] Make sure some Crackerjack tests are running under
	root
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
Message-ID: <20090708234656.ZpxlZAzIrevF_NgK5KBFLLxnKPCagyjP0KNZORxrtL4@z>

 The tests need to run under root to change their EUID

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/mq_unlink/mq_unlink01.c |    1 +
 testcases/kernel/syscalls/utimes/utimes01.c       |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
index 067656c..85baa2b 100644
--- a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
+++ b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
@@ -123,6 +123,7 @@ extern void cleanup() {
 /*                                                                            */
 /******************************************************************************/
 void setup() {
+        tst_require_root(tst_exit);
         /* Capture signals if any */
         /* Create temporary directories */
         TEST_PAUSE;
diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index e52495b..7705269 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -130,6 +130,8 @@ extern void cleanup() {
 /*                                                                            */
 /******************************************************************************/
 void setup() {
+        tst_require_root(tst_exit);
+
         /* Capture signals if any */
         /* Create temporary directories */
         TEST_PAUSE;
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
