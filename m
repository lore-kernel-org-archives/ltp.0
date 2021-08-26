From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Aug 2021 17:29:57 +0200
Subject: [LTP] [PATCH 2/4 v2] epoll_ctl: Add test for epoll_ctl03
In-Reply-To: <OSZP286MB08712608A50835393F85FF90CCC69@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
References: <20210825153932.138396-1-ziyaoxie@outlook.com>
 <OSZP286MB08712608A50835393F85FF90CCC69@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
Message-ID: <YSezde/7P7+v2TkI@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +		TST_EXP_PASS(epoll_ctl(epfd, EPOLL_CTL_MOD, fds[0], &events),
> +			     "epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.events=%x",

I've changed the %x to %08x to make the messages nicer and pushed,
thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
