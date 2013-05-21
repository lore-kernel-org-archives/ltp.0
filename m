Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uejrl-0005Zl-4f
	for ltp-list@lists.sourceforge.net; Tue, 21 May 2013 10:32:25 +0000
Date: Tue, 21 May 2013 12:33:19 +0200
From: chrubis@suse.cz
Message-ID: <20130521103319.GA28186@rei>
References: <006901ce5601$42cc89e0$c8659da0$@lge.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <006901ce5601$42cc89e0$c8659da0$@lge.com>
Subject: Re: [LTP] [PATCH] Makefile: Disable parallel build for
 $(CRITICAL_MAKEFILES)
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
To: Jungsoo Son <jungsoo.son@lge.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> This patch fixes parallel build error. When use parallel build
> 
> with -j16 or -j8, $(CRITICAL_MAKEFILES) are created as empty file
> 
> because generate-makefiles is called several times. So need to
> 
> disable parallel build.
> 
> The following code can guarantee sequencial building.
> 
> .NOTPARALLEL: $(CRITICAL_MAKEFILES)

The problem is that Open Posix Testsuite should stuck with POSIX make.
At least we promise that we will not break it actively. Now the 2008
POSIX make still does not support the idea of parallel build. I will
have a look what will other than GNU make implementations do with such
rule. If it would be ignored then we are fine adding it, if not we will
have to figure out how to detect GNU make and add the line accordingly.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
