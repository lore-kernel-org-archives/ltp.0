Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MOhTI-0005dR-2x
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 00:26:44 +0000
Received: from an-out-0708.google.com ([209.85.132.240])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOhTC-0001Ub-TG
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 00:26:44 +0000
Received: by an-out-0708.google.com with SMTP id c38so2512422ana.37
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jul 2009 17:26:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907081924.08439.vapier@gentoo.org>
References: <364299f40907061602v3d05964cq31150d97eab75daa@mail.gmail.com>
	<200907081924.08439.vapier@gentoo.org>
Date: Wed, 8 Jul 2009 17:26:37 -0700
Message-ID: <364299f40907081726l2a78728dx957f06cb3c46a986@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/3] Make system enhancements, Draft 1
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

On Wed, Jul 8, 2009 at 4:24 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Monday 06 July 2009 19:02:50 Garrett Cooper wrote:
>> 1. Write up a document on how to use the new Make system
>> (README.mk-devel), so others may assist in the work that we're
>> spearheading at Cisco and contributing back to LTP, and we can begin
>> dropping the adhoc Makefiles.
>> 2. Add master_rules.mk which contains canned rules for environment
>> setup, leaf directories, and trunk directories to reduce Make logic
>> noise in the existing LTP Makefile's. This is a more condensed and
>> straightforward version of the original master_rules.mk file
>> contributed and never integrated into LTP in the past.
>> 3. Add master_include.mk, a file which stands as the defacto include
>> Makefile for all . This was created out of the comment provided by
>> Mike Frysinger w.r.t. a master include file.
>>
>> Note: This patch has been largely tested, but some of the additional
>> functionality and rework in generic_trunk_target needs to be tested
>> more prior to commit; hence it's a Draft 1 patch.
>
> "srcdir" should refer to the current directory's source tree. =A0"top_src=
dir"
> should refer to the top level source tree. =A0building in-tree means srcd=
ir will
> be ".". =A0this is how autotools works and allows for easy out-of-tree
> compilation. =A0same goes for "builddir" and "top_builddir", not this "ob=
jxxx"
> convention.

Ah, ok. Will do -- thanks!

> for the toolchain, do you purposefully only document CC and CFLAGS ?

Where did I do that?

> i'm not familiar with this "MAKEOPTS=3D';'" thing you refer to. =A0what's=
 that all
> about ?

       -r, --no-builtin-rules
            Eliminate use of the built-in implicit rules.  Also clear
out the default list of suffixes for suffix rules.

There isn't a way to disable -r in make-3.81 except by removing it
from MAKEOPTS (that's how it was enabled in our make system at Cisco
in my group). `MAKEOPTS=3D;' is the quick way out. Nasty PITA...

> you list the copyright info twice

Please see my other comment.

> master_rules.mk shouldnt be a '-include' ... we want an error if that doe=
snt
> exist

I only did that to ensure that this commit could go in, irrespective
of PATCH 3/4, but I agree, it should be enabled once both changes are
committed.

> your %.a rule is missing a call to ranlib on the archive

Ok. How do I do that call exactly?

ar [blah]
ranlib [blah]

maybe?

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
