From: Li Wang <liwang@redhat.com>
Date: Fri, 8 Jan 2021 14:22:54 +0800
Subject: [LTP] [PATCH v2 1/1] syscalls/get_mempolicy01: Rewrite to new
 API
In-Reply-To: <20210106181735.1588-1-pvorel@suse.cz>
References: <20210106181735.1588-1-pvorel@suse.cz>
Message-ID: <CAEemH2dVgwHREFGrOe1tNUgZXZn5OAo5PJ-nne_yoj2nRHt=pw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Petr Vorel <pvorel@suse.cz> wrote:

[...]
> +static void do_test(unsigned int i)
>  {
> -       /* check syscall availability */
> -       ltp_syscall(__NR_get_mempolicy, NULL, NULL, 0, NULL, 0);
> +       struct test_case *tc = &tcase[i];
> +       int policy;
> +
> +       tst_res(TINFO, "test #%d: %s", i+1, tc->desc);
>
> -       if (!is_numa(NULL, NH_MEMS, 1))
> -               tst_brkm(TCONF, NULL, "requires NUMA with at least 1
> node");
> +       TST_EXP_PASS(get_mempolicy(&policy, getnodemask->maskp,
> getnodemask->size,
> +                          tc->addr, tc->flags), "%s", tc->desc);
>
> -       TEST_PAUSE;
> -       tst_tmpdir();
> +               struct bitmask *exp_mask = *(tc->exp_nodemask);
> +
> +               if (!numa_bitmask_equal(exp_mask, getnodemask)) {
> +                       tst_res(TFAIL, "masks are not equal");
> +                       tst_res_hexd(TINFO, exp_mask->maskp,
> +                               exp_mask->size / 8, "expected:");
> +                       tst_res_hexd(TINFO, getnodemask->maskp,
> +                               getnodemask->size / 8, "returned:");
> +               }
>

These few lines have a code indent issue, otherwise looks good.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210108/e7367c68/attachment.htm>
