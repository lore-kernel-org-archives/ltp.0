From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Dec 2017 15:01:43 +0100
Subject: [LTP] [PATCH] [RFC] brk01: Rewrite from scratch.
In-Reply-To: <767241426.54027806.1513084281907.JavaMail.zimbra@redhat.com>
References: <20171212112148.17424-1-chrubis@suse.cz>
 <767241426.54027806.1513084281907.JavaMail.zimbra@redhat.com>
Message-ID: <20171212140143.GF12279@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> git format-patch has parameter "-B", that can make big rewrites
> more readable.

Will use it next time, thanks.

> diff --git a/testcases/kernel/syscalls/brk/brk01.c b/testcases/kernel/syscalls/brk/brk01.c
> index 2467ef6732a0..d77c000df105 100644
> --- a/testcases/kernel/syscalls/brk/brk01.c
> +++ b/testcases/kernel/syscalls/brk/brk01.c
> @@ -22,6 +22,7 @@
>  
>  #include "tst_test.h"
>  
> +void *ptr;
>  void verify_brk(void)
>  {
>         uintptr_t cur_brk, new_brk;
> @@ -65,6 +66,9 @@ void verify_brk(void)
>                 /* Try to write to the newly allocated heap */
>                 if (i % 3 == 0)
>                         *((char *)cur_brk) = 0;
> +               ptr = malloc(2*4096);
> +               printf("%p\n", ptr);
> +
>         }
>  
>         tst_res(TPASS, "brk() works fine");
> 
> $ ./brk01
> ...
> tst_test.c:1022: BROK: Test killed by SIGSEGV!
> 
> My concern is that glibc allocates something as result
> of tst_* calls (e.g. buffered I/O write) and then we
> either write over it or de-allocate it. I think we should
> drop/postpone first tst_res().

Sounds reasonably I'm okay with dropping the tst_res() in the middle of
the loop. I guess that doing any library calls between the brk() that
enlarges and shrinks the heap is dangerous indeed.

And we may also increse the heap size by a few pages before we start the
actual test just as a safety measure.

-- 
Cyril Hrubis
chrubis@suse.cz
