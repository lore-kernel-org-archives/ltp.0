Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OAJVI-0004QD-GO
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 09:05:52 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OAJVH-0008Na-Hg
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 09:05:52 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4793ecn002242
	for <ltp-list@lists.sourceforge.net>; Fri, 7 May 2010 05:03:40 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4795jG12085096
	for <ltp-list@lists.sourceforge.net>; Fri, 7 May 2010 05:05:45 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4795i7h022824
	for <ltp-list@lists.sourceforge.net>; Fri, 7 May 2010 05:05:45 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100506183947.GA14900@us.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065657.23879.72093.sendpatchset@subratamodak.linux.ibm.com>
	<0B5AF9FC-8DAA-4995-9166-8EB0FE42F98C@gmail.com>
	<20100506135312.GA12072@us.ibm.com>
	<j2v364299f41005061038ucdbdaf19hcdad19491344e76d@mail.gmail.com>
	<20100506175512.GA25514@us.ibm.com>
	<k2v364299f41005061059rf51273ffk7c8c9755b92427e5@mail.gmail.com>
	<20100506183947.GA14900@us.ibm.com>
Date: Fri, 07 May 2010 14:35:41 +0530
Message-Id: <1273223141.6042.6.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [04/12 FAILURE] LTP? sysctl03 test fails
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
To: "Serge E. Hallyn" <serue@us.ibm.com>, Garrett Cooper <yanegomi@gmail.com>
Cc: LinuxTest Project <ltp-list@lists.sourceforge.net>, Michael Kerrisk <mtk.manpages@gmail.com>

Hmm, so, where do we need to fix this :-(

--Subrata

On Thu, 2010-05-06 at 13:39 -0500, Serge E. Hallyn wrote:
> Quoting Garrett Cooper (yanegomi@gmail.com):
> > On Thu, May 6, 2010 at 10:55 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> > > Quoting Garrett Cooper (yanegomi@gmail.com):
> > > So since we're all member of the doc team, send a patch for sysctl(2)
> > > manpage ERRORS section :)
> > >
> > > (mtk cc:d as this is probably news to him)
> > 
> > I already have a bug outstanding for it:
> > https://bugzilla.kernel.org/show_bug.cgi?id=15446
> 
> That's not what I said :)
> 
> > >> > An LSM could choose to return -EPERM
> > >> > after all, or perhaps even something different.  The thing that
> > >> > should scare us is if the call succeeds.  If we give any false
> > >> > positives, then true positives will seem less scary.
> > >>
> > >> This will fail on older kernels as sysctl(2) always returned EPERM due
> > >
> > > Sorry - what will fail?
> > 
> > Read through the link, and you will understand why your new proposed
> > patch with fail with a false negative.
> 
> I'm not sure that thread means what you think it does.
> 
> But look, just trying to help.  And no time for it really.  I'll drop
> this.
> 
> -serge


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
