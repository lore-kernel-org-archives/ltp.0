Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1Xtp35-0004vJ-0e
	for ltp-list@lists.sourceforge.net; Thu, 27 Nov 2014 02:43:15 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xtp32-0006XY-ND
	for ltp-list@lists.sourceforge.net; Thu, 27 Nov 2014 02:43:14 +0000
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Wed, 26 Nov 2014 21:43:07 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
	[9.57.198.29])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 342256E8028
	for <ltp-list@lists.sourceforge.net>;
	Wed, 26 Nov 2014 21:34:59 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	sAR2h38h24182916
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Nov 2014 02:43:04 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	sAR2h3NW014032
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Nov 2014 21:43:03 -0500
Received: from localhost.localdomain ([9.119.157.169])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	sAR2h2aE013965
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Nov 2014 21:43:03 -0500
Date: Thu, 27 Nov 2014 10:42:41 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20141127024241.GA16235@localhost.localdomain>
References: <20141113071324.GA2809@localhost.localdomain>
	<20141126125336.GA1062@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141126125336.GA1062@rei>
Subject: Re: [LTP] NUMA system and get_a_numa_node()
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
To: ltp-list@lists.sourceforge.net

On Wed, Nov 26, 2014 at 01:53:36PM +0100, Cyril Hrubis wrote:
> Hi!
> > We have a system which only has one NUMA node. When trying to run ksm02
> > on it, becase the code calling get_allowed_nodes() with a count 2 as
> > below:
> > 
> >  972 /* Warning: *DO NOT* use this function in child */
> >  973 unsigned int get_a_numa_node(void (*cleanup_fn) (void))
> >  974 {              
> >  975         unsigned int nd1, nd2;
> >  976         int ret; 
> >  977                        
> >  978         ret = get_allowed_nodes(0, 2, &nd1, &nd2);
> >  979         switch (ret) { 
> >  980         case 0:
> >  981                 break;
> >  982         case -3:
> >  983                 tst_brkm(TCONF, cleanup_fn, "requires a NUMA system.");
> > 
> > it always failed with "requires a NUMA system.".
> > 
> > I think a NUMA system may have only one node, right? If so, could we
> > change the count to 1?
> 
> Hmm, are you sure that the testcases are actually applicable to a system
> with only one node?
> 
> Because what the testcases do in the setup is to write 1 to
> /sys/kernel/mm/ksm/merge_across_nodes so I would expect that the test
> needs at least two nodes...
> 
I think if there is only one NUMA node, then this is a special case for
this testcase, it'll test if set "merge_across_nodes" to 1, any problem
will be triggered.

I have tried to change the node count to 1 in get_allowed_nodes() and
recompiled ksm02. It works successfully.

Thanks.


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
