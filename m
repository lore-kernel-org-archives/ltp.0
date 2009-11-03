Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N5Iz8-0006Sf-MR
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 12:59:42 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N5Iz0-0005oN-SD
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 12:59:42 +0000
Received: by pzk26 with SMTP id 26so3927618pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Nov 2009 04:59:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ab64ec20911030221o71ffbdc9g718e64217ee74b05@mail.gmail.com>
References: <ab64ec20911030221o71ffbdc9g718e64217ee74b05@mail.gmail.com>
Date: Tue, 3 Nov 2009 04:59:28 -0800
Message-ID: <364299f40911030459k78478ddfm766ba8c3ee8cf9a9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] installation problem...
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
To: naveen penumala <naveenspen@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, LTP list <ltp-list@lists.sf.net>

On Tue, Nov 3, 2009 at 2:21 AM, naveen penumala <naveenspen@gmail.com> wrot=
e:
> Hiee...
>
> I was trying to install latest "ltp-full-20091031" on my SUSE linux machi=
ne.
> After configuration (./configure) i was trying to build and install the L=
TP
> using "make ; make install" commands.
>
> But i got below message and LTP is not installing.
>
> make: `testcases/realtime/configure' is up to date.
> make: *** No rule to make target `/$*', needed by `doc-install'.=A0 Stop.
>
> Please suggest me how to over come this installation problem.

Naveen,
    If you're using make 3.79 (you can determine this with make
--version), you must upgrade to 3.81.
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
