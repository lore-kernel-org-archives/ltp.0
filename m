From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Apr 2016 14:28:25 +0200
Subject: [LTP] [RFC] [PATCH] lib/tst_mkfs: Exit with TCONF on missing
 mkfs.foo
In-Reply-To: <781652551.335143.1461671230875.JavaMail.zimbra@redhat.com>
References: <20160426110035.GA6780@rei.lan>
 <781652551.335143.1461671230875.JavaMail.zimbra@redhat.com>
Message-ID: <20160426122824.GB6766@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
> index a54d46878940..e58b639e94af 100644
> --- a/lib/tst_run_cmd.c
> +++ b/lib/tst_run_cmd.c
> @@ -71,7 +71,12 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
>                         dup2(stderr_fd, STDERR_FILENO);
>                 }
>  
> -               _exit(execvp(argv[0], (char *const *)argv));
> +               if (execvp(argv[0], (char *const *)argv) == -1) {
> +                       if (errno == ENOENT)
> +                               _exit(255);
> +                       else
> +                               _exit(errno);

I'm not 100% sure if we want to set the errno as an exit value since for
instance EPERM == 1 which would be indistinguishable from most of the
command failures.

Maybe we can exit with 255 on ENOENT and with 254 otherwise.

-- 
Cyril Hrubis
chrubis@suse.cz
