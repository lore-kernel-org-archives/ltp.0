Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M8cpN-0006PU-5o
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 16:15:05 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M8cpI-0005Ia-TY
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 16:15:05 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4PG4ieZ002752
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 12:04:44 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4PGF0Es112680
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 12:15:00 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4PGExn3012586
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 12:15:00 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A166FB6.6010208@cn.fujitsu.com>
References: <4A166FB6.6010208@cn.fujitsu.com>
Date: Mon, 25 May 2009 21:44:51 +0530
Message-Id: <1243268093.6752.24.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [QUESTION] about test execve04 which testing for EMFILE
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
To: Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2009-05-22 at 17:26 +0800, Wei Yongjun wrote: 
> recently kernel commit e7b9b550f53e81ea38e71d322d6f95730df058a2
> has removed the file get code. The execve syscall will never
> return EMFILE.
> 
> Call to execve() will be suceess even if the the process has the
> maximum number of files open, because execve() never open any file.
> 
> Can anyone tell me what does this test case test for? It be wrote
> base on which document? Just the man page?

* DESCRIPTION
*      Testcase to check execve(2) sets errno to EMFILE correctly
*
* ALGORITHM
*      Get the configured file descriptor table size. open(2) files to
fill
*      up the file descriptor table. Once file descriptor table is full,
*      an attempt to execve(2) any other executable fails with EMFILE.

is what the source description says. Can you please execute the test
against that kernel commit and share the results with/without commits ?

Regards--
Subrata

> 
> 
> 
> ------------------------------------------------------------------------------
> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
> is a gathering of tech-side developers & brand creativity professionals. Meet
> the minds behind Google Creative Lab, Visual Complexity, Processing, & 
> iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
> Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
