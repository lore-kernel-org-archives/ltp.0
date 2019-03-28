From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Mar 2019 16:12:28 +0100
Subject: [LTP] [PATCH 1/2] m4: Use common LTP_CHECK_LIBC_FUNCS to check
 libc implementations
In-Reply-To: <1553765807-31789-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1553765807-31789-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20190328151228.GA6002@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

...
> +++ b/m4/ltp-libc-funcs.m4
> @@ -0,0 +1,14 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (c) 2019 Fujitsu Ltd.
> +dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> +
> +dnl
> +dnl LTP_CHECK_LIBC_FUNCS
> +dnl ----------------------------
> +dnl
> +
> +AC_DEFUN([LTP_CHECK_LIBC_FUNCS],[
> +AC_CHECK_FUNCS(epoll_pwait execveat fallocate fchownat fstatat kcmp mkdirat \
> +mknodat openat preadv preadv2 pwritev pwritev2 readlinkat renameat renameat2 \
> +splice syncfs sync_file_range tee unshare vmsplice,,)
> +])
Note about formatting: maybe it'd be easier to edit the file if each function
was on separate line.


Kind regards,
Petr
