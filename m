From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Tue, 30 Mar 2021 01:51:14 +0000
Subject: [LTP] [PATCH] syscalls/shmctl04: Add kernel version requestions
In-Reply-To: <20210329134647.27740-1-zhaogongyi@huawei.com>
References: <20210329134647.27740-1-zhaogongyi@huawei.com>
Message-ID: <6062841B.6030302@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi
> SHM_STAT_ANY is imported to linux in v4.17.
>
> Signed-off-by: Zhao Gongyi<zhaogongyi@huawei.com>
> ---
>   testcases/kernel/syscalls/ipc/shmctl/shmctl04.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
> index 9e8ec4199..18ac8ba0a 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
> @@ -168,6 +168,7 @@ static void cleanup(void)
>   }
>
>   static struct tst_test test = {
> +	.min_kver = "4.17",
Some linux distribution such as centos7.8 has backported this feature, 
so we should call SHM_STAT_ANY directly to detect whether kernel 
supports SHM_STAT_ANY instead of using min_kver.

code as below:
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -155,10 +155,19 @@ static void verify_shminfo(unsigned int n)
  static void setup(void)
  {
         struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
+       struct shmid_ds temp_ds;
         nobody_uid = ltpuser->pw_uid;
         root_uid = 0;

         shm_id = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | SHM_RW);
+       TEST(shmctl(shm_id, SHM_STAT_ANY, &temp_ds));
+       if (TST_RET == -1) {
+               if (TST_ERR == EINVAL)
+                       tst_brk(TCONF, "kernel doesn't support 
SHM_STAT_ANY");
+               else
+                       tst_brk(TBROK | TTERRNO,
+                               "Current environment doesn't permit 
SHM_STAT_ANY");
+       }
  }


Also, On your environment, does semctl09.c/msgctl06.c have the same problem?

>   	.setup = setup,
>   	.cleanup = cleanup,
>   	.test = verify_shminfo,
> --
> 2.17.1
>
>
