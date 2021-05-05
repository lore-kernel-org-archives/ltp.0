From: Jan Kara <jack@suse.cz>
Date: Wed, 5 May 2021 18:48:57 +0200
Subject: [LTP] [PATCH 1/2] syscalls/inotify06: Terminate child process
 on test error
In-Reply-To: <20210505153847.6106-1-mdoucha@suse.cz>
References: <20210505153847.6106-1-mdoucha@suse.cz>
Message-ID: <20210505164857.GD9615@quack2.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed 05-05-21 17:38:46, Martin Doucha wrote:
> If the main test process exits early, the child would keep running and
> interfere with tmpdir cleanup.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/syscalls/inotify/inotify06.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Thanks for the patch. It looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/testcases/kernel/syscalls/inotify/inotify06.c b/testcases/kernel/syscalls/inotify/inotify06.c
> index 96189b082..f39ab46a1 100644
> --- a/testcases/kernel/syscalls/inotify/inotify06.c
> +++ b/testcases/kernel/syscalls/inotify/inotify06.c
> @@ -38,7 +38,8 @@
>  /* Number of files to test (must be > 1) */
>  #define FILES 5
>  
> -char names[FILES][PATH_MAX];
> +static char names[FILES][PATH_MAX];
> +static pid_t pid;
>  
>  static void setup(void)
>  {
> @@ -51,7 +52,6 @@ static void setup(void)
>  static void verify_inotify(void)
>  {
>  	int inotify_fd, fd;
> -	pid_t pid;
>  	int i, tests;
>  
>  	pid = SAFE_FORK();
> @@ -85,14 +85,24 @@ static void verify_inotify(void)
>  
>  	/* Kill the child creating / deleting files and wait for it */
>  	SAFE_KILL(pid, SIGKILL);
> +	pid = 0;
>  	SAFE_WAIT(NULL);
>  }
>  
> +static void cleanup(void)
> +{
> +	if (pid) {
> +		SAFE_KILL(pid, SIGKILL);
> +		SAFE_WAIT(NULL);
> +	}
> +}
> +
>  static struct tst_test test = {
>  	.timeout = 600,
>  	.needs_tmpdir = 1,
>  	.forks_child = 1,
>  	.setup = setup,
> +	.cleanup = cleanup,
>  	.test_all = verify_inotify,
>  };
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
