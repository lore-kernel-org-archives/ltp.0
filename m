From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 14 Aug 2020 15:28:55 +0200
Subject: [LTP] [PATCH] syscalls/msgrcv07: Add functional test for
 MSG_COPY flag
In-Reply-To: <1597392640-26678-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1597392640-26678-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200814132855.GC5559@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void test_msg_copy(void)
> +{
> +	struct msqid_ds buf = {0};
> +
> +	if (!msg_copy_sup)
> +		tst_res(TCONF, "kernel doesn't support MSG_COPY flag, skip it");
> +	prepare_queue();
> +
> +	/*
> +	 * If MSG_COPY flag was specified, then mtype is interpreted as number
> +	 * of the message to copy.
> +	 */
> +	SAFE_MSGRCV(queue_id, &rcv_buf, MSGSIZE, 0, MSG_COPY | IPC_NOWAIT);
> +	if (strcmp(rcv_buf.mtext, MSG1) == 0 && rcv_buf.type == MSGTYPE1)
> +		tst_res(TPASS, "msgrcv(MSG_COPY) got MSGTYPE1 msg data"
> +			" correctly");
> +	else
> +		tst_res(TFAIL, "msgrcv(MSG_COPY) got MSGTYPE1 msg data"
> +			" incorrectly");
> +
> +	SAFE_MSGRCV(queue_id, &rcv_buf, MSGSIZE, 1, MSG_COPY | IPC_NOWAIT);
> +	if (strcmp(rcv_buf.mtext, MSG2) == 0 && rcv_buf.type == MSGTYPE2)
> +		tst_res(TPASS, "msgrcv(MSG_COPY) got MSGTYPE2 msg data"
> +			" correctly");
> +	else
> +		tst_res(TFAIL, "msgrcv(MSG_COPY) got MSGTYPE2 msg data"
> +			" incorrectly");
> +
> +	SAFE_MSGCTL(queue_id, IPC_STAT, &buf);
> +	if (buf.msg_qnum == 2)
> +		tst_res(TPASS, "msgrcv(MSG_COPY) succeeded, msg queue "
> +			"still has 2 msg");
> +	else
> +		tst_res(TFAIL, "msgrcv(MSG_COPY) msg queue expected 2 msg num,"
> +			" but only got %d", (int)buf.msg_qnum);
> +	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
> +}
>  
>  static void setup(void)
>  {
>  	msgkey = GETIPCKEY();
> +	prepare_queue();
> +	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, MSGTYPE1, MSG_COPY));
> +	if (TST_RET != -1)
> +		tst_res(TINFO, "msgrcv succeeded unexpectedly, kernel doesn't"
> +			" support MSG_COPY flag");
> +
> +	if (TST_ERR == EINVAL) {
> +		tst_res(TINFO, "msgrcv failed as expected when not using"
> +			" MSG_COPY and IPC_NOWAIT concurrently");
> +		msg_copy_sup = 1;
> +	} else if (TST_ERR == ENOSYS) {
> +		tst_res(TINFO, "kernel doesn't enable CONFIG_CHECKPOINT_RESTORE");
> +	} else {
> +		tst_res(TINFO | TTERRNO, "msgrcv failed when not using MSG_COPY"
> +			"and IPC_NOWAIT concurrently, expected EINVAL but got");
> +	}

Why can't we just check for ENOSYS in the test_msg_copy() instead?

-- 
Cyril Hrubis
chrubis@suse.cz
