From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 2 Jan 2020 10:09:47 +0800
Subject: [LTP] [PATCH COMMITTED] tst_device: do sync() before reading
 test block device stat file
In-Reply-To: <20200102015236.7400-1-liwang@redhat.com>
References: <20200102015236.7400-1-liwang@redhat.com>
Message-ID: <b2b1b91e-4813-a281-6f56-0924d21bb103@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



Hi Li
> To avoid FS deferred IO metadata/cache interferes test result, so we
> do sync simply before the tst_dev_bytes_written invocation.
> 
Looks good, acked. Also, I think we can mention it in 
doc/test-writing-guidelines.txt when using this api.

Best Regards
Yang Xu
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>   testcases/kernel/syscalls/fdatasync/fdatasync03.c | 2 ++
>   testcases/kernel/syscalls/fsync/fsync04.c         | 2 ++
>   testcases/kernel/syscalls/sync/sync03.c           | 2 ++
>   testcases/kernel/syscalls/syncfs/syncfs01.c       | 2 ++
>   4 files changed, 8 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync03.c b/testcases/kernel/syscalls/fdatasync/fdatasync03.c
> index ee50e75c9..032ac4b58 100644
> --- a/testcases/kernel/syscalls/fdatasync/fdatasync03.c
> +++ b/testcases/kernel/syscalls/fdatasync/fdatasync03.c
> @@ -32,6 +32,8 @@ static void verify_fdatasync(void)
>   
>   	fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
>   
> +	sync();
> +
>   	tst_dev_bytes_written(tst_device->dev);
>   
>   	tst_fill_fd(fd, 0, TST_MB, FILE_SIZE_MB);
> diff --git a/testcases/kernel/syscalls/fsync/fsync04.c b/testcases/kernel/syscalls/fsync/fsync04.c
> index c67fc5692..3c1f45e94 100644
> --- a/testcases/kernel/syscalls/fsync/fsync04.c
> +++ b/testcases/kernel/syscalls/fsync/fsync04.c
> @@ -32,6 +32,8 @@ static void verify_fsync(void)
>   
>   	fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
>   
> +	sync();
> +
>   	tst_dev_bytes_written(tst_device->dev);
>   
>   	tst_fill_fd(fd, 0, TST_MB, FILE_SIZE_MB);
> diff --git a/testcases/kernel/syscalls/sync/sync03.c b/testcases/kernel/syscalls/sync/sync03.c
> index a6f72d2ed..085ccfdeb 100644
> --- a/testcases/kernel/syscalls/sync/sync03.c
> +++ b/testcases/kernel/syscalls/sync/sync03.c
> @@ -32,6 +32,8 @@ static void verify_sync(void)
>   
>   	fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
>   
> +	sync();
> +
>   	tst_dev_bytes_written(tst_device->dev);
>   
>   	tst_fill_fd(fd, 0, TST_MB, FILE_SIZE_MB);
> diff --git a/testcases/kernel/syscalls/syncfs/syncfs01.c b/testcases/kernel/syscalls/syncfs/syncfs01.c
> index 051a19ea6..3cf404450 100644
> --- a/testcases/kernel/syscalls/syncfs/syncfs01.c
> +++ b/testcases/kernel/syscalls/syncfs/syncfs01.c
> @@ -33,6 +33,8 @@ static void verify_syncfs(void)
>   
>   	fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
>   
> +	sync();
> +
>   	tst_dev_bytes_written(tst_device->dev);
>   
>   	tst_fill_fd(fd, 0, TST_MB, FILE_SIZE_MB);
> 


