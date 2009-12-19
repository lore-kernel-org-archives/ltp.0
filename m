Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NLouZ-0004Qa-8t
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:19:15 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLouR-00049l-O2
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:19:15 +0000
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id B5141139B082D
	for <ltp-list@lists.sourceforge.net>;
	Sat, 19 Dec 2009 03:18:33 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314) id 1NLott-0006cj-00
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 03:18:33 +0100
Date: Sat, 19 Dec 2009 03:18:25 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u45x2cdkcfnueu@debian>
Subject: [LTP] [PATCH] Fix the nfs runtest file
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
Message-ID: <20091219021825.ZfeO2oPWJ6YkJYyfb_jpmCN99NRDKEHNVdQ9PTVvSlo@z>

Hello,

 The command "export X=Y cmd" means export variable X (valued Y) and
 variable cmd; it does not run cmd. To do the latter, you can write
 "X=Y cmd" (as in this patch) or "export X=Y; cmd"

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 runtest/nfs |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/runtest/nfs b/runtest/nfs
index 4f5d876..1cddcd6 100644
--- a/runtest/nfs
+++ b/runtest/nfs
@@ -2,10 +2,10 @@
 #
 # PLEASE READ THE README FILE IN /nfs BEFORE RUNNING THESE.
 #
-nfs01 export VERSION SOCKET_TYPE; export TCbin=$LTPROOT/testcases/bin nfs01
-nfs02 export VERSION SOCKET_TYPE; export TCbin=$LTPROOT/testcases/bin nfs02
-nfs03 export VERSION SOCKET_TYPE; export TCbin=$LTPROOT/testcases/bin nfs03
-nfs04 export VERSION SOCKET_TYPE; export TCbin=$LTPROOT/testcases/bin nfs04
+nfs01 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs01
+nfs02 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs02
+nfs03 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs03
+nfs04 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs04
 nfslock01 export VERSION; nfslock01
 
 # This will run 1 thread on 20 directories with 50 files in each.
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
