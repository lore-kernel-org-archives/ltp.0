From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Apr 2017 10:36:57 +0800
Subject: [LTP] [PATCH 1/2] ltp/numa: add new test11
In-Reply-To: <1488526490-22120-1-git-send-email-liwang@redhat.com>
References: <1488526490-22120-1-git-send-email-liwang@redhat.com>
Message-ID: <CAEemH2d-pXiyso8_tX7LokdWS_sX-rPLUo2ex-kF9JaqKOM-pg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ping for these two patch~

On Fri, Mar 3, 2017 at 3:34 PM, Li Wang <liwang@redhat.com> wrote:
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/numa/README         |  2 ++
>  testcases/kernel/numa/numa01.sh      | 51 ++++++++++++++++++++++++++++++++--
>  testcases/kernel/numa/support_numa.c | 53 ++++++++++++++++++++++++++++++++++--
>  3 files changed, 101 insertions(+), 5 deletions(-)
>
> diff --git a/testcases/kernel/numa/README b/testcases/kernel/numa/README
> index 57b12f7..a5c3f1b 100644
> --- a/testcases/kernel/numa/README
> +++ b/testcases/kernel/numa/README
> @@ -54,6 +54,8 @@ Verifies the numa_node_size api with hardware checking.
>  TestCase10:
>  Verifieds the NUMA migratepages policy.
>
> +TestCase11:
> +Verifies the hugepage memory allocated from the node we specify.
>
>  Pre-requisites
>  ====================================================================================================================
> diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
> index f0f6139..69e5357 100755
> --- a/testcases/kernel/numa/numa01.sh
> +++ b/testcases/kernel/numa/numa01.sh
> @@ -31,11 +31,12 @@
>  #               Test #8: Verifies memhog                                     #
>  #               Test #9: Verifies numa_node_size api                         #
>  #               Test #10:Verifies Migratepages                               #
> +#               Test #11:Verifies hugepage alloacted on specified node       #
>  #                                                                            #
>  ##############################################################################
>
>  TST_ID="numa01"
> -TST_CNT=10
> +TST_CNT=11
>  TST_SETUP=setup
>  TST_TESTFUNC=test
>  TST_NEEDS_TMPDIR=1
> @@ -83,11 +84,13 @@ setup()
>  {
>         export MB=$((1024*1024))
>         export PAGE_SIZE=$(getconf PAGE_SIZE)
> +       export HPAGE_SIZE=$(awk '/Hugepagesize:/ {print $2}' /proc/meminfo)
>
>         # arguments to memory exercise program support_numa.c
>         ALLOC_1MB=1
>         SHARE_1MB=2
> -       PAUSE=3
> +       HUGE_PAGE=3
> +       PAUSE=4
>
>         total_nodes=0
>
> @@ -399,4 +402,48 @@ test10()
>         tst_res TPASS "NUMA MIGRATEPAGES policy"
>  }
>
> +# Verification of hugepage memory allocated on a node
> +test11()
> +{
> +       Mem_huge=0
> +       Sys_node=/sys/devices/system/node
> +
> +       if [ ! -d "/sys/kernel/mm/hugepages/" ]; then
> +               tst_res TCONF "hugepage is not supported"
> +               return
> +       fi
> +
> +       for node in $nodes_list; do
> +               Ori_hpgs=$(cat ${Sys_node}/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages)
> +               New_hpgs=$((Ori_hpgs + 1))
> +               echo $New_hpgs >${Sys_node}/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages
> +
> +               Chk_hpgs=$(cat ${Sys_node}/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages)
> +               if [ "$Chk_hpgs" -ne "$New_hpgs" ]; then
> +                       tst_res TCONF "hugepage is not enough to test"
> +                       return
> +               fi
> +
> +               numactl --cpunodebind=$node --membind=$node support_numa $HUGE_PAGE &
> +               pid=$!
> +               wait_for_support_numa $pid
> +
> +               Mem_huge=$(echo $(numastat -p $pid |awk '/Huge/ {print $'$((node+2))'}'))
> +               Mem_huge=$((${Mem_huge%.*} * 1024))
> +
> +               if [ "$Mem_huge" -lt "$HPAGE_SIZE" ]; then
> +                       tst_res TFAIL \
> +                               "NUMA memory allocated in node$node is less than expected"
> +                       kill -CONT $pid >/dev/null 2>&1
> +                       echo $Ori_hpgs >${Sys_node}/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages
> +                       return
> +               fi
> +
> +               kill -CONT $pid >/dev/null 2>&1
> +               echo $Ori_hpgs >${Sys_node}/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages
> +       done
> +
> +       tst_res TPASS "NUMA local node hugepage memory allocated"
> +}
> +
>  tst_run
> diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
> index eaf63e3..97f3008 100644
> --- a/testcases/kernel/numa/support_numa.c
> +++ b/testcases/kernel/numa/support_numa.c
> @@ -22,7 +22,7 @@
>  /*                                                                            */
>  /* File:        support_numa.c                                                */
>  /*                                                                            */
> -/* Description: Allocates 1MB of memory and touches it to verify numa         */
> +/* Description: Allocates memory and touches it to verify numa                */
>  /*                                                                            */
>  /* Author:      Sivakumar Chinnaiah  Sivakumar.C@in.ibm.com                   */
>  /*                                                                            */
> @@ -52,16 +52,43 @@ static void help(void)
>         printf("Input:  Describe input arguments to this program\n");
>         printf("        argv[1] == 1 then allocate 1MB of memory\n");
>         printf("        argv[1] == 2 then allocate 1MB of share memory\n");
> -       printf("        argv[1] == 3 then pause the program to catch sigint\n");
> +       printf("        argv[1] == 3 then allocate 1HUGE PAGE SIZE of memory\n");
> +       printf("        argv[1] == 4 then pause the program to catch sigint\n");
>         printf("Exit:   On failure - Exits with non-zero value\n");
>         printf("        On success - exits with 0 exit value\n");
>
>         exit(1);
>  }
>
> +static int read_hugepagesize(void)
> +{
> +       FILE *fp;
> +       char line[BUFSIZ], buf[BUFSIZ];
> +       int val;
> +
> +       fp = fopen("/proc/meminfo", "r");
> +       if (fp == NULL) {
> +               fprintf(stderr, "Failed to open /proc/meminfo");
> +               return 0;
> +       }
> +
> +       while (fgets(line, BUFSIZ, fp) != NULL) {
> +               if (sscanf(line, "%64s %d", buf, &val) == 2)
> +                       if (strcmp(buf, "Hugepagesize:") == 0) {
> +                               fclose(fp);
> +                               return 1024 * val;
> +                       }
> +       }
> +
> +       fclose(fp);
> +       fprintf(stderr, "can't find \"%s\" in %s", "Hugepagesize:", "/proc/meminfo");
> +
> +       return 0;
> +}
> +
>  int main(int argc, char *argv[])
>  {
> -       int i, fd, rc;
> +       int i, fd, rc, hpsz;
>         char *buf = NULL;
>         struct stat sb;
>
> @@ -114,6 +141,26 @@ int main(int argc, char *argv[])
>                 remove(TEST_SFILE);
>                 break;
>         case 3:
> +               hpsz = read_hugepagesize();
> +               if (hpsz == 0)
> +                       exit(1);
> +
> +               buf = mmap(NULL, hpsz, PROT_READ | PROT_WRITE,
> +                               MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
> +                               -1, 0);
> +
> +               if (buf == MAP_FAILED) {
> +                       perror("mmap failed");
> +                       exit(1);
> +               }
> +
> +               memset(buf, 'a', hpsz);
> +
> +               raise(SIGSTOP);
> +
> +               munmap(buf, hpsz);
> +               break;
> +       case 4:
>                 raise(SIGSTOP);
>                 break;
>         default:
> --
> 1.8.3.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp



-- 
Regards,
Li Wang
Email: liwang@redhat.com
