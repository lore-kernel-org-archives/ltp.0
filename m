Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N6VNI-0008Et-Sf
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 20:25:36 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N6VNB-0001PU-4F
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 20:25:36 +0000
Received: by pwi18 with SMTP id 18so875594pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Fri, 06 Nov 2009 12:25:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20091106195940.GH819@basil.fritz.box>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911060616.40305.vapier@gentoo.org>
	<20091106130906.GW31511@one.firstfloor.org>
	<200911060821.40182.vapier@gentoo.org>
	<364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
	<20091106191343.GC819@basil.fritz.box>
	<20091106194335.GB32249@refried.org>
	<20091106195940.GH819@basil.fritz.box>
Date: Fri, 6 Nov 2009 12:25:23 -0800
Message-ID: <364299f40911061225k2e359ae0w4466a571261e96e@mail.gmail.com>
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

On Fri, Nov 6, 2009 at 11:59 AM, Andi Kleen <andi@firstfloor.org> wrote:
> On Fri, Nov 06, 2009 at 02:43:35PM -0500, Nate Straz wrote:
>> On Nov =A06 20:13, Andi Kleen wrote:
>> > > So yes, there are known issues with using make versions <3.81. The
>> >
>> > For me it seems more the known issue is in the Makefile. 3.80
>> > is a widely used Make version.
>> >
>> > > reason being that some macros and functions that I use to determine
>> > > absolute path, etc were not available in make 3.80.
>> >
>> > Most of my infrastructure in test systems is based on SUSE 10.0
>> > and it's impractical to upgrade make everywhere.
>>
>> openSUSE 10.3 does include make-3.81. =A0I hope upgrading to the latest
>> point release won't disrupt your test systems.
>
> It does; anything udev based has unacceptable boot time penalty
> with nfsroot. That's why they are still on 10.0.

Andi,
    You can actually cross-compile, use out-of-build-tree and
bootstrap the system so it can effectively netboot with LTP installed.
This is something that we're doing in Cisco today, and it's something
I highly recommend doing -- especially if you have higher quality
hardware with newer OS'es doing the building for you.
    Granted, it does require more work setting everything up from
scratch, but once the work is done, it's a lot easier as far as
long-term maintenance is concerned if you're developing regularly on a
particular revisioned code-base.
    I'm more than happy to provide solutions, but they need to be
functional, stable, and easy-to-maintain longterm. Providing hacks for
make 3.80 isn't necessarily a good thing for the project to support
and it may not even solve your problem 100% (you may run into
stability issues using $(shell readlink -f "") instead of $(abspath ).
Then it comes back to tools -- I'm basically going to have to write
checks in autoconf to make sure that readlink does as planned (isn't
broken), and it's going to be more painful for you performance wise to
have this hack in place, as opposed to just having an upgraded version
of make, which also has resolved several bugs between 3.80 and 3.81.
HTH,
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
