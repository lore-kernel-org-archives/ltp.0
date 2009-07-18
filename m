Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSGgS-00051o-8R
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 20:39:04 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSGgN-0002wZ-Hj
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 20:39:04 +0000
Received: by pzk8 with SMTP id 8so1230173pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 18 Jul 2009 13:38:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907151257.54936.vapier@gentoo.org>
References: <364299f40907112253s6edf39b2m5c6aa5aeb8ed2f5d@mail.gmail.com>
	<200907151257.54936.vapier@gentoo.org>
Date: Sat, 18 Jul 2009 13:38:58 -0700
Message-ID: <364299f40907181338j1ae91378k842c799b30027d46@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Patches respin done;
	waiting for approval ACK before 	continuing...
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

On Wed, Jul 15, 2009 at 9:57 AM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Sunday 12 July 2009 01:53:55 Garrett Cooper wrote:
>> =A0 =A0 I have a lot of other modified Makefiles, but I'm waiting for an
>> ACK from developers (most notably Matt and Mike) before continuing,
>> and I'll need to do a final test run before commit. The patches will
>> be large, but similar from here on out...
>
> the current patch series is confusing at best due to the numbering in the
> subject and random relationship noted in each patch. =A0i really havent a=
 clue
> how they're fitting together, i'm just reviewing each by itself and assum=
ing
> they fit together somehow. =A0after the next set of review, please do 1 t=
hread
> with all the patches in it (no need to declare their order since they're =
going
> in as a set):
> - respin summary
> =A0 =A0 =A0 =A0|- refactor....
> =A0 =A0 =A0 =A0|- enhancements....
> =A0 =A0 =A0 =A0`- autoconf.....

    Yeah... that was my intent. I was just trying to make the
changeset a bit easier to digest during review...
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
