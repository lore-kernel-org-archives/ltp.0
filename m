Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Eddy@quicksall.com>) id 1N8aj7-0005MO-DJ
	for ltp-list@lists.sourceforge.net; Thu, 12 Nov 2009 14:32:45 +0000
Received: from fmailhost04.isp.att.net ([204.127.217.104])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N8aiz-0002GV-J5
	for ltp-list@lists.sourceforge.net; Thu, 12 Nov 2009 14:32:45 +0000
From: "Eddy Quicksall" <Eddy@Quicksall.com>
References: <4AFBCBBC.9090207@linux.vnet.ibm.com>
	<1258026859.4866.8.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1258026859.4866.8.camel@subratamodak.linux.ibm.com>
Date: Thu, 12 Nov 2009 09:32:23 -0500
Message-ID: <002001ca63a4$f3c54aa0$db4fdfe0$@com>
MIME-Version: 1.0
Content-Language: en-us
Subject: Re: [LTP] installing ltp-devel-2.0-0.0.i386.rpm
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, 'Peter Oberparleiter' <oberpar@linux.vnet.ibm.com>

Quick question before I start off on the wrong track. What I need is a
program that will allow me to test my SCSI target. I will need to have
control over the CDBs and TMFs. Will LTP Tools allow me to do that?

Eddy

-----Original Message-----
From: Subrata Modak [mailto:subrata@linux.vnet.ibm.com] 
Sent: Thursday, November 12, 2009 6:54 AM
To: Eddy Quicksall
Cc: ltp-list@lists.sourceforge.net; Peter Oberparleiter
Subject: Re: installing ltp-devel-2.0-0.0.i386.rpm

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
>
----------------------------------------------------------------------------
--
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008
30-Day 
> trial. Simplify your report design, integration and deployment - and focus
on 
> what you do best, core application coding. Discover what's new with
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> plain text document attachment (Attached Message Part)
> _______________________________________________
> Ltp-coverage mailing list
> Ltp-coverage@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-coverage
> 
>
----------------------------------------------------------------------------
--
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008
30-Day 
> trial. Simplify your report design, integration and deployment - and focus
on 
> what you do best, core application coding. Discover what's new with
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________ Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
