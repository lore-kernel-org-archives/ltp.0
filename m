Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NLolW-0002Bm-IA
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:09:54 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLolQ-0007Xa-4G
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:09:54 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9A44C139B01D8
	for <ltp-list@lists.sourceforge.net>;
	Sat, 19 Dec 2009 03:09:41 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314) id 1NLolJ-0001mM-00
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 03:09:41 +0100
Date: Sat, 19 Dec 2009 03:06:23 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u45xnju2cfnueu@debian>
Subject: [LTP] [PATCH] Add (mandatory) parameters to linktest.sh in the
	runtest file
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
Message-ID: <20091219020623.xB0VWE9sAsEmDicXGcSNmE2aIyLwB8Q_W6s6bwkiwqI@z>

Hello,

linktest.sh is failing when ran using the stress.part1 file, because it lacks command line arguments. This patch just adds them (taken from the fs runtest file).

Regards
  Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 runtest/stress.part1 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/runtest/stress.part1 b/runtest/stress.part1
index 236c471..b75d504 100644
--- a/runtest/stress.part1
+++ b/runtest/stress.part1
@@ -156,7 +156,7 @@ rwtest05 export LTPROOT; rwtest.sh -N rwtest05 -c -q -i 50 -T 64b 500b:/tmp/rwte
 iogen01 export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write -c -Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
 
 fs_inod01 fs_inod $TMP 10 10 1
-linker01 linktest.sh
+linker01 linktest.sh 1000 1000
 openfile01 openfile -f10 -t10
 inode01 inode01
 inode02 inode02
-- 
1.6.4.3




------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
