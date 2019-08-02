From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 2 Aug 2019 10:57:27 +0200
Subject: [LTP] [PATCH v3 1/5] m4: remove useless ltp-securebits.m4
In-Reply-To: <1564465533-2475-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190729144227.GA8824@dell5510>
 <1564465533-2475-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190802085727.GA11805@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> Since commit fe9d9218c, we have detected linux/securebits.h in
> confiure.ac. one place used the HAVE_SECUREBITS(ltp-securebits.m4
> defined), it only controls compile. kernel/security/securebits/
> check_keepcaps.c has HAVE_LINUX_SECUREBITS_H check in internal,
> so removing it is safe.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Xiao Yang <ice_yangxiao@163.com>
Whole patchset merged (with tiny changes in commit messages).
Thanks for this cleanup and speedup!

Kind regards,
Petr
