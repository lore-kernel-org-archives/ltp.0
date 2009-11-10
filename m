Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N7l0O-0006FZ-DS
	for ltp-list@lists.sourceforge.net; Tue, 10 Nov 2009 07:19:08 +0000
Received: from mail-vw0-f171.google.com ([209.85.212.171])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N7l0I-0005dl-0z
	for ltp-list@lists.sourceforge.net; Tue, 10 Nov 2009 07:19:08 +0000
MIME-Version: 1.0
In-Reply-To: <200911091519.56866.vapier@gentoo.org>
References: <1257220567.10382.3.camel@munipradeep-laptop>
	<200911091422.07495.vapier@gentoo.org>
	<364299f40911091155t15fbae6am766e5e0b7b53387c@mail.gmail.com>
	<200911091519.56866.vapier@gentoo.org>
Date: Mon, 9 Nov 2009 23:18:56 -0800
Message-ID: <364299f40911092318s6a9dec01oe8c69fc925fe531f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Got warning message on ltp-full-20091031 while running
	./configure
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
Cc: ltp-list <ltp-list@lists.sf.net>

On Mon, Nov 9, 2009 at 12:19 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Monday 09 November 2009 14:55:54 Garrett Cooper wrote:
>> On Mon, Nov 9, 2009 at 11:22 AM, Mike Frysinger wrote:
>> > well, the configure script wasnt really broken before. =A0people just =
cant
>> > handle any sort of warning message and reading the related log files c=
an
>> > be too much.
>>
>> =A0 =A0 I think we're kind of at fault for not having AC_MSG_INFO instead
>> of AC_MSG_WARN, but oh well... AC_MSG_WARN is designed to be terse :].
>
> not sure what you mean. =A0the warning pointed out originally did not come
> directly from us, nor do/did we have any way of controlling it other than
> using a newer version of autoconf ...

Oooooh... ok, Now it all makes sense.
-Garrett

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
