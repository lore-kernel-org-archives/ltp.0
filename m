From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 3 Jun 2021 09:49:36 +0000
Subject: [LTP] [PATCH v1 2/4] syscalls/shmget*: Convert into new api
In-Reply-To: <609BB199.5040409@fujitsu.com>
References: <1620809541-6891-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1620809541-6891-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <609BB199.5040409@fujitsu.com>
Message-ID: <60B8A5D6.1080308@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Ping. Also add a url[1] for the missing EPRERM error(should see lastest
man-page).

[1]https://github.com/mkerrisk/man-pages/commit/090fdddb4342f92a1dbeba687462f4bcee816232

Best Regards
Yang Xu
> Hi ALL
>> 1) merge shmget05.c into shmget02.c
>> 2) Use SHMMIN -1 and SHMMAX + 1 to trigger EINVAL error
>> 3) Use SHM_RD, SHM_WR, SHM_RW to trigger EACCES error under unpriviledged user
> 
> Sorry for missing EPERM error in shmget02.c(I will add it in v2 when you
> have comment on rest patches)
> 
> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> index a57904ce9..319d1e972 100644
> --- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> @@ -17,6 +17,9 @@
>    * greater than SHMMAX. Or a segment for the given key exists, but size is
>    * greater than the size of that segment.
>    * EACCES - The user does not have permission to access the shared
> memory segment.
> + * EPERM - The SHM_HUGETLB flag was specified, but the caller was not
> privileged
> + * (did not have the CAP_IPC_LOCK capability). Also the caller's group
> id should
> + * be not in hugetlb_shm_group proc file.
>    */
>   #include<errno.h>
>   #include<sys/types.h>
> @@ -47,6 +50,7 @@ static struct tcase {
>          {&shmkey1, SHMMAX + 1, IPC_CREAT | IPC_EXCL, 0, EINVAL},
>          {&shmkey, SHM_SIZE * 2, IPC_EXCL, 0, EINVAL},
>          {&shmkey, SHM_SIZE, SHM_RD, 1, EACCES},
> +       {&shmkey1, SHM_SIZE, IPC_CREAT | SHM_HUGETLB, 1, EPERM}
>   };
> 
>   static void verify_shmget(struct tcase *tc)
> @@ -91,6 +95,7 @@ static void setup(void)
>          shmkey = GETIPCKEY();
>          shmkey1 = GETIPCKEY();
> 
> +       SAFE_FILE_PRINTF("/proc/sys/vm/hugetlb_shm_group", "1");
>          shm_id = SAFE_SHMGET(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL);
>          pw = SAFE_GETPWNAM("nobody");
>          tst_res(TINFO, "%d %d", shmkey, shmkey1);
> @@ -110,4 +115,8 @@ static struct tst_test test = {
>          .cleanup = cleanup,
>          .test = do_test,
>          .tcnt = ARRAY_SIZE(tcases),
> +       .save_restore = (const char * const[]) {
> +                "?/proc/sys/vm/hugetlb_shm_group",
> +               NULL,
> +       }
>   };
> 
