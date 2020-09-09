From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 9 Sep 2020 10:23:13 +0800
Subject: [LTP] [PATCH v2] syscalls/msgrcv07: Add functional test for
 MSG_COPY flag
In-Reply-To: <20200908140838.GB17482@yuki.lan>
References: <20200814132855.GC5559@yuki.lan>
 <1597727924-4969-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200908140838.GB17482@yuki.lan>
Message-ID: <97b07cd4-ab97-ed5a-7bbb-ceef072b7e61@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril

> Hi!
>> +static void test_msg_copy(void)
>> +{
>> +	struct msqid_ds buf = {0};
>> +
>> +	if (!msg_copy_sup) {
>> +		tst_res(TCONF, "kernel doesn't support MSG_COPY flag, skip it");
>> +		return;
>> +	}
>> +	prepare_queue();
>> +
>> +	/*
>> +	 * If MSG_COPY flag was specified, then mtype is interpreted as number
>> +	 * of the message to copy.
>> +	 */
>> +	SAFE_MSGRCV(queue_id, &rcv_buf, MSGSIZE, 0, MSG_COPY | IPC_NOWAIT);
>> +	if (strcmp(rcv_buf.mtext, MSG1) == 0 && rcv_buf.type == MSGTYPE1)
>> +		tst_res(TPASS, "msgrcv(MSG_COPY) got MSGTYPE1 msg data"
>> +			" correctly");
>> +	else
>> +		tst_res(TFAIL, "msgrcv(MSG_COPY) got MSGTYPE1 msg data"
>> +			" incorrectly");
>> +
>> +	SAFE_MSGRCV(queue_id, &rcv_buf, MSGSIZE, 1, MSG_COPY | IPC_NOWAIT);
>> +	if (strcmp(rcv_buf.mtext, MSG2) == 0 && rcv_buf.type == MSGTYPE2)
>> +		tst_res(TPASS, "msgrcv(MSG_COPY) got MSGTYPE2 msg data"
>> +			" correctly");
>> +	else
>> +		tst_res(TFAIL, "msgrcv(MSG_COPY) got MSGTYPE2 msg data"
>> +			" incorrectly");
> 
> Can we please keep the strings on a single line?
> 
> I guess that we can shorten the messages a bit e.g.
> 
> tst_res(TFAIL, "msgrcv(MSG_COPY) got MSGTYPE2 data correctly");
> 
> Or even:
> 
> tst_res(TFAIL, "MSG_COPY got MSGTYPE2 data correctly");
> 
> Please try to keep the messages short and to the point.
Will fix it.
> 
>> +	SAFE_MSGCTL(queue_id, IPC_STAT, &buf);
>> +	if (buf.msg_qnum == 2)
>> +		tst_res(TPASS, "msgrcv(MSG_COPY) succeeded, msg queue "
>> +			"still has 2 msg");
>> +	else
>> +		tst_res(TFAIL, "msgrcv(MSG_COPY) msg queue expected 2 msg num,"
>> +			" but only got %d", (int)buf.msg_qnum);
> 
> Here as well we can shorten it to something as:
> 
> 	tst_res(TPASS, "Two messages still in queue");
> 
> 	tst_res(TFAIL, "Expected 2 msgs in queue got %i",
> 		(int)buf.msg_qnum);
> 
Will fix it.
>> +	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
>> +}
>> +
>>   static void test_zero_msgtyp(void)
>>   {
>>   	prepare_queue();
>> @@ -159,11 +203,28 @@ static void test_negative_msgtyp(void)
>>   static void setup(void)
>>   {
>>   	msgkey = GETIPCKEY();
>> +	prepare_queue();
>> +	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, MSGTYPE1, MSG_COPY));
>> +	if (TST_RET != -1)
>> +		tst_res(TINFO, "msgrcv succeeded unexpectedly, kernel doesn't"
>> +			" support MSG_COPY flag");
>> +
>> +	if (TST_ERR == EINVAL) {
>> +		tst_res(TINFO, "msgrcv failed as expected when not using"
>> +			" MSG_COPY and IPC_NOWAIT concurrently");
>> +		msg_copy_sup = 1;
>> +	} else if (TST_ERR == ENOSYS) {
>> +		tst_res(TINFO, "kernel doesn't enable CONFIG_CHECKPOINT_RESTORE");
>> +	} else {
>> +		tst_res(TINFO | TTERRNO, "msgrcv failed when not using MSG_COPY"
>> +			"and IPC_NOWAIT concurrently, expected EINVAL but got");
>> +	}
> 
> This check actually does not work, it fails to detect the support on
> newer kernels, e.g. 5.6.1 without the CONFIG_CHECKPOINT_RESTORE.
> 
> When kernel is new enough call to msgrcv() with MSG_COPY without
> IPC_NOWAIT returns EINVAL even without CONFIG_CHECKPOINT_RESTORE I guess
> that the flags are checked in the generic code and not ifdefed out. You
> will get ENOSYS only on correct combination i.e. MSG_COPY | IPC_NOWAIT.\
Yes, I understand your meaning.
> 
> So why don't we rather:
> 
> * Check if the kernel is older than 3.8 and skip the MSG_COPY test when
>    it is
> 
> * Check for ENOSYS in the test_msg_copy() function
> 
> These two conditions should cover all possible cases.
Yes. msgrcv03 uses this way. Will fix it on v3.
Thanks for your explanation.

Best Regards
Yang Xu
> 


