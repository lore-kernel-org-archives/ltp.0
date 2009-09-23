Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MqoDH-0002j8-Lt
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 13:18:23 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MqoDB-0004kK-AV
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 13:18:23 +0000
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id D7D5E12034D95
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Sep 2009 15:18:11 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314) id 1MqoD5-0004Q4-00
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 15:18:11 +0200
Date: Wed, 23 Sep 2009 14:38:59 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u0ri81srcfnueu@debian>
Subject: [LTP] [PATCH] Use SIG_ERR to indicate tst_sig's default handler,
 to allow (and not clash with) SIG_DFL
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
Message-ID: <20090923123859.l-q9BkFxc0rVZcBeW4IdW_3kKuVbfmx9oBv0HsLVdCY@z>

Hello,

 SIG_DFL happens to be 0 as well as DEF_HANDLER - this means you
 cannot use SIG_DFL as tst_sig argument, eg. if you want to reset the
 signal handling in tests' children to normal.

 This patch changes DEF_HANDLER to be SIG_ERR, as this value cannot be normally used with tst_sig(), so they cannot clash.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 include/test.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/test.h b/include/test.h
index 864b8de..f737575 100644
--- a/include/test.h
+++ b/include/test.h
@@ -91,7 +91,7 @@
 /* defines for unexpected signal setup routine (set_usig.c) */
 #define FORK    1		/* SIGCLD is to be ignored */
 #define NOFORK  0		/* SIGCLD is to be caught */
-#define DEF_HANDLER 0	/* tells set_usig() to use default signal handler */
+#define DEF_HANDLER SIG_ERR	/* tells set_usig() to use default signal handler */
 
 /*
  * The following defines are used to control tst_res and t_result reporting.
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
