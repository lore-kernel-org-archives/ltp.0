Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MTFqT-0000up-15
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 13:57:29 +0000
Received: from mail-px0-f190.google.com ([209.85.216.190])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTFqO-0004Le-6d
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 13:57:29 +0000
Received: by pxi28 with SMTP id 28so2435805pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 06:57:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A65BC10.8000908@petalogix.com>
References: <364299f40907181419y73621db2w1242b7a1fa7650c@mail.gmail.com>
	<4A63FFC3.80304@petalogix.com>
	<364299f40907200032x28cc62cdn73ebb42f31d80361@mail.gmail.com>
	<4A65BC10.8000908@petalogix.com>
Date: Tue, 21 Jul 2009 06:57:23 -0700
Message-ID: <364299f40907210657t2f03bec4qd5deaf697b12f1e9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 3/4] Make system enhancements, Draft 3
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: michal.simek@petalogix.com
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

On Tue, Jul 21, 2009 at 6:01 AM, Michal Simek<michal.simek@petalogix.com> w=
rote:
> Garrett Cooper wrote:
>> On Sun, Jul 19, 2009 at 10:25 PM, Michal
>> Simek<michal.simek@petalogix.com> wrote:
>>>>
>>>> +LIBOBJS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=
=3D $$(addprefix $$(builddir)/,$$(patsubst %.c,%.o,$$(LIBSRCS)))
>>>>
>>>>
>>> long line.
>>>
>>
>> I try my best to do two things with makefile code:
>> 1. align Makefile code with single tab, then spaces.
>> 2. compress as many statements as possible to reduce the number of
>> required evaluation steps, because that can result in interesting
>> behavior from make with define blocks...
>>
>> I will try and compress the space further (that line was tab
>> separated) in a style cleanup commit after this is all said and
>> committed, if I don't get to it sooner. It's just easier to add and
>> delete tabs for now :).
>>
> make no sense to send a patch with coding style violation and then send
> next patch
> which fixed that bad coding style. It is better to do it properly in
> first time.
> We have to clean whole LTP source code not pollute it.

I am cleaning up a lot more `style-guide violations' than I am causing in L=
TP.

All Cisco level project support for LTP has been yanked recently due
to limited restructuring (the other gentleman that was going to help
me is no longer part of my project as well), so I'm doing this solely
on my spare time.

If you _want_ to fix the items, you can too -- this is an opensource
project you know ;)... I am aware of the eyesores and I'll get to them
as soon as I can.

1. If it breaks functionality, it needs to be fixed before commit.
2. If it's an eyesore, I'll prioritize it and fix it ASAP.

BTW, AFAIK there isn't a style guide for LTP -- so before correcting
me on style I'd produce a writeup stating that _this_ is how I need to
code my code in order to meet LTP's standards, please.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
