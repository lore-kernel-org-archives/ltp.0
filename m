Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <deller@gmx.de>) id 1Vit4v-0005Eb-IH
	for ltp-list@lists.sourceforge.net; Tue, 19 Nov 2013 21:43:25 +0000
Received: from mout.gmx.net ([212.227.15.18])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Vit4u-00049y-EQ
	for ltp-list@lists.sourceforge.net; Tue, 19 Nov 2013 21:43:25 +0000
Received: from p100.box ([84.173.38.207]) by mail.gmx.com (mrgmx101) with
	ESMTPSA (Nemesis) id 0MgoiC-1W4ndm0JX6-00M7Si for
	<ltp-list@lists.sourceforge.net>; Tue, 19 Nov 2013 22:43:18 +0100
Date: Tue, 19 Nov 2013 22:43:16 +0100
From: Helge Deller <deller@gmx.de>
Message-ID: <20131119214316.GA2109@p100.box>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] fix file testcase for parisc architecture
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

The PA-RISC architecture is big-endian.
Add it to the big-endian platforms list, which then fixes this testcase.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/testcases/commands/ade/file/file_test.sh b/testcases/commands/ade/file/file_test.sh
index a7cdf55..9914ebe 100755
--- a/testcases/commands/ade/file/file_test.sh
+++ b/testcases/commands/ade/file/file_test.sh
@@ -339,7 +339,7 @@ fi
 
   if uname -m |
     grep -qe '\(m68k\)\|\(sparc\)\|\(mips\b\)\|\(mipseb\)\|\(sh.eb\)' \
-         -e '\(powerpc\)\|\(ppc\)\|\(s390\)'; then
+         -e '\(powerpc\)\|\(ppc\)\|\(s390\)\|\(parisc\)'; then
      TEST_ARCH=MSB
   fi
 

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
