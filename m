Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <monstr@monstr.eu>) id 1MQlIr-0005jI-9S
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 16:56:29 +0000
Received: from mail-fx0-f208.google.com ([209.85.220.208])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQlIp-0007M3-1J
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 16:56:29 +0000
Received: by fxm4 with SMTP id 4so370441fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Jul 2009 09:56:26 -0700 (PDT)
Message-ID: <4A5CB8B4.7050108@monstr.eu>
Date: Tue, 14 Jul 2009 18:56:20 +0200
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
References: <4A5C8068.6020203@monstr.eu> <200907141652.59049.arnd@arndb.de>
	<4A5CAEFF.9080206@monstr.eu> <200907141843.05629.arnd@arndb.de>
In-Reply-To: <200907141843.05629.arnd@arndb.de>
Subject: Re: [LTP] access_ok macor
Reply-To: monstr@monstr.eu
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: LTP <ltp-list@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

Arnd Bergmann wrote:
> On Tuesday 14 July 2009, Michal Simek wrote:
>> Arnd Bergmann wrote:
> 
>>>>  r29=00000000, r30=00000000, r31=CE9759A4, rPC=C000123C
>>>>  msr=800045AE, ear=00000001, esr=000000B2, fsr=000080D0
>>>> Segmentation fault
>>>>
>>> I guess then you should check if 0xc000123c is in your
>>> exception table, or why it is not.
>> on that address is load instruction for unaligned exception because addr is odd number
>> that's why is called unaligned exception handler and from this function
>> is called load instruction which failed. :-(
>>
>> Currently this make more sense why that tests failed. If that pointers are
>> even number exception is not taken and exception sure don't have fixup for it because
>> this is generic code. :-(
>>
>> That's the problem because we are looking for regs->pc but this point to unaligned exception
>> handler.
> 
> Ok, that makes a lot of sense.
> 
> The solution then is to handle fixups from the unaligned exception handler
> if you come from the kernel. That should fix the three text cases.
> 
> I don't fully understand your exception handling there, but I think you
> also need to add code checking for __range_ok() to your unaligned handler,
> to prevent malicious user space code from accessing the kernel through
> unaligned pointers.

when the code tried to read/write from unaligned address (and in cpu is turn on unaligned exception)
then is caused unaligned exception and asm code assemble/return value which is on that unaligned
address. (Assemble it that read/write every byte separately). That will be harder to prevent all
this cases because unaligned exception is in generic code.
What do you mean add __range_ok? Range checking is ok. The problem is when in case get_user kernel
try to load unaligned addr - unaligned exception is perform and try to load that value separately.
If that page is not there, page fault handler is called and not find it, it is performed search
from exception table and that address is not there of course - because address in pc is generic
unaligned code. I think that handling this needs more code.
Maybe if the address with from unaligned exception handler (there are some address which can caused
it) and find out which aligned address is there and find out proper fixup for it.
I think that this could work.

What do you think?

Michal



> 
> 	Arnd <><


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854

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
