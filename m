Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M8wAH-0002VS-4u
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2009 12:53:57 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M8wAF-0001Uw-OE
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2009 12:53:57 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4QCMKCi026548
	for <ltp-list@lists.sourceforge.net>; Tue, 26 May 2009 06:22:20 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4QCMv67208160
	for <ltp-list@lists.sourceforge.net>; Tue, 26 May 2009 06:22:57 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4QCMv6h010189
	for <ltp-list@lists.sourceforge.net>; Tue, 26 May 2009 06:22:57 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A1BB9F6.6050107@cn.fujitsu.com>
References: <4A166FB6.6010208@cn.fujitsu.com>
	<1243268093.6752.24.camel@subratamodak.linux.ibm.com>
	<4A1BB9F6.6050107@cn.fujitsu.com>
Date: Tue, 26 May 2009 17:52:52 +0530
Message-Id: <1243340572.6293.23.camel@subratamodak.linux.ibm.com>
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

On Tue, 2009-05-26 at 17:44 +0800, Wei Yongjun wrote: 
> Subrata Modak wrote:
> > On Fri, 2009-05-22 at 17:26 +0800, Wei Yongjun wrote: 
> >   
> >> recently kernel commit e7b9b550f53e81ea38e71d322d6f95730df058a2
> >> has removed the file get code. The execve syscall will never
> >> return EMFILE.
> >>
> >> Call to execve() will be suceess even if the the process has the
> >> maximum number of files open, because execve() never open any file.
> >>
> >> Can anyone tell me what does this test case test for? It be wrote
> >> base on which document? Just the man page?
> >>     
> >
> > * DESCRIPTION
> > *      Testcase to check execve(2) sets errno to EMFILE correctly
> > *
> > * ALGORITHM
> > *      Get the configured file descriptor table size. open(2) files to
> > fill
> > *      up the file descriptor table. Once file descriptor table is full,
> > *      an attempt to execve(2) any other executable fails with EMFILE.
> >
> > is what the source description says. Can you please execute the test
> > against that kernel commit and share the results with/without commits ?
> >   
> 
> Test without that commit:
> # ./execve04 -F ./test3
> execve04 1 PASS : Expected failure - 24 : Too many open files
> 
> Test with that commit:
> # ./execve04 -F ./test3
> <program name unknown>: error while loading shared libraries: libc.so.6:
> cannot open shared object file: Error 24
> execve04 1 FAIL :
> execve(/home/weiyj/ltp/testcases/kernel/syscalls/execve/./test3) failed:
> expected EMFILE(24), got 127 (Key has expired)
> 
> Test with that commit but I compiled test3 with --static:
> # gcc test3.c -o test3 --static
> # ./execve04 -F ./test3
> Hello World
> execve04 1 FAIL :
> execve(/home/weiyj/ltp/testcases/kernel/syscalls/execve/./test3) failed:
> expected EMFILE(24), got 0 (Success)
> 
> The latest kernel do execve(2) without get file descriptor, it only
> need one file struct. It seem that this test is obsoleted.

Lets remove then. Send a patch to do so.

Regards--
Subrata

> 
> 


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
