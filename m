From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Mar 2017 14:03:42 +0100
Subject: [LTP] [PATCH v2 1/1] syscalls/mq_timedreceive: convert to new
	API
In-Reply-To: <20170301201331.22402-1-pvorel@suse.cz>
References: <20170301201331.22402-1-pvorel@suse.cz>
Message-ID: <20170303130342.GA16323@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	/*
> -	 * Prepare send message
> -	 */
> -	for (i = 0; i < tc->len; i++)
> -		smsg[i] = i;
> +	if (tc->ttype == SEND_SIGINT)
> +		pid = create_sig_proc(SIGINT, 40, 200000);
>  
> -	/*
> -	 * Send message
> -	 */
> -	switch (tc->ttype) {
> -	case EMPTY_QUEUE:
> -	case SEND_SIGINT:
> -	case FD_NONE:
> -	case FD_NOT_EXIST:
> -	case FD_FILE:
> -		break;
> -	default:
> -		TEST(rc = mq_timedsend(fd, smsg, tc->len, tc->prio, &ts));
> -		if (TEST_RETURN < 0) {
> -			tst_resm(TFAIL | TTERRNO, "mq_timedsend failed");
> -			result = 1;
> -			goto EXIT;
> -		}
> -		break;
> -	}
> +	for (j = 0; j < tc->len; j++)
> +		smsg[j] = j;
> +
> +	/* send */
> +	if ((tc->ttype == NORMAL || tc->ttype == INVALID_MSG_LEN)
> +		&& mq_timedsend(fd, smsg, tc->len, tc->prio,
> +			     &((struct timespec){0})) < 0)
> +			tst_brk(TBROK | TERRNO, "mq_timedsend failed");

This is still too ugly. Why can't we get rid of all of these special
cases here and move the code that is specific for a given test to the
test setup and cleanup functions?

Apart from that we may as well open the fd pointing to file once in the
test setup and close it once in the test cleanup.

Also we should use SAFE_OPEN() for opening the file. And we may as well
add safe_posix_ipc.h with SAFE_MQ_OPEN().

Oh, and we are adding signal handler twice in the test setup(), once via
signal() and second time via sigaction().

-- 
Cyril Hrubis
chrubis@suse.cz
