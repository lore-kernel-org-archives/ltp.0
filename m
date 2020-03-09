From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 9 Mar 2020 11:57:02 +0800
Subject: [LTP] [PATCH v2] hugeshmctl01: Small refactor and remove
 stat_time
In-Reply-To: <CAEemH2ce95Uyi1cZumF4drQ7NtehVwWyhcTM5L7cEjcb7he+oA@mail.gmail.com>
References: <20200306071221.GA13530@dell5510>
 <1583490720-10003-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2ce95Uyi1cZumF4drQ7NtehVwWyhcTM5L7cEjcb7he+oA@mail.gmail.com>
Message-ID: <1d808289-aa4b-a47d-55cd-81908aaa532c@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li

> Hi XuYang,
> 
> Thanks for the quick work on refactoring. I'd suggest using the new 
> '.request_hugepages'? in the testcase, would mind having a try?
OK. But I think we can merge this patch( it has a new line before 
func_stat, remove ..) firstly and then I will use this library api in 
next patch for all related  hugepage cases.

Best Regards
Yang Xu
> 
> --- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
> @@ -53,8 +53,6 @@ static void func_set(void);
>  ?static void func_rmid(void);
>  ?static void *set_shmat(void);
> 
> -static long hugepages = 128;
> -
>  ?static struct tst_option options[] = {
>  ? ? ? ? {"s:", &nr_opt, "-s ? num ?Set the number of the been allocated 
> hugepages"},
>  ? ? ? ? {NULL, NULL, NULL}
> @@ -290,15 +288,16 @@ void setup(void)
>  ?{
>  ? ? ? ? long hpage_size;
> 
> - ? ? ? save_nr_hugepages();
> - ? ? ? if (nr_opt)
> - ? ? ? ? ? ? ? hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
> + ? ? ? if (nr_opt) {
> + ? ? ? ? ? ? ? tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
> + ? ? ? ? ? ? ? tst_request_hugepages(tst_hugepages);
> + ? ? ? }
> +
> + ? ? ? if (tst_hugepages == 0)
> + ? ? ? ? ? ? ? tst_brk(TCONF, "No enough hugepages for testing");
> 
> - ? ? ? limit_hugepages(&hugepages);
> - ? ? ? set_sys_tune("nr_hugepages", hugepages, 1);
>  ? ? ? ? hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
> -
> - ? ? ? shm_size = hpage_size * hugepages / 2;
> + ? ? ? shm_size = hpage_size * tst_hugepages / 2;
>  ? ? ? ? update_shm_size(&shm_size);
>  ? ? ? ? shmkey = getipckey();
>  ?}
> @@ -306,7 +305,6 @@ void setup(void)
>  ?void cleanup(void)
>  ?{
>  ? ? ? ? rm_shm(shm_id_1);
> - ? ? ? restore_nr_hugepages();
>  ?}
> 
>  ?static struct tst_test test = {
> @@ -318,4 +316,5 @@ static struct tst_test test = {
>  ? ? ? ? .cleanup = cleanup,
>  ? ? ? ? .test = test_hugeshmctl,
>  ? ? ? ? .needs_checkpoints = 1,
> + ? ? ? .request_hugepages = 128,
>  ?};
> 
> 
> -- 
> Regards,
> Li Wang


