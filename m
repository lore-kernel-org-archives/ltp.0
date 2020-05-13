From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 May 2020 14:34:09 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/pidfd_open01.c: Add check for
 close-on-exec flag
In-Reply-To: <20200513012626.1571-1-yangx.jy@cn.fujitsu.com>
References: <20200513012626.1571-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20200513123409.GA10803@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> pidfd_open(2) will set close-on-exec flag on the file descriptor as it
> manpage states, so check close-on-exec flag by fcntl(2).
> 
> BTW:
> I tried to pass (long) TST_RET to fcntl() but triggered the following
> compiler warning, so pass (int) pidfd instead.
> ------------------------------------------------------
> In file included from pidfd_open01.c:9:
> pidfd_open01.c: In function ???run???:
> ../../../../include/tst_test.h:76:41: warning: format ???%i??? expects argument of type ???int???, but argument 5 has type ???long int??? [-Wformat=]
>    76 |   tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
>       |                                         ^~~~~~~~~
> ../../../../include/tst_safe_macros.h:224:5: note: in expansion of macro ???tst_brk???
>   224 |     tst_brk(TBROK | TERRNO,                          \
>       |     ^~~~~~~
> pidfd_open01.c:20:9: note: in expansion of macro ???SAFE_FCNTL???
>    20 |  flag = SAFE_FCNTL(TST_RET, F_GETFD);

You can either cast the TST_RET to int as SAFE_FCNTL((int)TST_RET, ...)
or if you decide to store the pidfd into an int variable there is no
added value in using the TEST() macro here so the code should just do
pidfd = pidfd_open(...) and use the pidfd instead of TST_RET.

-- 
Cyril Hrubis
chrubis@suse.cz
