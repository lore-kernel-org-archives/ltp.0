Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <arnd@arndb.de>) id 1MQlZR-0006h8-Ti
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 17:13:37 +0000
Received: from moutng.kundenserver.de ([212.227.17.8])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQlZN-0005qQ-Gn
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 17:13:37 +0000
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Jul 2009 19:13:20 +0200
References: <4A5C8068.6020203@monstr.eu> <200907141843.05629.arnd@arndb.de>
	<4A5CB8B4.7050108@monstr.eu>
In-Reply-To: <4A5CB8B4.7050108@monstr.eu>
MIME-Version: 1.0
Message-Id: <200907141913.21240.arnd@arndb.de>
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
To: monstr@monstr.eu
Cc: LTP <ltp-list@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Tuesday 14 July 2009, Michal Simek wrote:
> when the code tried to read/write from unaligned address (and in cpu is turn on unaligned exception)
> then is caused unaligned exception and asm code assemble/return value which is on that unaligned
> address. (Assemble it that read/write every byte separately). That will be harder to prevent all
> this cases because unaligned exception is in generic code.
> What do you mean add __range_ok? Range checking is ok. The problem is when in case get_user kernel
> try to load unaligned addr - unaligned exception is perform and try to load that value separately.
> If that page is not there, page fault handler is called and not find it, it is performed search
> from exception table and that address is not there of course - because address in pc is generic
> unaligned code. I think that handling this needs more code.
> Maybe if the address with from unaligned exception handler (there are some address which can caused
> it) and find out which aligned address is there and find out proper fixup for it.
> I think that this could work.
> 
> What do you think?

I think the key point is that the kernel should never try an unaligned
access. Other architectures already rely on this, so you can too.
Instead of doing an aligned access from the unaligned exception handler,
you should not access the data at all when you come from kernel mode
but only search the fixup table to see if you should continue anyway.

Sorry for adding confusion by mentioning the __range_ok, which is addressing
a separate problem. I should have made that clearer.

In pseudo-code, I think you should do:

void unaligned_exception(struct pt_regs *regs, unsigned long address)
{
	if (kernel_mode(regs)) {
		/*
		 * unaligned access not allowed in kernel,
		 * but search exception table.
		 */
		bad_page_fault(regs, address, 0);
	} else {
		if (!access_ok(address, 4))
			force_sig(SIGBUS, current);
		else
			fixup_unaligned_access(regs);
	}
}

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
