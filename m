Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xvnih-0005tt-14
	for ltp-list@lists.sourceforge.net; Tue, 02 Dec 2014 13:42:23 +0000
Date: Tue, 2 Dec 2014 14:42:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141202134207.GA17838@rei.suse.de>
References: <1416227892.10929.1.camel@G08JYZSD130126.localdomain>
	<1416227940.10929.2.camel@G08JYZSD130126.localdomain>
	<OFBF4427CD.765E36E1-ON65257D93.005B53D8-65257D93.005BDCA8@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OFBF4427CD.765E36E1-ON65257D93.005B53D8-65257D93.005BDCA8@in.ibm.com>
Subject: Re: [LTP] [PATCH 2/5] ima_measurements.sh: Some cleanup
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
To: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> If you delete this TST_COUNT how will the PAN engine keep track of test 
> count ? I feel its required. Wait for comments from others in mailing 
> list.

As a matter of the fact the TST_COUNT should be deleted from the test
code as it's initialized in the test.sh library nowadays.

Moreover I doubt that ltp-pan is able to keep track of the test
subtests, all it cares about is the overall exit status.

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
