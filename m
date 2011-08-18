Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qu0FD-00037S-GZ
	for ltp-list@lists.sourceforge.net; Thu, 18 Aug 2011 10:54:39 +0000
Date: Thu, 18 Aug 2011 12:59:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110818105913.GA19491@saboteur.suse.cz>
References: <1310538972-27982-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1311143742-16746-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1311143742-16746-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] posix:sigset:fix the wrong use of sigset() in
 6-1.c and 7-1.c
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> v1->v2:
> 	v1:use the sigset for twice times.
> 	v2:not use sigset for twice, but just check the SIG_ERR.
> 
> According to the posix IEEE Std 1003.1-2008:Upon successful completion,
> sigset() shall return SIG_HOLD if the signal had been blocked and the
> signal's previous disposition if it had not been blocked.
> 
> In these two test instances, the first time when sigset() is called, it
> then calls the __sigprocmask() to mask the signal to SIG_BLOCK and checks
> the old set to see if the signal was blocked previously, and it's not.
> So it will not return SIG_HOLD, but the sigset() already runs successfully.
> 
> Then, after the first time we calls the sigset, the signal has already be
> blocked, and now, calls the sigset() second, it will return SIG_HOLD, since
> the signal had been blocked when we called the sigset() first time.
> 
> We are now checking the return value of the first time calling. So, if
> it fails, it'll return SIG_ERR instead. Just need to check the SIG_ERR.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Applied a little different patch for sigset/7-1.c (but added your
Signed-of-by so you have credit for the work too).

I'll apply the part for sigset/6-1.c.

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
