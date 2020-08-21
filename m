From: Li Wang <liwang@redhat.com>
Date: Fri, 21 Aug 2020 14:57:32 +0800
Subject: [LTP] [PATCH 4/4] syscalls/kill06:Cleanup && Convert to new
 library
In-Reply-To: <1597919168-10702-4-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1597919168-10702-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1597919168-10702-4-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <CAEemH2dPXaV24bT4Ddp47iEWDzV5837SfDtsKEKB7_VbLNg9xA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Feiyu Zhu <zhufy.jy@cn.fujitsu.com> wrote:

...
> +       pid_t pid, child_pid[5];
>

I'd suggest dropping these two variables since it makes no sense to
save the children PIDs in the following testing.



> +       int nsig, i, status;
> +
> +       pid = SAFE_FORK();
> +       if (pid == 0) {
> +               setpgrp();
> +               for (i = 0; i < 5; i++) {
> +                       child_pid[i] = SAFE_FORK();
>

if we drop the arrays, that loop would be like:

                for (i = 0; i < 5; i++) {
                        if (!SAFE_FORK())
                                pause();
                }



> +                       if (!child_pid[i])
> +                               pause();
>                 }
>
> -               /*
> -                * Check to see if the process was terminated with the
> -                * expected signal.
> -                */
> -               nsig = WTERMSIG(status);
> -               if (!nsig) {
> -                       tst_resm(TFAIL, "Did not receive any signal");
> -               } else if (nsig == TEST_SIG) {
> -                       tst_resm(TPASS, "received expected signal %d",
> -                                nsig);
> -               } else {
> -                       tst_resm(TFAIL,
> -                                "expected signal %d received %d",
> -                                TEST_SIG, nsig);
> -               }
> +               TEST(kill(-getpgrp(), SIGKILL));
> +               if (TST_RET != 0)
> +                       tst_res(TFAIL | TTERRNO, "kill failed");
> +               tst_res(TINFO, "%d never received a signal", getpid());
>

This TINFO is a misleading message to people. If the process receives a
signal
but not been killed, how do you say that never received a signal?
So I suggest deleting this line.


> +               exit(0);
>         }
> -
> -       cleanup();
> -       tst_exit();
> -}
> -
> -/*
> - * do_child()
> - */
> -void do_child(void)
> -{
> -       int exno = 1;
> -
> -       sleep(299);
> -
> -       tst_resm(TINFO, "%d never received a" " signal", getpid());
> -       exit(exno);
> -}
> -
> -/*
> - * setup() - performs all ONE TIME setup for this test
> - */
> -void setup(void)
> -{
> -       /* Setup default signal handling */
> -       tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -       TEST_PAUSE;
> +
> +       SAFE_WAITPID(pid, &status, 0);
>

What about waiting for any child process here?
  SAFE_WAITPID(-1, &status, 0);



> +       nsig = WTERMSIG(status);
> +       if (nsig != SIGKILL) {
> +               tst_res(TFAIL, "wait: unexpected signal %d returned, "
> +                       "expected SIGKILL(9)", nsig);
> +               return;
> +       }
> +       tst_res(TPASS, "receive expected signal SIGKILL(9)");
>  }
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200821/43a364ab/attachment-0001.htm>
