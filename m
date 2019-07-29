From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Jul 2019 14:26:21 +0200
Subject: [LTP] [PATCH v2 1/2] m4: remove some useless m4
In-Reply-To: <1563789167-2328-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1b8b7f73-fd31-58d2-5162-3648fa9729a5@163.com>
 <1563789167-2328-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190729122621.GB5872@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Since commit fe9d9218c, we have detected linux/securebits.h in
> confiure.ac. one place used the HAVE_SECUREBITS defined), it only
> controls compile. kernel/security/securebits/check_keepcaps.c has
> HAVE_LINUX_SECUREBITS_H check in internal, so removing it is safe.

> No testcase used these macros defined in ltp/time.m4, and these
> (CLOCK_MONOTONIC_RAW, CLOCK_REALTIME_COARSE, CLOCK_MONOTONIC_COARSE)
> have been defined in lapi/posix_clocks.h. Removing it is safe.

> FS_IOC_GETFLAGS and FS_IOC_SETFLAGS have been defined in lapi/fs.h.
> setxattr03.c checked this ioctl return value, so removing it is safe.

> Since commit ef772539, LTP_CHECK_CGROUPSTATS has been removed. But
> testcase still used it. It looks like a mistakenly deletion. Removing
> ltp-cgroupstats.m4, check linux/cgroupstats.h in configure.ac.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Acked-by: Petr Vorel <pvorel@suse.cz>

Although I wonder whether mixing 4 changes (even related to autoconf)
in single commit is a good idea (makes it a bit hard to review).

Kind regards,
Petr
