Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MwkSG-0007ZI-DJ
	for ltp-list@lists.sourceforge.net; Sat, 10 Oct 2009 22:30:24 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MwkS9-0004a1-H6
	for ltp-list@lists.sourceforge.net; Sat, 10 Oct 2009 22:30:24 +0000
Received: by pzk31 with SMTP id 31so4798398pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 10 Oct 2009 15:30:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40910101502l19472085v233d75751e1badb6@mail.gmail.com>
References: <364299f40910091048w54ece725l2b07a04bb82f6a4f@mail.gmail.com>
	<200910101551.16789.vapier@gentoo.org>
	<364299f40910101502l19472085v233d75751e1badb6@mail.gmail.com>
Date: Sat, 10 Oct 2009 15:30:11 -0700
Message-ID: <364299f40910101530t3be5d6d8i5e530c5137d923b8@mail.gmail.com>
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

On Sat, Oct 10, 2009 at 3:02 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Sat, Oct 10, 2009 at 12:51 PM, Mike Frysinger <vapier@gentoo.org> wrot=
e:
>> On Friday 09 October 2009 13:48:42 Garrett Cooper wrote:
>>> =A0 =A0 I'm posting the following diff as reference (it's compressed
>>> because the entire diff is ~1.8MB) as I'm now going to commit the
>>> following to CVS after 1.25 years of anticipation waiting for this
>>> enhancement in the Makefiles to correct issues related to difficulty
>>> primarily in 1) terms of maintenance, 2) lack of out-of-build-tree
>>> support, and 3) the fact that we weren't following autoconf-like
>>> practices for installation [ties into 1) and 2)].
>>> =A0 =A0 If there are any issues in building the sourcebase after this,
>>> please consult the TODO file in the root directory to determine
>>> whether or not it's a known issue. If the issue isn't listed there,
>>> please email the list and CC me. I ran it on Fedora 10, Gentoo Linux,
>>> and Ubuntu Feisty Fawn, so I tried to get as much coverage as possible
>>> when making these changes.
>>
>> seems like the compile step depends on install dirs. =A0a simple make in=
 a
>> subdir fails with:
>> $ make
>> mkdir -p "/opt/ltp/testcases/bin"
>> mkdir: cannot create directory `/opt/ltp': Permission denied
>> make: *** [/opt/ltp/testcases/bin] Error 1
>>
>> or if prefix isnt set:
>> $ make
>> mkdir -p "/testcases/bin"
>> mkdir: cannot create directory `/testcases': Permission denied
>> make: *** [/testcases/bin] Error 1
>
> =A0 =A0Both of these items requires the appropriate prefix to be put in
> config.mk, and/or the definition of DESTDIR, because the new Makefile
> infra installs directly to the destination folder.
> =A0 =A0I'll go and fix the latter case though...

    I just changed it so it won't do this anymore, but what I need to
know exactly is how do you intend to do submakes, e.g. do you intend
to manually compile the library, NOT do the install, then go to a
subdir, run make all, and that's it?
    make install (IMO) still needs $(prefix) to be defined to a sane
setting, so it's now only a requirement for install.
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
