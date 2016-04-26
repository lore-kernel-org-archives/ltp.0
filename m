From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 Apr 2016 07:47:10 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] lib/tst_mkfs: Exit with TCONF on
	missing	mkfs.foo
In-Reply-To: <20160426110035.GA6780@rei.lan>
References: <20160426110035.GA6780@rei.lan>
Message-ID: <781652551.335143.1461671230875.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Tuesday, 26 April, 2016 1:00:35 PM
> Subject: [LTP] [RFC] [PATCH] lib/tst_mkfs: Exit with TCONF on missing	mkfs.foo
> 
> When mkfs.foo is not installed the tst_mkfs() exits the test with TBROK
> which is not correct as the return should be TCONF instead.
> 
> To make it exit with TCONF we have to:
> 
> * Use mkfs.foo directly instead of the deprecated mkfs wrapper
>   - since the wrapper always exits with 1 in case of any failure
>   - we do that in the shell test.sh already anyway
> 
> * Check for the return value from tst_run_cmd()
>   - when execvp() fails the child does _exit(-1)
>     which sets the exit value to 255
>   - this is not ideal as we should examine errno for ENOENT
>     as well, but that would complicate the code since we would
>     have to propagate the reason of the execvp() failure to the
>     parent somehow

We could return 255 (or something less common) only after
we check that errno is ENOENT, so we don't hide other failures
as TCONF.

diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
index a54d46878940..e58b639e94af 100644
--- a/lib/tst_run_cmd.c
+++ b/lib/tst_run_cmd.c
@@ -71,7 +71,12 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
                        dup2(stderr_fd, STDERR_FILENO);
                }
 
-               _exit(execvp(argv[0], (char *const *)argv));
+               if (execvp(argv[0], (char *const *)argv) == -1) {
+                       if (errno == ENOENT)
+                               _exit(255);
+                       else
+                               _exit(errno);
+               }
        }

Regards,
Jan 

> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  lib/tst_mkfs.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> index 7d9c924..c08b09e 100644
> --- a/lib/tst_mkfs.c
> +++ b/lib/tst_mkfs.c
> @@ -25,8 +25,9 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
>                const char *fs_type, const char *const fs_opts[],
>                const char *extra_opt)
>  {
> -	int i, pos = 3;
> -	const char *argv[OPTS_MAX] = {"mkfs", "-t", fs_type};
> +	int i, pos = 1, ret;
> +	char mkfs[64];
> +	const char *argv[OPTS_MAX] = {mkfs};
>  	char fs_opts_str[1024] = "";
>  
>  	if (!dev)
> @@ -35,6 +36,8 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
>  	if (!fs_type)
>  		tst_brkm(TBROK, cleanup_fn, "No fs_type specified");
>  
> +	snprintf(mkfs, sizeof(mkfs), "mkfs.%s", mkfs);
> +
>  	if (fs_opts) {
>  		for (i = 0; fs_opts[i]; i++) {
>  			argv[pos++] = fs_opts[i];
> @@ -65,7 +68,18 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
>  
>  	tst_resm(TINFO, "Formatting %s with %s opts='%s' extra opts='%s'",
>  	         dev, fs_type, fs_opts_str, extra_opt ? extra_opt : "");
> -	tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 0);
> +	ret = tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 1);
> +
> +	switch (ret) {
> +	case 0:
> +	break;
> +	case 255:
> +		tst_brkm(TCONF, cleanup_fn,
> +			 "%s not found in $PATH", mkfs);
> +	default:
> +		tst_brkm(TBROK, cleanup_fn,
> +			 "%s failed with %i", mkfs, ret);
> +	}
>  }
>  
>  const char *tst_dev_fs_type(void)
> --
> 2.7.3
> 
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
