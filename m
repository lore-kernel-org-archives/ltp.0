From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 Jul 2019 14:34:42 +0200
Subject: [LTP] [PATCH v3.1] lib: add tst_no_corefile()
In-Reply-To: <02ade9af1634c4681156dceecfd51721284044e3.1562591065.git.jstancek@redhat.com>
References: <20190705051603.24599-1-liwang@redhat.com>
 <02ade9af1634c4681156dceecfd51721284044e3.1562591065.git.jstancek@redhat.com>
Message-ID: <20190711123441.GA8709@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +void tst_no_corefile(int verbose)
> +{
> +	struct rlimit new_r, old_r;
> +
> +	SAFE_GETRLIMIT(RLIMIT_CORE, &old_r);
> +	if (old_r.rlim_max >= 1 || geteuid() == 0) {
> +		/*
> +		 * 1 is a special value, that disables core-to-pipe.
> +		 * At the same time it is small enough value for
> +		 * core-to-file, so it skips creating cores as well.
> +		 */
> +		new_r.rlim_cur = 1;
> +		new_r.rlim_max = 1;
> +		SAFE_SETRLIMIT(RLIMIT_CORE, &new_r);
> +	}
> +
> +	if (verbose)
> +		tst_res(TINFO, "Avoid dumping corefile for process(pid=%d)", getpid());

Should we print the message here only

	if (old_r.rlim_max <= 1 || geteuid() == 0)

because otherwise we will print the mesasge even in cases that the
corefile is not in fact limited.

-- 
Cyril Hrubis
chrubis@suse.cz
