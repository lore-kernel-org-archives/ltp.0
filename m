Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N6WqN-0002oZ-Cd
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 21:59:43 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N6WqH-00063e-3w
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 21:59:43 +0000
Received: by pwi18 with SMTP id 18so917204pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Fri, 06 Nov 2009 13:59:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20091106214558.GJ819@basil.fritz.box>
References: <20091106095745.GA25377@basil.fritz.box>
	<364299f40911061225k2e359ae0w4466a571261e96e@mail.gmail.com>
	<20091106210225.GI819@basil.fritz.box>
	<200911061612.11199.vapier@gentoo.org>
	<20091106214558.GJ819@basil.fritz.box>
Date: Fri, 6 Nov 2009 13:59:31 -0800
Message-ID: <364299f40911061359v1e59fb0ct7b990da3edf655ea@mail.gmail.com>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>, Nate Straz <nate@refried.org>

On Fri, Nov 6, 2009 at 1:45 PM, Andi Kleen <andi@firstfloor.org> wrote:
> On Fri, Nov 06, 2009 at 04:12:10PM -0500, Mike Frysinger wrote:
>> On Friday 06 November 2009 16:02:25 Andi Kleen wrote:
>> > I'm also highly surprised that this doesn't work with autoconf -- I th=
ought
>> > the whole point of autoconf was to generate portable makefiles, but
>> > in this case it seems to especially generate a non portable Makefile.
>>
>> that is not the point of autoconf at all; it has nothing to do with make=
files.
>> that is the point of automake -- which we specifically are not using. =
=A0there
>> are way too many Makefiles that would need to be generated.
>
> True. So you guys just managed to write a very non portable Makefile on y=
our
> own. =A0Congratulations.
>
> I tried to debug the problem, but it's such a maze that I gave up.
>
> It seems to be related to abs_top_builddir not getting expanded correctly.
>
> I suspect simply expanding some of the filter magic rules manually
> might fix it.

In summary, some of the built-in functions in 3.80 aren't implemented
/ don't work period. I need to go back and look at the documentation
and do a side-by-side comparison, but I remember that a developer
emails the help-make@gnu.org list some time back and one of the
primary Gnu make developers just flat out told him to upgrade from
3.80 to 3.81... However, we have a smaller userbase and thus I think
that we can fill in the functional gaps.

$(abspath $(FOO)) only exists in 3.81+, along with some of the other
built-in functions IIRC. Replacing $(abspath ) with $(shell readlink
-f "$(FOO)" 2>/dev/null) is possible, but there are some associated
issues with that solution:

1. They must have readlink
1. It may fail if their shell is toast (in this case, they're kind of SoL).
2. It may fail if their's a bug (that's my job to fix).

It's bad practice to use $(shell ) because it also consumes a lot more
resources allocating a separate shell, and all that badness associated
with it.

If $(patsubst ) is toast, then I'll have to replace it with $(shell )
call to awk or perl.

This can be done, and I'll work on it on Sunday and Monday. I need to
get back to my $JOB because unfortunately I have a test work to
complete.

I really do appreciate the feedback. As I stated before though, 3.80
is where we need to draw the line in the sand, because 3.79 is a
buggy, ancient PoS, so RHEL 4 users and other users of distros around
that era will _need_ to compile 3.80, or 3.81 and install it on their
target systems.

Thanks,
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
