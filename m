Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xo7hh-0006Z4-RJ
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 09:25:37 +0000
Date: Tue, 11 Nov 2014 10:25:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141111092459.GA27842@rei>
References: <1415680146-9562-1-git-send-email-xuw@redhat.com>
	<20141111064930.GB23693@rei.suse.de>
	<203848791.5780103.1415690440115.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <203848791.5780103.1415690440115.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] tst_mkfs: ignorce SIGCHLD for calling system
 function
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
To: Xu Wang <xuw@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Hi,
> 
> function "void tst_mkfs(...)" is used by such flollowing test cases:
> 
> testcases/kernel/syscalls/../
>     creat06
>     fchown04
>     fchown04_16
>     inotify_03
>     ichown03
>     ichown03_16
>     link08
>     linkat02
>     mkdir03
>     mkdirat02
>     mknod07
>     mknodat02
>     mount01
>     mount06
>     rename11
>     reanameat01
>     rmdir02
>     umount01
> 
> And all of these test cases " tst_sig(NOFORK, DEF_HANDLER, cleanup);" before calling tst_mkfs.
> So when the tst_mkfs calls "if (system("mkfs.btrfs 2>&1 | grep '\\-f ' >/dev/null") == 0) ", the
> SIGCHLD will be caught by parent process, and all of the tests will fail.
> In my opinion, change the tst_mkfs is the better way.

Hmm, we have that trick allready in tst_run_cmd() but that cannot be
used because it fails on non-zero exit value.

What I would like to avoid is spreading signal() calls around the
library code. So the best solution may be to add a tst_system() to
tst_run_cmd.c which would behave like system() but will also swap
the signal handlers (and will include the very same comment explaining
why we do that as we have in the tst_run_cmd.c). Then we can use the
tst_system() internally in the test library.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
