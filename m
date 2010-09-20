Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mwenzel@novell.com>) id 1OxhAX-0005nl-4m
	for ltp-list@lists.sourceforge.net; Mon, 20 Sep 2010 14:16:33 +0000
Received: from sinclair.provo.novell.com ([137.65.248.137])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OxhAT-0005Qs-UZ
	for ltp-list@lists.sourceforge.net; Mon, 20 Sep 2010 14:16:31 +0000
Message-Id: <4C971855020000E800068F16@sinclair.provo.novell.com>
Date: Mon, 20 Sep 2010 08:16:21 -0600
From: "Murlin Wenzel" <mwenzel@novell.com>
References: <4C936C31020000E800068DF2@sinclair.provo.novell.com>
	<AANLkTimUonwvA6PRiTzM01aC6EUf3SMp+ACfG0TJci2S@mail.gmail.com>
In-Reply-To: <AANLkTimUonwvA6PRiTzM01aC6EUf3SMp+ACfG0TJci2S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part7A57ACA5.1__="
Subject: Re: [LTP] [Patch] enable hyperthreading tests
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
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list <ltp-list@lists.sf.net>

--=__Part7A57ACA5.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>>> On 9/17/2010 at 03:22 PM, in message
<AANLkTimUonwvA6PRiTzM01aC6EUf3SMp+ACfG0TJci2S@mail.gmail.com>, Garrett =
Cooper
<yanegomi@gmail.com> wrote:=20
> On Fri, Sep 17, 2010 at 12:25 PM, Murlin Wenzel <mwenzel@novell.com> =
wrote:
>> Currently the hyperthreading tests will only run on 32bit (i386) os=20
> versions.  HT is also supported on x86_64, so I changed defines to =
allow=20
> either os version.
>>
>> Signed-off-by: Murlin Ray Wenzel <mwenzel@novell.com>
>=20
> Seems sane. Could you change `i386 architecture' to `x86 architecture'=20=

> please?
> Thanks,
> -Garrett

Added requested change from i386 to x86 in print statements.

Murlin




--=__Part7A57ACA5.1__=
Content-Type: text/plain; name="enable_ht.PATCH"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="enable_ht.PATCH"

