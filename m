Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1Xxy4M-0002QF-5Z
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 13:09:42 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xxy4K-0004uM-9O
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 13:09:42 +0000
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Mon, 8 Dec 2014 08:09:34 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
	[9.57.198.25])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 679906E803C
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Dec 2014 08:01:25 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	sB8D9UsZ22675498
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Dec 2014 13:09:30 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	sB8D9UNH018649
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Dec 2014 08:09:30 -0500
Received: from localhost.localdomain ([9.125.24.218])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	sB8D9T4b018579
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Dec 2014 08:09:30 -0500
Date: Mon, 8 Dec 2014 21:03:01 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20141208130301.GB3352@localhost.localdomain>
References: <20141206012422.GA3352@localhost.localdomain>
	<20141208120922.GD11071@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141208120922.GD11071@rei.suse.de>
Subject: Re: [LTP] questions about getrusage04
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

On Mon, Dec 08, 2014 at 01:09:22PM +0100, Cyril Hrubis wrote:
> Hi!
> > I cannot understand why udelta/sdelta > "1000+(BIAS_MAX*factor_nr)" is a
> > problem. Could any expert give me a explain, please?
> 
> It tests timer precision for getrusage timers. If the timers are
> incremting by larger values than expected, something is wrong in kernel.
> The precision depends on CONFIG_HZ settings which is represented by the
> BIAS_MAX.
Where does the 1000 come from? If on a slow system, we need to increase
the "factor_nr", right? 
> 
> > And looks like with this patch applied, it works well on powerpc:
> 
> Can you please share the output of the testcase on ppc and ppc64? What
> is the expected timer granularity there?
> 
Looks like the granularity is 10000us:

getrusage04    0  TINFO  :  Expected timers granularity is 10000 us
getrusage04    0  TINFO  :  Using 1 as multiply factor for max [us]time increment (1000+10000us)!
getrusage04    0  TINFO  :  utime:          56us; stime:        1192us
getrusage04    0  TINFO  :  utime:          56us; stime:        2009us
getrusage04    0  TINFO  :  utime:          56us; stime:        4233us
getrusage04    0  TINFO  :  utime:        1227us; stime:        5243us
getrusage04    0  TINFO  :  utime:        1227us; stime:        8541us
getrusage04    0  TINFO  :  utime:        2072us; stime:        8741us
getrusage04    0  TINFO  :  utime:        2602us; stime:       11169us
getrusage04    0  TINFO  :  utime:        2743us; stime:       11747us
getrusage04    0  TINFO  :  utime:        2948us; stime:       12790us
getrusage04    0  TINFO  :  utime:        2948us; stime:       18118us
getrusage04    0  TINFO  :  utime:        2948us; stime:       18596us
getrusage04    0  TINFO  :  utime:        4458us; stime:       20030us
getrusage04    0  TINFO  :  utime:        4458us; stime:       20244us
getrusage04    0  TINFO  :  utime:        4458us; stime:       23432us
getrusage04    0  TINFO  :  utime:        5412us; stime:       24650us
getrusage04    0  TINFO  :  utime:        5412us; stime:       27273us
getrusage04    0  TINFO  :  utime:        6125us; stime:       27909us
getrusage04    0  TINFO  :  utime:        6125us; stime:       27911us
getrusage04    0  TINFO  :  utime:        6125us; stime:       28111us
getrusage04    0  TINFO  :  utime:        6235us; stime:       28513us
getrusage04    0  TINFO  :  utime:        6235us; stime:       28750us
getrusage04    1  TPASS  :  Test Passed


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
