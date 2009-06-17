Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MIY9Y-0002H1-AK
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:16:56 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MIY9X-0006gN-6Y
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:16:56 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id EAAAD104222C7
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jun 2009 02:49:05 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #277) id 1MIXib-0000NT-00
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:49:05 +0200
Date: Wed, 17 Jun 2009 15:18:04 +0200
From: "Jiri Palecek >" <"<jirka"@suse.de>(none)
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvwh0ithlwynca@debian>
Subject: [LTP] [PATCH] Include "config.h" in the aio02 test to get
	HAVE_LIBAIO_H
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
Message-ID: <20090617131804.QPg0FFBvzSR61royPWKX0t8Fz-O95OZF0Te1hBs5c8Y@z>

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/io/aio/aio02/main.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/io/aio/aio02/main.c b/testcases/kernel/io/aio/aio02/main.c
index 791b5e0..5dae3e8 100644
--- a/testcases/kernel/io/aio/aio02/main.c
+++ b/testcases/kernel/io/aio/aio02/main.c
@@ -8,6 +8,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include "test.h"
+#include "config.h"
 
 #ifdef HAVE_LIBAIO_H
 
-- 
1.6.3.1




------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
