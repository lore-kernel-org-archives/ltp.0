Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1Mavg2-00035j-6v
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 18:02:26 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mavg0-000358-0n
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 18:02:26 +0000
Message-ID: <4A81B227.7020500@canonical.com>
Date: Tue, 11 Aug 2009 13:02:15 -0500
From: Paul Larson <paul.larson@canonical.com>
MIME-Version: 1.0
References: <20090811172957.7074.62874.sendpatchset@subratamodak.linux.ibm.com>
	<20090811173101.7074.31798.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090811173101.7074.31798.sendpatchset@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH 05/05] Add the necessary Interface and Option
 through "runltp"
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

Subrata Modak wrote:
...
> +	-F LOOPS,PERCENTAGE Induce PERCENTAGE Fault in the Kernel Subsystems, and, run each test for LOOPS loop

I haven't had time for an exhaustive review, but here are a few
questions/comments I had:

1. Why introduce yet another looping mechanism within LTP when we
already have one?  Is there an advantage that you see to doing it this
way, rather than just having an additional option that calls the script
to generate this additional random fault injection?

2. Would be good to push the check for /debug being mounted down into
one of the other scripts rather than in runltp.  runltp is already
hideously bloated and this would make it more useful when running
standalone.

3. would be great if there were some way to tag the results to say when
a fault was or was not in the process of being generated.  That is,
perhaps, not possible at this time though.

4. more granularity possible with the fault injections to specify the
type of faults, or optionally, the behaviour you have here?

Thanks,
Paul Larson


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
