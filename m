Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7Rp-00036S-9f
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:58:09 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7Rj-0006sB-6G
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:58:04 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1238579182.6065.40.camel@subratamodak.linux.ibm.com>
References: <49D30905.2010807@cs.unc.edu>
	<1238579182.6065.40.camel@subratamodak.linux.ibm.com>
Date: Tue, 23 Jun 2009 20:18:52 +0530
Message-Id: <1245768533.4860.62.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] LTP scheduler testing
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
To: Mac Mollison <mollison@cs.unc.edu>
Cc: ltp-list <ltp-list@lists.sf.net>

On Wed, 2009-04-01 at 15:16 +0530, Subrata Modak wrote: 
> Hi Mac,
> 
> On Wed, 2009-04-01 at 02:26 -0400, Mac Mollison wrote:
> > Hi,
> > 
> > I'm working with a group researching real-time systems at the University
> > of North Carolina at Chapel Hill. I'm writing a testing framework for a
> > linux kernel scheduler patch called LITMUS^RT, which allows us to test
> > out various scheduling policies that are not in the normal kernel. I'm

Are you still working on this ? And, can you share the tests with us ?

Regards--
Subrata

> 
> Good to know about your work.
> 
> > also writing a paper about my efforts. I have a few questions...
> > 
> > 1) Have any papers been published discussing LTP's testing of the Linux
> > kernel scheduler (including the real-time parts)?
> 
> Nope. Papers have been published about the general testing (including
> schedulers) through LTP, but, nothing specific to Schedulers alone.
> 
> > 
> > 2) As far as I can tell, the LTP is not concerned with testing that some
> > scheduling policy is followed, but just that the scheduler is 'working'.
> 
> True. We are concerned only about that the scheduler that your kernel is
> built/enabled/booted with is working fine. And you can verify whether
> any subsequent kernel commits has introduced any significant regression.
> 
> > For example, you wouldn't be trying to ensure that the completely fair
> > scheduler is actually completely fair, just that it appears to be
> > scheduling things properly. Is this correct? (My research is more
> > interested in whether or not a theoretical scheduling policy is being
> > followed in practice, not whether or not it "works" for the end user.)
> 
> I would be also interested in getting your work tested by the LTP
> community. We would be really interested in something like:
> 
> 1) Determine which scheduling policy is employed in the running kernel
> (through /boot/config* or /pros/config*),
> 2) Then invoke the corresponding testcase to find whether the job is
> being done correctly.
> 
> > 
> > 3) Are you aware of other projects which have done work on testing
> > scheduling in linux, or any published papers on the topic?
> 
> We have the REALTIME tests in LTP, which measures all those aspects, but
> only for the RT kernel. You can check them out here. Hope this helps:
> 
> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/realtime,
> 
> Regards--
> Subrata
> 
> > 
> > Thanks so much for your time and help!
> > 
> > Mac Mollison
> > 
> > 
> > 
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
