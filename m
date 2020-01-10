From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Jan 2020 14:00:29 +0100
Subject: [LTP] [PATCH v2] syscalls/capget02: remove useless getpid()
In-Reply-To: <1578554765-30025-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1578554765-30025-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200110130029.GB25704@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> Since pid=0 returns the capabilities for the calling thread,
> we can remove getpid. Also we can cover this test point.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> -----------------
> v1-v2:
> remove pid = 0 assignment, because it has been initialized as 0.
> add comment
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Note, waiting for merge before current git get's fixed.
(v2 of https://patchwork.ozlabs.org/patch/1220180/).


Kind regards,
Petr
