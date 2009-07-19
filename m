Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSOmR-0006Vi-Hl
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:17:47 +0000
Received: from mail-px0-f190.google.com ([209.85.216.190])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSOmL-0006g7-70
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:17:47 +0000
Received: by pxi28 with SMTP id 28so1371265pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 18 Jul 2009 22:17:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907182014.11010.vapier@gentoo.org>
References: <364299f40907061818q7cda3465vffb00323af18c5f8@mail.gmail.com>
	<200907181822.03140.vapier@gentoo.org>
	<364299f40907181607m42e27de9sacb61084452ea53a@mail.gmail.com>
	<200907182014.11010.vapier@gentoo.org>
Date: Sat, 18 Jul 2009 22:17:40 -0700
Message-ID: <364299f40907182217s1c906bd0lb052091fb4f82af9@mail.gmail.com>
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

On Sat, Jul 18, 2009 at 5:14 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Saturday 18 July 2009 19:07:13 Garrett Cooper wrote:
>> On Sat, Jul 18, 2009 at 3:22 PM, Mike Frysinger wrote:
>> > On Saturday 18 July 2009 17:25:58 Garrett Cooper wrote:
>> >> On Wed, Jul 15, 2009 at 9:37 AM, Mike Frysinger wrote:
>> >> > On Sunday 12 July 2009 01:49:52 Garrett Cooper wrote:
>> >> >> +# Avoid overwriting definitions in leaf callers.
>> >> >> +CPPFLAGS =A0 =A0 ?=3D @CPPFLAGS@ -I$(includedir)
>> >> >> +CFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D @CFLAGS@
>> >> >> +LDLIBS =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D @LIBS@
>> >> >> +LDFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0?=3D @LDFLAGS@ -L$(libdir)
>> >> >
>> >> > this looks like it'll cause problems if you set these in your
>> >> > environment export CPPFLAGS=3D'' CFLAGS=3D'-pipe' LDFLAGS=3D''
>> >> > make
>> >> >
>> >> > i would use $(origin ...) to determine whether the variables are
>> >> > coming from the leaf Makefile
>> >>
>> >> Ah, yes. Excellent point.
>> >>
>> >> So what's the appropriate protocol then:
>> >>
>> >> If set in environment, ignore?
>> >> Or:
>> >> If set in Makefile, ignore?
>> >
>> > if it's set in the env, the "?=3D" should already handle that. =A0i ca=
nt
>> > think of a reason for the leaf makefiles to be settings default flags =
...
>> > do you have an example in mind ?
>>
>> Yes, actually. The problem with the current system is that we keep on
>> using +=3D, which bloats the CFLAGS / LDFLAGS / LDLIBS, etc
>> unnecessarily, so if we get 5 levels deep we end up with a line like:
>>
>> gcc -I../../../../../include -I../../../../include -I../../../include
>> -I../../include -I../include
>>
>> etc.
>>
>> Now that's just plain silly and we'll run into ceilings very quickly
>> with long argument lines, plus it'll slow down gcc / binutils with the
>> search path.
>
> well that should be addressed independently. =A0have the .mk export some
> variable like LTP_BUILD_INITIALIZED =3D yes, and then stick all of these
> defaults and appends behind that.

Done.
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
