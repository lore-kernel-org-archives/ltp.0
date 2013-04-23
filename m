Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UUdt0-00034B-S2
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 14:07:58 +0000
Date: Tue, 23 Apr 2013 16:08:52 +0200
From: chrubis@suse.cz
Message-ID: <20130423140852.GG28044@rei>
References: <CANXECd6HvF8LTCfkhjv_nn_gC1zgOJ_u_4401k_LptG9WUuzYA@mail.gmail.com>
	<20130417180901.GA30553@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130417180901.GA30553@rei>
Subject: Re: [LTP] Is running from a read-only path supported?
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
To: Ismael Farf??n <sulfurfff@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > First of, thanks for your effort writing all this bunch of tests, It's
> > really helpful.
> > 
> > We are running LTP to test the correct behavior of a FileSystem
> > mounted in /mnt, however I installed ltp in /read/only/NFS/export/ltp.
> > 
> > I've already changed ltprun [1] so that it writes the failed log in
> > TMP (which should point to /mnt) instead of LTPBIN, but there are a
> > bunch of tests creating files in "." instead of TMPDIR, and for what
> > I've seen "." is actually LTPBIN for some tests which in our case is
> > read-only.
> 
> Such tests are buggy and needs to be fixed.
> 
> Just send a patch against latest git with Signed-off-by line and I will
> apply it right away.
> 
> > Also, I can't pass a base directory to run on to many of the tests,
> > take [2] as example where I patched it to write to TMPDIR.
> 
> We have a interface that automatically setups temporary directory for
> the test. All that is needed is that the test calls tst_tmpdir() at the
> start and tst_rmdir() at the end and, if needed, in the cleanup().
> 
> See include/test.h for details.

Ping. Any work done on this?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
