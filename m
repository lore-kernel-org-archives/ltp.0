Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MXNz7-0002zg-3f
	for ltp-list@lists.sourceforge.net; Sat, 01 Aug 2009 23:27:29 +0000
Received: from rv-out-0708.google.com ([209.85.198.251])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MXNz1-0003Z7-1f
	for ltp-list@lists.sourceforge.net; Sat, 01 Aug 2009 23:27:29 +0000
Received: by rv-out-0708.google.com with SMTP id b17so705360rvf.22
	for <ltp-list@lists.sourceforge.net>;
	Sat, 01 Aug 2009 16:27:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40908011540p1ddaf44eo2a7059d1b793ef85@mail.gmail.com>
References: <364299f40908011540p1ddaf44eo2a7059d1b793ef85@mail.gmail.com>
Date: Sat, 1 Aug 2009 16:27:17 -0700
Message-ID: <364299f40908011627o6fca777x835f9e6d988c588f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Purpose for TCbin, TCsrc, etc?
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
To: LTP list <ltp-list@lists.sourceforge.net>

On Sat, Aug 1, 2009 at 3:40 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> Hi guys,
> =A0 =A0I'm reading through a bunch of scripts, and I'm trying to
> understand what the need is for having TCbin, TCsrc, etc -- is it the
> fact that we have 5~10 different similarly written utilities, crafted
> for a specific purpose, which weren't made generic enough that one
> could essentially `bind them all' to a unified purpose? If so, is
> there any way where we could make an effort to fix these items as soon
> as possible? I've identified some of the issues, but this is something
> that will need to be fixed after the first Makefile cleanup drop
> because it requires some recoding in bourne shell, to which extent I'm
> not entirely sure which scripts need to be fixed, yet. I've included
> the diffs that I was thinking about committing to the
> makefile-infra-rework branch, but will revert for the sake of time.
> =A0 =A0IMO these items should be easy to fix -- they're just not a high
> priority now and the workaround is simple (change the install dir for
> the Makefiles).

Figured out why these variables exist and why these Makefiles suck
(from the CVS comment for the files I just committed):

2. Fix up a number of Makefiles and start a WiP with network/ipv6 and
network/lib6. I now understand why network/ipv6/ // network/tcp_cmds
are so hacked up scripting-wise (look at network/ipv6/Makefile for
more details -- it's a linky hacky mess). Also, need to figure out a
better way to deal with all of this cruddy runcc.a logic -- it really
has no good purpose and should be disposed of.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
