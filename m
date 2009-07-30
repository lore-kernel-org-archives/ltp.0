Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MWVLP-0005w2-4l
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 13:06:51 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWVLI-00063O-Hz
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 13:06:51 +0000
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 69DA510EDAB4E
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Jul 2009 15:06:38 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp06.web.de with asmtp (WEB.DE 4.110 #277) id 1MWVLB-000705-00
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 15:06:37 +0200
Date: Thu, 30 Jul 2009 11:57:54 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uxvtdtvrcfnueu@debian>
Subject: [LTP] [PATCH] Make the test result codes a real bitfield again
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
Message-ID: <20090730095754.6eqK4l3qoVIe8JXzWVKOn-FF8h51M84nYmqjWsep-Hc@z>

Hello,

the commit "extend the test result to a bit field so we can extend the output further" from July 20th unfortunately changes the code, that was previously a bitfield, to a non-bitfield. This causes FAILED tests to return erroneously 0.

This patch changes the test result codes to be individual bits in the bitfield (effectively reverting  a small part of aforementioned patch).

Regards
    Jiri Palecek

---
 include/test.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/test.h b/include/test.h
index 5c325b3..4d9803a 100644
--- a/include/test.h
+++ b/include/test.h
@@ -44,15 +44,15 @@
 
 #include "compiler.h"
 
-/* Use low 4 bits to encode test type */
-#define TTYPE_MASK 0xf
+/* Use low 6 bits to encode test type */
+#define TTYPE_MASK 0x3f
 #define TPASS      0    /* Test passed flag */
 #define TFAIL      1    /* Test failed flag */
 #define TBROK      2    /* Test broken flag */
-#define TWARN      3    /* Test warning flag */
-#define TRETR      4    /* Test retire flag */
-#define TINFO      5    /* Test information flag */
-#define TCONF      6    /* Test not appropriate for configuration flag */
+#define TWARN      4    /* Test warning flag */
+#define TRETR      8    /* Test retire flag */
+#define TINFO      16   /* Test information flag */
+#define TCONF      32   /* Test not appropriate for configuration flag */
 #define TTYPE_RESULT(ttype) ((ttype) & TTYPE_MASK)
 
 #define TERRNO     0x100   /* Append errno information to output */
-- 
1.6.3.3




------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
