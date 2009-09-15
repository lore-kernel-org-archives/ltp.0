Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MnZyt-0000RS-NH
	for Ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 15:30:11 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 1b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MnZym-0002UK-OL
	for Ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 15:30:11 +0000
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by pophost.sonytel.be (Postfix) with ESMTP id 2FD2644485
	for <Ltp-list@lists.sourceforge.net>;
	Tue, 15 Sep 2009 17:29:59 +0200 (CEST)
Date: Tue, 15 Sep 2009 17:30:05 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Message-ID: <alpine.LRH.2.00.0909151729460.29769@vixen.sonytel.be>
MIME-Version: 1.0
Subject: [LTP] [PATCH] smt_smp: Return TCONF if SMT/SMP is not supported
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linux Test Project <Ltp-list@lists.sourceforge.net>

Currently the tests just fails if SMT/SMP is not supported.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 .../hyperthreading/ht_affinity/smt_smp_affinity.sh |    3 +--
 .../hyperthreading/ht_enabled/smt_smp_enabled.sh   |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/smt_smp_affi=
nity.sh b/testcases/kernel/sched/hyperthreading/ht_affinity/smt_smp_affinit=
y.sh
index 109800d..0a33f51 100755
--- a/testcases/kernel/sched/hyperthreading/ht_affinity/smt_smp_affinity.sh
+++ b/testcases/kernel/sched/hyperthreading/ht_affinity/smt_smp_affinity.sh
@@ -44,8 +44,7 @@ if [ -f ./ht_enabled ];then
 	if [ $ret_value -ne 0 ];then
 		tst_resm TCONF "SMT/SMP is not supported"
 		tst_resm TINFO "End: SMT/SMP Affinity"
-		TFAILCNT=3D$(( $TFAILCNT+1 ))
-		exit $TFAILCNT
+		exit 0
 	fi
 else
 	tst_resm TBROK "ht_enabled:File not found"
diff --git a/testcases/kernel/sched/hyperthreading/ht_enabled/smt_smp_enabl=
ed.sh b/testcases/kernel/sched/hyperthreading/ht_enabled/smt_smp_enabled.sh
index 8b8a909..e234ea4 100755
--- a/testcases/kernel/sched/hyperthreading/ht_enabled/smt_smp_enabled.sh
+++ b/testcases/kernel/sched/hyperthreading/ht_enabled/smt_smp_enabled.sh
@@ -41,8 +41,7 @@ if [ -f ./ht_enabled ];then
 	if [ $ret_value -ne 0 ];then
 		tst_resm TCONF "SMT/SMP is not supported"
 		tst_resm TINFO "End: SMT/SMP Enabled"
-		TFAILCNT=3D$(( $TFAILCNT+1 ))
-		exit $TFAILCNT
+		exit 0
 	fi
 else
 	tst_resm TBROK "ht_enabled:File not found"
-- =

1.6.2.4

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
