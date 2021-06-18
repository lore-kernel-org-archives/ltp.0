From: xieziyao <xieziyao@huawei.com>
Date: Fri, 18 Jun 2021 13:16:54 +0000
Subject: [LTP] [PATCH 3/3 v2] getrusage: Cleanup and bugfix for
 getrusage03
In-Reply-To: <YMyPhiiKwuwEdj7N@yuki>
References: <20210617105556.130869-1-xieziyao@huawei.com>
 <20210617105556.130869-4-xieziyao@huawei.com>,<YMyPhiiKwuwEdj7N@yuki>
Message-ID: <021a65c83ac448e882077e7dabe1667b@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Yes, please do.

Feel fine with your modification and thanks for your review.

Kind Regards,
Ziyao

________________________________

Xie Ziyao
Email: xieziyao@huawei.com<mailto:xieziyao@huawei.com>


From: Cyril Hrubis<chrubis@suse.cz<mailto:chrubis@suse.cz>>
To: xieziyao<xieziyao@huawei.com<mailto:xieziyao@huawei.com>>
Cc: ltp<ltp@lists.linux.it<mailto:ltp@lists.linux.it>>;mdoucha<mdoucha@suse.cz<mailto:mdoucha@suse.cz>>
Subject: Re: [LTP][PATCH 3/3 v2] getrusage: Cleanup and bugfix for getrusage03
Time: 2021-06-18 20:46:14

Hi!
>  static void sig_ign(void)
>  {
> -     tst_resm(TINFO, "Testcase #06: SIG_IGN");
> -
> -     SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> -     tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> -     signal(SIGCHLD, SIG_IGN);
> +     SAFE_SIGNAL(SIGCHLD, SIG_IGN);
> +     SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
>        maxrss_init = ru.ru_maxrss;
>
> -     switch (pid = fork()) {
> -     case -1:
> -             tst_brkm(TBROK, cleanup, "fork #6");
> -     case 0:
> -             retval = system("getrusage03_child -n 500");
> -             if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
> -                     tst_brkm(TBROK | TERRNO, cleanup, "system");
> -             exit(0);
> -     default:
> -             break;
> -     }
> +     pid_t pid = SAFE_FORK();
> +
> +     if (!pid)
> +             SAFE_EXECLP("getrusage03_child", "getrusage03_child",
> +                         "consume", "500", NULL);
>
> -     sleep(1);               /* children become zombie */
> -     SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> -     tst_resm(TINFO, "after_zombie.children = %ld", ru.ru_maxrss);
> +     TST_PROCESS_EXIT_WAIT(pid, 0);
> +     SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
>        if (is_in_delta(ru.ru_maxrss - maxrss_init))
> -             tst_resm(TPASS, "initial.children ~= after_zombie.children");
> +             tst_res(TPASS, "initial.children ~= after_zombie.children");
>        else
> -             tst_resm(TFAIL, "initial.children !~= after_zombie.children");
> -     signal(SIGCHLD, SIG_DFL);
> -}
> +             tst_res(TFAIL, "after_zombie.children = %li, expected %li",
> +                     ru.ru_maxrss, maxrss_init);

I guess that these messages could be better, techincally it's not a
zombie but rather ignored child, so I would change this to:

"initial.children ~= ignored_child.children"

Other than this the rest is good.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


Also if you agree I can fix the two minor issues in the patchset before
merge, no need to send v3.

--
Cyril Hrubis
chrubis@suse.cz
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210618/2fbe3251/attachment.htm>
