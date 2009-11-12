Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N8YGH-0007tV-K4
	for ltp-list@lists.sourceforge.net; Thu, 12 Nov 2009 11:54:49 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N8YGB-0001sJ-H8
	for ltp-list@lists.sourceforge.net; Thu, 12 Nov 2009 11:54:49 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nACBnA0i032251
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Nov 2009 04:49:10 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nACBsNrJ173268
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Nov 2009 04:54:23 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nACBsNw1025214
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Nov 2009 04:54:23 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AFBCBBC.9090207@linux.vnet.ibm.com>
References: <4AFBCBBC.9090207@linux.vnet.ibm.com>
Date: Thu, 12 Nov 2009 17:24:19 +0530
Message-Id: <1258026859.4866.8.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] installing ltp-devel-2.0-0.0.i386.rpm
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
To: Eddy Quicksall <Eddy@Quicksall.com>
Cc: ltp-list@lists.sourceforge.net, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

Hi Eddy,

On Thu, 2009-11-12 at 09:47 +0100, Peter Oberparleiter wrote:
> Forwarding this to the ltp-list which is better suited to discuss ltp 
> related questions.
> 
> -------- Original Message --------
> Subject: [Ltp-coverage] installing ltp-devel-2.0-0.0.i386.rpm
> Date: Wed, 11 Nov 2009 15:07:09 -0500
> From: Eddy Quicksall <Eddy@Quicksall.com>
> To: <ltp-coverage@lists.sourceforge.net>
> 
> I am new to Linux. I want to use the LTP tools to test my SCSI target. I
> have installed ltp-devel-2.0-0.0.i386.rpm by right clicking on the RPM. It
> said it installed it but I can't figure out where it installed it. Can
> someone give me some help?

As the name suggests, ltp-devel-2.0-0.0.i386.rpm is meant for
development of LTP test cases from any directory of the system. This
RPM :
     1. Installs some header and libraries for the discretely developed
        test cases to compile,
     2. Installs some Man pages for easy LTP test cases development,
     3. And all go inside /opt/ltp/ by default,

I i can understand correctly, you need to test your hardware. For that
you need to download the stable and existing test suite and the latest
from ltp.sf.net, untar it, read the instructions inside the
README/INSTALL carefully, build, install and then run it. Please let us
know for any further clarification.

Regards--
Subrata

> 
> 
> 
> Eddy
> 
> 
> plain text document attachment (Attached Message Part)
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> plain text document attachment (Attached Message Part)
> _______________________________________________
> Ltp-coverage mailing list
> Ltp-coverage@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-coverage
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
