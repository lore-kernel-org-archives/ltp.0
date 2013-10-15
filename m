Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VW56A-0008Ka-Tn
	for ltp-list@lists.sourceforge.net; Tue, 15 Oct 2013 13:55:46 +0000
Date: Tue, 15 Oct 2013 15:55:33 +0200
From: chrubis@suse.cz
Message-ID: <20131015135532.GC25867@rei>
References: <00ae01cec57d$6b50bbc0$41f23340$@cn.fujitsu.com>
	<552630664.4346396.1381389438416.JavaMail.root@redhat.com>
	<000901cec66b$5bd10b70$13732250$@cn.fujitsu.com>
	<1096964421.7014139.1381837841727.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1096964421.7014139.1381837841727.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] getrusage/getrusage04.c: Fix factor_nr = 1
	->	factor_nr = 5
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
> > When kernel is vmlinuz-2.6.18-371.el5xen, the case will fail.
> > But with vmlinuz-2.6.18-371.el5, it works well.
> 
> I'm seeing the same as you also with previous minor RHEL5 releases on dom0:
> 5.3 2.6.18-128.el5xen
> 5.6 2.6.18-238.el5xen
> 5.9 2.6.18-348.el5xen
> 5.10 2.6.18-371.el5xen
> 
> > Maybe the case is not suit for xen kernel.
> 
> It's possible, it doesn't look like regression to me so far.
> The systems are definitely not "slow" ones, and test can pass on bare-metal kernel. 

The problem with the test is that it tries to assert that granurality of
gerusage CPU time accounting is as good as possible. The granularity
itself depends on kernel config options, mainly on CONFIG_HZ. But as the
kernel compilation options are not exported (by running kernel) in any
reliable way the code I've added tries to guess them by side channel
(the CLOCK_REALTIME_COARSE resolution). If CLOCK_REALTIME_COARSE is not
supported it goes with 4ms which should correspond with CONFIG_HZ=250.

Now the accuracy on xen may be off for several reasons. It can have
CONFIG_HZ=100. Or xen may not be able to account virtual CPU time with
the same accuracy as on the real CPU...

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
