From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Nov 2020 13:59:38 +0100
Subject: [LTP] [PATCH] pan/ltp-pan.c: fix file descriptors leaks
In-Reply-To: <1604925271-4811-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1604925271-4811-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <20201109125938.GC9991@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ltp-pan will leak file descriptors of fopen() into the child process
> of the test case, fix this problem by using mode "e" for fopen().

Looks good, however this is supported since glibc 2.7 and it does not
seem to be supported on musl libc either.

I guess that it would be better just to close these files after a fork
in the runchild() function, but that would mean that we would have to
pass all these files as paramters to the function as well.

-- 
Cyril Hrubis
chrubis@suse.cz
