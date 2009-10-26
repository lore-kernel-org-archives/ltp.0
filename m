Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N2SzF-0000Se-8L
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 17:04:05 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N2Sz4-0003dS-TC
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 17:04:00 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9QH1HrI017649
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 11:01:18 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9QH3Zhq150482
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 11:03:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9QH2HjF008926
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 11:02:17 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40910202206m10020bdg389ee8ab5994a488@mail.gmail.com>
References: <364299f40910202206m10020bdg389ee8ab5994a488@mail.gmail.com>
Date: Mon, 26 Oct 2009 22:33:06 +0530
Message-Id: <1256576586.4929.60.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] New test : sniperkill - killing processes from a distance
Reply-To: subrata@linux.vnet.ibm.com
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Tue, 2009-10-20 at 22:06 -0700, Garrett Cooper wrote: 
> Hi all,
>     The LTP signal tests are wonderful, but due to issues in our
> architecture, there were some unforeseen problems with some signal
> handling. As such I came up with a test and a C app named `sniperkill'
> and `killme.c'. sniperkill invokes killme according to a set matrix of
> signal numbers, according to the signal(7) manpage, verifying that the
> signal 1) terminates, 2) is ignored, or 3) is terminated producing a
> coredump. This also exercises the RT signals as well as the standard
> POSIX and Linux signals.
>     I verified the results on x86 and they were functional (minus
> SIGSYS which coredumped unexpectedly -- which means I get to file a
> bug with kernel.org -- yay!). I penciled in the other architectures as
> per the manpage, given that the other architectures we test on are
> clearly mentioned, I'm almost positive the data's in the correct
> spots, despite the ambiguity in the statement: `the first one is
> usually valid for alpha and sparc'.
>     I'm going to try running it on mips* and ppc, but the results
> won't be 100% sane with our OS platform (I know -- that's why wrote
> the test :(...).
>     An example log of my execution on x86_64 is included.
>     Please let me know if I should add this and where I should add
> this, so I can check it into the repo and more can benefit from this
> post-mortem analysis signal tool :).
> Thanks,
> -Garrett

Hey Garret. I feel it should go to a place where it signifies more:
testcases/kernel/syscalls/kill/

Regards--
Subrata

> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
