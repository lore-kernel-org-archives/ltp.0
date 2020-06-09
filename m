From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Jun 2020 20:55:49 +0800
Subject: [LTP] [PATCH V4 06/17] syscalls/futex: Add support for time64
 tests
In-Reply-To: <ff8a9eee3642f28a365437c9a42e5126e90bc242.1590144577.git.viresh.kumar@linaro.org>
References: <cover.1590144577.git.viresh.kumar@linaro.org>
 <ff8a9eee3642f28a365437c9a42e5126e90bc242.1590144577.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2fmr+jXW3kZ5LAMrGH0ReHND2jr-TqoSHm9p9WBePtE3g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 22, 2020 at 6:53 PM Viresh Kumar <viresh.kumar@linaro.org>
wrote:

> ...
> diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c
> b/testcases/kernel/syscalls/futex/futex_wake04.c
> index f92bda53f6c7..edbb9c644c57 100644
> --- a/testcases/kernel/syscalls/futex/futex_wake04.c
> +++ b/testcases/kernel/syscalls/futex/futex_wake04.c
> ...
>
>  static void wakeup_thread2(void)
>  {
> +       struct test_variants *tv = &variants[tst_variant];
>         void *addr;
>         int hpsz, pgsz, res;
>         pthread_t th1, th2;
>
>         hpsz = read_hugepagesize();
> -       tst_resm(TINFO, "Hugepagesize %i", hpsz);
> +       tst_res(TINFO, "Hugepagesize %i", hpsz);
>
>         /*allocate some shared memory*/
>         addr = mmap(NULL, hpsz, PROT_WRITE | PROT_READ,
>                     MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
>
>         if (addr == MAP_FAILED) {
> -               if (errno == ENOMEM) {
> -                       tst_brkm(TCONF, NULL,
> -                                "Cannot allocate hugepage, memory too
> fragmented?");
> -               }
> +               if (errno == ENOMEM)
> +                       tst_res(TCONF, "Cannot allocate hugepage, memory
> too fragmented?");
>

Here we can use tst_brk(TCONF, ...), otherwise, the if condition will out
of action for ENOMEM.

-               tst_brkm(TBROK | TERRNO, NULL, "Cannot allocate hugepage");
> +               tst_res(TFAIL | TERRNO, "Cannot allocate hugepage");
> +               return;
>

tst_brk(TBROK | TERRNO, ...)

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200609/cd003ff1/attachment.htm>
