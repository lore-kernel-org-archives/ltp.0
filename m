From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Fri, 23 Jul 2021 04:36:07 +0000
Subject: [LTP] [PATCH v3 3/3] syscalls/shmget*: Convert into new api
In-Reply-To: <YPlNzVze5T9r5qCz@yuki>
References: <YNM4rlDJLzb4xk6v@yuki>
 <1624512827-3256-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1624512827-3256-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YPlNzVze5T9r5qCz@yuki>
Message-ID: <60FA474F.5090502@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
> Hi!
>> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
>> index 4436ca7f8..6be8d8157 100644
>> --- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
>> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
>
> ...
>
>> +static struct tst_test test = {
>> +	.needs_tmpdir = 1,
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test = do_test,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.request_hugepages = 0,
>> +};
>
> We got some test failures for the ENOMEM hugepage test and then I we
> realized that setting .request_hugepages = 0 is no-op since zero is the
> default value when it's not initialized and we ignore it the tst_test.c.
>
> Thinking of possible solutions I guess that the easiest would be to add
> a special value that would tell the library to set the pool size to 0.
Yes
>
> Something as:
>
> diff --git a/include/tst_test.h b/include/tst_test.h
> index c7d77eb09..5f05e3a33 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -125,6 +125,8 @@ struct tst_tag {
>
>   extern unsigned int tst_variant;
>
> +#define TST_NO_HUGEPAGES ((unsigned long)-1)
> +
>   struct tst_test {
>          /* number of tests available in test() function */
>          unsigned int tcnt;
> diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
> index 1d0e62e5b..ef93afc61 100644
> --- a/lib/tst_hugepage.c
> +++ b/lib/tst_hugepage.c
> @@ -34,6 +34,11 @@ unsigned long tst_request_hugepages(unsigned long hpages)
>          else
>                  tst_hugepages = hpages;
>
> +       if (hpages == TST_NO_HUGEPAGES) {
> +               hpages = 0;
> +               goto set_hugepages;
> +       }
> +
It should use tst_hugepages because set_hugepages will set by this.
I will send a patch to fix this.

I think the reason of introduced problem is that we don't add library 
test for 0 hugepage. Also will add it.
>          SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
>          max_hpages = SAFE_READ_MEMINFO("MemFree:") / SAFE_READ_MEMINFO("Hugepagesize:");
>
> @@ -47,6 +52,8 @@ unsigned long tst_request_hugepages(unsigned long hpages)
>                          goto out;
>          }
>
> +set_hugepages:
> +
>          tst_sys_conf_save("?/proc/sys/vm/nr_hugepages");
>          SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%lu", tst_hugepages);
>          SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu",&val);
>
