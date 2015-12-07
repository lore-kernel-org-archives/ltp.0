From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Dec 2015 10:25:03 +0100
Subject: [LTP] {get|set}_thread_area issue on ARM
In-Reply-To: <20151204034711.GA27222@yury-N73SV>
References: <20151204034711.GA27222@yury-N73SV>
Message-ID: <20151207092503.GA11996@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I just tried build ltp for arm, and one (maybe, first of) test failed
> build. Namely, set_thread_area01.c
> 
> The reason is that __NR_set_thread_area and __NR_get_thread_area are
> not declared. They should come from
> /usr/arm-linux-gnueabi/include/asm/unistd.h
> But there's only:
> [...]
> #define __NR_remap_file_pages           (__NR_SYSCALL_BASE+253)
>                                          /* for set_thread_area */
>                                          /* for get_thread_area */
> #define __NR_set_tid_address            (__NR_SYSCALL_BASE+256)
> [...]
> 
> In kernel, there are stubs for corresponding syscall numbers. So it
> looks like this pair is deprecated and unsupported. I can build ltp
> for aarch64 and x84_64 just fine.
> 
> Could someone explain me what am I doing wrong?

LTP contains stub syscall definitions for cases when certain
syscall is not supported by given arch. What is the exact error that
causes the build failure? I had a look at the test source code and the
only thing that could be an issue is that there would be duplicate case
in switch() statement since on aarch64 both __NR_set_thread_area and
__NR_get_thread_area would be defined to -1 (which means not implemented
in LTP).

-- 
Cyril Hrubis
chrubis@suse.cz
