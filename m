Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1NF6dd-0004T3-NL
	for ltp-list@lists.sourceforge.net; Mon, 30 Nov 2009 13:50:01 +0000
Date: Mon, 30 Nov 2009 14:50:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091130135024.GA4304@saboteur.suse.cz>
References: <20091116151656.GB16811@schrodinger.suse.cz>
	<20091120125347.GA4858@schrodinger.suse.cz>
	<20091126141346.GA7306@saboteur.suse.cz>
	<364299f40911260622s4e5ae3c5j555b922a7b85f4b0@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f40911260622s4e5ae3c5j555b922a7b85f4b0@mail.gmail.com>
Subject: Re: [LTP] [RFC] utstest.h
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> > I've been looking at sources for usctest.h again today (lib/parse_op=
ts.c) and I
> >> > still have the feeling that this is badly written/broken code and sh=
ould be
> >> > fixed but as there are thousands of tests that uses usctest interfac=
e we should
> >> > be careful when touching these sources. So IMHO the best approach is=
 to change
> >> > one thing at the time and see if this was a good move.
> >> >
> >> > So let's start with TEST_PAUSE macro. Accordingly to comment in the =
header,
> >> > this expands to the code that waits for SIGUSR1 signal (and this is =
not
> >> > generaly true). =A0This macro is expanded to the int usc_global_setu=
p_hook()
> >> > function. The function forks the program accordingly to STD_COPIES a=
nd
> >> > accordingly STD_PAUSE it sleeps for a SIGUSR1 or not (all forked ins=
tances); it
> >> > also changes program segment size with sbrk().
> >> >
> >> > Looking into the test sources, this is called when the test starts i=
n order to
> >> > implement test parameters "-c n" (run n copies concurently) and "-p"=
 (pause
> >> > test) and system variable USC_TP_SBRK. Do we need these parameters o=
r any of
> >> > them? If you convice me that these parameters are usefull I would gl=
adly clean
> >> > up and document code that implements TEST_PAUSE, otherwise I would v=
ote for
> >> > removing them (or at least the useless ones).
> >> >
> >>
> >> Okay, let me put it like this. Are parameters introduced by TEST_PAUSE=
 really
> >> used for anything? Would anybody cry if there where removed? Would be =
patch
> >> removing them accepted and merged into CVS?
> >>
> >
> > Anybody out there? I would really like to clean up and simplify the tes=
t interface.
> =

>     I personally don't see why it should still exist when pan delivers
> this level of functionality, but pan isn't compiled on UCLINUX
> still... besides, I don't make the designed decisions.

Okay, do we have somebody who is in a charge of desing decisions? Or at lea=
st
any mechanism to do that.

-- =

Cyril Hrubis
chrubis@suse.cz

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
