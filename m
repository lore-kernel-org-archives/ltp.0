Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VW5me-0003sF-MX
	for ltp-list@lists.sourceforge.net; Tue, 15 Oct 2013 14:39:40 +0000
Date: Tue, 15 Oct 2013 16:39:27 +0200
From: chrubis@suse.cz
Message-ID: <20131015143927.GB27433@rei>
References: <00ae01cec57d$6b50bbc0$41f23340$@cn.fujitsu.com>
	<552630664.4346396.1381389438416.JavaMail.root@redhat.com>
	<000901cec66b$5bd10b70$13732250$@cn.fujitsu.com>
	<1096964421.7014139.1381837841727.JavaMail.root@redhat.com>
	<20131015135532.GC25867@rei>
	<2139370019.7163656.1381846796437.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2139370019.7163656.1381846796437.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] getrusage/getrusage04.c: Fix factor_nr = 1 ->
 factor_nr = 5
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Drew Jones <drjones@redhat.com>, Zeng Linggang <zenglg.jy@cn.fujitsu.com>

Hi!
> > The problem with the test is that it tries to assert that granurality of
> > gerusage CPU time accounting is as good as possible. The granularity
> > itself depends on kernel config options, mainly on CONFIG_HZ. But as the
> > kernel compilation options are not exported (by running kernel) in any
> > reliable way the code I've added tries to guess them by side channel
> > (the CLOCK_REALTIME_COARSE resolution). If CLOCK_REALTIME_COARSE is not
> > supported it goes with 4ms which should correspond with CONFIG_HZ=250.
> > 
> > Now the accuracy on xen may be off for several reasons. It can have
> > CONFIG_HZ=100. Or xen may not be able to account virtual CPU time with
> > the same accuracy as on the real CPU...
> 
> Drew (from xen team) mentioned something along these lines as well.
> 
> Do we have some simple way to detect that test is running on xen (dom0/domU),
> so we could end test with TCONF in that case?

I'm not aware of any. But feel free to add a function into LTP lib/.

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
