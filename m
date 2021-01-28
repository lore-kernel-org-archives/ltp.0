From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jan 2021 16:37:38 +0100
Subject: [LTP] [PATCH v1 2/3] syscalls/mallinfo02: Add a basic test to
 check use mmap or sbrk
In-Reply-To: <1611654925-8994-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1611654925-8994-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <YBLaQvt2g3z8Xy1A@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> "The number of bytes in blocks currently allocated using mmap(2).".
> For allocations greater than or equal to 128K and that can't be satisfied from
> the free list, the memory-allocation functions employ mmap(2) instead of increasing
> the program break using sbrk(2).
>
> In this case, we test 20k size to use sbrk and 128k size to use mmap.

The size when glibc uses mmap() instead of heap is libc implementation
detail. I'm not sure that we want to have that value hardcoded in a LTP test.

Also glibc documentation says:

The default value is set to `131072' bytes and the threshold is adjusted
dynamically to suit the allocation patterns of the program.

-- 
Cyril Hrubis
chrubis@suse.cz
