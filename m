Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MnZxx-00051Z-8u
	for Ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 15:29:13 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 72vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MnZxr-0002Nn-Th
	for Ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 15:29:13 +0000
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by pophost.sonytel.be (Postfix) with ESMTP id 45C9744485
	for <Ltp-list@lists.sourceforge.net>;
	Tue, 15 Sep 2009 17:29:00 +0200 (CEST)
Date: Tue, 15 Sep 2009 17:29:06 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Message-ID: <alpine.LRH.2.00.0909151728510.29741@vixen.sonytel.be>
MIME-Version: 1.0
Subject: [LTP] [PATCH] quotactl01: Replace hardcoded 258 by
	__NR_set_tid_address
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

The call signature seems to match the set_tid_address() syscall.
Also remove the comment about calling quotactl, as it's obviously bogus.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 testcases/kernel/syscalls/quotactl/quotactl01.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/ke=
rnel/syscalls/quotactl/quotactl01.c
index fe8df33..f410948 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -152,7 +152,7 @@ int main(int ac, char **av) {
         			tst_resm(TPASS, "quotactl call succeeded");
                         }
                 }
-	             TEST(result =3D syscall(258, &newtid));     //call quotactl()
+	             TEST(result =3D syscall(__NR_set_tid_address, &newtid));
                      if(TEST_RETURN =3D=3D getpid()) {
                         cleanup();
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
