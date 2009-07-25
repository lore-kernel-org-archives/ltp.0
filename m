Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <markver@us.ibm.com>) id 1MUXjS-0005vD-SF
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 03:15:34 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MUXjL-0003WS-0M
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 03:15:34 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6P3A7GP022987
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Jul 2009 23:10:07 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6P3FLLJ223524
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Jul 2009 23:15:21 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6P3CgdV020654
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Jul 2009 23:12:42 -0400
Received: from d01ml096.pok.ibm.com (d01ml096.pok.ibm.com [9.63.10.19])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n6P3CgAH020651
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Jul 2009 23:12:42 -0400
In-Reply-To: <200907242113.36309.vapier@gentoo.org>
References: <OFE8FAC2C8.7B8ECD5A-ON852575FD.0081EDEC-852575FD.00837054@us.ibm.com>
	<200907242113.36309.vapier@gentoo.org>
Message-ID: <OF4ACEB620.6D41DA11-ON852575FE.001180EF-852575FE.0011E218@us.ibm.com>
From: Mark Ver <markver@us.ibm.com>
Date: Fri, 24 Jul 2009 23:15:19 -0400
MIME-Version: 1.0
Subject: Re: [LTP] hardware requirements
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8215672051018807533=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8215672051018807533==
Content-type: multipart/alternative; 
	Boundary="0__=0ABBFF6DDF82067F8f9e8a93df938690918c0ABBFF6DDF82067F"
Content-Disposition: inline

--0__=0ABBFF6DDF82067F8f9e8a93df938690918c0ABBFF6DDF82067F
Content-type: text/plain; charset=US-ASCII

> > Is there an agreed upon set of hardware requirements (memory, disk
space,
> > etc.) for running, if not all tests, at least the default testcases
> > executed by runltp?
>
> not really
>
> > Also, if not very knowledgeable of hardware, is there an easy way to
tell
> > if a particular test will run on a target platform or not?  For
example, I
> > suspect the DMA_THREAD_DIOTEST7 tests are not expected to run on all
> > architectures.  Is there a way to find out what platforms it does
support?
>
> many of test cases dont care at all about resources.  might be useful to
have
> an embedded doc format so tests that do care about resources can declare
them
> and then a script can run periodically to collect all of them in a
summary
> format.
>
> i'm pretty sure that in the vast majority of cases, the memory size is
the
> only thing that a test may play with.
> -mike

Yeah, I guess I was thinking of tests like hackbench which don't seem to
run well on systems with little memory.  And some of the growfiles tests
seem to be a little sensitive about the amount of free /tmp space.
--0__=0ABBFF6DDF82067F8f9e8a93df938690918c0ABBFF6DDF82067F
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>&gt; &gt; Is there an agreed upon set of hardware requirements (memory, disk space,<br>
&gt; &gt; etc.) for running, if not all tests, at least the default testcases<br>
&gt; &gt; executed by runltp?<br>
&gt; <br>
&gt; not really<br>
&gt; <br>
&gt; &gt; Also, if not very knowledgeable of hardware, is there an easy way to tell<br>
&gt; &gt; if a particular test will run on a target platform or not? &nbsp;For example, I<br>
&gt; &gt; suspect the DMA_THREAD_DIOTEST7 tests are not expected to run on all<br>
&gt; &gt; architectures. &nbsp;Is there a way to find out what platforms it does support?<br>
&gt; <br>
&gt; many of test cases dont care at all about resources. &nbsp;might be useful to have <br>
&gt; an embedded doc format so tests that do care about resources can declare them <br>
&gt; and then a script can run periodically to collect all of them in a summary <br>
&gt; format.<br>
&gt; <br>
&gt; i'm pretty sure that in the vast majority of cases, the memory size is the <br>
&gt; only thing that a test may play with.<br>
&gt; -mike<br>
</tt><br>
<tt>Yeah, I guess I was thinking of tests like hackbench which don't seem to run well on systems with little memory. &nbsp;And some of the growfiles tests seem to be a little sensitive about the amount of free /tmp space.</tt><br>
</body></html>
--0__=0ABBFF6DDF82067F8f9e8a93df938690918c0ABBFF6DDF82067F--



--===============8215672051018807533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============8215672051018807533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8215672051018807533==--


