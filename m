Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSJ6H-0002yg-9t
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 23:13:53 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSJ6C-0005tr-H9
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 23:13:53 +0000
Received: by mail-pz0-f178.google.com with SMTP id 8so1263985pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 18 Jul 2009 16:13:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907181822.03140.vapier@gentoo.org>
References: <364299f40907061818q7cda3465vffb00323af18c5f8@mail.gmail.com>
	<200907151237.49839.vapier@gentoo.org>
	<364299f40907181425h31ec769aw5f349b86891c94ad@mail.gmail.com>
	<200907181822.03140.vapier@gentoo.org>
Date: Sat, 18 Jul 2009 16:07:13 -0700
Message-ID: <364299f40907181607m42e27de9sacb61084452ea53a@mail.gmail.com>
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

On Sat, Jul 18, 2009 at 3:22 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Saturday 18 July 2009 17:25:58 Garrett Cooper wrote:
>> On Wed, Jul 15, 2009 at 9:37 AM, Mike Frysinger<vapier@gentoo.org> wrote:
>> > On Sunday 12 July 2009 01:49:52 Garrett Cooper wrote:
>> >> +# Avoid overwriting definitions in leaf callers.
>> >> +CPPFLAGS =A0 =A0 ?=3D @CPPFLAGS@ -I$(includedir)
>> >> +CFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D @CFLAGS@
>> >> +LDLIBS =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D @LIBS@
>> >> +LDFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0?=3D @LDFLAGS@ -L$(libdir)
>> >
>> > this looks like it'll cause problems if you set these in your environm=
ent
>> > export CPPFLAGS=3D'' CFLAGS=3D'-pipe' LDFLAGS=3D''
>> > make
>> >
>> > i would use $(origin ...) to determine whether the variables are coming
>> > from the leaf Makefile
>>
>> Ah, yes. Excellent point.
>>
>> So what's the appropriate protocol then:
>>
>> If set in environment, ignore?
>> Or:
>> If set in Makefile, ignore?
>
> if it's set in the env, the "?=3D" should already handle that. =A0i cant =
think of
> a reason for the leaf makefiles to be settings default flags ... do you h=
ave
> an example in mind ?

Yes, actually. The problem with the current system is that we keep on
using +=3D, which bloats the CFLAGS / LDFLAGS / LDLIBS, etc
unnecessarily, so if we get 5 levels deep we end up with a line like:

gcc -I../../../../../include -I../../../../include -I../../../include
-I../../include -I../include

etc.

Now that's just plain silly and we'll run into ceilings very quickly
with long argument lines, plus it'll slow down gcc / binutils with the
search path.

>> >> +DEBUG_CFLAGS ?=3D -g
>> >> +DEBUG_CXXFLAGS =A0 =A0 =A0 ?=3D $(DEBUG_CFLAGS)
>> >> +
>> >> +CFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D $(DEBUG_CFLAGS)
>> >> +CXXFLAGS =A0 =A0 +=3D $(DEBUG_CXXFLAGS)
>> >> +
>> >> +# There have been several bugs in the past related to -O2+ when
>> >> +# -fno-strict-aliasing is not specified.
>> >> +OPT_CFLAGS =A0 ?=3D -O2 -fno-strict-aliasing
>> >> +OPT_CXXFLAGS ?=3D $(OPT_CFLAGS)
>> >
>> > in general, i recall only like 1 bug that was a gcc issue. =A0all the
>> > others were broken source code. =A0i dont think we should live with co=
de
>> > that violates aliasing rules.
>>
>> See my previous comment. There are ~10 different bugs spanning
>> compilers from v3.3.x to 4.4.x, which deal with broken
>> -fstrict-aliasing optimizations in the tree optimizer.
>
> please centralize the comments then rather than sprinkling them about the
> different source files. =A0here the comment should say:
> # -fno-strict-aliasing: please see README.mk-devel

Will do.

>> >> --- m4/GNUmakefile =A0 =A018 Jan 2009 22:22:40 -0000 =A0 =A0 =A01.1
>> >> +++ m4/GNUmakefile =A0 =A012 Jul 2009 05:46:28 -0000
>> >
>> > i think we only need a top level GNUmakefile. =A0all the other subdirs=
 can
>> > stay Makefile.
>>
>> Well, ok. I was just leaving it as-is, because that's the way it is today
>> :).
>>
>> Like in rock-paper-scissors:
>>
>> GNUmakefile beats Makefile, which beats makefile.
>
> mmm that GNUmakefile is there for a different reason (to ignore the autom=
ake-
> generated Makefile), so we dont want to go renaming it. =A0so you dont ne=
ed to
> go doing something different.

k.

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
