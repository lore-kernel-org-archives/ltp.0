Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M7Och-0007gx-VH
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 06:52:55 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M7Ocd-0001jX-O0
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 06:52:55 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4M6ggkn008164
	for <ltp-list@lists.sourceforge.net>; Fri, 22 May 2009 02:42:42 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4M6qp7I224494
	for <ltp-list@lists.sourceforge.net>; Fri, 22 May 2009 02:52:51 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4M6qpR6027879
	for <ltp-list@lists.sourceforge.net>; Fri, 22 May 2009 02:52:51 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <522C1DF17AF50042AD8AE87F7887BD3D0158B35583@exch.hq.tensilica.com>
References: <522C1DF17AF50042AD8AE87F7887BD3D0158B35583@exch.hq.tensilica.com>
Date: Fri, 22 May 2009 12:22:40 +0530
Message-Id: <1242975161.8760.15.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Detect test results more accurately
	when	generating HTML
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
To: Marc Gauthier <marc@tensilica.com>, rohit verma <rohit.170309@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Thu, 2009-05-21 at 01:13 -0700, Marc Gauthier wrote: 
> Hi, my first patch to this list.  Actually not a patch,
> but the files themselves, to avoid line-wrapping issues
> and because the diff is twice the size of the new file.
> 
> -Marc

Thanks Marc.

Rohit,

Can you test this and see if these solves the problem that you were
discussing for long ?

Regards--
Subrata

> 
> 
> -----------
> Detect test results more accurately when generating HTML
> 
> Process test output lines that appear between <<<test_end>>>
> and the following <<<test_start>>>.  Assign to the preceding
> test where the name matches, else to the following test.
> 
> If a single test has multiple types of results (e.g. both
> FAIL and WARN), report only the most significant one, to
> avoid mis-computing the total number of PASS tests or
> total counts that don't add up to the number of tests.
> 
> If a test's output has no explicit result (PASS, FAIL, etc),
> look at the exit value to determine whether it passed.
> 
> Setting the SHOW_UNRESOLVED environment variable to 1
> classifies as UNRESOLVED any test with no explicit result
> and a zero exit code.
> 
> Setting the SUMMARY_OUTPUT environment variable to 1
> causes only one line of output per test to be shown, for a
> tighter page that allows quickly scanning the results.
> 
> Show percentage of each result type in summary section.
> 
> Simplify parsing a bit.
> 
> Signed-off-by:  Marc Gauthier <marc@tensilica.com>
> 
> ------------------------------------------------------------------------------
> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
> is a gathering of tech-side developers & brand creativity professionals. Meet
> the minds behind Google Creative Lab, Visual Complexity, Processing, & 
> iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
> Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
