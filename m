Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UV24P-0005J0-PQ
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 15:57:21 +0000
Date: Wed, 24 Apr 2013 17:58:11 +0200
From: chrubis@suse.cz
Message-ID: <20130424155811.GA12406@rei.suse.cz>
References: <8a4fb5929c599b2dec955086713069c20f95c466.1366704928.git.jstancek@redhat.com>
	<201304231213.33013.vapier@gentoo.org>
	<1865305189.2143033.1366786432951.JavaMail.root@redhat.com>
	<201304241152.47110.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201304241152.47110.vapier@gentoo.org>
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > delete all the "#else" branches since you're now using
> > > linux_syscall_numbers.h
> > 
> > Without that check in parent, you can end up in situation where some child
> > aborts first and then parent reports failure. By doing it early in setup()
> > you can avoid allocating resources that won't go away when process later
> > terminates with TCONF.
> 
> by including linux_syscall_numbers.h, you've guaranteed that 
> __NR_process_vm_readv will always be defined, thus the code under "#ifndef 
> __NR_process_vm_readv" will never be run, thus you should delete it.

Not until these are added to at least one of the in files and
linux_syscall_numbers.h are regenerated.

Which is why we started to fiddle with the kernel/include directory in
the first place.

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
