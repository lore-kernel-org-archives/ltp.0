Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MwoNW-0003B1-OZ
	for ltp-list@lists.sourceforge.net; Sun, 11 Oct 2009 02:41:46 +0000
Received: from mail-px0-f179.google.com ([209.85.216.179])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MwoNS-0003fa-E5
	for ltp-list@lists.sourceforge.net; Sun, 11 Oct 2009 02:41:46 +0000
Received: by pxi9 with SMTP id 9so7756063pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Sat, 10 Oct 2009 19:41:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200910102202.38970.vapier@gentoo.org>
References: <364299f40910091048w54ece725l2b07a04bb82f6a4f@mail.gmail.com>
	<200910101834.26319.vapier@gentoo.org>
	<364299f40910101601s6f868506k24aab4356a03fcd6@mail.gmail.com>
	<200910102202.38970.vapier@gentoo.org>
Date: Sat, 10 Oct 2009 19:41:36 -0700
Message-ID: <364299f40910101941w3bef8a8ewf1de03a680f5ad1e@mail.gmail.com>
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

On Sat, Oct 10, 2009 at 7:02 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Saturday 10 October 2009 19:01:06 Garrett Cooper wrote:
>> On Sat, Oct 10, 2009 at 3:34 PM, Mike Frysinger <vapier@gentoo.org> wrot=
e:
>> > also, it seems like the lib subdir is missing a default dependency on =
the
>> > libltp.a library:
>> > $ cd lib
>> > $ make clean
>> > rm -f -f libltp.a *.o *.pyc
>> > $ make
>> > make: Nothing to be done for `install'.
>> > $ make libltp.a
>> > <correct output>
>> >
>> > actually, now that i see this output, i guess the problem is that the
>> > default target is "install" instead of "all" (which implies compiled
>> > local objects only) ?
>>
>> Ok, that's what I figured. Fixing right now and will be done in <15 mins.
>
> the generic target subdirs all work now, but looks like lib/ is a special
> case. =A0lib.mk sets DEFAULT_GOAL to "install" which is no good. =A0if i =
drop the
> line, then whatever the first target declared is used as the default. =A0=
this
> can be a little weird with how files are included, so changing this to "a=
ll"
> gets expected behavior.
>
> will the other .mk have similar problems ? =A0should we set DEFAULT_GOAL =
to all
> in env_pre.mk so people dont have to worry about ordering ?

Done.
Thanks!
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
