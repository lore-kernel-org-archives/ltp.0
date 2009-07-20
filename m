Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSnMv-0002wO-7Y
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 07:33:05 +0000
Received: from mail-pz0-f201.google.com ([209.85.222.201])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSnMp-00010U-2e
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 07:33:05 +0000
Received: by pzk39 with SMTP id 39so11212pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Jul 2009 00:32:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A63FFC3.80304@petalogix.com>
References: <364299f40907181419y73621db2w1242b7a1fa7650c@mail.gmail.com>
	<4A63FFC3.80304@petalogix.com>
Date: Mon, 20 Jul 2009 00:32:57 -0700
Message-ID: <364299f40907200032x28cc62cdn73ebb42f31d80361@mail.gmail.com>
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

On Sun, Jul 19, 2009 at 10:25 PM, Michal
Simek<michal.simek@petalogix.com> wrote:
> Garrett Cooper wrote:
>> Version 3 of the epic saga: [PATCH 3/4] Make system enhancements.

[...]

> I cross compile LTP all the time and Mike do the same for BlackFin.
> cross-compilation was possible.
> CROSS_COMPILE=3Dmb-linux-
> make

Yes, as Mike corrected me, what I was looking for was `out-of-tree
build support', where a group (say Montevista) could build more than
one architecture, or build with more than one compiler / toolchain /
sys-root using the same source directory.

Well, that and a few Makefiles were broken as far as cross-compilation
was concerned, in particular library generation on some architectures,
and hardcoded paths to libraries, host based file scanning heuristics,
you name it.

This is the first leap forward in correcting all of these things, and
it will not be the last step that must be made as this project is
large and the changes / test stimuli are as well.

[...]

>> +LIBOBJS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D=
 $$(addprefix $$(builddir)/,$$(patsubst %.c,%.o,$$(LIBSRCS)))
>>
> long line.

I try my best to do two things with makefile code:
1. align Makefile code with single tab, then spaces.
2. compress as many statements as possible to reduce the number of
required evaluation steps, because that can result in interesting
behavior from make with define blocks...

I will try and compress the space further (that line was tab
separated) in a style cleanup commit after this is all said and
committed, if I don't get to it sooner. It's just easier to add and
delete tabs for now :).

Thanks!
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
