Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MnZxU-0000Tf-P2
	for Ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 15:28:44 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 1b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MnZxO-0002KU-I0
	for Ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 15:28:44 +0000
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by pophost.sonytel.be (Postfix) with ESMTP id CEB3944485
	for <Ltp-list@lists.sourceforge.net>;
	Tue, 15 Sep 2009 17:28:32 +0200 (CEST)
Date: Tue, 15 Sep 2009 17:28:39 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Message-ID: <alpine.LRH.2.00.0909151727490.29706@vixen.sonytel.be>
MIME-Version: 1.0
Subject: [LTP] [PATCH] quotactl01: Fix tst_resm() format causing crash
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

When the quotactl syscall fails, quotactl01 crashes with a segmentation fau=
lt
due to an incorrect printf()-style format.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
--
v2: Use TTERRNO

 testcases/kernel/syscalls/quotactl/quotactl01.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/ke=
rnel/syscalls/quotactl/quotactl01.c
index 6800a25..fe8df33 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -147,7 +147,7 @@ int main(int ac, char **av) {
                 for (i =3D 0; i <=3D 7; i++){
                         TEST(retval =3D syscall(__NR_quotactl, cmd[i], (co=
nst char *)NULL, id, (caddr_t)NULL));
 			if(TEST_RETURN !=3D 0){
-                 	   	tst_resm(TFAIL, "%s failed - errno =3D %d : %s ...cm=
derror=3D%s", TCID, TEST_ERRNO, strerror(TEST_ERRNO),cmd[i]);
+				tst_resm(TFAIL|TTERRNO, "%s failed, cmd=3D0x%x", TCID, cmd[i]);
                         }else{
         			tst_resm(TPASS, "quotactl call succeeded");
                         }
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
