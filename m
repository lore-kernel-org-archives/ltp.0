Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N6TTG-0007Pa-DB
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 18:23:38 +0000
Received: from mail-px0-f179.google.com ([209.85.216.179])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N6TTF-0003po-Es
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 18:23:38 +0000
Received: by pxi9 with SMTP id 9so853090pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 06 Nov 2009 10:23:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911060616.40305.vapier@gentoo.org>
	<20091106130906.GW31511@one.firstfloor.org>
	<200911060821.40182.vapier@gentoo.org>
	<364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
Date: Fri, 6 Nov 2009 10:23:31 -0800
Message-ID: <364299f40911061023w42293d4fh99228a9b771e9446@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP 20091031 Makefiles totally broken?!?
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
Cc: ltp-list@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>

On Fri, Nov 6, 2009 at 10:04 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Fri, Nov 6, 2009 at 5:21 AM, Mike Frysinger <vapier@gentoo.org> wrote:
>> On Friday 06 November 2009 08:09:06 Andi Kleen wrote:
>>> On Fri, Nov 06, 2009 at 07:16:39AM -0400, Mike Frysinger wrote:
>>> > On Friday 06 November 2009 04:57:45 Andi Kleen wrote:
>>> > > I ran configure, which seems to spend 99% of its time
>>> > > checking for stuff that is always there on any Linux,
>>> >
>>> > not really. =A0most of the configure checks are there because people =
have
>>> > complained about specific issues trying to run on older linux distros.
>>> > and we
>>>
>>> I always just deleted the tests that didn't build. That's far better
>>> than not building at all like now.
>>
>> perhaps an acceptable workaround for you, but certainly not for most peo=
ple
>>
>>> > arent actively blocking using LTP on other *nix systems.
>>>
>>> yes you're just actively blocking running LTP on Linux now it seems.
>>
>> please refrain from filling e-mails with unrelated BS
>>
>>> > > and after that I just get
>>> > >
>>> > > # make
>>> > > make: `testcases/realtime/configure' is up to date.
>>> > > #
>>> >
>>> > -ENEEDINFO
>>> >
>>> > are you using live cvs ? =A0latest release ? =A0what distro ? =A0what=
 version
>>> > of
>>>
>>> See Subject on SUSE 10.0
>>>
>>> > autoconf/make ? =A0what does `make -d` show ?
>>>
>>> autoconf doesn't matter because I didn't regenerate the script.
>>>
>>> GNU Make 3.80
>>
>> looks like a bug in make-3.80. =A0works fine with make-3.81. =A0care to =
take a
>> look Garrett ?
>>
>> usually i just install older versions on my system as `make-$VER` to make
>> testing different ones easy. =A0since all the makefiles use $(MAKE), this
>> shouldnt be a problem to execute `make-$VER` instead of `make`.
>
> Hi Andi,
>
> As I just wrote in the INSTALL file after the release (I apologize for
> not catching this beforehand, but all of the systems I use -- Fedora,
> Gentoo, RHEL 4 update 6, Ubuntu -- have make 3.81):
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> In order to compile and use pan, you must have bison/yacc, flex, and make
> 3.81+ installed.

I reread this statement and it is ambiguous. I just changed it in CVS
to state the following:

1. In order to compile ltp you must have make 3.81+.
2. In order to compile and use pan, you must have bison/yacc, and flex
installed.

> # ...
>
> make 3.81 can be obtained here:
> - http://ftp.gnu.org/gnu/make/make-3.81.tar.bz2
>
> # ...
>
> Common Issues
> ----------------------
>
> Issue: =A0 =A0When executing make [all] it says:
>
> =A0 =A0" *** No rule to make target `/$*', needed by `pan-all'. =A0Stop."
>
> Solution: You must upgrade to make 3.81. Please see the Requirements
> section above.
>
> Issue: =A0 =A0When executing make [all] it says something like:
>
> =A0 =A0# ...
> =A0 =A0install -m 00644 "/scratch/ltp-dev2/ltp/include/test.h"
> "/scratch/ltp-install12/include/test.h"
> =A0 =A0install -m 00644 "/scratch/ltp-dev2/ltp/include/tlibio.h"
> "/scratch/ltp-install12/include/tlibio.h"
> =A0 =A0install -m 00644 "/scratch/ltp-dev2/ltp/include/usctest.h"
> "/scratch/ltp-install12/include/usctest.h"
> =A0 =A0install -m 00644 "/scratch/ltp-dev2/ltp/include/write_log.h"
> "/scratch/ltp-install12/include/write_log.h"
> =A0 =A0make[1]: Leaving directory `/scratch/ltp-dev2/ltp/include'
> =A0 =A0make -C lib -f "/scratch/ltp-dev2/ltp/lib/Makefile" all
> =A0 =A0make[1]: Entering directory `/scratch/ltp-dev2/ltp/lib'
> =A0 =A0" *** No rule to make target `dataascii.o', needed by `libltp.a'.
> Stop." # <-- the error
>
> Solution: You cannot build LTP with -r / --no-builtin-rules and/or
> =A0 =A0 =A0 =A0 =A0-R / --no-builtin-variables specified. LTP relies heav=
ily on built-in
> =A0 =A0 =A0 =A0 =A0implicit rules and variables to function properly.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> So yes, there are known issues with using make versions <3.81. The
> reason being that some macros and functions that I use to determine
> absolute path, etc were not available in make 3.80.
>
> I've considered adding a configure check for the make version. I'm
> probably going to do it this weekend to avoid support issues like
> these.
>
> Thanks,
> -Garrett
>

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
