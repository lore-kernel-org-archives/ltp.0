From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Feb 2016 15:02:06 +0100
Subject: [LTP] [PATCH 2/2] epoll_pwait/epoll_pwait02.c: add new testcase
In-Reply-To: <1453288200-3990-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1453288200-3990-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1453288200-3990-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160209140206.GB11823@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Verify that:
>  epoll_pwait(2) with NULL sigmask argument fails
>  if interrupted by a signal handler.

These two testcases are nearly identical, the difference is sinal mask
for epoll_pwait() and function that child executes, right?. Why can't we
implement both of them in one test?

-- 
Cyril Hrubis
chrubis@suse.cz
