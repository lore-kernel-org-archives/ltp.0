Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xxyb4-0003h2-6A
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 13:43:30 +0000
Date: Mon, 8 Dec 2014 14:43:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141208134309.GC13319@rei.suse.de>
References: <1417776470-12961-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1417776470-12961-1-git-send-email-zlang@redhat.com>
Subject: Re: [LTP] [PATCH] diotest: set errno with zero before test with zero
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
To: Zorro Lang <zlang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> some code logic in diotest4.c likes below:
> ----
>     ret = lseek(fd, offset, SEEK_SET);
>     if ((ret >= 0) || (errno != EINVAL)) {
>         tst_resm(TFAIL, "lseek allows negative offset. returns %d:%s", ret, strerror(errno));
>         failed = TRUE;
>         fail_count++;
>     } else
>         tst_resm(TPASS, "Negative Offset");
> 
>     ....
>     ....
> 
>     ret = read(fd, buf, count);
>     if (ret >= 0 || errno != errnum) {
>         tst_resm(TFAIL, "read allows %s. returns %d: %s", msg, ret, strerror(errno));
>         l_fail = TRUE;
>     }
> ----
> 
> If lseek() EINVAL and read() return >= 0, the errno will not be setted to 0. The
> errno will still be EINVAL.
> 
> I hit this problem when test on nfs. In NFS, lseek() return EINVAL as excepted,
> but the read() will return 1, when count = 1. But the errno is still EINVAL.
> That's incorrect.
> 
> So I set errno = 0, before read() and all other functions which like this.

Can you please clarify the commit message a bit so that it's clear that
it's the test failure message that is confusing in case that read()
haven't failed as expected and the errno is still set?

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
