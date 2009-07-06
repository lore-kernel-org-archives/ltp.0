Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MNs3W-0001Ts-F7
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 17:32:42 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNs3D-0003ba-A9
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 17:32:37 +0000
Received: by yxe33 with SMTP id 33so4897968yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 10:32:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907022342.59078.vapier@gentoo.org>
References: <364299f40907021746p3ce4bacdwbfc834ef7e4cfcfd@mail.gmail.com>
	<200907022245.43330.vapier@gentoo.org>
	<364299f40907022027n5f9ee24as262417392ed5bbf2@mail.gmail.com>
	<200907022342.59078.vapier@gentoo.org>
Date: Mon, 6 Jul 2009 10:32:21 -0700
Message-ID: <364299f40907061032x1cd632bem368a4a1109583e86@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 8/10] config.mk not required for clean
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Thu, Jul 2, 2009 at 8:42 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Thursday 02 July 2009 23:27:52 Garrett Cooper wrote:
>> On Thu, Jul 2, 2009 at 7:45 PM, Mike Frysinger wrote:
>> > how about we aim for avoiding the include completely regardless of
>> > target. really config.mk is setting up the environment and recursive
>> > makes should be inheriting those. =A0so if our toplevel .mk exported
>> > something like: LTP_CONFIG_INCLUDED =3D yes
>> >
>> > then all the fragments in the sub-makefiles should look like:
>> > ifneq ($(LTP_CONFIG_INCLUDED),yes)
>> > include $(topdir)/config.mk
>> > endif
>> >
>> > then you could have the clean target lie by doing:
>> > $(MAKE) -C testcases LTP_CONFIG_INCLUDED=3Dyes clean
>> >
>> > which would address all of your concerns ?
>>
>> Yes. That's sort of the concern that I was going for with my previous
>> spin, but then it turned into a gob of Makefile.inc files that were
>> being added unnecessarily to the SCM. Considering that the include
>> file is only needed for files that include config.mk (which are a
>> small handful -- 10 to be exact), I figured that adding the necessary
>> logic to the top would be wise.
>
> today it is 10, but ideally this is the format we'll be moving to
> -mike

Yes. I'm respinning this diff today as one file, and I'll be
submitting other patches today sometime before 8pm PST as well, which
will mark the initial evolution of the Make system provided the
feedback that you gave me.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
