From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Apr 2021 10:19:22 +0200
Subject: [LTP] [PATCH v4 1/2] splice02: Generate input in C
In-Reply-To: <20210416165355.5160-1-pvorel@suse.cz>
References: <20210416165355.5160-1-pvorel@suse.cz>
Message-ID: <YH09Ckqng/puMxSa@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	fd = SAFE_OPEN("splice02-temp", O_WRONLY | O_CREAT | O_TRUNC, 0644);
> +	tst_res(TINFO, "checking file content");
> +	do {
> +		i = 0;
> +		size = to_check > SPLICE_SIZE ? SPLICE_SIZE : to_check;
> +		map = SAFE_MMAP(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
                                                                        ^
									This offset
									should
									increase
									by
									size
									on
									each
									iteration.


As it is we check only the first few pages of the file again and again.

> +		while (map[i] && i < size) {
                          ^
		Why map[i]? The i < size should be enough to make sure
		we newer get bytes after end of the file.

> +			if (map[i] != letter)
> +				fail++;
> +			i++;
> +		}
> +		SAFE_MUNMAP(map, size);
> +		to_check -= size;
> +	} while (to_check > 0);
>  
> -	TEST(splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0));
> -	if (TST_RET < 0) {
> -		tst_res(TFAIL, "splice failed - errno = %d : %s",
> -			TST_ERR, strerror(TST_ERR));
> -	} else {
> -		tst_res(TPASS, "splice() system call Passed");
> +	if (fail) {
> +		tst_res(TFAIL, "%ld failed bytes found", fail);
                                      ^
				      Wrong? Unexpected?
> +		return;
>  	}
>  
> +	tst_res(TPASS, "splice() system call passed");
> +
> +cleanup:
>  	SAFE_CLOSE(fd);
> +	exit(0);
> +}
> +
> +static void run(void)
> +{
> +	size_t size, written, max_pipe_size, to_write;
> +	char buf[BUFSIZE];
> +
> +	SAFE_PIPE(pipe_fd);
> +
> +	memset(buf, letter, BUFSIZE);
> +
> +	if (!file_size) {
> +		max_pipe_size = SAFE_FCNTL(pipe_fd[1], F_GETPIPE_SZ);
> +		file_size = max_pipe_size << 4;
> +	}
> +
> +	to_write = file_size;
> +
> +	if (!SAFE_FORK())
> +		do_child();
> +
> +	tst_res(TINFO, "writting %d bytes", file_size);
> +
> +	while (to_write > 0) {
> +		size = to_write > BUFSIZE ? BUFSIZE : to_write;
> +		written = SAFE_WRITE(1, pipe_fd[1], &buf, size);
> +		to_write -= written;
> +	}
> +
> +	SAFE_CLOSE(pipe_fd[0]);
> +	SAFE_CLOSE(pipe_fd[1]);
> +
> +	tst_reap_children();
>  }
>  
>  static struct tst_test test = {
> -	.test_all = splice_test,
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_checkpoints = 1,
>  	.needs_tmpdir = 1,
> +	.forks_child = 1,
>  	.min_kver = "2.6.17",
> +	.options = (struct tst_option[]) {
> +		{"s:", &sarg, "-s x     Size of output file in bytes (default: 16x max pipe size, i.e. 1M on intel)"},
> +		{}
> +	},
>  };
> -- 
> 2.31.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
