Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MJ7W9-0003Yd-RS
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:02:37 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7W8-00052T-QE
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:02:37 +0000
Date: Tue, 23 Jun 2009 10:02:30 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090623150230.GA20383@us.ibm.com>
References: <1233076092-8660-1-git-send-email-orenl@cs.columbia.edu>
	<bb33bcf20903160526v56f16a82m9192770e228016b1@mail.gmail.com>
	<1237365510.5381.34.camel@subratamodak.linux.ibm.com>
	<20090318133943.GA22636@us.ibm.com>
	<1237385013.5381.58.camel@subratamodak.linux.ibm.com>
	<1245768524.4860.60.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1245768524.4860.60.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [RFC v13][PATCH 00/14] Kernel based checkpoint/restart
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
Cc: ltp-list <ltp-list@lists.sf.net>, Oren Laadan <orenl@cs.columbia.edu>, Alexander Viro <viro@zeniv.linux.org.uk>, matthltc <matthltc@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Serge Hallyn <serue@linux.vnet.ibm.com>, sukadev <sukadev@linux.vnet.ibm.com>

Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> On Wed, 2009-03-18 at 19:33 +0530, Subrata Modak wrote: 
> > Thanks Serge.
> > 
> > On Wed, 2009-03-18 at 08:39 -0500, Serge E. Hallyn wrote:
> > > Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> > > > Serge,
> > > > 
> > > > Did i talk to you regarding these tests in our OLS 2008 meeting ? I do
> > > > not remember exactly, but, when i saw this posting, i thought may be
> > > > there was some conversation.
> > > 
> > > I'm not sure.  However no patches are in -mm or linux-next yet.
> > > 
> > > I'm not yet certain what the test methodology will be.  Some for
> > > instance feel that the best way to test c/r is to just run ltp
> > > inside a container and continuously c/r it.  Of course, that
> > > isn't very useful when c/r support is not yet sufficient to
> > > accomplish that.  So at the moment we do have sets of programs
> > > specifically written to be checkpointable.
> > > 
> > > For instance I have a program and script which continuously
> > > runs, updates state, writes to a file, checkpoints, kills,
> > > and restarts.  That sort of thing should make a nice testcase.
> > > Oren maintains a git tree with checkpointable programs at
> > > git://git.ncl.cs.columbia.edu/pub/git/user-cr.git .
> > > 
> > > So definately let's talk again after patches hit mainline.  I'll
> > > whip up some testcases based on existing code.
> 
> Serge,
> 
> Do we have this in 2.6.30 ?

Let me check!

Heh, just kidding.  Nope.

-serge

------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
