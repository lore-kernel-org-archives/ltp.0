Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UUcZu-00065a-T1
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 12:44:11 +0000
Date: Tue, 23 Apr 2013 14:45:04 +0200
From: chrubis@suse.cz
Message-ID: <20130423124504.GD28044@rei>
References: <8a4fb5929c599b2dec955086713069c20f95c466.1366704928.git.jstancek@redhat.com>
	<20130423102935.GB28044@rei>
	<956651177.1121108.1366719315370.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <956651177.1121108.1366719315370.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/cma: add runtime check to setup()
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > >  static void setup(void)
> > > @@ -191,9 +191,11 @@ static void setup(void)
> > >  	    sflag ? SAFE_STRTOL(NULL, sz_opt, 1, LONG_MAX - PADDING_SIZE * 2)
> > >  	    : 100000;
> > >  
> > > -#if !defined(__NR_process_vm_readv)
> > > +#if !defined(__NR_process_vm_writev)
> > >  	tst_brkm(TCONF, NULL, "process_vm_writev does not exist "
> > >  		 "on your system");
> > > +#else
> > > +	ltp_syscall(__NR_process_vm_writev, 0, NULL, 0, NULL, 0, 0);
> > >  #endif
> > >  	semid = init_sem(1);
> > 
> > If you add the __NR_process_vm_writev to at least one of the
> > testscases/kernel/include/*.in and run regen script (make clean && make
> > in the corresponding dir), the linux_syscall_numbers.h will contain at
> > least stubs and ltp_syscall() will be able to handle both situations.
> 
> We seem to be regenerating linux_syscall_numbers.h only when it's missing
> or when you run it manually. Should we just remove it from git tree?
> Build process will generate one and it will contain latest bits from *.in files

Right. And please add dependency on the *.in files too (this seems to be
missing as well).

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
