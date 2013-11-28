Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vm56b-0001uA-IX
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 17:10:21 +0000
Date: Thu, 28 Nov 2013 18:09:51 +0100
From: chrubis@suse.cz
Message-ID: <20131128170951.GA18651@rei.Home>
References: <528DE213.1030106@cn.fujitsu.com> <20131128143504.GF19263@rei.Home>
	<52977568.9070306@imgtec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52977568.9070306@imgtec.com>
Subject: Re: [LTP] [PATCH v3]  dup3(2): add EINVAL error number test
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
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> +static void cleanup(void)
> >> +{
> >> +	TEST_CLEANUP;
> >> +
> >> +	SAFE_CLOSE(cleanup, old_fd);
> >
> > Take care not to call cleanup() from within a cleanup()
> >
> > If the close() here will fail, the cleanup will be called, then the
> > close() will fail and the cleanup will be called... untill the end of
> > the stack and the test will eventually SegFault.
> >
> > Also if the SAFE_CREAT() in setup() will fail, the close() will fail
> > too, because the old_fd will be set to -1.
> >
> > I've fixed that this time and pushed (see diff bellow), thanks.
> >
> >
> > @@ -117,7 +117,8 @@ static void cleanup(void)
> >   {
> >          TEST_CLEANUP;
> >
> > -       SAFE_CLOSE(cleanup, old_fd);
> > +       if (old_fd > 0)
> > +               SAFE_CLOSE(NULL, old_fd);
> >
> >          tst_rmdir();
> >   }
> >
> 
> Hello,
> 
> This test does not seem to compile on uClibc based systems
> 
> I am getting this:
> dup3_02.c:53: error: 'O_CLOEXEC' undeclared here (not in a function)

Looking at fcntl.h in uClibc git the O_CLOEXEC is defined only on
__USE_GNU

Does adding

#define _GNU_SOURCE

before the includes help?

If not, your uClibc version does not yet support it and we will have to
add:

#ifndef O_CLOEXEC
# define O_CLOEXEC 02000000
#endif

To fix it.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
