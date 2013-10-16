Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VWPBK-0004NV-KL
	for ltp-list@lists.sourceforge.net; Wed, 16 Oct 2013 11:22:26 +0000
Date: Wed, 16 Oct 2013 13:22:13 +0200
From: chrubis@suse.cz
Message-ID: <20131016112213.GB24451@rei.Home>
References: <9C261B4871671149A8D67C0E65957391507046@039-SN1MPN1-003.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9C261B4871671149A8D67C0E65957391507046@039-SN1MPN1-003.039d.mgd.msft.net>
Subject: Re: [LTP] "cpu_hotplug/functional/cpuhotplug05.sh" failed
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
To: Liao Guoqi-B25230 <B25230@freescale.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> When I run cpuhotplug05 cases on our platform(powerpc), it failed:
> Name:   cpuhotplug05
> Date:   Wed Oct 16 10:49:31 UTC 2013
> Desc:   Does sar behave properly during CPU hotplug events?
> 
> CPU is 1
> cpuhotplug05    1  TFAIL  :  CPU1 Not Found on SAR!
> 
> After some investigation:
> 
> the following code:
> 
>         while ! grep -iq nan $TMP/log_$$; do
> 
>                 tst_resm TFAIL "CPU${CPU_TO_TEST} Not Found on SAR!"
> 
>                 exit_clean 1
> 
>         done
> 
> root cause:
> output of command "sar" has been changed, the log from "sar" output did NOT include "nan".
> 
> Enrionment:
> Sysstat version: 10.1.4
> Ltp version: 20130109-r0

It looks like the sar parameters and output changes from time to time.
On my system (systat 10.0.5) sar does not accept zero as a inifinte
count and needs to be executed as 'sar -P ALL 1' instead of
'sar -P ALL 1 0'.

I guess that the only solution is to switch on systat version and change
expectations accordingly. Feel free to send a patch.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
