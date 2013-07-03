Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UuKLl-0006yy-Gu
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 10:31:49 +0000
Date: Wed, 3 Jul 2013 12:33:21 +0200
From: chrubis@suse.cz
Message-ID: <20130703103321.GA2906@rei>
References: <1372765421-2934-1-git-send-email-alexey.kodanev@oracle.com>
	<201307021650.56483.vapier@gentoo.org>
	<51D3DA8A.5020602@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D3DA8A.5020602@oracle.com>
Subject: Re: [LTP] [PATCH v6] fw_load: new test of device firmware loading
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hi!
> >> >  +++ b/testcases/kernel/firmware/fw_load_kernel/Makefile
> >> >
> >> >  +MAKE_TARGETS	:= ltp_fw_load.ko
> >> >  +ltp_fw_load.ko: ltp_fw_load.c
> >> >  +	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
> >> >  +	-mv ltp_fw_load.ko ltp_fw_load.ko~
> >> >  +	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir) clean
> >> >  +	-mv ltp_fw_load.ko~ ltp_fw_load.ko
> > what's with ignoring the exit status of all these ?  and why clean when you're
> > done ?  doesn't seem like you'd want to do either of these.
> >
> Ignoring the exit status, allow to proceed with the LTP build, despite 
> of any error during the module's build. Then, user-space test will 
> return TCONF, if it doesn't find the module.

This is done so that LTP is forward compatible with kernel internal API
changes. The test tries to load the module and returns TCONF if module
was not found (i.e. wasn't build either due to kernel-devel missing or
module build failure).

> There are a lot of files that left after module's build and If I don't 
> clean there, I have to manually add files to the clean target and 
> perhaps, even more.

Making make clean work would be better, but I'm not sure how to make
that work, the kernel build leaves various files there and I'm not sure
if these have stable names, but we can do some effort to clean up all
the *.cmd.o and maybe some of the rest of them.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
