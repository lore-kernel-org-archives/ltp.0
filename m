Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mwkw6-0000kC-00
	for ltp-list@lists.sourceforge.net; Sat, 10 Oct 2009 23:01:14 +0000
Received: from mail-px0-f179.google.com ([209.85.216.179])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mwkw5-0001bO-52
	for ltp-list@lists.sourceforge.net; Sat, 10 Oct 2009 23:01:13 +0000
Received: by pxi9 with SMTP id 9so7687110pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Sat, 10 Oct 2009 16:01:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200910101834.26319.vapier@gentoo.org>
References: <364299f40910091048w54ece725l2b07a04bb82f6a4f@mail.gmail.com>
	<200910101551.16789.vapier@gentoo.org>
	<364299f40910101502l19472085v233d75751e1badb6@mail.gmail.com>
	<200910101834.26319.vapier@gentoo.org>
Date: Sat, 10 Oct 2009 16:01:06 -0700
Message-ID: <364299f40910101601s6f868506k24aab4356a03fcd6@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] mixing of install/build targets
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

On Sat, Oct 10, 2009 at 3:34 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Saturday 10 October 2009 18:02:47 Garrett Cooper wrote:
>> On Sat, Oct 10, 2009 at 12:51 PM, Mike Frysinger wrote:
>> > On Friday 09 October 2009 13:48:42 Garrett Cooper wrote:
>> >> =A0 =A0 I'm posting the following diff as reference (it's compressed
>> >> because the entire diff is ~1.8MB) as I'm now going to commit the
>> >> following to CVS after 1.25 years of anticipation waiting for this
>> >> enhancement in the Makefiles to correct issues related to difficulty
>> >> primarily in 1) terms of maintenance, 2) lack of out-of-build-tree
>> >> support, and 3) the fact that we weren't following autoconf-like
>> >> practices for installation [ties into 1) and 2)].
>> >> =A0 =A0 If there are any issues in building the sourcebase after this,
>> >> please consult the TODO file in the root directory to determine
>> >> whether or not it's a known issue. If the issue isn't listed there,
>> >> please email the list and CC me. I ran it on Fedora 10, Gentoo Linux,
>> >> and Ubuntu Feisty Fawn, so I tried to get as much coverage as possible
>> >> when making these changes.
>> >
>> > seems like the compile step depends on install dirs. =A0a simple make =
in a
>> > subdir fails with:
>> > $ make
>> > mkdir -p "/opt/ltp/testcases/bin"
>> > mkdir: cannot create directory `/opt/ltp': Permission denied
>> > make: *** [/opt/ltp/testcases/bin] Error 1
>> >
>> > or if prefix isnt set:
>> > $ make
>> > mkdir -p "/testcases/bin"
>> > mkdir: cannot create directory `/testcases': Permission denied
>> > make: *** [/testcases/bin] Error 1
>>
>> =A0 =A0 Both of these items requires the appropriate prefix to be put in
>> config.mk, and/or the definition of DESTDIR, because the new Makefile
>> infra installs directly to the destination folder.
>> =A0 =A0 I'll go and fix the latter case though...
>
> i'm not sweating requiring the prefix to be sane via confgure/config.mk/.=
..
> i'm saying the compile step should not be needing things in the prefix. =
=A0that
> includes the creation of the install prefix (i just did a cvs up and that
> seems to be fixed), and building against the headers/libraries. =A0that s=
eems to
> be broken atm:
> $ make
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I//opt/ltp/include=
 -
> I../../../../include =A0-L//opt/ltp/lib =A0 ptrace04.c =A0-laio -lltp -o =
ptrace04
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.4.1/../../../../x86_64-pc-linux-gnu/bi=
n/ld:
> cannot find -lltp
> collect2: ld returned 1 exit status
> make: *** [ptrace04] Error 1
>
> those paths against the configured prefix (/opt/ltp) should not be there.=
 =A0we
> should be compiling against the local include only ($(top_srcdir)/include=
) and
> linking against the local lib only ($(top_builddir)/lib).
>
> also, it seems like the lib subdir is missing a default dependency on the
> libltp.a library:
> $ cd lib
> $ make clean
> rm -f -f libltp.a *.o *.pyc
> $ make
> make: Nothing to be done for `install'.
> $ make libltp.a
> <correct output>
>
> actually, now that i see this output, i guess the problem is that the def=
ault
> target is "install" instead of "all" (which implies compiled local objects
> only) ?

Ok, that's what I figured. Fixing right now and will be done in <15 mins.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
