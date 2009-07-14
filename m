Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <arnd@arndb.de>) id 1MQhxL-0004uR-82
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 13:22:03 +0000
Received: from moutng.kundenserver.de ([212.227.126.187])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQhxD-0002O0-U5
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 13:22:03 +0000
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Jul 2009 15:21:47 +0200
References: <4A5C8068.6020203@monstr.eu>
In-Reply-To: <4A5C8068.6020203@monstr.eu>
MIME-Version: 1.0
Message-Id: <200907141521.47719.arnd@arndb.de>
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
> I found that I can setup text base in binutils/ld/emulparam/elf32mb_linux.sh
> 
> The problem which I have is that if I run socketpair, getsockname, getpeername LTP
> tests with invalid salen pointer there are addresses close to 0x0. Microblaze
> has no text there and the sigsegv fault is generated.

This sounds like a classic NULL pointer dereference that is handled correctly
by the kernel. The question is where the address came from.

> This fault could be fixed by changed access_ok macro where I check bottom limit
> at 0x1000 0000 too. After this change the LTP program not failed but I am not sure
> if is the right solution because none arch do it. All archs just check upper limit
> not lower.
> 
> What is the correct solution for it? Moving .text base to 0x0 or is there any other
> elegant solution?

Moving .text is not the right solution, because it only papers over real bugs.
access_ok() is also not the right place to check this, the only purpose it has
is to make sure that the argument is not a valid kernel address but either a
valid user address or possibly invalid address. Also, access_ok() is only used
together with the copy_from/to_user and get/put_user function families. These
need to catch invalid addresses with a fixup table entry in the kernel.

I briefly looked at your implementation but could not find any problems in
this area. Could you use gdb to find out whether the sigsegv happens in the
kernel at all, or in user space?

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
