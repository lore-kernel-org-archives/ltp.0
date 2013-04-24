Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UUtaf-0002CY-Bf
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 06:54:05 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UUtad-0008Oh-AR
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 06:54:05 +0000
Date: Wed, 24 Apr 2013 02:53:52 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1865305189.2143033.1366786432951.JavaMail.root@redhat.com>
In-Reply-To: <201304231213.33013.vapier@gentoo.org>
References: <8a4fb5929c599b2dec955086713069c20f95c466.1366704928.git.jstancek@redhat.com>
	<201304231213.33013.vapier@gentoo.org>
MIME-Version: 1.0
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



----- Original Message -----
> From: "Mike Frysinger" <vapier@gentoo.org>
> To: ltp-list@lists.sourceforge.net
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Tuesday, 23 April, 2013 6:13:31 PM
> Subject: Re: [LTP] [PATCH] syscalls/cma: add runtime check to setup()
> 
> On Tuesday 23 April 2013 04:17:15 Jan Stancek wrote:
> > __NR_process_vm_readv / __NR_process_vm_writev defined doesn't
> > guarantee, that kernel supports these syscalls. Add check to setup(),
> > which uses ltp_syscall(). If syscall isn't supported it will
> > end the testcase with TCONF.
> 
> delete all the "#else" branches since you're now using
> linux_syscall_numbers.h

Without that check in parent, you can end up in situation where some child
aborts first and then parent reports failure. By doing it early in setup() you can
avoid allocating resources that won't go away when process later terminates with TCONF.

Regards,
Jan

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