diff -urN ltp-full-20100831/testcases/kernel/sched/hyperthreading//ht_affin=
ity/ht_affinity.c ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreadi=
ng//ht_affinity/ht_affinity.c=0A--- ltp-full-20100831/testcases/kernel/sche=
d/hyperthreading//ht_affinity/ht_affinity.c	2010-09-14 05:04:34.0000000=
00 -0600=0A+++ ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreading/=
/ht_affinity/ht_affinity.c	2010-09-20 08:09:29.000000000 -0600=0A@@ =
-233,8 +233,8 @@=0A int main(int argc, char *argv[])=0A {=0A =0A-#ifndef =
__i386__=0A-	tst_brkm(TCONF, NULL, "This test suite can only execute on =
i386 architecture.");=0A+#if (!defined __i386__ && !defined __x86_64__)=0A+=
	tst_brkm(TCONF, NULL, "This test suite can only execute on x86 =
architecture.");=0A #else=0A 	if (!check_ht_capability())=0A 	{=0Adiff =
-urN ltp-full-20100831/testcases/kernel/sched/hyperthreading//ht_affinity/h=
t_utils.c ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreading//ht_a=
ffinity/ht_utils.c=0A--- ltp-full-20100831/testcases/kernel/sched/hyperthre=
ading//ht_affinity/ht_utils.c	2010-09-14 05:04:34.000000000 -0600=0A+++ =
ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreading//ht_affinity/ht=
_utils.c	2010-09-17 11:08:44.000000000 -0600=0A@@ -17,7 +17,7 @@=0A =
=0A inline void cpuid(int op, int *eax, int *ebx, int *ecx, int *edx)=0A =
{=0A-#ifndef __i386__=0A+#if (!defined __i386__ && !defined __x86_64__)=0A =
	return;=0A #else=0A 	__asm__("cpuid"=0Adiff -urN ltp-full-201008=
31/testcases/kernel/sched/hyperthreading//ht_enabled/ht_enabled.c =
ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreading//ht_enabled/ht_=
enabled.c=0A--- ltp-full-20100831/testcases/kernel/sched/hyperthreading//ht=
_enabled/ht_enabled.c	2010-09-14 05:04:34.000000000 -0600=0A+++ =
ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreading//ht_enabled/ht_=
enabled.c	2010-09-20 08:10:44.000000000 -0600=0A@@ -22,8 +22,8 @@=0A =
int main(int argc, char *argv[])=0A {=0A 	int ret_val =3D 1;=0A-#ifnd=
ef __i386__=0A-	tst_brkm(TCONF, NULL, "This test suite can only execute on =
i386 architecture.");=0A+#if  (!defined __x86_64__ && !defined __i386__)=0A=
+	tst_brkm(TCONF, NULL, "This test suite can only execute on x86 =
architecture.");=0A #else=0A 		ret_val =3D check_ht_capability();=
=0A #endif=0Adiff -urN ltp-full-20100831/testcases/kernel/sched/hyperthread=
ing//ht_enabled/ht_utils.c ltp-full-20100831.mrw/testcases/kernel/sched/hyp=
erthreading//ht_enabled/ht_utils.c=0A--- ltp-full-20100831/testcases/kernel=
/sched/hyperthreading//ht_enabled/ht_utils.c	2010-09-14 05:04:34.0000000=
00 -0600=0A+++ ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreading/=
/ht_enabled/ht_utils.c	2010-09-17 11:06:02.000000000 -0600=0A@@ -20,7 =
+20,7 @@=0A =0A inline void cpuid(int op, int *eax, int *ebx, int *ecx, =
int *edx)=0A {=0A-#ifndef __i386__=0A+#if (!defined __i386__ && !defined =
__x86_64__)=0A 	return;=0A #else=0A 	__asm__("cpuid"=0A@@ -47,8 +47,7 =
@@=0A 		/*printf("The processor in this system supports =
HT\n");*/=0A 		return 1;=0A 	} else {=0A-		/*printf("T=
he processor in this system does not support=0A-		* =
HT\n");*/=0A+		/*printf("The processor in this system does not =
support HT\n");*/=0A 		return 0;=0A 	}=0A }=0Adiff -urN =
ltp-full-20100831/testcases/kernel/sched/hyperthreading//ht_interrupt/ht_in=
terrupt.c ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreading//ht_i=
nterrupt/ht_interrupt.c=0A--- ltp-full-20100831/testcases/kernel/sched/hype=
rthreading//ht_interrupt/ht_interrupt.c	2010-09-14 05:04:34.000000000 =
-0600=0A+++ ltp-full-20100831.mrw/testcases/kernel/sched/hyperthreading//ht=
_interrupt/ht_interrupt.c	2010-09-20 08:11:40.000000000 -0600=0A@@ =
-111,8 +111,8 @@=0A {=0A 	tst_resm(TINFO, "Begin: HyperThreading =
Interrupt");=0A =0A-#ifndef __i386__=0A-	tst_brkm(TCONF, NULL, =
"This test suite can only execute on i386 architecture.");=0A+#if =
(!defined __i386__ && !defined __x86_64__)=0A+	tst_brkm(TCONF, NULL, =
"This test suite can only execute on x86 architecture.");=0A #else=0A 	if =
(!check_ht_capability())=0A 	{=0Adiff -urN ltp-full-20100831/testcases/k=
ernel/sched/hyperthreading//ht_interrupt/ht_utils.c ltp-full-20100831.mrw/t=
estcases/kernel/sched/hyperthreading//ht_interrupt/ht_utils.c=0A--- =
ltp-full-20100831/testcases/kernel/sched/hyperthreading//ht_interrupt/ht_ut=
ils.c	2010-09-14 05:04:34.000000000 -0600=0A+++ ltp-full-20100831.mrw/tes=
tcases/kernel/sched/hyperthreading//ht_interrupt/ht_utils.c	2010-09-17 =
11:10:58.000000000 -0600=0A@@ -60,7 +60,7 @@=0A =0A inline void cpuid(int =
op, int *eax, int *ebx, int *ecx, int *edx)=0A {=0A-#ifndef __i386__=0A+#if=
 (!defined __i386__ && !defined __x86_64__)=0A 	return;=0A #else=0A 	=
__asm__("cpuid"=0A
--=__Part7A57ACA5.1__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--=__Part7A57ACA5.1__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=__Part7A57ACA5.1__=--

