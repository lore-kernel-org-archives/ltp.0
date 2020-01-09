From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Jan 2020 10:59:55 +0100
Subject: [LTP] [PATCH] syscalls/capget02: Use pid=0 instead of getpid()
In-Reply-To: <6bd663d6-2ef4-cee8-1a5c-163dc2a74d8b@cn.fujitsu.com>
References: <1578553217-29510-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <6bd663d6-2ef4-cee8-1a5c-163dc2a74d8b@cn.fujitsu.com>
Message-ID: <20200109095955.GC31981@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Since pid=0 returns the capabilities for the calling thread,
> > we can remove getpid and use pid=0 instead of it. Also we
> > can cover this test point.
> Since I defined static struct, I think it doesn't need pid=0 assignment. 
> I will send a v2 and add comment.

If you are at it, can you also allocate guarded buffers instead?

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2231-guarded-buffers

-- 
Cyril Hrubis
chrubis@suse.cz
