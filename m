From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Nov 2019 16:16:10 +0100
Subject: [LTP] [PATCH v4 1/5] syscalls/quotactl01: Add Q_GETNEXTQUOTA
 test
In-Reply-To: <20191120151244.GA28197@dell5510>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1574241216-15168-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191120151244.GA28197@dell5510>
Message-ID: <20191120151610.GB28197@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan, Cyril, Xu,

> > +#ifdef HAVE_STRUCT_IF_NEXTDQBLK
> > +# include <linux/quota.h>
> > +#else
> > +# ifdef HAVE_LINUX_TYPES_H
> > +# include <linux/types.h>
> @Jan, @Cyril: Do we want to generally avoid loading <linux/types.h> if not really needed?
> __u64 can be uint64_t etc (as it's also visible in struct dqblk in <sys/quota.h>
> in various libc headers).
> We used this approach for /usr/include/linux/bpf.h and for fanotify fixes for
> musl (testcases/kernel/syscalls/fanotify/fanotify.h).

> So unless you're against this approach here I'll change it before merge
> (and add this info to next version of library API writing guidelines patch
> https://patchwork.ozlabs.org/patch/1166786/).
+ general question: do we want always test against kernel headers or libc
headers? Libc is often outdated, so mostly it'd be our fallback to be tested.
Ideally both kernel and libc header should be tested, but that's not easily
achievable.

Kind regards,
Petr
