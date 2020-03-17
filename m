From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Mar 2020 21:52:05 +0100
Subject: [LTP] [PATCH] open_posix_testsuite: Fix compilation issues
In-Reply-To: <1584430031-47227-1-git-send-email-zou_wei@huawei.com>
References: <1584430031-47227-1-git-send-email-zou_wei@huawei.com>
Message-ID: <20200317205205.GA23447@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Fix compilation issues:
> 1. Add the '-lpthread -lrt -lm' config into LDFLAGS

Just linking with -lpthread is not correct way how to compile pthread
programs on Linux, we have to add -pthread to both CLFAGS and LDFLAGS.

I guess that we should also default to the output of getconf for pthread
CFLAGS and LDFLAGS if available[1]. Unfortunately it looks like this is not
implemented on Linux yet.

So if getconf fails we will have to probably fallback to per-OS table of
CFLAGS and LDFLAGS.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/c99.html#tagtcjh_25

-- 
Cyril Hrubis
chrubis@suse.cz
