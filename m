Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N6Weh-0004kH-JW
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 21:47:39 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N6WeZ-0003Bv-Qr
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 21:47:39 +0000
Received: by pzk26 with SMTP id 26so956782pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 06 Nov 2009 13:47:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20091106210225.GI819@basil.fritz.box>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911060616.40305.vapier@gentoo.org>
	<20091106130906.GW31511@one.firstfloor.org>
	<200911060821.40182.vapier@gentoo.org>
	<364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
	<20091106191343.GC819@basil.fritz.box>
	<20091106194335.GB32249@refried.org>
	<20091106195940.GH819@basil.fritz.box>
	<364299f40911061225k2e359ae0w4466a571261e96e@mail.gmail.com>
	<20091106210225.GI819@basil.fritz.box>
Date: Fri, 6 Nov 2009 13:47:26 -0800
Message-ID: <364299f40911061347h24237df0x23aea3be3dc78b7e@mail.gmail.com>
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

On Fri, Nov 6, 2009 at 1:02 PM, Andi Kleen <andi@firstfloor.org> wrote:
> On Fri, Nov 06, 2009 at 12:25:23PM -0800, Garrett Cooper wrote:
>> =A0 =A0 You can actually cross-compile, use out-of-build-tree and
>> bootstrap the system so it can effectively netboot with LTP installed.
>> This is something that we're doing in Cisco today, and it's something
>> I highly recommend doing -- especially if you have higher quality
>> hardware with newer OS'es doing the building for you.
>
> The hardware I'm using for testing is perfectly capable of
> building LTP itself.
>
>> =A0 =A0 Granted, it does require more work setting everything up from
>> scratch, but once the work is done, it's a lot easier as far as
>> long-term maintenance is concerned if you're developing regularly on a
>> particular revisioned code-base.
>
> I would prefer to not get into any cross compiling mess. It would
> require either static linking or maintenance of a separate build
> tree with own libraries, both have many drawbacks.
>
>> =A0 =A0 I'm more than happy to provide solutions, but they need to be
>> functional, stable, and easy-to-maintain longterm. Providing hacks for
>> make 3.80 isn't necessarily a good thing for the project to support
>
> What hacks?
>
> make 3.80 has build whole distributions with millions of LOCs, it's uncle=
ar
> to me why it shouldn't be able to build LTP too.
>
> I'm pretty sure that not supporting older distributions is very
> necessarily a bad thing.

I agree. There are some feature gaps between 3.80 and 3.81 I'll need
to address, which means I need to first off download SLES 10 and
install it on another VM, and toy around with it (if you can provide
me with those details, I'll give it a shot).

>> and it may not even solve your problem 100% (you may run into
>> stability issues using $(shell readlink -f "") instead of $(abspath ).
>
> I did a quick test of readlink -f and it seems to work here.
>
>> Then it comes back to tools -- I'm basically going to have to write
>> checks in autoconf to make sure that readlink does as planned (isn't
>> broken), and it's going to be more painful for you performance wise to
>> have this hack in place, as opposed to just having an upgraded version
>> of make, which also has resolved several bugs between 3.80 and 3.81.
>
> I don't understand: the key is not to test for commands used
> by makefiles, but simply only use features which are generally available.
>
> I'm also highly surprised that this doesn't work with autoconf -- I thoug=
ht
> the whole point of autoconf was to generate portable makefiles, but
> in this case it seems to especially generate a non portable Makefile.
>
> I suspect it's actually not a autoconf problem by itself, but
> something that's in the LTP templates.

Agreed. The problem that everyone with <3.80 is running into is that I
was stupid and was under the assumption that many distros wouldn't
still use make 3.81 because it's been out for the past 4 years. My
apologies -- I stand corrected.

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
