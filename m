Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N3Znb-0001tM-O3
	for ltp-list@lists.sourceforge.net; Thu, 29 Oct 2009 18:32:39 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N3ZnV-00027b-Hx
	for ltp-list@lists.sourceforge.net; Thu, 29 Oct 2009 18:32:39 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9TIVG3X024027
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Oct 2009 12:31:16 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9TIWHKr169516
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Oct 2009 12:32:18 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9TIWCNO022475
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Oct 2009 12:32:12 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1256576586.4929.60.camel@subratamodak.linux.ibm.com>
References: <364299f40910202206m10020bdg389ee8ab5994a488@mail.gmail.com>
	<1256576586.4929.60.camel@subratamodak.linux.ibm.com>
Date: Fri, 30 Oct 2009 00:02:00 +0530
Message-Id: <1256841120.5210.27.camel@subratamodak.linux.ibm.com>
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

On Mon, 2009-10-26 at 22:33 +0530, Subrata Modak wrote: 
> On Tue, 2009-10-20 at 22:06 -0700, Garrett Cooper wrote: 
> > Hi all,
> >     The LTP signal tests are wonderful, but due to issues in our
> > architecture, there were some unforeseen problems with some signal
> > handling. As such I came up with a test and a C app named `sniperkill'
> > and `killme.c'. sniperkill invokes killme according to a set matrix of
> > signal numbers, according to the signal(7) manpage, verifying that the
> > signal 1) terminates, 2) is ignored, or 3) is terminated producing a
> > coredump. This also exercises the RT signals as well as the standard
> > POSIX and Linux signals.
> >     I verified the results on x86 and they were functional (minus
> > SIGSYS which coredumped unexpectedly -- which means I get to file a
> > bug with kernel.org -- yay!). I penciled in the other architectures as
> > per the manpage, given that the other architectures we test on are
> > clearly mentioned, I'm almost positive the data's in the correct
> > spots, despite the ambiguity in the statement: `the first one is
> > usually valid for alpha and sparc'.
> >     I'm going to try running it on mips* and ppc, but the results
> > won't be 100% sane with our OS platform (I know -- that's why wrote
> > the test :(...).
> >     An example log of my execution on x86_64 is included.
> >     Please let me know if I should add this and where I should add
> > this, so I can check it into the repo and more can benefit from this
> > post-mortem analysis signal tool :).
> > Thanks,
> > -Garrett
> 
> Hey Garret. I feel it should go to a place where it signifies more:
> testcases/kernel/syscalls/kill/

What do you think about my suggestion ?

Regards--
Subrata

> 
> Regards--
> Subrata
> 
> > ------------------------------------------------------------------------------
> > Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> > is the only developer event you need to attend this year. Jumpstart your
> > developing skills, take BlackBerry mobile applications to market and stay 
> > ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> > http://p.sf.net/sfu/devconference
> > _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
