Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7UB-0008KS-SJ
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:00:35 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7U4-0001wC-QU
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:00:30 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NEr6I0025467
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 08:53:06 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NF0JlI138960
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:00:21 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NF0F5x020171
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:00:15 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200905200534.n4K5YZnD028353@e32.co.us.ibm.com>
References: <200905200534.n4K5YZnD028353@e32.co.us.ibm.com>
Date: Tue, 23 Jun 2009 20:19:07 +0530
Message-Id: <1245768547.4860.66.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Contribution to LTP
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
To: Praveen <praveen@primesoftsolutionsinc.com>
Cc: ltp-list@lists.sourceforge.net, 'Nathan Straz' <nstraz@redhat.com>, 'Nate Straz' <nate@refried.org>

On Wed, 2009-05-20 at 11:06 +0530, Praveen wrote: 
> Hi Subrata,
> 
> Thanks for the information.
> 
> I am sure LTP will satisfy my enthusiasm to participate in Opensource.

Hi Praveen,

Have you found anything interesting to start contributing to ?

Regards--
Subrata

> First, I will start with registering to mailing list. 
> 
> Thanks again for the information.
> 
> Thanks, 
> Praveen Kumar k
> PrimeSoft IP Solutions Inc
> 
> Phone : 040-27762986/27762987 
> Skype ID: kpraveen72
> www.primesoftsolutionsinc.com 
> 
> -----Original Message-----
> From: Subrata Modak [mailto:subrata@linux.vnet.ibm.com] 
> Sent: Tuesday, May 19, 2009 4:02 PM
> To: Praveen
> Cc: ltp-list@lists.sourceforge.net; Nate Straz; Nathan Straz
> Subject: Re: [LTP] Contribution to LTP
> 
> Hi Praveen,
> 
> On Tue, 2009-05-19 at 13:43 +0530, Praveen wrote: 
> > Hi,
> > 
> >  
> > 
> > I am a C/Shell scripting Developer. I would like to
> > contribute/participate in LTP.
> > 
> >  
> > 
> > Please let me know, if I have any opportunity to work with LTP.
> 
> You have all the opportunity at your disposal to contribute to LTP. In
> fact, we need lots of volunteers to contribute to LTP. As, beginner, the
> first thing to do is just watch over the mailing list to find out how
> people work. And then there are lots of things in store for you:
> (And, off course, first subscribe to this list and this is available on
> subscription basis, which is free:
> http://sourceforge.net/mail/?group_id=3382),
> 
> 1) Pick up some area in kernel for which tests do not exist in LTP (Of
> course this area should be of your interest). Try to write small tests
> for them and submit to LTP. It would be better if you track
> http://kernelnewbies.org/LinuxChanges for the changes and start with a
> latest stable kernel release,
> 
> 2) Execute the existing LTP tests on all the machines available to you,
> and see if you can hit a LTP/Kernel bug. If it is an LTP issue(s), send
> the corresponding patch to the mailing list for review,
> 
> 3) Make the LTP provision system more better, so that we can be more
> efficient/effective in running these tests. You can also work towards
> making it more automated.
> 
> The present LTP provisioning engine PAN has lots of drawbacks and it is
> old. This needs to be updated, or, replaced with something better.
> Sometime back Nathan Straz posted some comments on it:
> 
> http://fedorahosted.org/collie/
> http://marc.info/?t=122540445800003&r=1&w=2,
> 
> I need somebody, who can do a feasibility analysis of the advantages of
> PAN over collie, and show the fruits of migration from PAN to COLLIE. A
> workable version of the patch would also be welcome. The work would be
> little tough as PAN has stabilized and we would be resisting any changes
> which introduces bug(s) in our existing provisioning environment,
> 
> 4) Another important aspect would be to improve documentation for LTP.
> You can start with by reading individual test cases, understand the code
> (you will be assisted with the minimal existent description, so, do not
> worry), refer to man pages, google, and improve upon the test case(s)
> description. You are free to start from where ever you like.
> 
> You are welcome to LTP and i would hope your enthusiasm does not die
> down soon ;-)
> 
> Regards--
> Subrata
> 
> > 
> >  
> > 
> >  
> > 
> > Thanks,
> > 
> > Praveen Kumar k
> > 
> > PrimeSoft IP Solutions Inc 
> > 
> > Phone: 040-27762986/27762987 
> > 
> > Skype ID: kpraveen72
> > 
> > www.primesoftsolutionsinc.com 
> > 
> >  
> > 
> > 
> >
> ----------------------------------------------------------------------------
> --
> > Crystal Reports - New Free Runtime and 30 Day Trial
> > Check out the new simplified licensing option that enables 
> > unlimited royalty-free distribution of the report engine 
> > for externally facing server and web deployment. 
> > http://p.sf.net/sfu/businessobjects
> > _______________________________________________ Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 
> 
> 


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
