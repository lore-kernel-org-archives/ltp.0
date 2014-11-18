Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XqZ2Q-0001pH-I7
	for ltp-list@lists.sourceforge.net; Tue, 18 Nov 2014 03:01:06 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XqZ2P-0008PG-DL
	for ltp-list@lists.sourceforge.net; Tue, 18 Nov 2014 03:01:06 +0000
Message-ID: <1416276309.11313.10.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 18 Nov 2014 10:05:09 +0800
In-Reply-To: <OFBF4427CD.765E36E1-ON65257D93.005B53D8-65257D93.005BDCA8@in.ibm.com>
References: <1416227892.10929.1.camel@G08JYZSD130126.localdomain>
	<1416227940.10929.2.camel@G08JYZSD130126.localdomain>
	<OFBF4427CD.765E36E1-ON65257D93.005B53D8-65257D93.005BDCA8@in.ibm.com>
MIME-Version: 1.0
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

Hi,
On Mon, 2014-11-17 at 22:09 +0530, Poornima Nayak wrote:
> If you delete this TST_COUNT how will the PAN engine keep track of
> test count ? I feel its required. Wait for comments from others in
> mailing list. 

Thank you for your review. :)
I have not deleted 'TST_COUNT', I put it at the begin of the test.
Moreover 'tst_resm' and 'tst_brkm' are in the script of 'test.sh'.
And 'TST_COUNT' will '++' when they are invoked by 'tst_resm' or
'tst_brkm' everytime.

Best regards,
Zeng

> Rest of the patch looks fine. 
> 
> Zeng Linggang <zenglg.jy@cn.fujitsu.com> wrote on 11/17/2014 06:09:00
> PM:
> 
> > 


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
