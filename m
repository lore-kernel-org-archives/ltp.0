From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 May 2017 11:31:01 +0200
Subject: [LTP] [PATCH] Add terminating NUL after calling readlink()
In-Reply-To: <20170506085206.GA3058@ls3530.fritz.box>
References: <20170506085206.GA3058@ls3530.fritz.box>
Message-ID: <20170509093101.GB4150@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
> index c4dca66d0..553c65aad 100644
> --- a/testcases/kernel/containers/pidns/pidns03.c
> +++ b/testcases/kernel/containers/pidns/pidns03.c
> @@ -63,7 +63,7 @@ int child_func(void *arg)
>  	}
>  
>  	/* self is symlink to directory named after current pid number */
> -	if (readlink(PROCDIR"/self", buf, sizeof(buf)) == -1) {
> +	if (SAFE_READLINK(NULL, PROCDIR"/self", buf, sizeof(buf)) == -1) {
>  		perror("readlink");
>  		umount(PROCDIR);
>  		return 1;

SAFE_READLINK() will newer return -1 here, it will abort the test with
TBROK as a exit value.

If we want to use it here it should look as:

static void child_cleanup(void)
{
	umount(PROCDIR);
}

...

	SAFE_READLINK(child_cleanup, PROCDIR"/self", buf, sizeof(buf));

	umount(PROC_DIR);

...

I also wonder if we have to umount the "/proc" in the child or if the
kernel will umount it automatically once the child exits, which would
allow us to simplify the child function...

> diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
> index 629bcf4d1..bfdffd52b 100644
> --- a/testcases/kernel/fs/fsstress/fsstress.c
> +++ b/testcases/kernel/fs/fsstress/fsstress.c
> @@ -1143,6 +1143,8 @@ int readlink_path(pathname_t * name, char *lbuf, size_t lbufsiz)
>  	int rval;
>  
>  	rval = readlink(name->path, lbuf, lbufsiz);
> +	if (rval >= 0)
> +		lbuf[rval] = 0; /* add terminating NUL */

Shouldn't we check here that the rval < lbufsiz? Or pass lbufsiz - 1 to
the readlink() call?

>  	if (rval >= 0 || errno != ENAMETOOLONG)
>  		return rval;
>  	separate_pathname(name, buf, &newname);

-- 
Cyril Hrubis
chrubis@suse.cz
