From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 31 Oct 2019 15:31:50 +0100
Subject: [LTP] [PATCH v2 3/6] syscalls/quotactl01.c: Add Q_GETNEXQUOTA
 test
In-Reply-To: <1571821231-3846-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1571821231-3846-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1571821231-3846-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20191031143148.GA6781@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> Q_GETNEXTQUOTA was introduced since linux 4.6, this operation is the
> same as Q_GETQUOTA, but it returns quota information for the next ID
> greater than or equal to id that has a quota set.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  include/lapi/quotactl.h                       | 23 ++---
>  m4/ltp-quota.m4                               | 36 +-------
>  .../kernel/syscalls/quotactl/quotactl01.c     | 86 ++++++++++++-------
>  3 files changed, 67 insertions(+), 78 deletions(-)

> diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
...
>  #ifndef LAPI_QUOTACTL_H__
>  # define LAPI_QUOTACTL_H__

> +#include <linux/quota.h>
I'd prefer to add autotools check for <linux/quota.h configure.ac
(I guess we ignore include/config.h.default atm).

But, more important, I'd prefer to include <sys/quota.h> here as well:

#ifdef HAVE_LINUX_QUOTA_H
# include <linux/quota.h>
#else
# include <sys/quota.h>
#endif

=> move it from quotactl0*.c (there is not yet agreement to include headers in
lapi files, but later lapi files does it).

The reason is that old distros fail when both headers are included at the same
time (probably <linux/quota.h> got fixed later, maybe there is an workaround,
but the easiest way is to handle this in header anyway).

Kind regards,
Petr

[1] https://travis-ci.org/pevik/ltp/jobs/605507690
[2] https://api.travis-ci.org/v3/job/605507690/log.txt
