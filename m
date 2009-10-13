Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mxa81-00036m-8h
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 05:40:57 +0000
Received: from mail-px0-f201.google.com ([209.85.216.201])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mxa7u-0007fT-Lj
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 05:40:57 +0000
Received: by pxi39 with SMTP id 39so9596096pxi.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Oct 2009 22:40:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200910130130.30228.vapier@gentoo.org>
References: <364299f40910122222q5117ecf0i854db292154132c7@mail.gmail.com>
	<200910130130.30228.vapier@gentoo.org>
Date: Mon, 12 Oct 2009 22:40:44 -0700
Message-ID: <364299f40910122240p586a60aarc796112b68c519e2@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] convert linktest.pl to linktest.sh
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

On Mon, Oct 12, 2009 at 10:30 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tuesday 13 October 2009 01:22:02 Garrett Cooper wrote:
>> +do_link() {
>> + =A0 =A0 =A0 pfix=3D$1; shift
>> + =A0 =A0 =A0 ln_opts=3D$1; shift
>> + =A0 =A0 =A0 limit=3D$1; shift
>
> any point in shifting ? =A0be simpler to just use $1 $2 $3

No point really -- I'll change that.

>> + =A0 =A0 =A0 cd ${pfix}link; \
>> + =A0 =A0 =A0 while [ $i -lt $limit ]; do \
>
> why the line continuation ?

I deleted that stupidity.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (( lerrors++ ))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (( i++ ))
>> + =A0 =A0 =A0 (( TST_COUNT++ ))
>
> i think you want:
> =A0 =A0 =A0 =A0: $(( TST_COUNT +=3D 1 ))

Ok, dumb question again -- $(( TST_COUNT +=3D 1 )) is the POSIX
compliant method? (( TST_COUNT++ )) works too... (I keep on forgetting
what's POSIX compliant on this item...).

I also fixed a variable not being defined too, which resulted in a cosmetic=
 bug:

        pfix=3D$1; shift
        ln_opts=3D$1; shift
        limit=3D$1; shift
+       prefix_msg=3D$1; shift

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
