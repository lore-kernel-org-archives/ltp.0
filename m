From: Li Wang <liwang@redhat.com>
Date: Sat, 2 Jan 2021 17:23:42 +0800
Subject: [LTP] [RFC PATCH 3/5] CGroup API tests
In-Reply-To: <20201216100121.16683-4-rpalethorpe@suse.com>
References: <20201216100121.16683-1-rpalethorpe@suse.com>
 <20201216100121.16683-4-rpalethorpe@suse.com>
Message-ID: <CAEemH2cLkNbczZ7n-wvyxfAiVtM6+vyjUpV84_Rx3wuN+tonwg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Richard Palethorpe via ltp <ltp@lists.linux.it> wrote:

Rewrite of existing test and new test for the CGroups API.
> ...
> --- a/lib/newlib_tests/test21.c
> +++ b/lib/newlib_tests/test21.c
> @@ -11,8 +11,6 @@
>  #include "tst_test.h"
>  #include "tst_cgroup.h"
>
> -#define PATH_CGROUP1 "/mnt/liwang1"
> -#define PATH_CGROUP2 "/mnt/liwang2"
>  #define MEMSIZE 1024 * 1024
>
>  static void do_test(void)
> @@ -21,19 +19,16 @@ static void do_test(void)
>
>         switch (pid) {
>         case 0:
> -               tst_cgroup_move_current(PATH_CGROUP1);
> -               tst_cgroup_mem_set_maxbytes(PATH_CGROUP1, MEMSIZE);
> -               tst_cgroup_mem_set_maxswap(PATH_CGROUP1, MEMSIZE);
> -
> -               tst_cgroup_move_current(PATH_CGROUP2);
> -
> +               tst_cgroup_move_current(TST_CGROUP_MEMORY);
> +               tst_cgroup_mem_set_maxbytes(MEMSIZE);
> +               tst_cgroup_mem_set_maxswap(MEMSIZE);
>

We'd better set a different value(maybe MEMSIZE/2) for the child's
CGROUP_MEMORY because test21 is designed to verify there is
no race condition when multithread using the same controller. In
other words, we need to avoid that iteration become a NOP.



>         break;
>         default:
> -               tst_cgroup_move_current(PATH_TMP_CG_CST);
> +               tst_cgroup_move_current(TST_CGROUP_CPUSET);
>
> -               tst_cgroup_move_current(PATH_TMP_CG_MEM);
> -               tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, MEMSIZE);
> -               tst_cgroup_mem_set_maxswap(PATH_TMP_CG_MEM, MEMSIZE);
> +               tst_cgroup_move_current(TST_CGROUP_MEMORY);
> +               tst_cgroup_mem_set_maxbytes(MEMSIZE);
> +               tst_cgroup_mem_set_maxswap(MEMSIZE);
>         break;
>         }
>
> @@ -42,20 +37,11 @@ static void do_test(void)
>
>  static void setup(void)
>  {
> -       tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
> -       tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_CGROUP1);
> -
> -       tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
> -       tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_CGROUP2);
> +       tst_cgroup_require(TST_CGROUP_MEMORY, NULL);
>

The test requires _CPUSET too:
    tst_cgroup_require(TST_CGROUP_CPUSET, NULL);

 }
>
>  static void cleanup(void)
>  {
> -       tst_cgroup_umount(PATH_TMP_CG_MEM);
> -       tst_cgroup_umount(PATH_CGROUP1);
> -
> -       tst_cgroup_umount(PATH_TMP_CG_CST);
> -       tst_cgroup_umount(PATH_CGROUP2);
>  }
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210102/9e77d7a7/attachment-0001.htm>
