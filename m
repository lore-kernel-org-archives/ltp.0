Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xxxvw-0007zb-TV
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 13:01:00 +0000
Date: Mon, 8 Dec 2014 14:00:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141208130045.GA13319@rei.suse.de>
References: <1417856007.2526.12.camel@G08JYZSD130126.localdomain>
	<20141208113557.GA11071@rei.suse.de>
	<1418042315.13292.4.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1418042315.13292.4.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH] test.sh: tst_resm and tst_brkm enhance
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> In <LTP>/testcases/network/multicast/mc_cmds
> --------------------------------------------------------------------------------
>             ...
> 113         ping -c2 -I $INTERFACE 224.0.0.1 > $PING_OUT
> 114         if [ $? -ne 0 ]; then
> 115                 tst_resm TINFO "Trying to ping with $INTERFACE_DEVICE"\
> 116                                "with the -I option instead of IP address"
>                     ...
> 122         fi
>             ...
> --------------------------------------------------------------------------------
> 
> If "ping -c2 -I $INTERFACE 224.0.0.1 > $PING_OUT" failed,
> it just output "Trying to ping with $INTERFACE_DEVICE",
> "with the -I option instead of IP address" would be discard.
> 
> After this patch, if "ping ..." failed the second string also output.

Good catch. Can you please send a patch that includes this information
in the description as well?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
