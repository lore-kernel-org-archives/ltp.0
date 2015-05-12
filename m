Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YsAYz-0000yO-3G
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 13:49:37 +0000
Date: Tue, 12 May 2015 15:48:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150512134858.GA11906@rei.suse.de>
References: <20150504063425.GA9995@localhost.localdomain>
	<20150504115324.GB7674@rei.suse.de>
	<20150506135504.GC2752@localhost.localdomain>
	<5551F71E.7090400@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5551F71E.7090400@huawei.com>
Subject: Re: [LTP] [PATCH] performing test on loop device if noatime or
 relatime specified
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> then compile error:
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style-definition -D_FORTIFY_SOURCE=2 -I/home/cuibixuan/home/git/ltp/ltp/testcases/kernel/include -I../../../../include -I../../../../include   -L../../../../lib  open12.c   -lltp -o open12
> open12.c: In function ?setup?:
> open12.c:103: error: ?MS_STRICTATIME? undeclared (first use in this function)
> open12.c:103: error: (Each undeclared identifier is reported only once
> open12.c:103: error: for each function it appears in.)
> make[4]: *** [open12] Error 1
> make[4]: Leaving directory `/home/cuibixuan/home/git/ltp/ltp/testcases/kernel/syscalls/open'
> 
> Do 'man mount' and can not find 'MS_STRICTATIME'.
> 
> I get from man-pages of linux:
> MS_STRICTATIME (since Linux 2.6.30)
>               Always update the last access time (atime) when files on this
>               filesystem are accessed.  (This was the default behavior
>               before Linux 2.6.30.)  Specifying this flag overrides the
>               effect of setting the MS_NOATIME and MS_RELATIME flags.
> 
> If not support 'MS_STRICTATIME'?
> My system is SUSE11-SP2, linux 3.0.13, and gcc version 4.3.4.

Solution to compilation failures is to add fallback definition into
ltp/include/lapi/mount.h (have a look at ltp/include/lapi/fcntl.h) and
include it in the testcase source. That would make the testcase compile,
but it may still fail when executed. To fix the execution we would need
to do a runtime check if the kernel supports this flag, I guess that we
would need to pass it only on newer kernels (we use tst_kvercmp() for
that).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
