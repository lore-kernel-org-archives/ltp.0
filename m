Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <monstr@monstr.eu>) id 1MQiJz-0005MT-5C
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 13:45:27 +0000
Received: from mail-fx0-f208.google.com ([209.85.220.208])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQiJx-0005Px-TI
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 13:45:27 +0000
Received: by fxm4 with SMTP id 4so242241fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Jul 2009 06:45:24 -0700 (PDT)
Message-ID: <4A5C8BF2.8020505@monstr.eu>
Date: Tue, 14 Jul 2009 15:45:22 +0200
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
References: <4A5C8068.6020203@monstr.eu> <200907141521.47719.arnd@arndb.de>
In-Reply-To: <200907141521.47719.arnd@arndb.de>
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
>> I found that I can setup text base in binutils/ld/emulparam/elf32mb_linux.sh
>>
>> The problem which I have is that if I run socketpair, getsockname, getpeername LTP
>> tests with invalid salen pointer there are addresses close to 0x0. Microblaze
>> has no text there and the sigsegv fault is generated.
> 
> This sounds like a classic NULL pointer dereference that is handled correctly
> by the kernel. The question is where the address came from.

It is not anly NULL pointer - is LTP tests are some fake addresses. From my tests I see
that I am not able to access place till 1000 0000 in dec.
Bad address come from tests to test it.

Look at
http://developer.petalogix.com/git/gitweb.cgi?p=ltp-microblaze.git;a=commitdiff;h=45f4cd783ce8b94f1267bb87c0c46e8536f62eca

There are three affected tests and my quick fixes which I am trying to solve now.


> 
>> This fault could be fixed by changed access_ok macro where I check bottom limit
>> at 0x1000 0000 too. After this change the LTP program not failed but I am not sure
>> if is the right solution because none arch do it. All archs just check upper limit
>> not lower.
>>
>> What is the correct solution for it? Moving .text base to 0x0 or is there any other
>> elegant solution?
> 
> Moving .text is not the right solution, because it only papers over real bugs.

I can confirm it - I moved it and rebuild toolchain.

> access_ok() is also not the right place to check this, the only purpose it has
> is to make sure that the argument is not a valid kernel address but either a
> valid user address or possibly invalid address. Also, access_ok() is only used
> together with the copy_from/to_user and get/put_user function families. These
> need to catch invalid addresses with a fixup table entry in the kernel.

ok - that mean that problem could be in bad fixup table?


> 
> I briefly looked at your implementation but could not find any problems in
> this area. Could you use gdb to find out whether the sigsegv happens in the
> kernel at all, or in user space?

We don't have gdb in place.

The problem should come from get_user macro. net/socket.c:212
I was looking for it in the morning. I am checking it again.

Thanks,
Michal


int move_addr_to_user(struct sockaddr *kaddr, int klen, void __user *uaddr,
		      int __user *ulen)
{
	int err;
	int len;

	err = get_user(len, ulen);
	if (err)
		return err;


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
