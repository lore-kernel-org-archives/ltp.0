Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MZF57-0000xN-Vj
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 02:21:21 +0000
Received: from mail-qy0-f201.google.com ([209.85.221.201])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MZF50-0003wT-ML
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 02:21:21 +0000
MIME-Version: 1.0
In-Reply-To: <8368651DACC1964480F951191B94A078F8A312@svexch01.mvista.com>
References: <d51f89b0908032310k20c3843am7ea069d03436a7a@mail.gmail.com>
	<1249387637.15587.29.camel@subratamodak.linux.ibm.com>
	<d51f89b0908040516i7c65740bi3e30e0972c8374fa@mail.gmail.com>
	<4A7A9DFB.7050305@petalogix.com>
	<8368651DACC1964480F951191B94A078F8A312@svexch01.mvista.com>
Date: Thu, 6 Aug 2009 19:21:09 -0700
Message-ID: <364299f40908061921i39ad3e51q4aeffc666166c496@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Issue with rt_sigqueueinfo testcase in LTP.
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list <ltp-list@lists.sf.net>, rohit verma <rohit.170309@gmail.com>

On Thu, Aug 6, 2009 at 5:50 PM, Henry Yei<hyei@mvista.com> wrote:
> Yes, I had just noticed this as well. =A0Since it was "passing", it took =
awhile to spot.
>
> Returning pass even with tst_resm(TFAIL,.. Being called must have somethi=
ng to do with the forking, but I'm not familiar with how the LTP framework =
deals with that.

I don't think that's the problem. I think that the real problem is how
the testcase itself is written, because I don't see any code that
checks WIFEXITED and WIFSIGNALED (I would check for both those items
when doing sigqueue), and I don't see where the child(ren) actually
exit... HMMM...

Thoughts?
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
