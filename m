Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1XuFag-0007AW-9g
	for ltp-list@lists.sourceforge.net; Fri, 28 Nov 2014 07:03:42 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XuFaf-0003y5-55
	for ltp-list@lists.sourceforge.net; Fri, 28 Nov 2014 07:03:42 +0000
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Fri, 28 Nov 2014 00:03:35 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
	[9.57.198.29])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3AD9E38C8026
	for <ltp-list@lists.sourceforge.net>;
	Fri, 28 Nov 2014 02:03:33 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	sAS73Xnf19922972
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Nov 2014 07:03:33 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	sAS73WMT019801
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Nov 2014 02:03:32 -0500
Received: from localhost.localdomain ([9.125.6.116])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	sAS73WcA019779
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Nov 2014 02:03:32 -0500
Date: Fri, 28 Nov 2014 14:44:30 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20141128064430.GC16235@localhost.localdomain>
References: <20141113071324.GA2809@localhost.localdomain>
	<20141126125336.GA1062@rei>
	<20141127024241.GA16235@localhost.localdomain>
	<54769527.4020603@cn.fujitsu.com>
	<20141127074529.GB16235@localhost.localdomain>
	<5476DCA3.5000701@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5476DCA3.5000701@cn.fujitsu.com>
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

On Thu, Nov 27, 2014 at 04:11:15PM +0800, Wanlong Gao wrote:
> On 11/27/2014 03:45 PM, Han Pingtian wrote:
> >>
> >>
> >> Do you think ONLY ONE NODE can be called NUMA?
> >>
> >> http://en.wikipedia.org/wiki/Non-uniform_memory_access
> >>
> > 
> > I think it's not a problem to run the testcase on a non-NUMA system, if
> > we take it as a special case?
> 
> It's meaningless, the "special case" you said is already there, it's ksm01.
> 

All right. I hope I can figure out what features is ksm02 testing.

But looks like ksm02 tests "set_mempolicy()" and "cpuset", which ksm01
doesn't deal with. Isn't there any meanings to test them on a single
node system?

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
