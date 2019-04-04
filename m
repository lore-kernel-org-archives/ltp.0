From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Apr 2019 12:31:31 +0200
Subject: [LTP] [PATCH 1/2] m4: Use common LTP_CHECK_LIBC_FUNCS to check
 libc implementations
In-Reply-To: <20190328151228.GA6002@x230>
References: <1553765807-31789-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190328151228.GA6002@x230>
Message-ID: <20190404103131.GB20565@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +++ b/m4/ltp-libc-funcs.m4
> > @@ -0,0 +1,14 @@
> > +dnl SPDX-License-Identifier: GPL-2.0-or-later
> > +dnl Copyright (c) 2019 Fujitsu Ltd.
> > +dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> > +
> > +dnl
> > +dnl LTP_CHECK_LIBC_FUNCS
> > +dnl ----------------------------
> > +dnl
> > +
> > +AC_DEFUN([LTP_CHECK_LIBC_FUNCS],[
> > +AC_CHECK_FUNCS(epoll_pwait execveat fallocate fchownat fstatat kcmp mkdirat \
> > +mknodat openat preadv preadv2 pwritev pwritev2 readlinkat renameat renameat2 \
> > +splice syncfs sync_file_range tee unshare vmsplice,,)
> > +])
> Note about formatting: maybe it'd be easier to edit the file if each function
> was on separate line.

Agreed, also we have AC_CHECK_FUNCS() in the configure.ac so the best
step would be moving these there as well.

Other than that this is a great cleanup, thanks for doing this.

-- 
Cyril Hrubis
chrubis@suse.cz
