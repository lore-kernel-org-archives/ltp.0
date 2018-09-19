From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Sep 2018 09:25:18 +0200
Subject: [LTP] [PATCH] mem/mmapstress10: fix hangs with recent glibc
In-Reply-To: <cda846784ce55a77519a5ea86b6b073899a20ab6.1537285751.git.jstancek@redhat.com>
References: <cda846784ce55a77519a5ea86b6b073899a20ab6.1537285751.git.jstancek@redhat.com>
Message-ID: <20180919072518.GA28540@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> There haven't been any major changes to this test in years,
> so presumably something in recent glibc changed, that exposed
> this problem.

I guess that it may have been elsewhere as well, such as kernel
scheduller changes, etc.

> I confirmed with glibc-2.28, that this test can hang quite reliably
> on 2 CPU KVM guest. It reproduces easier with smaller number of loops
> for child_mapper() and overall test runtime reduced (-p 20 -t 0.02).
> 
> The problem is that childs' signal handler and main function both
> call exit(), which can deadlock on __exit_funcs_lock:
> 
>   #0  0x00007f0619d72f8c in __lll_lock_wait_private () from /lib64/libc.so.6
>   #1  0x00007f0619ca2f4b in __run_exit_handlers () from /lib64/libc.so.6
>   #2  0x00007f0619ca3160 in exit () from /lib64/libc.so.6
>   #3  0x00000000004039d8 in clean_mapper (sig=<optimized out>) at mmapstress10.c:898
>   #4  <signal handler called>
>   #5  0x00007f0619ca2fbd in __run_exit_handlers () from /lib64/libc.so.6
>   #6  0x00007f0619ca3160 in exit () from /lib64/libc.so.6
>   #7  0x0000000000403e7f in child_mapper (file=file@entry=0x40f530 "mmapstress10.out", procno=<optimized out>,
>       nprocs=nprocs@entry=20) at mmapstress10.c:676
>   #8  0x0000000000403833 in main (argc=<optimized out>, argv=<optimized out>) at mmapstress10.c:458
> 
> Switch all signal handlers to _exit().

Looks like a reasonable band aid for the problem. I looked shortly at
the source code and anything cleaner would require larger rewrite, so
acked.

-- 
Cyril Hrubis
chrubis@suse.cz
