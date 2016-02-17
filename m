From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Feb 2016 09:51:09 +0800
Subject: [LTP] [PATCH] mem/oom: do cleanup work for oom0{3,4,5}
In-Reply-To: <1454074573-5205-1-git-send-email-liwang@redhat.com>
References: <1454074573-5205-1-git-send-email-liwang@redhat.com>
Message-ID: <CAEemH2fnOp_FuXAbq9JPw6wtabCUQY5cxeCk0eGT9e041kx82g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sorry, ping~

On Fri, Jan 29, 2016 at 9:36 PM, Li Wang <liwang@redhat.com> wrote:

> oom03 should not test on aarch64 system which does not support NUMA, so I
> add
> the function to make sure it could be skiped.
> -----
>   # ./oom03
>   oom03       0  TINFO  :  set overcommit_memory to 1
>   ...
>   oom03       0  TINFO  :  expected victim is 29154.
>   oom03       6  TPASS  :  victim signalled: (9) SIGKILL
>   oom03       7  TCONF  :  numa_helper.c:86: syscall(236)
> __NR_get_mempolicy not supported on your arch
>   oom03       8  TCONF  :  numa_helper.c:86: Remaining cases not
> appropriate for configuration
>
> oom0{4,5} get fails on aarch64 system if run it in continuous twice(the
> first time skiped with TCONF, then the second time it will be failed).
> -----
>   # ./oom05
>   oom05       0  TINFO  :  set overcommit_memory to 1
>   oom05       1  TCONF  :  numa_helper.c:86: syscall(236)
> __NR_get_mempolicy not supported on your arch
>   oom05       2  TCONF  :  numa_helper.c:86: Remaining cases not
> appropriate for configuration
>
>   # ./oom05
>   oom05       0  TINFO  :  set overcommit_memory to 1
>   oom05       1  TBROK  :  mem.c:997: mkdir /dev/cgroup: errno=EEXIST(17):
> File exists
>   oom05       2  TBROK  :  mem.c:997: Remaining cases broken
>   oom05       0  TINFO  :  set overcommit_memory to 1
>
> the reason is that it doesn't pass the cleanup to the tst_brkm() there.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> -----
> ---
>  testcases/kernel/mem/oom/oom03.c | 3 +++
>  testcases/kernel/mem/oom/oom04.c | 2 +-
>  testcases/kernel/mem/oom/oom05.c | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/mem/oom/oom03.c
> b/testcases/kernel/mem/oom/oom03.c
> index 3afc3de..eabaeb9 100644
> --- a/testcases/kernel/mem/oom/oom03.c
> +++ b/testcases/kernel/mem/oom/oom03.c
> @@ -94,6 +94,9 @@ void setup(void)
>         tst_sig(FORK, DEF_HANDLER, cleanup);
>         TEST_PAUSE;
>
> +       if (!is_numa(NULL))
> +               tst_brkm(TCONF, NULL, "The case need a NUMA system.");
> +
>         overcommit = get_sys_tune("overcommit_memory");
>         set_sys_tune("overcommit_memory", 1, 1);
>         mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
> diff --git a/testcases/kernel/mem/oom/oom04.c
> b/testcases/kernel/mem/oom/oom04.c
> index ffb5503..0a315e1 100644
> --- a/testcases/kernel/mem/oom/oom04.c
> +++ b/testcases/kernel/mem/oom/oom04.c
> @@ -100,7 +100,7 @@ void setup(void)
>          */
>         ret = get_allowed_nodes(NH_MEMS, 1, &memnode);
>         if (ret < 0)
> -               tst_brkm(TBROK, NULL, "Failed to get a memory node "
> +               tst_brkm(TBROK, cleanup, "Failed to get a memory node "
>                                       "using get_allowed_nodes()");
>         write_cpusets(memnode);
>  }
> diff --git a/testcases/kernel/mem/oom/oom05.c
> b/testcases/kernel/mem/oom/oom05.c
> index 9cd49a7..44a243e 100644
> --- a/testcases/kernel/mem/oom/oom05.c
> +++ b/testcases/kernel/mem/oom/oom05.c
> @@ -125,7 +125,7 @@ void setup(void)
>          */
>         ret = get_allowed_nodes(NH_MEMS, 1, &memnode);
>         if (ret < 0)
> -               tst_brkm(TBROK, NULL, "Failed to get a memory node "
> +               tst_brkm(TBROK, cleanup, "Failed to get a memory node "
>                                       "using get_allowed_nodes()");
>         write_cpusets(memnode);
>  }
> --
> 1.9.3
>
>
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
>



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160217/b5ca4fd8/attachment.html>
