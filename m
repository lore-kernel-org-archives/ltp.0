From: Eryu Guan <eguan@redhat.com>
Date: Mon, 5 Jun 2017 22:25:40 +0800
Subject: [LTP] [PATCH] syscalls/flock: open test file with O_RDWR mode
In-Reply-To: <20170517170956.27118-1-eguan@redhat.com>
References: <20170517170956.27118-1-eguan@redhat.com>
Message-ID: <20170605142540.GL19952@eguan.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 18, 2017 at 01:09:56AM +0800, Eryu Guan wrote:
> NFS requires the open mode to match the lock type, i.e. for LOCK_SH
> file must be opened for read, and for LOCK_EX file must be opened
> for write. Otherwise flock01 and flock04 fail on NFS with EBADF.
> 
> So open all test files in flock tests with O_RDWR mode that both
> lock type requirements can be met.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

ping on this one.

Thanks,
Eryu

> ---
>  testcases/kernel/syscalls/flock/flock01.c | 2 +-
>  testcases/kernel/syscalls/flock/flock02.c | 2 +-
>  testcases/kernel/syscalls/flock/flock03.c | 2 +-
>  testcases/kernel/syscalls/flock/flock04.c | 2 +-
>  testcases/kernel/syscalls/flock/flock05.c | 2 +-
>  testcases/kernel/syscalls/flock/flock06.c | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/flock/flock01.c b/testcases/kernel/syscalls/flock/flock01.c
> index a7ecba1..3e17be4 100644
> --- a/testcases/kernel/syscalls/flock/flock01.c
> +++ b/testcases/kernel/syscalls/flock/flock01.c
> @@ -153,7 +153,7 @@ void setup(void)
>  	sprintf(filename, "flock01.%d", getpid());
>  
>  	/* creating temporary file */
> -	fd = creat(filename, 0644);
> +	fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0644);
>  	if (fd < 0)
>  		tst_brkm(TBROK, tst_rmdir, "creating a new file failed");
>  }
> diff --git a/testcases/kernel/syscalls/flock/flock02.c b/testcases/kernel/syscalls/flock/flock02.c
> index 971160d..414df68 100644
> --- a/testcases/kernel/syscalls/flock/flock02.c
> +++ b/testcases/kernel/syscalls/flock/flock02.c
> @@ -150,7 +150,7 @@ void setup(void)
>  
>  	sprintf(filename, "flock02.%d", getpid());
>  
> -	fd = creat(filename, 0666);
> +	fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0666);
>  	if (fd < 0)
>  		tst_brkm(TFAIL | TERRNO, cleanup, "creat failed");
>  }
> diff --git a/testcases/kernel/syscalls/flock/flock03.c b/testcases/kernel/syscalls/flock/flock03.c
> index e53b3b7..420f509 100644
> --- a/testcases/kernel/syscalls/flock/flock03.c
> +++ b/testcases/kernel/syscalls/flock/flock03.c
> @@ -181,7 +181,7 @@ static void setup(void)
>  
>  	TST_CHECKPOINT_INIT(tst_rmdir);
>  
> -	fd = creat(FILE_NAME, 0666);
> +	fd = open(FILE_NAME, O_CREAT | O_TRUNC | O_RDWR, 0666);
>  	if (fd < 0) {
>  		tst_resm(TBROK, "creating a new file failed");
>  		cleanup();
> diff --git a/testcases/kernel/syscalls/flock/flock04.c b/testcases/kernel/syscalls/flock/flock04.c
> index 5dafaa4..87f1dfb 100644
> --- a/testcases/kernel/syscalls/flock/flock04.c
> +++ b/testcases/kernel/syscalls/flock/flock04.c
> @@ -164,7 +164,7 @@ void setup(void)
>  
>  	sprintf(filename, "flock04.%d", getpid());
>  
> -	fd = creat(filename, 0666);
> +	fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0666);
>  	if (fd == -1)
>  		tst_brkm(TFAIL, cleanup, "creating a new file failed");
>  }
> diff --git a/testcases/kernel/syscalls/flock/flock05.c b/testcases/kernel/syscalls/flock/flock05.c
> index d9d3d00..13ae2f6 100644
> --- a/testcases/kernel/syscalls/flock/flock05.c
> +++ b/testcases/kernel/syscalls/flock/flock05.c
> @@ -182,7 +182,7 @@ void setup(void)
>  	sprintf(filename, "flock05.%d", getpid());
>  
>  	/* creating temporary file */
> -	fd = creat(filename, 0666);
> +	fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0666);
>  	if (fd == -1) {
>  		tst_resm(TFAIL, "creating a new file failed");
>  
> diff --git a/testcases/kernel/syscalls/flock/flock06.c b/testcases/kernel/syscalls/flock/flock06.c
> index d9c1d2d..a35c8cf 100644
> --- a/testcases/kernel/syscalls/flock/flock06.c
> +++ b/testcases/kernel/syscalls/flock/flock06.c
> @@ -158,7 +158,7 @@ void setup(void)
>  	sprintf(filename, "flock06.%d", getpid());
>  
>  	/* creating temporary file */
> -	fd = creat(filename, 0666);
> +	fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0666);
>  	if (fd < 0)
>  		tst_brkm(TBROK, tst_rmdir, "creating a new file failed");
>  	close(fd);
> -- 
> 2.9.4
> 
