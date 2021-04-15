From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Apr 2021 16:11:03 +0200
Subject: [LTP] [PATCH v3 1/2] splice02: Generate input in C
In-Reply-To: <YHhDurTlljhXAKL9@yuki>
References: <20210413043844.5612-1-pvorel@suse.cz>
 <YHhDurTlljhXAKL9@yuki>
Message-ID: <YHhJdwbeUCz5sDfK@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> I meant that we could simplify the test with:

> diff --git a/testcases/kernel/syscalls/splice/splice02.c b/testcases/kernel/syscalls/splice/splice02.c
> index fd71f2995..1b566a2f4 100644
> --- a/testcases/kernel/syscalls/splice/splice02.c
> +++ b/testcases/kernel/syscalls/splice/splice02.c
> @@ -54,18 +54,13 @@ static void do_child(void)

>  	fd = SAFE_OPEN(TEST_FILENAME, O_WRONLY | O_CREAT | O_TRUNC, 0644);

> -	while (to_write > 0) {
> +	do {
>  		TEST(splice(STDIN_FILENO, NULL, fd, NULL, WRITE_SIZE, 0));
> -		tst_res(TINFO, "splice() wrote %ld, remaining %d", TST_RET, to_write);
>  		if (TST_RET < 0) {
>  			tst_res(TFAIL | TTERRNO, "splice failed");
>  			goto cleanup;
> -		} else if (!TST_RET) {
> -			break;
> -		} else {
> -			to_write -= TST_RET;
>  		}
> -	}
> +	} while (TST_RET > 0);

>  	stat(TEST_FILENAME, &st);
>  	if (st.st_size != num_writes) {
> @@ -100,10 +95,10 @@ static void run(void)
>  	for (i = 0; i < num_writes; i++)
>  		SAFE_WRITE(1, pipe_fd[1], "x", 1);

> -	tst_reap_children();
> -
>  	SAFE_CLOSE(pipe_fd[0]);
>  	SAFE_CLOSE(pipe_fd[1]);
> +
> +	tst_reap_children();
>  }

>  static struct tst_test test = {


> If you close the pipe in the parent before reaping children the last
> splice() will return 0 and exit the loop. No need to count anything.

LGTM, going to merge it with these changes (+ cleanup to_write)
and your Reviewed-by: tags.
Thanks a lot!

Kind regards,
Petr
