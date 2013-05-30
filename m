Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ui2Uf-0004Gp-KV
	for ltp-list@lists.sourceforge.net; Thu, 30 May 2013 13:02:13 +0000
Date: Thu, 30 May 2013 15:03:25 +0200
From: chrubis@suse.cz
Message-ID: <20130530130325.GA5552@rei.suse.cz>
References: <006901ce5601$42cc89e0$c8659da0$@lge.com>
	<20130521103319.GA28186@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130521103319.GA28186@rei>
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
> > This patch fixes parallel build error. When use parallel build
> > 
> > with -j16 or -j8, $(CRITICAL_MAKEFILES) are created as empty file
> > 
> > because generate-makefiles is called several times. So need to
> > 
> > disable parallel build.
> > 
> > The following code can guarantee sequencial building.
> > 
> > .NOTPARALLEL: $(CRITICAL_MAKEFILES)
> 
> The problem is that Open Posix Testsuite should stuck with POSIX make.
> At least we promise that we will not break it actively. Now the 2008
> POSIX make still does not support the idea of parallel build. I will
> have a look what will other than GNU make implementations do with such
> rule. If it would be ignored then we are fine adding it, if not we will
> have to figure out how to detect GNU make and add the line accordingly.

I got a an idea how to fix this in portable fashion. The key is the
order of filenames the make looks for.

The gnu make tries GNUmakefile first, then makefile or Makefile.

So if we create GNUmakefile, which would include the Makefile and adds
the .NOTPARALLEL: target it should work both with both GNU make and any
other POSIX conforming make out there.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
