From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Mar 2016 20:07:54 +0800
Subject: [LTP] [PATCH] mm/ksm: extend 'max_page_sharing' before ksm
	testing
In-Reply-To: <1456390092-1428-1-git-send-email-liwang@redhat.com>
References: <1456390092-1428-1-git-send-email-liwang@redhat.com>
Message-ID: <CAEemH2dFwSDuNm9euwRErRWL4kdgUG_3w+wo-BzG0WMJoBqCwA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

After thinking over this change, I feel that do `echo 100000
>'/sys/kernel/mm/ksm/max_page_sharing` as hard-code is a bad idea. Since
the case ksm0[1-6].c could also accept different "num" via parameter, it
will be failed if we do `./ksm01 -n num` (eg. num >= 6, the pages >=
196608).

-------------------
# ./ksm02 -n 6
ksm02       0  TINFO  :  get node0.
ksm02       0  TINFO  :  child 0 stops.
ksm02       0  TINFO  :  child 1 stops.
ksm02       0  TINFO  :  wait for all children to stop.
ksm02       0  TINFO  :  child 3 stops.
ksm02       0  TINFO  :  child 2 stops.
ksm02       0  TINFO  :  child 4 stops.
....
ksm02       0  TINFO  :  check!
ksm02       0  TINFO  :  run is 1.
ksm02       0  TINFO  :  pages_shared is 3.
ksm02       1  TFAIL  :  mem.c:238: pages_shared is not 2.
ksm02       0  TINFO  :  pages_sharing is 196605.
ksm02       2  TFAIL  :  mem.c:238: pages_sharing is not 196606.
ksm02       0  TINFO  :  pages_volatile is 0.
ksm02       0  TINFO  :  pages_unshared is 0.
ksm02       0  TINFO  :  sleep_millisecs is 0.
ksm02       0  TINFO  :  pages_to_scan is 196608.
...


Sorry for my careless, I just use the default value 'num=3' to test my
patchV1 and get pass before. A better way to solve the problem is setting
the 'max_page_sharing' dynamically in test program.


Patch V2:
---------------
diff --git a/testcases/kernel/mem/include/mem.h
b/testcases/kernel/mem/include/mem.h
index 43988fe..019eb46 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -43,7 +43,7 @@ void testoom(int mempolicy, int lite, int retcode, int
allow_sigkill);
 /* KSM */

 #define PATH_KSM               "/sys/kernel/mm/ksm/"
-
+int max_page_sharing;
 void test_ksm_merge_across_nodes(unsigned long nr_pages);

 /* THP */
diff --git a/testcases/kernel/mem/ksm/ksm01.c
b/testcases/kernel/mem/ksm/ksm01.c
index b62df06..a352abd 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -105,6 +105,9 @@ void setup(void)
                tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
        if (access(PATH_KSM, F_OK) == -1)
                tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+       if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+               SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
