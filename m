Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XxyEA-0007yC-3O
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 13:19:50 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 2D224AB09
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Dec 2014 13:19:39 +0000 (UTC)
Date: Mon, 8 Dec 2014 14:19:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141208131931.GB13319@rei.suse.de>
References: <20141206012422.GA3352@localhost.localdomain>
	<20141208120922.GD11071@rei.suse.de>
	<20141208130301.GB3352@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141208130301.GB3352@localhost.localdomain>
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

Hi!
> > It tests timer precision for getrusage timers. If the timers are
> > incremting by larger values than expected, something is wrong in kernel.
> > The precision depends on CONFIG_HZ settings which is represented by the
> > BIAS_MAX.
> Where does the 1000 come from? If on a slow system, we need to increase
> the "factor_nr", right?

The factor is set to 1 and it shouldn't needed to change that.

> > > And looks like with this patch applied, it works well on powerpc:
> > 
> > Can you please share the output of the testcase on ppc and ppc64? What
> > is the expected timer granularity there?
> > 
> Looks like the granularity is 10000us:
> 
> getrusage04    0  TINFO  :  Expected timers granularity is 10000 us
> getrusage04    0  TINFO  :  Using 1 as multiply factor for max [us]time increment (1000+10000us)!
> getrusage04    0  TINFO  :  utime:          56us; stime:        1192us
> getrusage04    0  TINFO  :  utime:          56us; stime:        2009us
> getrusage04    0  TINFO  :  utime:          56us; stime:        4233us
> getrusage04    0  TINFO  :  utime:        1227us; stime:        5243us
> getrusage04    0  TINFO  :  utime:        1227us; stime:        8541us
> getrusage04    0  TINFO  :  utime:        2072us; stime:        8741us
> getrusage04    0  TINFO  :  utime:        2602us; stime:       11169us
> getrusage04    0  TINFO  :  utime:        2743us; stime:       11747us
> getrusage04    0  TINFO  :  utime:        2948us; stime:       12790us
> getrusage04    0  TINFO  :  utime:        2948us; stime:       18118us
> getrusage04    0  TINFO  :  utime:        2948us; stime:       18596us
> getrusage04    0  TINFO  :  utime:        4458us; stime:       20030us
> getrusage04    0  TINFO  :  utime:        4458us; stime:       20244us
> getrusage04    0  TINFO  :  utime:        4458us; stime:       23432us
> getrusage04    0  TINFO  :  utime:        5412us; stime:       24650us
> getrusage04    0  TINFO  :  utime:        5412us; stime:       27273us
> getrusage04    0  TINFO  :  utime:        6125us; stime:       27909us
> getrusage04    0  TINFO  :  utime:        6125us; stime:       27911us
> getrusage04    0  TINFO  :  utime:        6125us; stime:       28111us
> getrusage04    0  TINFO  :  utime:        6235us; stime:       28513us
> getrusage04    0  TINFO  :  utime:        6235us; stime:       28750us
> getrusage04    1  TPASS  :  Test Passed

Hmm, this looks like the granularity of the timer is much smaller than
10000us and it varies greatly between measurements. Is this CONFIG_NO_HZ
system?

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
