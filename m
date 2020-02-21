From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 21 Feb 2020 17:29:04 +0100
Subject: [LTP] [PATCH] lib: fputs() in print_result() is not signal safe
In-Reply-To: <bac938d8a2d57653b9f22e55c6d222a990b6a5cf.1582301521.git.jstancek@redhat.com>
References: <bac938d8a2d57653b9f22e55c6d222a990b6a5cf.1582301521.git.jstancek@redhat.com>
Message-ID: <20200221162903.GA26343@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We have tests that use tst_res() from signal handler and current
> implementation leads to rare hangs if signal arrives in bad time:
>   main
>    tst_run_tcases
>     fork_testrun
>      testrun
>       run_tests
>        run
>         tst_res_ -> TINFO from main process
>          tst_vres_
>           print_result
>            fputs
>             __lll_lock_wait_private
>             <signal handler called>
>              tst_res_ -> TINFO from signal handler
>               tst_vres_
>                print_result
>                 fputs
>                  __lll_lock_wait_private -> HANGS
> 
> One example is timer_settime01, where we have TPASS from main process
> and TINFO as response to SIGALRM. SIGALRM happening immediately on older
> kernels might be a bug, but that is beside the point of this patch.

I guess that tst_res() wasn't even supposed to be signal-async-safe but
looking at the code I guess that this is the only change needed to make
it so.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