+                               "%d", &max_page_sharing);

        /*
         * kernel commit 90bd6fd introduced a new KSM sysfs knob
@@ -128,4 +131,8 @@ void cleanup(void)
        if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
                FILE_PRINTF(PATH_KSM "merge_across_nodes",
                                 "%d", merge_across_nodes);
+
+       if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+               FILE_PRINTF(PATH_KSM "max_page_sharing",
+                                "%d", max_page_sharing);
 }

...

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 7b5bb35..ec25ce3 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -502,6 +502,9 @@ void create_same_memory(int size, int num, int unit)
        stop_ksm_children(child, num);

        tst_resm(TINFO, "KSM merging...");
+       if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+               SAFE_FILE_PRINTF(NULL, PATH_KSM "max_page_sharing",
+                               "%ld", size * pages * num);
        SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
        SAFE_FILE_PRINTF(cleanup, PATH_KSM "pages_to_scan", "%ld",
                         size * pages *num);


Patch V2 result PASS:
------------------------------
# ./ksm01 -n 30
ksm01       0  TINFO  :  child 0 stops.
ksm01       0  TINFO  :  child 1 stops.
ksm01       0  TINFO  :  child 2 stops.
ksm01       0  TINFO  :  child 3 stops.
ksm01       0  TINFO  :  child 4 stops.
ksm01       0  TINFO  :  child 5 stops.
ksm01       0  TINFO  :  child 6 stops.
...
ksm01       0  TINFO  :  check!
ksm01       0  TINFO  :  run is 1.
ksm01       0  TINFO  :  pages_shared is 2.
ksm01       0  TINFO  :  pages_sharing is 983038.
ksm01       0  TINFO  :  pages_volatile is 0.
ksm01       0  TINFO  :  pages_unshared is 0.
ksm01       0  TINFO  :  sleep_millisecs is 0.
ksm01       0  TINFO  :  pages_to_scan is 983040.
....

Comments welcome, if no objection, I will send PATCH V2 tomorrow.

Regards,
Li Wang


On Thu, Feb 25, 2016 at 4:48 PM, Li Wang <liwang@redhat.com> wrote:

> This kernel commit (de39e60a6, ksm: introduce ksm_max_page_sharing per
> page...)
> introduced a new KSM sysfs knob '/sys/kernel/mm/ksm/max_page_sharing' in
> linux-next.
>
> The runtime value of 'max_page_sharing' will affect
> pages_shared/pages_sharing,
> because this enforces a deduplication limit to avoid the virtual memory
> rmap lists
> to grow too large.
>
> ltp/ksm0* tests can easily get failures on that kernel like:
> -----
> ksm01       0  TINFO  :  wait for all children to stop.
> ksm01       0  TINFO  :  KSM merging...
> ksm01       0  TINFO  :  resume all children.
> ksm01       0  TINFO  :  child 2 stops.
> ...
> ksm01       0  TINFO  :  run is 1.
> ksm01       0  TINFO  :  pages_shared is 384.
> ksm01       1  TFAIL  :  mem.c:238: pages_shared is not 2.
> ksm01       0  TINFO  :  pages_sharing is 97920.
> ksm01       2  TFAIL  :  mem.c:238: pages_sharing is not 98302.
> ksm01       0  TINFO  :  pages_volatile is 0.
> ksm01       0  TINFO  :  pages_unshared is 0.
> ksm01       0  TINFO  :  sleep_millisecs is 0.
> ksm01       0  TINFO  :  pages_to_scan is 98304.
>
> So, I composed this patch to extend the 'max_page_sharing' value to make
> tests pass.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/mem/ksm/ksm01.c | 10 ++++++++++
>  testcases/kernel/mem/ksm/ksm02.c | 10 ++++++++++
>  testcases/kernel/mem/ksm/ksm03.c | 11 +++++++++++
>  testcases/kernel/mem/ksm/ksm04.c | 11 +++++++++++
>  testcases/kernel/mem/ksm/ksm06.c | 10 ++++++++++
>  5 files changed, 52 insertions(+)
>
> diff --git a/testcases/kernel/mem/ksm/ksm01.c
> b/testcases/kernel/mem/ksm/ksm01.c
> index b62df06..fccae1c 100644
> --- a/testcases/kernel/mem/ksm/ksm01.c
> +++ b/testcases/kernel/mem/ksm/ksm01.c
> @@ -73,6 +73,7 @@ char *TCID = "ksm01";
>  int TST_TOTAL = 1;
>
>  static int merge_across_nodes;
> +static int max_page_sharing;
>
>  option_t ksm_options[] = {
>         {"n:", &opt_num, &opt_numstr},
> @@ -105,6 +106,11 @@ void setup(void)
>                 tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
>         if (access(PATH_KSM, F_OK) == -1)
>                 tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
> +       if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
> +               SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
> +                               "%d", &max_page_sharing);
> +               SAFE_FILE_PRINTF(NULL, PATH_KSM "max_page_sharing",
> "100000");
> +       }
>
>         /*
>          * kernel commit 90bd6fd introduced a new KSM sysfs knob
> @@ -128,4 +134,8 @@ void cleanup(void)
>         if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
>                 FILE_PRINTF(PATH_KSM "merge_across_nodes",
>                                  "%d", merge_across_nodes);
> +
> +       if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
> +               FILE_PRINTF(PATH_KSM "max_page_sharing",
> +                                "%d", max_page_sharing);
>  }
> diff --git a/testcases/kernel/mem/ksm/ksm02.c
> b/testcases/kernel/mem/ksm/ksm02.c
> index 537ec01..8ca397a 100644
> --- a/testcases/kernel/mem/ksm/ksm02.c
> +++ b/testcases/kernel/mem/ksm/ksm02.c
> @@ -73,6 +73,7 @@ char *TCID = "ksm02";
>  int TST_TOTAL = 1;
>
>  static int merge_across_nodes;
> +static int max_page_sharing;
>
>  #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
>         && HAVE_MPOL_CONSTANTS
> @@ -125,6 +126,10 @@ void cleanup(void)
>                 FILE_PRINTF(PATH_KSM "merge_across_nodes",
>                                  "%d", merge_across_nodes);
>
> +       if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
> +               FILE_PRINTF(PATH_KSM "max_page_sharing",
> +                               "%d", max_page_sharing);
> +
>         umount_mem(CPATH, CPATH_NEW);
>  }
>
> @@ -136,6 +141,11 @@ void setup(void)
>                 tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
>         if (access(PATH_KSM, F_OK) == -1)
>                 tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
> +       if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
> +               SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
> +                               "%d", &max_page_sharing);
> +               SAFE_FILE_PRINTF(NULL, PATH_KSM "max_page_sharing",
> "100000");
> +       }
>
>         if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
>                 SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
> diff --git a/testcases/kernel/mem/ksm/ksm03.c
> b/testcases/kernel/mem/ksm/ksm03.c
> index b73e023..8670ed8 100644
> --- a/testcases/kernel/mem/ksm/ksm03.c
> +++ b/testcases/kernel/mem/ksm/ksm03.c
> @@ -73,6 +73,7 @@ char *TCID = "ksm03";
>  int TST_TOTAL = 1;
>
>  static int merge_across_nodes;
> +static int max_page_sharing;
>
>  option_t ksm_options[] = {
>         {"n:", &opt_num, &opt_numstr},
> @@ -113,6 +114,12 @@ void setup(void)
>                 SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
>         }
>
> +       if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
> +               SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
> +                               "%d", &max_page_sharing);
> +               SAFE_FILE_PRINTF(NULL, PATH_KSM "max_page_sharing",
> "100000");
> +       }
> +
>         mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
>         tst_sig(FORK, DEF_HANDLER, NULL);
>         TEST_PAUSE;
> @@ -124,5 +131,9 @@ void cleanup(void)
>                 FILE_PRINTF(PATH_KSM "merge_across_nodes",
>                                  "%d", merge_across_nodes);
>
> +       if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
> +               FILE_PRINTF(PATH_KSM "max_page_sharing",
> +                               "%d", max_page_sharing);
> +
>         umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
>  }
> diff --git a/testcases/kernel/mem/ksm/ksm04.c
> b/testcases/kernel/mem/ksm/ksm04.c
> index 0c1d4e0..15988f7 100644
> --- a/testcases/kernel/mem/ksm/ksm04.c
> +++ b/testcases/kernel/mem/ksm/ksm04.c
> @@ -73,6 +73,7 @@ char *TCID = "ksm04";
>  int TST_TOTAL = 1;
>
>  static int merge_across_nodes;
> +static int max_page_sharing;
>
>  #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
>         && HAVE_MPOL_CONSTANTS
> @@ -127,6 +128,10 @@ void cleanup(void)
>                 FILE_PRINTF(PATH_KSM "merge_across_nodes",
>                                  "%d", merge_across_nodes);
>
> +       if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
> +               FILE_PRINTF(PATH_KSM "max_page_sharing",
> +                               "%d", max_page_sharing);
> +
>         umount_mem(CPATH, CPATH_NEW);
>         umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
>  }
> @@ -146,6 +151,12 @@ void setup(void)
>                 SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
>         }
>
> +       if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
> +               SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
> +                               "%d", &max_page_sharing);
> +               SAFE_FILE_PRINTF(NULL, PATH_KSM "max_page_sharing",
> "100000");
> +       }
> +
>         tst_sig(FORK, DEF_HANDLER, cleanup);
>         TEST_PAUSE;
>         mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
> diff --git a/testcases/kernel/mem/ksm/ksm06.c
> b/testcases/kernel/mem/ksm/ksm06.c
> index 1cda01f..3d12419 100644
> --- a/testcases/kernel/mem/ksm/ksm06.c
> +++ b/testcases/kernel/mem/ksm/ksm06.c
> @@ -57,6 +57,7 @@ int TST_TOTAL = 1;
>  static int run;
>  static int sleep_millisecs;
>  static int merge_across_nodes;
> +static int max_page_sharing;
>  static int n_flag;
>  static unsigned long nr_pages;
>
> @@ -104,6 +105,11 @@ void setup(void)
>                         "%d", &merge_across_nodes);
>         SAFE_FILE_SCANF(NULL, PATH_KSM "sleep_millisecs",
>                         "%d", &sleep_millisecs);
> +       if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
> +               SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
> +                               "%d", &max_page_sharing);
> +               SAFE_FILE_PRINTF(NULL, PATH_KSM "max_page_sharing",
> "100000");
> +       }
>
>         tst_sig(FORK, DEF_HANDLER, cleanup);
>         TEST_PAUSE;
> @@ -116,6 +122,10 @@ void cleanup(void)
>         FILE_PRINTF(PATH_KSM "sleep_millisecs",
>                          "%d", sleep_millisecs);
>         FILE_PRINTF(PATH_KSM "run", "%d", run);
> +
> +       if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
> +               FILE_PRINTF(PATH_KSM "max_page_sharing",
> +                               "%d", max_page_sharing);
>  }
>
>  static void usage(void)
> --
> 1.8.3.1
>
>
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160308/f38397a6/attachment-0001.html>
