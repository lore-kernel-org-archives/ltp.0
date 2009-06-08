Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MDcrY-0006kU-Q7
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 11:18:00 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MDcrX-0002Mg-7f
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 11:18:00 +0000
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 38365FF0FDA7
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Jun 2009 13:17:58 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian.localnet)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277) id 1MDcrV-0003AK-00
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 13:17:57 +0200
From: Jiri Palecek <jpalecek@web.de>
Date: Mon, 8 Jun 2009 13:21:19 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200906081321.24278.jpalecek@web.de>
Subject: [LTP] [PATCH] Include config.h in aio01, to get HAVE_LIBAIO_H
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

Hello,

this patch is necessary for aio01 test to actually test something.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>

---
 testcases/kernel/io/aio/aio01/aio01.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/io/aio/aio01/aio01.c b/testcases/kernel/io/aio/aio01/aio01.c
index 7a510ee..6a69edb 100644
--- a/testcases/kernel/io/aio/aio01/aio01.c
+++ b/testcases/kernel/io/aio/aio01/aio01.c
@@ -49,6 +49,7 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "config.h"
 
 char *TCID = "aio01";
 int TST_TOTAL=6;
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
