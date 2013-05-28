Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UhM2X-00060D-KH
	for ltp-list@lists.sourceforge.net; Tue, 28 May 2013 15:42:21 +0000
Date: Tue, 28 May 2013 17:43:34 +0200
From: chrubis@suse.cz
Message-ID: <20130528154334.GB4229@rei>
References: <1369398051-2772-1-git-send-email-alexey.kodanev@oracle.com>
	<20130528143707.GA4229@rei> <51A4C663.7010506@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51A4C663.7010506@oracle.com>
Subject: Re: [LTP] [PATCH] New core test of cgroups and extended attributes
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
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > So we create a list of subsystem by hierarchy here, and try to mount
> > them with xattr later?
> That's right
> > Ah but due to bug in kernel (hier == 0 when we got to this part) we end
> > up only with these that are not mounted at the moment, right?
> Yes
> > That looks OK. Hopefully the kernel gets fixed. Will the kernel support
> > mouting the subsystems with additional xattr flags or will the mount
> > return an error (on my machine all mounted subsystems are mounted
> > without xattr)?
> >
> It's difficult to say, for now, we have a recent upstream commit 
> <http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=873fe09ea5df6ccf6bb34811d8c9992aacb67598> 
> in which new cgroup mount option introduced (__DEVEL__sane_behavior). It 
> can be used to get mount error. Developer says that this bug is a part 
> of largerbreakage - cgroup silently ignores mount option changes 
> whenremounted. He thinks that fixing only this part is not meaningful, 
> suggesting to add warning message if the mount options mismatch.

OK. Lets get keep the test as it is now. We will fix it later, once the
kernel devs figure out their solution.

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
