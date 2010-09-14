Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OvOF6-0003Qs-5K
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 05:39:44 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OvOF5-0004Ew-2c
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 05:39:44 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8E5YYKZ015830
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 23:34:34 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o8E5db0k217602
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 23:39:37 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8E5dbHV025137
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 23:39:37 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1284442695.5001.0.camel@subratamodak.linux.ibm.com>
References: <OF5A6A8369.7F81ED8A-ON8525779D.0052192C-8525779D.0053C7E9@us.ibm.com>
	<1284442695.5001.0.camel@subratamodak.linux.ibm.com>
Date: Tue, 14 Sep 2010 11:09:34 +0530
Message-Id: <1284442774.5001.2.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] 20100831 release msgctl10.c bug and patch
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
To: Scott Romanowski <romansc@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

And for all future patches kindly provide as DCP signoff liike:

Signed-off-by: Scott Romanowski <romansc@us.ibm.com>,

Regards--
Subrata

On Tue, 2010-09-14 at 11:08 +0530, Subrata Modak wrote:
> Thanks Scott. There was a problem in creating this patch:
> 
> patching file testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
> Hunk #1 succeeded at 452 with fuzz 1.
> patching file testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
> Hunk #1 FAILED at 452.
> 1 out of 1 hunk FAILED -- saving rejects to file
> testcases/kernel/syscalls/ipc/msgctl/msgctl10.c.rej
> 
> However due to a trivial patch i could make the changes.
> 
> Regards--
> Subrata
> 
> On Mon, 2010-09-13 at 11:15 -0400, Scott Romanowski wrote:
> > Hi,
> > MSGMNI should be limited to MAXNPROCS, since keyarray[] only has
> > MAXNPROCS entries. Without this, the loop at lines 177-181
> > for (i = 0; i < nprocs; i++) {
> > ok = 1;
> > do {
> > /* Get random key */
> > keyarray[i] = (key_t) rand();
> > 
> > can write past the end of keyarray[] if there are > MAXNPROCS free
> > message queues.
> > 
> > The patch:
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > diff -r 15082dabc40b testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
> > --- a/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c Mon Sep 13
> > 10:38:06 2010 -0400
> > +++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c Mon Sep 13
> > 10:53:32 2010 -0400
> > @@ -452,6 +452,8 @@
> > cleanup();
> > 
> > MSGMNI = nr_msgqs - get_used_msgqueues();
> > + if( MSGMNI > MAXNPROCS )
> > + MSGMNI = MAXNPROCS;
> > if (MSGMNI <= 0) {
> > tst_resm(TBROK,
> > "Max number of message queues already used, cannot create more.");
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > --
> > Scott Romanowski
> > 
> > 
> > ------------------------------------------------------------------------------
> > Start uncovering the many advantages of virtual appliances
> > and start using them to simplify application deployment and
> > accelerate your shift to cloud computing
> > http://p.sf.net/sfu/novell-sfdev2dev
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
