Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSHTe-0005DK-EL
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 21:29:54 +0000
Received: from wf-out-1314.google.com ([209.85.200.168])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSHTY-00051C-Lv
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 21:29:54 +0000
Received: by wf-out-1314.google.com with SMTP id 26so488305wfd.4
	for <ltp-list@lists.sourceforge.net>;
	Sat, 18 Jul 2009 14:29:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40907181425h31ec769aw5f349b86891c94ad@mail.gmail.com>
References: <364299f40907061818q7cda3465vffb00323af18c5f8@mail.gmail.com>
	<364299f40907062033j1660f689t65b8b8bdfb402f11@mail.gmail.com>
	<364299f40907112249g1a04c53cn4d25ce385f88bcaf@mail.gmail.com>
	<200907151237.49839.vapier@gentoo.org>
	<364299f40907181425h31ec769aw5f349b86891c94ad@mail.gmail.com>
Date: Sat, 18 Jul 2009 14:29:47 -0700
Message-ID: <364299f40907181429k4436a141yfa16f6fa4be2dedf@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 4/4] Make makefiles more autoconf friendly
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Sat, Jul 18, 2009 at 2:25 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> On Wed, Jul 15, 2009 at 9:37 AM, Mike Frysinger<vapier@gentoo.org> wrote:
>>> --- m4/GNUmakefile =A0 =A018 Jan 2009 22:22:40 -0000 =A0 =A0 =A01.1
>>> +++ m4/GNUmakefile =A0 =A012 Jul 2009 05:46:28 -0000
>>
>> i think we only need a top level GNUmakefile. =A0all the other subdirs c=
an stay
>> Makefile.
>
> Well, ok. I was just leaving it as-is, because that's the way it is today=
 :).
>
> Like in rock-paper-scissors:
>
> GNUmakefile beats Makefile, which beats makefile.

Turns out there's already a Makefile.in:

gcooper@orangebox /scratch/ltp-nova2/ltp-nova $ ls m4/
CVS          Makefile.in    ltp-eventfd.m4     ltp-signalfd.m4
GNUmakefile  ac_prog_ar.m4  ltp-modify_ldt.m4  ltp-taskstats.m4
Makefile.am  ltp-crypto.m4  ltp-selinux.m4

So if I were to rename it to Makefile, it would get nuked after
configure is called. Not something that we want I assume :)...

I'll leave the file as-is.

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
