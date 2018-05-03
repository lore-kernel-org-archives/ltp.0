From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 3 May 2018 12:46:38 +0200
Subject: [LTP] [PATCH] nfs/nfs_lib.sh: Fix wrong getopts parameter
	handling
In-Reply-To: <1525337565-10101-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1525337565-10101-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180503104638.mz63uamhpbr7656o@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> If nfs_lib.sh didn't use TST_OPTS and passed getopts parameter to
> tst_net.sh which could only handle -6, it caused getopts error:
> ----------------------------------------------------------------
> /opt/ltp/testcases/bin/nfs01: illegal option -- v
> /opt/ltp/testcases/bin/tst_net.sh: line 37: ?: command not found
> ----------------------------------------------------------------

> We use TST_OPTS and TST_PARSE_ARGS to fix this issue.

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---

Thanks for you fix, pushed.

We should finish rewriting network scripts to new API sooner than later.


Kind regards,
Petr
