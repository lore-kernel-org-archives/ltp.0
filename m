From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Jan 2020 13:50:59 +0100
Subject: [LTP] [PATCH] syscalls/timer*: use linux git tags for timer
 testcases
In-Reply-To: <1579585678-2209-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1579585678-2209-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200121125022.GA10467@gacrux.arch.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> I test these three cases(timer_delete01.c, timer_settime01.c, timer_settime02.c)
> on arm machines, they will get unknown 524 error like timer_create01.c.
> They are also regresstion test, so add linux tags about this error.

Merged, with slightly modified commit message.
Thank you!

Kind regards,
Petr
