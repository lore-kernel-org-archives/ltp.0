Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VVkWS-0007ZP-Ed
	for ltp-list@lists.sourceforge.net; Mon, 14 Oct 2013 15:57:33 +0000
Date: Mon, 14 Oct 2013 17:57:17 +0200
From: chrubis@suse.cz
Message-ID: <20131014155717.GA22710@rei>
References: <656844534.1470973.1380873788462.JavaMail.root@redhat.com>
	<1031362814.1472423.1380874094146.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1031362814.1472423.1380874094146.JavaMail.root@redhat.com>
Subject: Re: [LTP] Coverity report for ltp-20130904
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
Cc: ltp-list <ltp-list@lists.sf.net>

Hi!
> analyzer: coverity
> analyzer-args: --wait-for-license -co BAD_FREE:allow_first_field:true
> analyzer-version: Coverity Static Analysis for C/C++ version 6.5.3 on Linux 2.6.32-279.el6.x86_64 x86_64
> 
> This run includes snapshot of LTP git tree from 20130904 (on top of RHEL6).
> Results include also Open Posix testcases, flags: defaults, -MISSING_BREAK:
> http://jan.stancek.eu/coverity/ltp-20130904-2.el6.err.xz

Thanks for the report.

I've took liberty of removing some dead code from Open Posix testcases.
(and continue to look into the coverity results)

I've also set up LTP TODO wiki page at github, mainly for me in order
not to forget what I want to fix. But it may be used as a list of tasks
for anybody to take. Feel free (as well as anybody else who has account)
to update it as well. And for these who does not have an account, feel
free to report problems on the list, I will add them to the page.

-- 
Cyril Hrubis
chrubis@suse.cz

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
