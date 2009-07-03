Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMZRN-0004h5-6g
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 03:27:57 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMZRI-0006By-S4
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 03:27:57 +0000
Received: by yxe33 with SMTP id 33so1983492yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 20:27:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907022245.43330.vapier@gentoo.org>
References: <364299f40907021746p3ce4bacdwbfc834ef7e4cfcfd@mail.gmail.com>
	<200907022157.30535.vapier@gentoo.org>
	<364299f40907021900q5a9529favc07f84cd4ffd0d6a@mail.gmail.com>
	<200907022245.43330.vapier@gentoo.org>
Date: Thu, 2 Jul 2009 20:27:52 -0700
Message-ID: <364299f40907022027n5f9ee24as262417392ed5bbf2@mail.gmail.com>
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

On Thu, Jul 2, 2009 at 7:45 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Thursday 02 July 2009 22:00:41 Garrett Cooper wrote:
>> On Thu, Jul 2, 2009 at 6:57 PM, Mike Frysinger<vapier@gentoo.org> wrote:
>> > On Thursday 02 July 2009 21:21:06 Garrett Cooper wrote:
>> >> Both sinclude and include are possible I suppose, but as far as I
>> >> understand that actually does an fstat, tries to open the file, etc,
>> >> but this completely ignores the include statement and reduces I/O a b=
it.
>> >
>> > yes, it'll remove a syscall or two, but i dont think that is significa=
nt
>> > in the larger scheme of things
>> >
>> > the problem is that i dont want these kind of ifdef things propagating=
 as
>> > they'll get tweaked and go inconsistent all over the place
>> >
>> > how about include a top level .mk file that always exists and in there,
>> > you have the conditional config.mk include
>>
>> I couldn't agree more :)...
>>
>> FWIW using include all over the place has footprint implications
>> (somewhere on the order of 2~3 times longer when taxing the fs a bit
>> more), so it could be a boon to multijob compiles to go with sinclude
>> / -include.
>
> well, if you can see tangible differences, then it's worth discussing. =
=A0i dont
> think the include style would make a difference in this regard at all, it=
'd
> only change the behavior when the file doesnt exist (warn/error/etc...).

Yeah, but I'm trying to make maximize compiles while maximizing
repeatability. Hence, that's why there are comments in some of the
files about srcdir :)...

> how about we aim for avoiding the include completely regardless of target.
> really config.mk is setting up the environment and recursive makes should=
 be
> inheriting those. =A0so if our toplevel .mk exported something like:
> LTP_CONFIG_INCLUDED =3D yes
>
> then all the fragments in the sub-makefiles should look like:
> ifneq ($(LTP_CONFIG_INCLUDED),yes)
> include $(topdir)/config.mk
> endif
>
> then you could have the clean target lie by doing:
> $(MAKE) -C testcases LTP_CONFIG_INCLUDED=3Dyes clean
>
> which would address all of your concerns ?

Yes. That's sort of the concern that I was going for with my previous
spin, but then it turned into a gob of Makefile.inc files that were
being added unnecessarily to the SCM. Considering that the include
file is only needed for files that include config.mk (which are a
small handful -- 10 to be exact), I figured that adding the necessary
logic to the top would be wise.

>> People already complain about compiling LTP in my group -- I'm just
>> trying to give them less of a reason to complain :)..
>
> bah, tell them to build it in a tmpfs partition then ;)

Best reasoning I've heard all week :D.

There's an accidentally bug with pathing in my diff (that wasn't
exposed because it was just using in the CFLAGS section) that I'm
going to fix and resubmit patches for tomorrow after doing more
extensive development and testing on my Gentoo box at home.

More changes coming down the pike soon (tomorrow) as well...

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
