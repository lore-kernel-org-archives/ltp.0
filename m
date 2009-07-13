Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MQJ0B-0001Kn-C5
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2009 10:43:19 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQJ06-0008GF-3W
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2009 10:43:19 +0000
Received: by pxi27 with SMTP id 27so1056522pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 Jul 2009 03:43:12 -0700 (PDT)
Message-ID: <4A5B0971.6060005@petalogix.com>
Date: Mon, 13 Jul 2009 12:16:17 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] LTP
Reply-To: michal.simek@petalogix.com
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
To: "subrata@linux.vnet.ibm.com" <subrata@linux.vnet.ibm.com>
Cc: LTP <ltp-list@lists.sourceforge.net>, John Williams <john.williams@petalogix.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Hi All,

I would like to send to mailing list more information about LTP - how is
helping us to remove bugs
from Microblaze kernel/toolchain code and of course for future kernel
bug hunting for new archs.

I am trying to resolve problems in MMU Microblaze kernel code. Anyway I
think you know that
Microblaze in is mainline. :-)

Ok. We run runtest/syscalls to check if our kernel/ABI works as expected.
I have found tree big bugs which I would like to talk about.

The first is problem with missing flush tlb from MMU after calling
mmap01 tests.
I think you saw thread on list too.
This problem was very hard to debug because any printk debug messages
caused correct test behavior.
We have in LTP nine standard mmap test and only mmap01 failed. I found
that calling sync() syscall
caused (as printk) correct test behavior. When I run mmap01 -c 100 the
first some tests failed and the rest passed.
This was the first moment when I wanted to use Microblaze Qemu emulator
to find out where the problem is. (Thanks to Edgar - author of Qemu
Microblaze port and for his huge help).
Emulator help me to see what Microblaze do. I turned on program counter
tracing to see what Linux kernel really does.
I was able to see program counter and full execution flow, MMU behavior
- tlb hit/miss and interrupts.
Unfortunately I was not able to see tlb invalidation (we will upgrade
emulator to support this too :-) )
I saw when I run mmap01 -c 100 that firsts some tests failed which were
on the top and tests which passed were on the bottom.
I asked Microblaze hw guys for help and they point me to that Microblaze
code not flush tlbs after mmap.

What Microblaze did? Microblaze have 64 tlb and we use 2 fixed tlb for
kernel code - to speedup kernel.
This changed caused that we have not too much tlb misses and for
flushing current old mapping and wasn't replaced by
updated one (mmap syscall do that update) - that's why kernel need to
flush tlb for old mapping. When I called printk debug messages or sync
syscall,
kernel flush more tlb and test passed. The same behavior was when I run
100 tests. The firsts some tests failed
because weren't interrupted by any other code. Tests which passed and
were on the bottom of my log were interrupted
by any code which caused that old tlb mapping was flushed and on next
access were used new one.

The result is that LTP has more than 70 tests which use mmap syscall but
only two tests uncover big problem with tlb flush.
The first test was mmap01 and the second, which was bonus for me, was
shmdt01.



The second problem which I have met with it was on fallocate01 syscall.
It wasn't too hard to fixed it because after some
printk debugging I found that we have problem with u64 parameters
(Microblaze is 32bit cpu). Problem was
that glibc wasn't able to pass to kernel sixth parameter when we used
syscall macro because syscall macro
use 7 parameters because first is number of syscall. That six parameters
are assembled from u32 and u64 values where
Microblaze use convention that higher u32 are in one register and lower
u32 in next.
Microblaze use r5-r10 for passing parameters to function/syscall.

Mapping for syscall function is
r5= syscall number
r6= 1. parameter
r7= 2. parameter
r8= 3. parameter
r9= 4. parameter
r10= 5. parameter
and 6. parameter was on the stack.

Syscall glibc fuction just do cross for parameters where:
r5 moves to r12 (syscall number reg)
r6 -> r5
r7 -> r6
r8 -> r7
r9 -> r8
r10 -> r9
and r10 keeps the same value as was in r10.
Microblaze toolchain not to load sixth parameter from stack which we fixed.

Thanks to LTP we found a bug in toolchain. Affected tests: fallocate01,
fallocate02, fallocate03, sync_file_range01


The last but not least test which help me find out problem in kernel was
eventfd01.
Eventfd syscall test setup eventfd in kernel and tests tried to read
value from kernel counter. This value is 64-bit. For passing
this value back to user application is used put_user macro for 64 bit
return value. We used special asm code for passing
64 bit parameters but this in wrong. A lot of applications used this
code but only two LTP tests find out the problem in it.
We fixed it with calling two put_user macros for u32 values(as Blackfin
does) which fixed two LTP tests - eventfd01 and sendfile02_64.
I still work on this case because I miss some pieces of puzzle but only
two tests points to kernel put user problem.


We have some other problem which we will have to solve.
I am surprised that LTP help us to find out kernel and toolchain
problems. It will be very hard to find out
these problems without LTP. I used simple LTP compilation for quick
toolchain tests because of good coverage.


Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
