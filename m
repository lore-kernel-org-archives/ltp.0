Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MTFuw-0006bu-EK
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 14:02:06 +0000
Received: from fg-out-1718.google.com ([72.14.220.157])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTFur-0005S0-Nz
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 14:02:06 +0000
Received: by fg-out-1718.google.com with SMTP id 13so843959fge.9
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 07:02:00 -0700 (PDT)
Message-ID: <4A65CA56.20801@petalogix.com>
Date: Tue, 21 Jul 2009 16:01:58 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <364299f40907181419y73621db2w1242b7a1fa7650c@mail.gmail.com>	
	<4A63FFC3.80304@petalogix.com>	
	<364299f40907200032x28cc62cdn73ebb42f31d80361@mail.gmail.com>	
	<4A65BC10.8000908@petalogix.com>
	<364299f40907210657t2f03bec4qd5deaf697b12f1e9@mail.gmail.com>
In-Reply-To: <364299f40907210657t2f03bec4qd5deaf697b12f1e9@mail.gmail.com>
Subject: Re: [LTP] [PATCH 3/4] Make system enhancements, Draft 3
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
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Garrett Cooper wrote:
> On Tue, Jul 21, 2009 at 6:01 AM, Michal Simek<michal.simek@petalogix.com> wrote:
>   
>> Garrett Cooper wrote:
>>     
>>> On Sun, Jul 19, 2009 at 10:25 PM, Michal
>>> Simek<michal.simek@petalogix.com> wrote:
>>>       
>>>>> +LIBOBJS                              := $$(addprefix $$(builddir)/,$$(patsubst %.c,%.o,$$(LIBSRCS)))
>>>>>
>>>>>
>>>>>           
>>>> long line.
>>>>
>>>>         
>>> I try my best to do two things with makefile code:
>>> 1. align Makefile code with single tab, then spaces.
>>> 2. compress as many statements as possible to reduce the number of
>>> required evaluation steps, because that can result in interesting
>>> behavior from make with define blocks...
>>>
>>> I will try and compress the space further (that line was tab
>>> separated) in a style cleanup commit after this is all said and
>>> committed, if I don't get to it sooner. It's just easier to add and
>>> delete tabs for now :).
>>>
>>>       
>> make no sense to send a patch with coding style violation and then send
>> next patch
>> which fixed that bad coding style. It is better to do it properly in
>> first time.
>> We have to clean whole LTP source code not pollute it.
>>     
>
> I am cleaning up a lot more `style-guide violations' than I am causing in LTP.
>
> All Cisco level project support for LTP has been yanked recently due
> to limited restructuring (the other gentleman that was going to help
> me is no longer part of my project as well), so I'm doing this solely
> on my spare time.
>
> If you _want_ to fix the items, you can too -- this is an opensource
> project you know ;)... I am aware of the eyesores and I'll get to them
> as soon as I can.
>
> 1. If it breaks functionality, it needs to be fixed before commit.
> 2. If it's an eyesore, I'll prioritize it and fix it ASAP.
>
> BTW, AFAIK there isn't a style guide for LTP -- so before correcting
> me on style I'd produce a writeup stating that _this_ is how I need to
> code my code in order to meet LTP's standards, please.
>   
We talked about coding style for LTP some month ago. LTP should follow
linux kernel coding style. I though that Subrata wrote it somewhere,
didn't you?
On the base on it I fixed a lot of syscalls tests in my spare time too.

Michal

> Thanks,
> -Garrett
>   


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
