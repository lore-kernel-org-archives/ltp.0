Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PB449-0006co-2i
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:21:13 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB448-00044a-4K
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:21:13 +0000
Received: by wya21 with SMTP id 21so559513wya.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Oct 2010 04:21:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimHeBQkYhnPpAiOJx2R8Y1xznHffWYhAtBR=iCF@mail.gmail.com>
References: <AANLkTimHeBQkYhnPpAiOJx2R8Y1xznHffWYhAtBR=iCF@mail.gmail.com>
Date: Wed, 27 Oct 2010 04:21:06 -0700
Message-ID: <AANLkTi=zZud=H52Q5pE00gERVi6MfVF9QV7_C66W=CEP@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Realtime tests on ARM
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: David Peverley <pev@sketchymonkey.com>
Cc: gowrishankar.m@in.ibm.com, ltp-list@lists.sourceforge.net

On Wed, Oct 27, 2010 at 4:17 AM, David Peverley <pev@sketchymonkey.com> wro=
te:
> Hi all,
>
> The realtime tests aren't compiled for ARM currently as there's no
> implementation of atomic_add() in :
> =A0 testcases/realtime/include/librttest.h
>
> As a side note - in this function can we change the #error to not be
> blank and read something along the lines of =A0:
> =A0#error ERROR: atomic_add: Architecture not supported for compilation
>
> Anyway, the existing function here supports three architectures and
> lifts the implementations as follows :
> =A0__x86_64__ || =A0__i386__
> =A0 =A0arch/x86/include/asm/atomic_32.h
> =A0__powerpc__
> =A0 =A0arch/powerpc/include/asm/atomic.h (might need review!)
> =A0__sh__
> =A0 =A0arch/sh/include/asm/atomic-llsc.h (might need review!)
>
> Logically we can add an ARM case following the same logic. Looking in :
> =A0 arch/arm/include/asm/atomic.h
>
> We can implement this easily for v6+ architectures. The case for
> atomic_add in librttest.h would look something like :
> =A0#elif defined(__arm__) && (__LINUX_ARM_ARCH__ >=3D 6)
> =A0 =A0 =A0 unsigned long tmp;
> =A0 =A0 =A0 int result;
>
> =A0 =A0 =A0 __asm__ __volatile__(
> =A0 "1: ldrex =A0 %0, [%2]\n"
> =A0 " =A0 add =A0 =A0 %0, %0, %3\n"
> =A0 " =A0 strex =A0 %1, %0, [%2]\n"
> =A0 " =A0 teq =A0 =A0 %1, #0\n"
> =A0 " =A0 bne =A0 =A0 1b"
> =A0 =A0 =A0 : "=3D&r" (result), "=3D&r" (tmp)
> =A0 =A0 =A0 : "r" (&v->counter), "Ir" (i)
> =A0 =A0 =A0 : "cc");
>
> =A0 =A0 =A0 return result;
>
> For < v6 architectures this isn't easy as they don't implement
> ldrex/strex. The atomic.h implementation won't work as it's a kernel
> only implementation using local_irq_save() and local_irq_restore() so
> obviously no use for userspace atomic add.
>
> After reading up for a while I've come across a very cunning trick in
> the kernel where an atomic compare/exchange is implemented in
> __kuser_cmpxchg. This is implemented in :
> =A0 arch/arm/kernel/entry-armv.S
>
> This tantalisingly comments :
> =A0 /*
> =A0 =A0* For example, a user space atomic_add implementation could look l=
ike this:
> =A0 =A0*
> =A0 =A0* #define atomic_add(ptr, val) \
> =A0 =A0* =A0 =A0 =A0({ register unsigned int *__ptr asm("r2") =3D (ptr); \
> =A0 =A0* =A0 =A0 =A0 =A0 register unsigned int __result asm("r1"); \
> =A0 =A0* =A0 =A0 =A0 =A0 asm volatile ( \
> =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 "1: @ atomic_add\n\t" \
> =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 "ldr =A0 =A0 r0, [r2]\n\t" \
> =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 "mov =A0 =A0 r3, #0xffff0fff\n\t" \
> =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 "add =A0 =A0 lr, pc, #4\n\t" \
> =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 "add =A0 =A0 r1, r0, %2\n\t" \
> =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 "add =A0 =A0 pc, r3, #(0xffff0fc0 - 0xff=
ff0fff)\n\t" \
> =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 "bcc =A0 =A0 1b" \
> =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 : "=3D&r" (__result) \
> =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 : "r" (__ptr), "rIL" (val) \
> =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 : "r0","r3","ip","lr","cc","memory" ); \
> =A0 =A0* =A0 =A0 =A0 =A0 __result; })
> =A0 =A0*/
>
> So translating this into librttest.h format gives :
> =A0 #elif defined(__arm__) && (__LINUX_ARM_ARCH__ < 6)
> =A0 =A0 =A0 register unsigned int result asm("r1");
>
> =A0 =A0 =A0 /* See, arm/kernel/entry-armv.S:__kernel_cmpxchg() */
> =A0 =A0 =A0 __asm__ __volatile__ (
> =A0 "1: ldr =A0 =A0 r0, [r2]\n\t"
> =A0 " =A0 mov =A0 =A0 r3, #0xffff0fff\n\t"
> =A0 " =A0 add =A0 =A0 lr, pc, #4\n\t"
> =A0 " =A0 add =A0 =A0 r1, r0, %2\n\t"
> =A0 " =A0 add =A0 =A0 pc, r3, #(0xffff0fc0 - 0xffff0fff)\n\t"
> =A0 " =A0 bcc =A0 =A0 1b"
> =A0 =A0 =A0 : "=3D&r" (result)
> =A0 =A0 =A0 : "r" (&v->counter), "rIL" (i)
> =A0 =A0 =A0 : "r0","r3","ip","lr","cc","memory" );
>
> =A0 =A0 =A0 return result;
>
> Does this look reasonable to you guys?

    CCing Gowrishankar from IBM.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
