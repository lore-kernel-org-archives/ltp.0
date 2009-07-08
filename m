Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MOc04-0005gh-7U
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 18:36:12 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOc00-0000Nd-2n
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 18:36:12 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1246890698.4887.24.camel@subratamodak.linux.ibm.com>
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com>
	<1224840077.5270.69.camel@subratamodak.linux.ibm.com>
	<alpine.DEB.1.10.0810240749470.25677@gandalf.stny.rr.com>
	<1229093480.5171.60.camel@subratamodak.linux.ibm.com>
	<alpine.DEB.1.10.0812121533350.29763@gandalf.stny.rr.com>
	<1229347938.5353.8.camel@subratamodak.linux.ibm.com>
	<alpine.DEB.1.10.0812150851290.18692@gandalf.stny.rr.com>
	<1245768486.4860.53.camel@subratamodak.linux.ibm.com>
	<alpine.DEB.2.00.0907061024200.8813@gandalf.stny.rr.com>
	<1246890698.4887.24.camel@subratamodak.linux.ibm.com>
Date: Wed, 08 Jul 2009 23:43:53 +0530
Message-Id: <1247076833.5405.48.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] LTP RT Tests (Cyclic, rt-migrate, etc)
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
To: dvhltc <dvhltc@linux.vnet.ibm.com>, Sripathi Kodi <sripathik@linux.vnet.ibm.com>, Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, ltp-list <ltp-list@lists.sf.net>, Gregory Haskins <ghaskins@novell.com>, linux-rt-users <linux-rt-users@vger.kernel.org>, Clark Williams <clark.williams@gmail.com>

Darren/Sri/Gowri,

Where do you want me to put this exactly inside the RT tree ?

Regards--
Subrata

On Mon, 2009-07-06 at 20:01 +0530, Subrata Modak wrote: 
> On Mon, 2009-07-06 at 10:26 -0400, Steven Rostedt wrote:
> > 
> > On Tue, 23 Jun 2009, Subrata Modak wrote:
> > 
> > > Steven,
> > > 
> > > Do you remember this ?
> > 
> > Yes, and I finally got time to fix it up a little ;-)
> 
> Great. Forwarding to the ltp mailing list as well. Thanks steven.
> 
> Regards--
> Subrata
> 
> > 
> > OK, here it is. To run it, just do:
> > 
> >  ./rt-migrate-test -c 
> > 
> > You need to be root since it changes the priorities. It will check the 
> > number of processors and create N+1 threads (where N is the number of 
> > processors). Each thread will wake up at the same time and try to do a 
> > busy loop for 20 millisecs. If a lower prio thread runs for 1ms before a 
> > higher prio thread, it will fail. This should test the migration of the 
> > threads to make sure that the higher prio threads run first.
> > 
> > Sorry for taking so long.
> > 
> > -- Steve
> > 
> > 
> > 
> > > 
> > > Regards--
> > > Subrata
> > > 
> > > On Mon, 2008-12-15 at 08:52 -0500, Steven Rostedt wrote: 
> > > > On Mon, 15 Dec 2008, Subrata Modak wrote:
> > > > > > 
> > > > > > Lets see, you wanted my rt migration test. I'll clean that up now. Is 
> > > > > 
> > > > > Oh yes.
> > > > 
> > > > OK, I'm cleaning it up to be more for production use.
> > > > 
> > > > > 
> > > > > > there something else I needed to send you? If you remember.
> > > > > 
> > > > > I am not quite sure now. Will let you know in future.
> > > > 
> > > > OK, thanks,
> > > > 
> > > > -- Steve
> > > > 
> > > 
> > > 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
