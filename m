Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xo5HE-00059U-Pa
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 06:50:08 +0000
Date: Tue, 11 Nov 2014 07:49:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141111064930.GB23693@rei.suse.de>
References: <1415680146-9562-1-git-send-email-xuw@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1415680146-9562-1-git-send-email-xuw@redhat.com>
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
To: xuw@redhat.com
Cc: ltp-list@lists.sourceforge.net, fs-qe-dev@redhat.com

Hi!
> function(3) system will raise the SIGCHILD signal to parent process,
> which should cause the test case failed(especially to btrfs). ignorce
> it before calling the system function and restore it after the calling.

Which test was failing because of this?

Generally testcases should set the correct
tst_sig(FORK, ...) / tst_sig(NOFORK, ...)
even when they use system() or fork() indirectly.

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
