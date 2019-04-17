From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Apr 2019 19:10:05 +0200
Subject: [LTP] [PATCH 2/2] syscalls/stime: detect if libc stime() is
 implemented dynamically
In-Reply-To: <5C9D8EB2.4000705@cn.fujitsu.com>
References: <1553765807-31789-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1553765807-31789-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190328152442.GB6002@x230> <5C9D8EB2.4000705@cn.fujitsu.com>
Message-ID: <20190417171005.GB26229@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

...
> > > +++ b/m4/ltp-libc-funcs.m4
> > > @@ -10,5 +10,5 @@ dnl
> > >   AC_DEFUN([LTP_CHECK_LIBC_FUNCS],[
> > >   AC_CHECK_FUNCS(epoll_pwait execveat fallocate fchownat fstatat kcmp mkdirat \
> > >   mknodat openat preadv preadv2 pwritev pwritev2 readlinkat renameat renameat2 \
> > > -splice syncfs sync_file_range tee unshare vmsplice,,)
> > > +splice stime syncfs sync_file_range tee unshare vmsplice,,)
> > I hope AC_CHECK_FUNCS is working well on cross compilation (I guess so, but
> > noticed some problems on autotools with PKG_CHECK_MODULES, but that's different
> > as it's using pkg-config).
> > ...
> Hi Petr,

> I wonder the detail of your problems, so could you provide the operations
> and error messages?
autotools fails preadv and pwritev detection with AC_CHECK_FUNCS for android
build [1]. Not sure if it's a problem of my setup or autotools bug.


> Best Regards,
> Xiao Yang

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2019-April/011722.html
