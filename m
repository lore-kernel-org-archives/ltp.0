Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xtc6y-0000gn-2d
	for ltp-list@lists.sourceforge.net; Wed, 26 Nov 2014 12:54:24 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 4FB18AB43
	for <ltp-list@lists.sourceforge.net>;
	Wed, 26 Nov 2014 12:54:16 +0000 (UTC)
Date: Wed, 26 Nov 2014 13:53:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141126125336.GA1062@rei>
References: <20141113071324.GA2809@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141113071324.GA2809@localhost.localdomain>
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

Hi!
> We have a system which only has one NUMA node. When trying to run ksm02
> on it, becase the code calling get_allowed_nodes() with a count 2 as
> below:
> 
>  972 /* Warning: *DO NOT* use this function in child */
>  973 unsigned int get_a_numa_node(void (*cleanup_fn) (void))
>  974 {              
>  975         unsigned int nd1, nd2;
>  976         int ret; 
>  977                        
>  978         ret = get_allowed_nodes(0, 2, &nd1, &nd2);
>  979         switch (ret) { 
>  980         case 0:
>  981                 break;
>  982         case -3:
>  983                 tst_brkm(TCONF, cleanup_fn, "requires a NUMA system.");
> 
> it always failed with "requires a NUMA system.".
> 
> I think a NUMA system may have only one node, right? If so, could we
> change the count to 1?

Hmm, are you sure that the testcases are actually applicable to a system
with only one node?

Because what the testcases do in the setup is to write 1 to
/sys/kernel/mm/ksm/merge_across_nodes so I would expect that the test
needs at least two nodes...

-- 
Cyril Hrubis
chrubis@suse.cz

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
