Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pev@sketchymonkey.com>) id 1PB40Z-0006Lw-6m
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:17:31 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB40Y-00011r-Dl
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:17:31 +0000
Received: by gwaa11 with SMTP id a11so292381gwa.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Oct 2010 04:17:25 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Oct 2010 12:17:24 +0100
Message-ID: <AANLkTimHeBQkYhnPpAiOJx2R8Y1xznHffWYhAtBR=iCF@mail.gmail.com>
From: David Peverley <pev@sketchymonkey.com>
Subject: [LTP] Realtime tests on ARM
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

Hi all,

The realtime tests aren't compiled for ARM currently as there's no
implementation of atomic_add() in :
   testcases/realtime/include/librttest.h

As a side note - in this function can we change the #error to not be
blank and read something along the lines of  :
  #error ERROR: atomic_add: Architecture not supported for compilation

Anyway, the existing function here supports three architectures and
lifts the implementations as follows :
 __x86_64__ ||  __i386__
    arch/x86/include/asm/atomic_32.h
 __powerpc__
    arch/powerpc/include/asm/atomic.h (might need review!)
 __sh__
    arch/sh/include/asm/atomic-llsc.h (might need review!)

Logically we can add an ARM case following the same logic. Looking in :
   arch/arm/include/asm/atomic.h

We can implement this easily for v6+ architectures. The case for
atomic_add in librttest.h would look something like :
 #elif defined(__arm__) && (__LINUX_ARM_ARCH__ >= 6)
       unsigned long tmp;
       int result;

       __asm__ __volatile__(
   "1: ldrex   %0, [%2]\n"
   "   add     %0, %0, %3\n"
   "   strex   %1, %0, [%2]\n"
   "   teq     %1, #0\n"
   "   bne     1b"
       : "=&r" (result), "=&r" (tmp)
       : "r" (&v->counter), "Ir" (i)
       : "cc");

       return result;

For < v6 architectures this isn't easy as they don't implement
ldrex/strex. The atomic.h implementation won't work as it's a kernel
only implementation using local_irq_save() and local_irq_restore() so
obviously no use for userspace atomic add.

After reading up for a while I've come across a very cunning trick in
the kernel where an atomic compare/exchange is implemented in
__kuser_cmpxchg. This is implemented in :
   arch/arm/kernel/entry-armv.S

This tantalisingly comments :
   /*
    * For example, a user space atomic_add implementation could look like this:
    *
    * #define atomic_add(ptr, val) \
    *      ({ register unsigned int *__ptr asm("r2") = (ptr); \
    *         register unsigned int __result asm("r1"); \
    *         asm volatile ( \
    *             "1: @ atomic_add\n\t" \
    *             "ldr     r0, [r2]\n\t" \
    *             "mov     r3, #0xffff0fff\n\t" \
    *             "add     lr, pc, #4\n\t" \
    *             "add     r1, r0, %2\n\t" \
    *             "add     pc, r3, #(0xffff0fc0 - 0xffff0fff)\n\t" \
    *             "bcc     1b" \
    *             : "=&r" (__result) \
    *             : "r" (__ptr), "rIL" (val) \
    *             : "r0","r3","ip","lr","cc","memory" ); \
    *         __result; })
    */

So translating this into librttest.h format gives :
   #elif defined(__arm__) && (__LINUX_ARM_ARCH__ < 6)
       register unsigned int result asm("r1");

       /* See, arm/kernel/entry-armv.S:__kernel_cmpxchg() */
       __asm__ __volatile__ (
   "1: ldr     r0, [r2]\n\t"
   "   mov     r3, #0xffff0fff\n\t"
   "   add     lr, pc, #4\n\t"
   "   add     r1, r0, %2\n\t"
   "   add     pc, r3, #(0xffff0fc0 - 0xffff0fff)\n\t"
   "   bcc     1b"
       : "=&r" (result)
       : "r" (&v->counter), "rIL" (i)
       : "r0","r3","ip","lr","cc","memory" );

       return result;

Does this look reasonable to you guys?

Cheers,

~Pev

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
