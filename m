Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <arnd@arndb.de>) id 1MR4W7-0003pE-Bq
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 13:27:27 +0000
Received: from moutng.kundenserver.de ([212.227.126.187])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MR4Vy-0006jf-Vh
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 13:27:27 +0000
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Jul 2009 15:27:07 +0200
References: <4A5C8068.6020203@monstr.eu> <200907151214.52369.arnd@arndb.de>
	<20090715120512.GA2752@linux-mips.org>
In-Reply-To: <20090715120512.GA2752@linux-mips.org>
MIME-Version: 1.0
Message-Id: <200907151527.08341.arnd@arndb.de>
Subject: Re: [LTP] access_ok macor
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
To: Ralf Baechle <ralf@linux-mips.org>
Cc: LTP <ltp-list@lists.sourceforge.net>, monstr@monstr.eu, Linux Kernel list <linux-kernel@vger.kernel.org>, John Williams <jwilliams@itee.uq.edu.au>

On Wednesday 15 July 2009, Ralf Baechle wrote:
 
> > I think in step 4. AFIACT, the kernel must do a number of checks on accesses
> > to random pointers.
>
> Yes; but the checks that unaligned.c does on MIPS are no different from
> any other get_user(), that is it ensures that the entire 8/16/32/64-bit
> access is in userspace.  That's done using access_ok().

Well, access_ok() plus the fixup code for unmapped or write-protected user
pages, I guess. But I agree, there are no checks beyond what get/put_user
does. In particular, the access_ok() check should only be needed for
faults from user space, while any fault coming from kernel space is
either some kernel code accessing its own data (as you mention below) or
a __get_user/__put_user that has already checked access permissions.

In my example, I got the case from kernel space wrong, it should not
check access_ok() if !user_space(regs), or it needs to do set_fs(KERNEL_DS)
first, like the mips code does.

> We've moved on.  Handling miss-alignment is no longer a very relavent part
> of the syscall interface.  So I think for the definition of the Linux
> ABI this should just be left as implementation defined behaviour but
> whatever an architecture does, it should be done consistently for all
> system interfaces.

Ok, thanks, for explanation.

I guess for the microblaze unaligned handler, both cases mean that
it needs to do a fixup table lookup for the original fault and
it needs to handle fixups on its own emulation code. The only difference
between disallowing unaligned accesses in the ABI and allowing them
is which of the two ways (check fixup table, emulate instruction) it
tries first.

	Arnd <><

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
