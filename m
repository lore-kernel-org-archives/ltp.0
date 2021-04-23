From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 23 Apr 2021 14:11:55 +0200
Subject: [LTP] [PATCH] syscalls/getdtablesize: Update to the new api
In-Reply-To: <20210407081415.8353-1-zhaogongyi@huawei.com>
References: <20210407081415.8353-1-zhaogongyi@huawei.com>
Message-ID: <YIK5iw5DBC9YQSpl@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
> +++ b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
> @@ -1,119 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) International Business Machines  Corp., 2005
>   * Copyright (c) Wipro Technologies Ltd, 2005.  All Rights Reserved.
>   *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.

This is GPL-2.0 so the SPDX has to be without the -or-later part here.

> +#define TESTFILE "getdtablesize01_testfile"

This can be just "testfile" the test teporary directory is already
unique enough and has getdtablesize in it's name.

> +#define FILE_OPEN_MAX SAFE_SYSCONF(_SC_OPEN_MAX)
> 
> -char *TCID = "getdtablesize01";
> -int TST_TOTAL = 1;
> +static int *fd, count;
> 
> -int main(void)
> +static void run(void)
>  {
> -	int table_size, fd = 0, count = 0;
> +	int temp_fd;
>  	int max_val_opfiles;
>  	struct rlimit rlp;
> 
> -	setup();
> -	table_size = getdtablesize();
> -	getrlimit(RLIMIT_NOFILE, &rlp);
> -	max_val_opfiles = (rlim_t) rlp.rlim_cur;
> -
> -	tst_resm(TINFO,
> -		 "Maximum number of files a process can have opened is %d",
> -		 table_size);
> -	tst_resm(TINFO,
> -		 "Checking with the value returned by getrlimit...RLIMIT_NOFILE");
> -
> -	if (table_size == max_val_opfiles)
> -		tst_resm(TPASS, "got correct dtablesize, value is %d",
> -			 max_val_opfiles);
> -	else {
> -		tst_resm(TFAIL, "got incorrect table size, value is %d",
> -			 max_val_opfiles);
> -		cleanup();
> -	}
> +	TEST(getdtablesize());
> +	tst_res(TINFO,
> +		"Maximum number of files a process can have opened is %d",
> +		TST_RET);
> 
> -	tst_resm(TINFO,
> -		 "Checking Max num of files that can be opened by a process.Should be: RLIMIT_NOFILE - 1");
> -	for (;;) {
> -		fd = open("/etc/hosts", O_RDONLY);
> +	tst_res(TINFO, "Checking with the value returned by getrlimit");
> 
> -		if (fd == -1)
> -			break;
> -		count = fd;
> +	if (getrlimit(RLIMIT_NOFILE, &rlp))
> +		max_val_opfiles = FILE_OPEN_MAX;
> +	else
> +		max_val_opfiles = (rlim_t)rlp.rlim_cur;

Why do we fallback to sysconf() here? Does hte getrlmit() fail in some
cases? The original test just called getrlimit() and I do not remmeber
it failing.

> -#ifdef DEBUG
> -		printf("Opened file num %d\n", fd);
> -#endif
> -	}
> +	if (TST_RET == max_val_opfiles)
> +		tst_res(TPASS, "got correct dtablesize, value is %d "
> +			"max_val_opfiles value is %d",
> +			TST_RET, max_val_opfiles);
> +	else
> +		tst_res(TFAIL, "got incorrect dtablesize, value is %d"
> +			 "max_val_opfiles value is %d",
> +			 TST_RET, max_val_opfiles);

The LKML coding style says that we shouldn't break strings even if they
are over 80 characters.

> -//Now the max files opened should be RLIMIT_NOFILE - 1 , why ? read getdtablesize man page
> +	tst_res(TINFO,
> +		"Checking Max num of files that can be opened by a process."
> +		"Should be: RLIMIT_NOFILE - 1");
> 
> -	if (count > 0)
> -		close(count);
> -	if (count == (max_val_opfiles - 1))
> -		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
> -	else if (fd < 0 && errno == ENFILE)
> -		tst_brkm(TCONF, cleanup, "Reached maximum number of open files for the system");
> -	else
> -		tst_resm(TFAIL, "%d != %d", count, (max_val_opfiles - 1));
> +	while (1) {
> +		temp_fd = open(TESTFILE, O_CREAT | O_RDONLY, 0755);
> +		if (temp_fd == -1)
> +			break;
> +		fd[count++] = temp_fd;
> +	}

Here we blindly assume that the file descriptors will fit into the
table, which may not be true if the system is broken.

Also why do we need the array in the first place? The file descriptors
_are_ allocated continuously so the last fd we get from the open() call
is the maximal number of fds - 1, since the standard streams start at 0.
Technically we can even close the these descriptors if we store the
first fd we got from the open() call since the rest of fds will be in
the range, [first_fd, last_fd].

> -	cleanup();
> -	tst_exit();
> +	if (fd[count - 1] == (max_val_opfiles - 1))
> +		tst_res(TPASS,
> +			"max open file fd is correct, %d = %d",
> +			fd[count - 1], (max_val_opfiles - 1));
> +	else if (temp_fd < 0 && errno == ENFILE)
> +		tst_brk(TCONF,
> +			"Reached maximum number of open files for the system");
> +	else
> +		tst_res(TFAIL | TERRNO, "%d != %d", fd[count - 1], (max_val_opfiles - 1));
>  }
> 
> -void setup(void)
> +static void setup(void)
>  {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	fd = SAFE_MALLOC(FILE_OPEN_MAX * sizeof(int));
>  }
> 
> -void cleanup(void)
> +static void cleanup(void)
>  {
> +	int i;
> +	for (i = 0; i < count; i++)
> +		SAFE_CLOSE(fd[i]);
> +
> +	free(fd);
> +	fd = NULL;
>  }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> +
> --
> 2.17.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
