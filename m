Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MZKHJ-0004sU-SU
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 07:54:17 +0000
Received: from qw-out-1920.google.com ([74.125.92.147])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MZKHF-0000P5-9C
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 07:54:17 +0000
Received: by qw-out-1920.google.com with SMTP id 5so539656qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 07 Aug 2009 00:54:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A7BC3F0.9090508@petalogix.com>
References: <1249305859-23722-1-git-send-email-michal.simek@petalogix.com>
	<0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
	<b27f5b6149545ef2a1f3483d14d51d29f83aa7c6.1249304223.git.monstr@monstr.eu>
	<364299f40908061837r4f27c93at80061628cb8e880c@mail.gmail.com>
	<4A7BC3F0.9090508@petalogix.com>
Date: Fri, 7 Aug 2009 00:54:07 -0700
Message-ID: <364299f40908070054r7d2ef714na75ce466f08513cf@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/4] tst_is_cwd: Add support for ramfs
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
To: michal.simek@petalogix.com
Cc: ltp-list@lists.sourceforge.net

On Thu, Aug 6, 2009 at 11:04 PM, Michal Simek<michal.simek@petalogix.com> wrote:
> Hi,
>
>> On Mon, Aug 3, 2009 at 6:24 AM, <michal.simek@petalogix.com> wrote:
>>> From: Michal Simek <monstr@monstr.eu>
>>>
>>> I added support for testing ramfs and add together
>>> tests for nfs, tmpfs and ramfs.
>>
>> [...]
>>
>> Hi Michal,
>>
>> I'm looking at this code to solve another interesting problem, but
>> just out of curiosity -- why did you #define the constants instead of
>> using the definitions in sys/vfs.h? To ensure that the manpage was
>> correct :)?
>
> Not though about. Just find value and add it like for others.

It'd be better if we used #ifndef - #define - #endif though, right?

> But anyway for Ramfs I don't have that value in toolchain. For tmpfs and nfs I have.
> From my quick look the problem seems to be that ramfs magic is not in linux/magic.h
> but in fs/ramfs/inode.c which is wrong.

Well, that's something that should be filed as a bug and cleaned up,
right :)? It's better to have those exposed so folks can use it.

> What interesting problem?

We boot off nfs rootfs and I was trying to find a way to determine
whether or not something was initramfs, so we could call
default_rootfs() from init_post(), only when initramfs is not present
and mounted as root -- would this in fact apply?

Thanks,
-Garrett

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
