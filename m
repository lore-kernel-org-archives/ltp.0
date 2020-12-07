From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Dec 2020 17:33:40 +0100
Subject: [LTP] [PATCH] syscalls/madvise06: Add check for
 /proc/sys/vm/stat_refresh file
In-Reply-To: <1605679223-6665-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1605679223-6665-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <X85ZZCjU+cxWgoLx@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> On older kernel(ie centos 7.8ga), when we write 1 to /proc/sys/vm/stat_refresh,
> it failed to write because this file[1] was not introdued into centos7 kernel.
> It triggers a warnging. So do_exit() in tst_test.c will report TWARN(4) to ltp-pan and
> ltp-pan think this case failed.

I've rewrote this description since I found it too confusing and pushed
the patch, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
