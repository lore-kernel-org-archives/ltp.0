Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MZIvD-0002Th-E1
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 06:27:23 +0000
Received: from mail-ew0-f210.google.com ([209.85.219.210])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MZIv8-0003LJ-6m
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 06:27:23 +0000
Received: by ewy6 with SMTP id 6so1418950ewy.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Aug 2009 23:27:12 -0700 (PDT)
Message-ID: <4A7BC3F0.9090508@petalogix.com>
Date: Fri, 07 Aug 2009 08:04:32 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <1249305859-23722-1-git-send-email-michal.simek@petalogix.com>	
	<0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>	
	<b27f5b6149545ef2a1f3483d14d51d29f83aa7c6.1249304223.git.monstr@monstr.eu>
	<364299f40908061837r4f27c93at80061628cb8e880c@mail.gmail.com>
In-Reply-To: <364299f40908061837r4f27c93at80061628cb8e880c@mail.gmail.com>
Subject: Re: [LTP] [PATCH 2/4] tst_is_cwd: Add support for ramfs
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

> On Mon, Aug 3, 2009 at 6:24 AM, <michal.simek@petalogix.com> wrote:
>> From: Michal Simek <monstr@monstr.eu>
>>
>> I added support for testing ramfs and add together
>> tests for nfs, tmpfs and ramfs.
> 
> [...]
> 
> Hi Michal,
> 
> I'm looking at this code to solve another interesting problem, but
> just out of curiosity -- why did you #define the constants instead of
> using the definitions in sys/vfs.h? To ensure that the manpage was
> correct :)?

Not though about. Just find value and add it like for others.
But anyway for Ramfs I don't have that value in toolchain. For tmpfs and nfs I have.
From my quick look the problem seems to be that ramfs magic is not in linux/magic.h
but in fs/ramfs/inode.c which is wrong.
What interesting problem?

Michal

> 
> Thanks,
> -Garrett


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
