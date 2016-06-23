From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jun 2016 15:15:16 +0200
Subject: [LTP] [PATCH] syscalls/epoll_ctl*: Fix cleanup()
In-Reply-To: <1466672207-24238-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1466672207-24238-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160623131515.GB20300@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Although process will be killed when timeout, but using
> SAFE_CLOSE in cleanup may lead to infinite loop.

I would guess that the process will be out of stack and segfault much
sooner before the alarm fires.

Pushed with a bit shorter commit message, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
