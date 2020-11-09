From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Nov 2020 17:35:59 +0100
Subject: [LTP] [PATCH] Convert dup03 to new API and clean up
In-Reply-To: <20201105155020.16898-1-radoslav.kolev@suse.com>
References: <20201105155020.16898-1-radoslav.kolev@suse.com>
Message-ID: <20201109163559.GA29310@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void setup(void)
>  {
>  	long maxfds;
>  
>  	maxfds = sysconf(_SC_OPEN_MAX);
> -	/*
> -	 * Read the errors section if you're so inclined to determine
> -	 * why == -1 matters for errno.
> -	 */
> -	if (maxfds < 1)
> -		tst_brkm((maxfds == -1 ? TBROK | TERRNO : TBROK), NULL,
> -			 "sysconf(_SC_OPEN_MAX) failed");
> +	if (maxfds == -1)
> +		tst_brk(TBROK, "sysconf(_SC_OPEN_MAX) failed");
>  
>  	fd = malloc(maxfds * sizeof(int));
>  	if (fd == NULL)
> -		tst_brkm(TBROK | TERRNO, NULL, "malloc failed");
> -	fd[0] = -1;
> +		tst_brk(TBROK | TERRNO, "malloc failed");

We do have a SAFE_MALLOC() as well.

> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	fd[0] = SAFE_OPEN("dupfile", O_RDWR | O_CREAT, 0700);
>  
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	sprintf(filename, "dupfile");
> -	for (nfds = 1; nfds <= maxfds; nfds++)
> -		if ((fd[nfds - 1] =
> -		     open(filename, O_RDWR | O_CREAT, 0700)) == -1) {
> -			if (errno == EMFILE)
> -				break;
> -			else
> -				tst_brkm(TBROK | TBROK, cleanup, "open failed");
> -			nfds--;
> -		}
> -
> -	if (nfds == 0)
> -		tst_brkm(TBROK, cleanup, "unable to open at least one file");
> -	if (nfds > maxfds)
> -		tst_brkm(TBROK, cleanup,
> -			 "unable to open enough files to use all file descriptors, "
> -			 "tried %ld", maxfds);
> +	for (nfds = 1; fd[nfds-1] < maxfds-1; nfds++)
> +		fd[nfds] = SAFE_DUP(fd[0]);

I wonder if we should care about overrunning the array here, since in a
case of a kernel bug where dup() would return some constant we would
crash the test. What about:

	for (nfds = 1; nfds < maxfds; nfds++) {
		fd[nfds] = SAFE_DUP(fd[0]);

		if (fd[nfds] >= maxfds - 1)
			break;
	}


Other than these the changes looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
