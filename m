Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mwenzel@novell.com>) id 1Owgs8-0005A2-BH
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 19:45:24 +0000
Received: from sinclair.provo.novell.com ([137.65.248.137])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Owgs7-0002cP-Ai
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 19:45:24 +0000
Message-Id: <4C936C31020000E800068DF2@sinclair.provo.novell.com>
Date: Fri, 17 Sep 2010 13:25:05 -0600
From: "Murlin Wenzel" <mwenzel@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartF6DB2481.0__="
Subject: [LTP] [Patch] enable hyperthreading tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sf.net>

--=__PartF6DB2481.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Currently the hyperthreading tests will only run on 32bit (i386) os =
versions.  HT is also supported on x86_64, so I changed defines to allow =
either os version.

Signed-off-by: Murlin Ray Wenzel <mwenzel@novell.com>


--=__PartF6DB2481.0__=
Content-Type: text/plain; name="enable_ht.PATCH"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="enable_ht.PATCH"

diff -urN ltp-full-20100831/testcases/kernel/sched/hyperthreading//ht_affin=
ity/ht_affinity.c ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreadi=
ng//ht_affinity/ht_affinity.c=0A--- ltp-full-20100831/testcases/kernel/sche=
d/hyperthreading//ht_affinity/ht_affinity.c	2010-09-14 05:04:34.0000000=
00 -0600=0A+++ ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreading/=
/ht_affinity/ht_affinity.c	2010-09-17 11:07:50.000000000 -0600=0A@@ =
-233,7 +233,7 @@=0A int main(int argc, char *argv[])=0A {=0A =0A-#ifndef =
__i386__=0A+#if (!defined __i386__ && !defined __x86_64__)=0A 	tst_brkm(TC=
ONF, NULL, "This test suite can only execute on i386 architecture.");=0A =
#else=0A 	if (!check_ht_capability())=0Adiff -urN ltp-full-20100831/t=
estcases/kernel/sched/hyperthreading//ht_affinity/ht_utils.c ltp-full-20100=
831.mrw/testcases/kernel/sched/hyperthreading//ht_affinity/ht_utils.c=0A---=
 ltp-full-20100831/testcases/kernel/sched/hyperthreading//ht_affinity/ht_ut=
ils.c	2010-09-14 05:04:34.000000000 -0600=0A+++ ltp-full-20100831.mrw/tes=
tcases/kernel/sched/hyperthreading//ht_affinity/ht_utils.c	2010-09-17 =
11:08:44.000000000 -0600=0A@@ -17,7 +17,7 @@=0A =0A inline void cpuid(int =
op, int *eax, int *ebx, int *ecx, int *edx)=0A {=0A-#ifndef __i386__=0A+#if=
 (!defined __i386__ && !defined __x86_64__)=0A 	return;=0A #else=0A 	=
__asm__("cpuid"=0Adiff -urN ltp-full-20100831/testcases/kernel/sched/hypert=
hreading//ht_enabled/ht_enabled.c ltp-full-20100831.mrw/testcases/kernel/sc=
hed/hyperthreading//ht_enabled/ht_enabled.c=0A--- ltp-full-20100831/testcas=
es/kernel/sched/hyperthreading//ht_enabled/ht_enabled.c	2010-09-14 =
05:04:34.000000000 -0600=0A+++ ltp-full-20100831.mrw/testcases/kernel/sched=
/hyperthreading//ht_enabled/ht_enabled.c	2010-09-17 10:59:00.0000000=
00 -0600=0A@@ -22,7 +22,7 @@=0A int main(int argc, char *argv[])=0A {=0A 	=
int ret_val =3D 1;=0A-#ifndef __i386__=0A+#if  (!defined __x86_64__ && =
!defined __i386__)=0A 	tst_brkm(TCONF, NULL, "This test suite can only =
execute on i386 architecture.");=0A #else=0A 		ret_val =3D =
check_ht_capability();=0Adiff -urN ltp-full-20100831/testcases/kernel/sched=
/hyperthreading//ht_enabled/ht_utils.c ltp-full-20100831.mrw/testcases/kern=
el/sched/hyperthreading//ht_enabled/ht_utils.c=0A--- ltp-full-20100831/test=
cases/kernel/sched/hyperthreading//ht_enabled/ht_utils.c	2010-09-14 =
05:04:34.000000000 -0600=0A+++ ltp-full-20100831.mrw/testcases/kernel/sched=
/hyperthreading//ht_enabled/ht_utils.c	2010-09-17 11:06:02.000000000 =
-0600=0A@@ -20,7 +20,7 @@=0A =0A inline void cpuid(int op, int *eax, int =
*ebx, int *ecx, int *edx)=0A {=0A-#ifndef __i386__=0A+#if (!defined =
__i386__ && !defined __x86_64__)=0A 	return;=0A #else=0A 	__asm__("cp=
uid"=0A@@ -47,8 +47,7 @@=0A 		/*printf("The processor in this =
system supports HT\n");*/=0A 		return 1;=0A 	} else {=0A-		=
/*printf("The processor in this system does not support=0A-		* =
HT\n");*/=0A+		/*printf("The processor in this system does not =
support HT\n");*/=0A 		return 0;=0A 	}=0A }=0Adiff -urN =
ltp-full-20100831/testcases/kernel/sched/hyperthreading//ht_interrupt/ht_in=
terrupt.c ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreading//ht_i=
nterrupt/ht_interrupt.c=0A--- ltp-full-20100831/testcases/kernel/sched/hype=
rthreading//ht_interrupt/ht_interrupt.c	2010-09-14 05:04:34.000000000 =
-0600=0A+++ ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreading//ht=
_interrupt/ht_interrupt.c	2010-09-17 11:10:08.000000000 -0600=0A@@ =
-111,7 +111,7 @@=0A {=0A 	tst_resm(TINFO, "Begin: HyperThreading =
Interrupt");=0A =0A-#ifndef __i386__=0A+#if (!defined __i386__ && !defined =
__x86_64__)=0A 	tst_brkm(TCONF, NULL, "This test suite can only execute on =
i386 architecture.");=0A #else=0A 	if (!check_ht_capability())=0Adiff =
-urN ltp-full-20100831/testcases/kernel/sched/hyperthreading//ht_interrupt/=
ht_utils.c ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreading//ht_=
interrupt/ht_utils.c=0A--- ltp-full-20100831/testcases/kernel/sched/hyperth=
reading//ht_interrupt/ht_utils.c	2010-09-14 05:04:34.000000000 =
-0600=0A+++ ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreading//ht=
_interrupt/ht_utils.c	2010-09-17 11:10:58.000000000 -0600=0A@@ -60,7 =
+60,7 @@=0A =0A inline void cpuid(int op, int *eax, int *ebx, int *ecx, =
int *edx)=0A {=0A-#ifndef __i386__=0A+#if (!defined __i386__ && !defined =
__x86_64__)=0A 	return;=0A #else=0A 	__asm__("cpuid"=0A
--=__PartF6DB2481.0__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--=__PartF6DB2481.0__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=__PartF6DB2481.0__=--

