Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1R1IXj-0003hs-WC
	for ltp-list@lists.sourceforge.net; Wed, 07 Sep 2011 13:51:55 +0000
Date: Wed, 7 Sep 2011 15:52:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110907135229.GA2281@saboteur.suse.cz>
References: <4E660FFC.9080900@linux.vnet.ibm.com> <4E661798.70305@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E661798.70305@redhat.com>
Subject: Re: [LTP] [Patch v2 3/4] KSM test case fixes - mmap10
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >--- ltp.orig/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-05 08:42:12.000000000 +0200
> >+++ ltp/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-06 14:10:23.000000000 +0200
> >@@ -62,6 +62,7 @@
> >  #include "test.h"
> >  #include "usctest.h"
> >  #include "config.h"
> >+#include "../../mem/include/mem.h"
> >
> >  #define SIZE (5*1024*1024)
> >
> >@@ -94,6 +95,8 @@ int main(int argc, char *argv[])
> >
> >  	if (opt_ksm)
> >  	{
> >+		if( access( PATH_KSM, F_OK ) == -1 )
> >+			tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
> >  #ifdef HAVE_MADV_MERGEABLE
> >  		tst_resm(TINFO, "add to KSM regions.");
> >  #else
> 
> Hmmm... seems HAVE_MADV_MERGEABLE is not enough? from man page:
> 
> The MADV_MERGEABLE and MADV_UNMERGEABLE operations are only
> available if the kernel was configured with CONFIG_KSM.
> 
> Doesn't that means, if CONFIG_KSM is not set, MAD_MERGEABLE won't be
> defined?

I don't think so, the problem here is that you can't say that KSM is in
the kernel at test compile time, just because you can reboot into
another kernel after the test is compiled, even more when the LTP is
packaged you don't really know what kernel it will run on. The
HAVE_MADV_MERGEABLE is enough to get the test compiled with
MADV_MERGEABLE support, however you still may get ENOSYS from the
syscall when the test is executed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Using storage to extend the benefits of virtualization and iSCSI
Virtualization increases hardware utilization and delivers a new level of
agility. Learn what those decisions are and how to modernize your storage 
and backup environments for virtualization.
http://www.accelacomm.com/jaw/sfnl/114/51434361/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
