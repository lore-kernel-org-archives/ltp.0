From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Dec 2016 17:24:55 +0100
Subject: [LTP] [PATCH v2 5/5] ipc/msgget03.c: cleanup && convert to new
	API
In-Reply-To: <1481087800-20639-5-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20161123135513.GI3346@rei.lan>
 <1481087800-20639-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1481087800-20639-5-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161212162454.GI21828@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	TEST(msgget(msgkey + maxmsgs, IPC_CREAT | IPC_EXCL));
> +	if (TEST_RETURN != -1)
> +		tst_res(TFAIL, "msgget() succeeded unexpectedly");
> +
> +	if (TEST_ERRNO == ENOSPC)
> +		tst_res(TPASS | TTERRNO, "msgget() failed as expected");
> +	else
> +		tst_res(TFAIL | TTERRNO, "msgget() failed unexpectedly,"
> +			" expected %s", tst_strerrno(ENOSPC));
                                        ^
					This just generates "ENOSPC" we
					can as well just write it
					directly to the message string.

And as the tst_res() spans across two lines it would be better to use
curly braces around the if blocks.

>  }
>  
> -/*
> - * setup() - performs all the ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void setup(void)
>  {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	/*
> -	 * Create a temporary directory and cd into it.
> -	 * This helps to ensure that a unique msgkey is created.
> -	 * See ../lib/libipc.c for more information.
> -	 */
> -	tst_tmpdir();
> +	int res, num;
>  
>  	msgkey = getipckey();
>  
>  	maxmsgs = get_max_msgqueues();
>  	if (maxmsgs < 0)
> -		tst_brkm(TBROK, cleanup, "get_max_msgqueues failed");
> +		tst_brk(TBROK, "get_max_msgqueues failed");
>  
> -	msg_q_arr = (int *)calloc(maxmsgs, sizeof(int));
> -	if (msg_q_arr == NULL) {
> -		tst_brkm(TBROK, cleanup, "Couldn't allocate memory "
> -			 "for msg_q_arr: calloc() failed");
> +	msg_q_arr = SAFE_MALLOC(maxmsgs * sizeof(int));
> +
> +	for (num = 0; num < maxmsgs; num++) {
> +		msg_q_arr[num] = -1;
> +
> +		res = msgget(msgkey + num, IPC_CREAT | IPC_EXCL);
> +		if (res != -1)
> +			msg_q_arr[num] = res;
>  	}
> +
> +	tst_res(TINFO, "The maximum number of message queues (%d) reached",
> +		maxmsgs);
>  }
>  
> -/*
> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
> - * 	       or premature exit.
> - */
> -void cleanup(void)
> +static void cleanup(void)
>  {
> -	int i;
> +	int num;
>  
> -	/*
> -	 * remove the message queues if they were created
> -	 */
> -
> -	if (msg_q_arr != NULL) {
> -		for (i = 0; i < num_queue; i++) {
> -			rm_queue(msg_q_arr[i]);
> +	if (msg_q_arr) {
> +		for (num = 0; num < maxmsgs; num++) {
> +			rm_queue(msg_q_arr[num]);
> +			msg_q_arr[num] = -1;

Again, no need to reset the message queue identifier here.

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
