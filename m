Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WDDQx-0004zU-3h
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 13:31:31 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WDDQv-0000wy-Jh
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 13:31:31 +0000
Date: Tue, 11 Feb 2014 08:31:22 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <655335707.1328396.1392125482623.JavaMail.zimbra@redhat.com>
In-Reply-To: <136022909.5430461.1391690432110.JavaMail.root@redhat.com>
References: <20140204224400.GA8297@tarantula.localdomain>
	<136022909.5430461.1391690432110.JavaMail.root@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] use inotify_init1(0) for inotify tests on aarch64
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
To: Jeffrey Bastian <jbastian@redhat.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Jeffrey Bastian" <jbastian@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Thursday, 6 February, 2014 1:40:32 PM
> Subject: Re: [LTP] [PATCH] use inotify_init1(0) for inotify tests on aarch64
> 
> 
> 
> ----- Original Message -----
> > From: "Jeffrey Bastian" <jbastian@redhat.com>
> > To: ltp-list@lists.sourceforge.net
> > Sent: Tuesday, 4 February, 2014 11:44:00 PM
> > Subject: [LTP] [PATCH] use inotify_init1(0) for inotify tests on aarch64
> > 
> > aarch64 (and possibly other new architectures) does not implement
> > the __ARCH_WANT_SYSCALL_NO_FLAGS syscalls, so use inotify_init1(0)
> > instead of inotify_init(void)
> > 
> > Signed-off-by: Jeffrey Bastian <jbastian@redhat.com>
> 
> Looks good to me.
> 
> Reviewed-by: Jan Stancek <jstancek@redhat.com>

Pushed, thank you,
Jan

> 
> Regards,
> Jan
> 
> > ---
> >  testcases/kernel/syscalls/inotify/inotify.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/testcases/kernel/syscalls/inotify/inotify.h
> > b/testcases/kernel/syscalls/inotify/inotify.h
> > index e396947c4f98..68fe3b5f6426 100644
> > --- a/testcases/kernel/syscalls/inotify/inotify.h
> > +++ b/testcases/kernel/syscalls/inotify/inotify.h
> > @@ -30,8 +30,13 @@
> >  
> >  /* inotify(7) wrappers */
> >  
> > +#if __NR_inotify_init != __LTP__NR_INVALID_SYSCALL
> >  #define	myinotify_init() \
> >  	syscall(__NR_inotify_init)
> > +#else
> > +#define	myinotify_init() \
> > +	syscall(__NR_inotify_init1, 0)
> > +#endif
> >  
> >  #define	myinotify_add_watch(fd, pathname, mask)	\
> >  	syscall(__NR_inotify_add_watch, fd, pathname, mask)
> > --
> > 1.8.3.1
> > 
> > 
> > ------------------------------------------------------------------------------
> > Managing the Performance of Cloud-Based Applications
> > Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
> > Read the Whitepaper.
> > http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 
> 
> ------------------------------------------------------------------------------
> Managing the Performance of Cloud-Based Applications
> Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
> Read the Whitepaper.
> http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
