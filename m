Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VVdxD-0004Rr-P3
	for ltp-list@lists.sourceforge.net; Mon, 14 Oct 2013 08:56:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VVdxC-0003sE-AS
	for ltp-list@lists.sourceforge.net; Mon, 14 Oct 2013 08:56:43 +0000
Message-ID: <525BB19E.6030207@cn.fujitsu.com>
Date: Mon, 14 Oct 2013 16:55:58 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1381740628-11475-1-git-send-email-riku.voipio@linaro.org>
In-Reply-To: <1381740628-11475-1-git-send-email-riku.voipio@linaro.org>
Subject: Re: [LTP] [PATCH] [v2] power_management: add TCID
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Riku Voipio <riku.voipio@linaro.org>
Cc: ltp-list@lists.sourceforge.net, patches@linaro.org

On 10/14/2013 04:50 PM, Riku Voipio wrote:
> get_sched_values.c uses interfaces provided by -lltp which need
> TCID defined. Not sure how this built successfully before.
> 
> [v2] correct TCID to an unique one
> 
> Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>

Pushed, thank you.

Wanlong Gao


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
