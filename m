From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Jan 2017 19:01:30 +0800
Subject: [LTP] [PATCH] hugetlb: Fix tbrok issue in hugeshmat04
In-Reply-To: <365ca34e-bc84-2c59-3829-6d8369c6d09c@linux.vnet.ibm.com>
References: <365ca34e-bc84-2c59-3829-6d8369c6d09c@linux.vnet.ibm.com>
Message-ID: <CAEemH2eGor5uA9Bji93mADnps_3TXS4+498LS4=thcoCPssBnQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jan 11, 2017 at 2:37 PM, charishma <charishm@linux.vnet.ibm.com> wrote:
> hugeshmat04 tests are broken when the number of hugepages are less that
> expected.
>
> The check in set_sys_tune is causing the test execution to break,by removing
> this check in set_sys_tune function the test works fine.

set_sys_tune() do an examination to make sure nr_hugepages be set
correctly when give 1 to parameter 'check', if something wrong, test
break and exit. That is what we expected.

So, I doubt if there are some other reasons cause the failure.
can you do some check on your test machine as:

 # echo 1024 >/proc/sys/vm/nr_hugepages
 # cat /proc/meminfo |grep -i huge
 AnonHugePages:     10240 kB
 HugePages_Total:    1024
 HugePages_Free:     1024
 HugePages_Rsvd:        0
 HugePages_Surp:        0
 Hugepagesize:       2048 kB

or,
 # echo 0 >/proc/sys/vm/nr_hugepages
before running hugeshmat04?


>
> hugeshmat04    0  TINFO  :  set nr_hugepages to 1024
> hugeshmat04    1  TBROK  :  mem.c:1053: nr_hugepages = 1003, but expect 1024
> hugeshmat04    2  TBROK  :  mem.c:1053: Remaining cases broken
> hugeshmat04    0  TINFO  :  set nr_hugepages to 0
>
> Signed-off-by: Aneesh kumar <aneesh.kumar@in.ibm.com>
> Tested-by: Charishma M <charism2@in.ibm.com>
>
> Patch :
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> index 7a717476f4c8..cbb18a25a4f4 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> @@ -143,7 +143,7 @@ void setup(void)
>   hpage_size = read_meminfo("Hugepagesize:") * 1024;
>
>   hugepages = (orig_hugepages * hpage_size + SIZE) / hpage_size;
> - set_sys_tune("nr_hugepages", hugepages, 1);
> + hugepages = set_sys_tune("nr_hugepages", hugepages, 0);
>
>   TEST_PAUSE;
>  }
> diff --git a/testcases/kernel/mem/include/mem.h
> b/testcases/kernel/mem/include/mem.h
> index f9522a52ba16..2f6eb7d7beca 100644
> --- a/testcases/kernel/mem/include/mem.h
> +++ b/testcases/kernel/mem/include/mem.h
> @@ -87,7 +87,7 @@ void umount_mem(char *path, char *path_new);
>  unsigned int get_a_numa_node(void (*cleanup_fn)(void));
>  int  path_exist(const char *path, ...);
>  long read_meminfo(char *item);
> -void set_sys_tune(char *sys_file, long tune, int check);
> +long set_sys_tune(char *sys_file, long tune, int check);
>  long get_sys_tune(char *sys_file);
>  void cleanup(void);
>  void setup(void);
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 7e403b545228..6a9af0f2ea8c 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -927,7 +927,7 @@ long read_meminfo(char *item)
>   item, PATH_MEMINFO);
>  }
>
> -void set_sys_tune(char *sys_file, long tune, int check)
> +long set_sys_tune(char *sys_file, long tune, int check)
>  {
>   long val;
>   char path[BUFSIZ];
> @@ -936,13 +936,14 @@ void set_sys_tune(char *sys_file, long tune, int
> check)
>
>   snprintf(path, BUFSIZ, PATH_SYSVM "%s", sys_file);
>   SAFE_FILE_PRINTF(NULL, path, "%ld", tune);
> + val = get_sys_tune(sys_file);
>
>   if (check) {
> - val = get_sys_tune(sys_file);
>   if (val != tune)
>   tst_brkm(TBROK, cleanup, "%s = %ld, but expect %ld",
>   sys_file, val, tune);
>   }
> + return val;
>  }
>
>  long get_sys_tune(char *sys_file)
>
> Thanks,
> Charishma M.
>
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>



-- 
Regards,
Li Wang
Email: liwang@redhat.com
