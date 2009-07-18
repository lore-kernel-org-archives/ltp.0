Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSHQ2-0005Gd-2e
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 21:26:10 +0000
Received: from mail-px0-f190.google.com ([209.85.216.190])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSHPs-0006ga-Jy
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 21:26:04 +0000
Received: by pxi28 with SMTP id 28so1260595pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 18 Jul 2009 14:25:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907151237.49839.vapier@gentoo.org>
References: <364299f40907061818q7cda3465vffb00323af18c5f8@mail.gmail.com>
	<364299f40907062033j1660f689t65b8b8bdfb402f11@mail.gmail.com>
	<364299f40907112249g1a04c53cn4d25ce385f88bcaf@mail.gmail.com>
	<200907151237.49839.vapier@gentoo.org>
Date: Sat, 18 Jul 2009 14:25:58 -0700
Message-ID: <364299f40907181425h31ec769aw5f349b86891c94ad@mail.gmail.com>
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

On Wed, Jul 15, 2009 at 9:37 AM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Sunday 12 July 2009 01:49:52 Garrett Cooper wrote:
>> -AC_CONFIG_FILES([config.mk m4/Makefile])
>> +AC_CONFIG_FILES([ include/mk/config.mk lib/ltp.pc ltp-devel.spec
>> m4/Makefile \ +README.ltp-devel ])
>
> if you're going to start splitting lines, might as well do all of them and
> keep them sorted
> AC_CONFIG_FILES([ \
> =A0 =A0 =A0 =A0file1 \
> =A0 =A0 =A0 =A0file2 \
> =A0 =A0 =A0 =A0file3 \
> ])

Done.

>> --- /dev/null 1 Jan 1970 00:00:00 -0000
>> +++ ltp-devel.spec.in 12 Jul 2009 05:46:28 -0000
>
> each of the .in files should have a target in the related Makefile so tha=
t it
> gets updated if the source is modified
>
> ltp-devel.spec: $(srcdir)/ltp-devel.spec.in
> =A0 =A0 =A0 =A0./config.status $@

Ok.

>> +++ include/mk/config.mk.in =A0 12 Jul 2009 05:46:28 -0000
>> +AIO_LIBS =A0 =A0 =3D @AIO_LIBS@
>> +CRYPTO_LIB =A0 =3D @CRYPTO_LIB@
>> +SELINUX_LIBS =3D @SELINUX_LIBS@
>
> there should be a note here about standardizing the naming. =A0it should =
be
> "FOO_LIBS", not "_LIB".

Ok. I'll fix that then, even though I didn't cause it.

>> +# Avoid overwriting definitions in leaf callers.
>> +CPPFLAGS =A0 =A0 ?=3D @CPPFLAGS@ -I$(includedir)
>> +CFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D @CFLAGS@
>> +LDLIBS =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D @LIBS@
>> +LDFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0?=3D @LDFLAGS@ -L$(libdir)
>
> this looks like it'll cause problems if you set these in your environment
> export CPPFLAGS=3D'' CFLAGS=3D'-pipe' LDFLAGS=3D''
> make
>
> i would use $(origin ...) to determine whether the variables are coming f=
rom
> the leaf Makefile

Ah, yes. Excellent point.

So what's the appropriate protocol then:

If set in environment, ignore?
Or:
If set in Makefile, ignore?

> also, please add '-pipe' to default CFLAGS

Sure.

>> +DEBUG_CFLAGS ?=3D -g
>> +DEBUG_CXXFLAGS =A0 =A0 =A0 ?=3D $(DEBUG_CFLAGS)
>> +
>> +CFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D $(DEBUG_CFLAGS)
>> +CXXFLAGS =A0 =A0 +=3D $(DEBUG_CXXFLAGS)
>> +
>> +# There have been several bugs in the past related to -O2+ when
>> +# -fno-strict-aliasing is not specified.
>> +OPT_CFLAGS =A0 ?=3D -O2 -fno-strict-aliasing
>> +OPT_CXXFLAGS ?=3D $(OPT_CFLAGS)
>
> in general, i recall only like 1 bug that was a gcc issue. =A0all the oth=
ers
> were broken source code. =A0i dont think we should live with code that vi=
olates
> aliasing rules.

See my previous comment. There are ~10 different bugs spanning
compilers from v3.3.x to 4.4.x, which deal with broken
-fstrict-aliasing optimizations in the tree optimizer.

>> +#export AR CC CFLAGS CPPFLAGS LDLIBS LDFLAGS RANLIB
>
> forgot to delete ?

Yeah ><.

>> --- m4/GNUmakefile =A0 =A018 Jan 2009 22:22:40 -0000 =A0 =A0 =A01.1
>> +++ m4/GNUmakefile =A0 =A012 Jul 2009 05:46:28 -0000
>
> i think we only need a top level GNUmakefile. =A0all the other subdirs ca=
n stay
> Makefile.

Well, ok. I was just leaving it as-is, because that's the way it is today :=
).

Like in rock-paper-scissors:

GNUmakefile beats Makefile, which beats makefile.

>> +LFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -l -w
>> +CFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -w
>
> punt these

Will do.

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
