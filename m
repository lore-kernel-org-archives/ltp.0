From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 24 Oct 2016 12:49:28 +0200
Subject: [LTP] [PATCH 1/2] syscalls/quotatcl01.c: Rewrite && Convert to
 new API
In-Reply-To: <1477032835-11570-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1477032835-11570-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161024104928.GA19167@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	tst_parse_opts(ac, av, (option_t *) opts, NULL);
> +	pid = SAFE_FORK();
> +	if (!pid)
> +		create_qf();
>  
> -	setup();
> +	SAFE_WAITPID(pid, NULL, 0);

Just use tst_run_cmd() instead of the fork(), execlp(), wait() combo and
remove the forks_child flag.

> -	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +	test_id = geteuid();
>  
> -		tst_count = 0;
> +	sprintf(usr_path, "%s/%s", mntpoint, usr_qf);
> +	sprintf(grp_path, "%s/%s", mntpoint, grp_qf);

Well these strings could be compile time constants. If you do:

#define MNTPOINT "mntpoint"

#ifdef HAVE_QUOTAV2
# define USR_PATH MNTPOINT "aquota.user"
...
#else
# define USR_PATH MNTPOINT "quota.user"
...
#endif

But that is a minor issue.

And yes, the inner block of #ifdef should ideally be indented with
single space per block as in the example snipped above, but that is even
more minor.

-- 
Cyril Hrubis
chrubis@suse.cz
