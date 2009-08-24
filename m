Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MfiyP-0006Ph-P9
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 23:29:13 +0000
Received: from qw-out-2122.google.com ([74.125.92.25])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MfiyI-0000uP-Vb
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 23:29:13 +0000
MIME-Version: 1.0
In-Reply-To: <d51f89b0908240516n1b4ca28m988feb00f077fbd7@mail.gmail.com>
References: <d51f89b0908240516n1b4ca28m988feb00f077fbd7@mail.gmail.com>
Date: Mon, 24 Aug 2009 16:29:01 -0700
Message-ID: <364299f40908241629x7dcfcbc2sdb2322198b7b729c@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Patch for smt_smp_affinity
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: rohit verma <rohit.170309@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Mon, Aug 24, 2009 at 5:16 AM, rohit verma<rohit.170309@gmail.com> wrote:
> Dear Subrata,
>
> smt_smp_ affinity test case is passing on Fedora but fails on Ubuntu
> for the same H/W.On Ubuntu system, after doing strace i observed that
> system call sched_getaffinity was returning -1 [ERROR:EINVAL] due to
> second argument.
>
> sched_getaffinity(pid, sizeof(unsigned int), &mask1)
>
> Please find attached herewith the patch which fixes the issue.

Rohit,
    Good catch -- one style note though: tst_resm doesn't require a
"\n" because that's automatically appended to each message.
Thanks,
-Garrett

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
