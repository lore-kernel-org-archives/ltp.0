Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N6ZXU-0003gT-Bb
	for ltp-list@lists.sourceforge.net; Sat, 07 Nov 2009 00:52:24 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N6ZXS-0007bK-5p
	for ltp-list@lists.sourceforge.net; Sat, 07 Nov 2009 00:52:24 +0000
Received: by pzk26 with SMTP id 26so1028580pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 06 Nov 2009 16:52:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200911061923.09848.vapier@gentoo.org>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911061809.05115.vapier@gentoo.org>
	<20091106233422.GB6619@count0.beaverton.ibm.com>
	<200911061923.09848.vapier@gentoo.org>
Date: Fri, 6 Nov 2009 16:52:16 -0800
Message-ID: <364299f40911061652l5cf3ac19h696152cdfebb547d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP 20091031 Makefiles totally broken?!?
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

On Fri, Nov 6, 2009 at 4:23 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Friday 06 November 2009 18:34:22 Matt Helsley wrote:
>> On Fri, Nov 06, 2009 at 06:09:04PM -0500, Mike Frysinger wrote:
>> > On Friday 06 November 2009 18:02:31 Matt Helsley wrote:
>> > > On Fri, Nov 06, 2009 at 03:09:02PM -0400, Mike Frysinger wrote:
>> > > > also, i thought we were going to rename the top level Makefile to
>> > > > GNUmakefile and add a dummy Makefile that just spat out "sorry, ltp
>> > > > requires GNU make".
>> > >
>> > > Bleh. Can't we just check the output of $(MAKE) --version rather than
>> > > assume other makes use "Makefile"?
>> >
>> > the assumption is that only GNU make parses "GNUmakefile". =A0i think
>> > that's a pretty safe assumption.
>>
>> Right, but GNU Make also parses Makefile.
>
> not if a GNUmakefile exists in the same dir, or the user forces the issue=
 via
> the -f flag
>
>> If some poor bastard runs:
>>
>> make -f Makefile
>>
>> where GNU Make is "make" they may be further confused. Seems like it's
>> better to check what's actually running ($(MAKE)) or will run
>> (like `which make` in configure) than rely on a filename hack like this.
>
> said poor bastard should be smacked :p. =A0checking the value of $(MAKE) =
wont
> work as it could be an arbitrary number of things which could all be valid
> values under GNU make. =A0configure checks wont matter because it's the u=
ser who
> runs `make` or `gmake` or `make-some-noise`. =A0requiring `make` to be GN=
U make
> in configure when the user can easily run `gmake` at make time is pointle=
ss
> user interference.
>
> using a different filename on the other hand is exactly what GNU make has
> designed in from the get go specifically for this purpose -- when GNU mak=
e is
> required. =A0if you honestly think people are doing something pointless l=
ike
> `make -f Makefile`, then it's trivial to add a check to it to (1) check
> $(MAKE) --version and include GNUmakefile or (2) $(error out). =A0no poin=
t in
> forcing the shell/etc... overhead in the default build for the majority of
> users.

No, but you can do something like:

ifdef MAKE_SANITY_CHECK
export MAKE_SANITY_CHECK =3D 1
ifneq ($(lastword $(sort 3.80 $(MAKE_VERSION))),$(MAKE_VERSION))
$(error Upgrade your junk..)
endif
endif

that way it only executes this once.

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
