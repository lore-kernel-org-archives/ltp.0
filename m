From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Oct 2018 14:19:17 +0200
Subject: [LTP] [PATCH 3/3] syscalls/preadv202: Add new testcase
In-Reply-To: <1538125851-26738-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1538125851-26738-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1538125851-26738-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20181004121916.GB7724@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Note:
> From preadv2(2) manpage, preadv2() with invalid flag should return
> EINVAL, but it actually returned EOPNOTSUPP in current upstream
> kernel, as below:
> ---------------------------------------------------------------
> include/uapi/linux/fs.h:
> define RWF_SUPPORTED   (RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>                          RWF_APPEND)
> ...
> 
> include/linux/fs.h:
> static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
> {
>         if (unlikely(flags & ~RWF_SUPPORTED)) {
>                 return -EOPNOTSUPP;
>         }
> ...
> ---------------------------------------------------------------
> 
> We use EOPNOTSUPP as expected errno for the time being.

This is probably worth a patch for the man-pages project, will you take
care of that?

Pushed with a minor change, I've changed the EFAULT test to get address
from tst_get_bad_addr() instead of the hardcoded -1.

Thanks!

-- 
Cyril Hrubis
chrubis@suse.cz
