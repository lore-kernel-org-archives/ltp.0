From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Nov 2016 15:05:08 +0100
Subject: [LTP] [PATCH 2/4] ipc/msgget01.c: cleanup && convert to new API
In-Reply-To: <1479885511-7414-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1479885511-7414-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1479885511-7414-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161123140507.GJ3346@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	msgkey = getipckey();
> +
> +	TEST(msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RD | MSG_WR));
> +
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL | TTERRNO, "msgget() failed");

Just do return; here so that we can omit the else branch.

> +	} else {
> +		msg_q_1 = TEST_RETURN;
> +
> +		check_functionality();

There is no reason to keep the check in the separate funciton now, we
can just do it here instead.

>  	}
>  
> -	cleanup();
> -	tst_exit();
> +	rm_queue(msg_q_1);
>  }
>  
> -/*
> - * check_functionality() - check the functionality of the tested system call.
> - */
> -void check_functionality(void)
> +static void check_functionality(void)
>  {
> -	int i = 0;
>  	MSGBUF snd_buf, rcv_buf;
>  
> -	/* EAGLE: Houston, Tranquility Base here. The Eagle has landed! */
>  	char *queue_msg =
>  	    "Qston, check_functionality here.  The message has queued!";
>  
> -	/*
> -	 * copy our message into the buffer and then set the type.
> -	 */
> -	do {
> -		snd_buf.mtext[i++] = *queue_msg;
> -	} while (*queue_msg++ != '\0');
> +	strcpy(snd_buf.mtext, queue_msg);
>  
>  	snd_buf.mtype = MSGTYPE;
>  
> -	/* send the message */
>  	if (msgsnd(msg_q_1, &snd_buf, MSGSIZE, 0) == -1) {
> -		tst_brkm(TBROK, cleanup, "Could not send a message in the "
> +		tst_brk(TBROK, "Could not send a message in the "
                        ^
			TBROK | TERRNO
>  			 "check_functionality() routine.");
                           ^
			   We shoud print something shorter and more to
			   the point, such as:

			   tst_brk(TBROK|TERRNO, "msgsnd() failed");
>  	}
>  
> -	/* receive the message */
>  	if (msgrcv(msg_q_1, &rcv_buf, MSGSIZE, MSGTYPE, IPC_NOWAIT) == -1) {
> -		tst_brkm(TBROK, cleanup, "Could not read a messages in the "
> +		tst_brk(TBROK, "Could not read a messages in the "
>  			 "check_functionality() routine.");

		here as well

>  	}
>  
>  	if (strcmp(snd_buf.mtext, rcv_buf.mtext) == 0) {
> -		tst_resm(TPASS, "message received = message sent");
> +		tst_res(TPASS, "message received = message sent");
>  	} else {
> -		tst_resm(TFAIL, "message received != message sent");
> +		tst_res(TFAIL, "message received != message sent");
>  	}
>  }
>  
> -/*
> - * setup() - performs all the ONE TIME setup for this test.
> - */
> -void setup(void)
> -{
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
> -
> -	msgkey = getipckey();
> -}
> -
> -/*
> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
> - * 	       or premature exit.
> - */
> -void cleanup(void)
> -{
> -	/* if it exists, remove the message queue that was created */
> -	rm_queue(msg_q_1);
> -
> -	tst_rmdir();
> -
> -}

We should keep the rm_queue() in the cleanup function and add the
cleanup to the test structure as well, so that the queue is removed if
some part of the test called tst_brk().

And we should also set the msg_q_1 to -1 after the rm_qeueue() in the
verify_msgget() since otherwise we may attempt to remove already removed
queue when the test is called with -i and the test function is called
repeatedly.

> +static struct tst_test test = {
> +	.tid = "msgget01",
> +	.test_all = verify_msgget,
> +	.needs_tmpdir = 1
> +};
> -- 
> 1.8.3.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
