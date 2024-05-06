Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDFDC10F16
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714996449; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Xtvl0rta+rTBw6waAO5oS1HPtsWhe9T2FZLJlh9ZUww=;
 b=lamev0X+C8JO/DTAopp5azm8BPzIooTxNH4y96yDPUxqxRXv2QGlcBHaiAXHVgweT43Du
 ZC8lGD+//bhnARrlgJCcNoQwB5wTVeL8EfvR0hKXM9PFkx4121yhZCSSOHYC/4jwYluAbUa
 SFRlNT/Mxf8nK+OBGJV5QSA6lWR1MEE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1C573CBCC9
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 13:54:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A863E3C0831
 for <ltp@lists.linux.it>; Mon,  6 May 2024 13:53:47 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D04B01A0C014
 for <ltp@lists.linux.it>; Mon,  6 May 2024 13:53:46 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34e667905d2so1408275f8f.1
 for <ltp@lists.linux.it>; Mon, 06 May 2024 04:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1714996426; x=1715601226; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tliOiNTFsfHU6jDFw+W0RKV1gNVr38esxFUMzdBMRg8=;
 b=XAjYmKgHtSzvmf1cmMFQha5wBZFuKoyQhrpTb5497sEmMKc4qsqoR92HtAXPJd1wxm
 GLAwMympwOT03B2iY9wKbnu2dyM1DkgjAWGPC5tlv4rkQuB+k/mq0iPXgoP3bLFFelJv
 T0a828q+YQqZK3ibv/4wQrTjhw+Q/hqbh3+Z6qFT6LH+3tvy673pkpYGNh+OHkoqjYw4
 UPft8LqIFq/gwRvx7SpSWS4X0BYygcB+dxbbuqEtQFsih+ZdlHYwwMu5VWwxNdITy/0f
 6yWoERWR4cGR/lDlgqo+Fvrt1/rP6gheap1dPrl8dk3GgQBOI1HAxbPt3+gYjTI6vsYT
 sijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714996426; x=1715601226;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tliOiNTFsfHU6jDFw+W0RKV1gNVr38esxFUMzdBMRg8=;
 b=SNOtnJQA7J82bO3kOYzgLKj6FzcIgS28LtmbbP8zaLLcKpD4GF0Mic1Zj9uK2YSYZ1
 jk87WAZahYGolhSUcLtpOY1PWf/BbOFHKbWwd4tHz/n8znl/+vkeqgcGd6vkH3X9wyEK
 dp9UxWwawcdXSyTc7GEDF1o3vKv539CehuTEKlTo6UEFvMVPJZzvR+/1sqb+iM8tn5+t
 TEeOuOHcNp2SpPIL+Lx+ufVHfKxljSzNSpCzzui5iRsqzuyFcLyHzX5IDvxmm1dlquET
 BvWxbmXZgJzW0BRQNSH+ZplP4ANF5PLvL83BjJIFco7u+cV6mIp6gy+ccBnAhIRdvo3s
 1OIA==
X-Gm-Message-State: AOJu0Yy+JUAvcuv+nQeZom9x1aNHEoXCHrAK+ZHAzmUjHgC86zF85CMO
 JjhJ9Ps9lIrMEWWdZuiTJma09uBEK3H5ob95pPg6scP/SoemyraGAKJDENl6au4=
X-Google-Smtp-Source: AGHT+IFjJVeI6mBejlAtHkAyzof2H4FkALH8bZtLhIZjkf33Dcf7UQTDpQq4Rhf5IsNIVmRZgDuE4w==
X-Received: by 2002:adf:c08c:0:b0:34a:1a7a:9d60 with SMTP id
 d12-20020adfc08c000000b0034a1a7a9d60mr7112947wrf.62.1714996426139; 
 Mon, 06 May 2024 04:53:46 -0700 (PDT)
Received: from [10.232.133.81] ([88.128.88.124])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4a4a000000b0034c462f920csm10498783wrs.40.2024.05.06.04.53.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 04:53:45 -0700 (PDT)
Message-ID: <04df6063-5691-4f56-a163-f0fd437ceed5@suse.com>
Date: Mon, 6 May 2024 13:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240503093151.29928-1-andrea.cervesato@suse.de>
 <Zji-Jh96mBq90dM-@yuki>
Content-Language: en-US
In-Reply-To: <Zji-Jh96mBq90dM-@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Rewrite msgstress testing suite
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Thanks for catching it. Yes, feel free to add it and send the patch.

Andrea

On 5/6/24 13:25, Cyril Hrubis wrote:
> Hi!
>> +static void reader(const int id, const int pos)
>> +{
>> +	int size;
>> +	int iter = num_iterations;
>> +	struct sysv_msg msg_recv;
>> +	struct sysv_data *buff = &ipc_data[pos];
>> +
>> +	while (--iter >= 0 && !(*stop)) {
>> +		memset(&msg_recv, 0, sizeof(struct sysv_msg));
>> +
>> +		size = SAFE_MSGRCV(id, &msg_recv, 100, MSGTYPE, 0);
>> +
>> +		if (msg_recv.type != buff->msg.type) {
>> +			tst_res(TFAIL, "Received the wrong message type");
>>   
>> -	for (i = 0; i < nprocs; i++) {
>> -		fflush(stdout);
>> -		if ((pid = FORK_OR_VFORK()) < 0) {
>> -			tst_brkm(TFAIL,
>> -				 NULL,
>> -				 "\tFork failed (may be OK if under stress)");
>> +			*stop = 1;
>> +			return;
>>   		}
>> -		/* Child does this */
>> -		if (pid == 0) {
>> -			procstat = 1;
>> -			exit(dotest(keyarray[i], i));
>> +
>> +		if (msg_recv.data.len != buff->msg.data.len) {
>> +			tst_res(TFAIL, "Received the wrong message data length");
>> +
>> +			*stop = 1;
>> +			return;
>>   		}
>> -		pidarray[i] = pid;
>> -	}
>>   
>> -	count = 0;
>> -	while (1) {
>> -		if ((wait(&status)) > 0) {
>> -			if (status >> 8 != 0) {
>> -				tst_brkm(TFAIL, NULL,
>> -					 "Child exit status = %d",
>> -					 status >> 8);
>> -			}
>> -			count++;
>> -		} else {
>> -			if (errno != EINTR) {
>> -				break;
>> +		for (int i = 0; i < size; i++) {
>> +			if (msg_recv.data.pbytes[i] != buff->msg.data.pbytes[i]) {
>> +				tst_res(TFAIL, "Received wrong data at index %d: %x != %x", i,
>> +					msg_recv.data.pbytes[i],
>> +					buff->msg.data.pbytes[i]);
>> +
>> +				*stop = 1;
>> +				return;
>>   			}
>> -#ifdef DEBUG
>> -			tst_resm(TINFO, "Signal detected during wait");
>> -#endif
>>   		}
>> -	}
>> -	/* Make sure proper number of children exited */
>> -	if (count != nprocs) {
>> -		tst_brkm(TFAIL,
>> -			 NULL,
>> -			 "Wrong number of children exited, Saw %d, Expected %d",
>> -			 count, nprocs);
>> -	}
>>   
>> -	tst_resm(TPASS, "Test ran successfully!");
>> +		tst_res(TDEBUG, "Received correct data");
>> +		tst_res(TDEBUG, "msg_recv.type = %ld", msg_recv.type);
>> +		tst_res(TDEBUG, "msg_recv.data.len = %d", msg_recv.data.len);
>> +	}
>>   
>> -	cleanup();
>> -	tst_exit();
>> +	buff->id = -1;
> You can't reset the buff->id to -1 here since that will cause the test
> to leak the message queues because the cleanup will not remove anything.
>
>
>>   }
>>   
>> -static int dotest(key_t key, int child_process)
>> +static void run(void)
>>   {
>> -	int id, pid;
>> -	int ret, status;
>> +	int id, pos;
>>   
>> -	sighold(SIGTERM);
>> -	TEST(msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR));
>> -	if (TEST_RETURN < 0) {
>> -		printf("msgget() error in child %d: %s\n",
>> -			child_process, strerror(TEST_ERRNO));
>> +	reset_messages();
> And this is even a bigger problem, with that we forget the IDs on each
> iteration with -i so we will leak even more message queues, just check
> ipcs output after running this test.
>
>
> I can push the patch with a following diff, if you agree:
>
> diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> index 5851938dd..5c84957b3 100644
> --- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> +++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> @@ -6,7 +6,7 @@
>    * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>    */
>   
> -/*
> +/*\
>    * [Description]
>    *
>    * Stress test for SysV IPC. We send multiple messages at the same time,
> @@ -146,8 +146,15 @@ static void reader(const int id, const int pos)
>                  tst_res(TDEBUG, "msg_recv.type = %ld", msg_recv.type);
>                  tst_res(TDEBUG, "msg_recv.data.len = %d", msg_recv.data.len);
>          }
> +}
>   
> -       buff->id = -1;
> +static void remove_queues(void)
> +{
> +       for (int pos = 0; pos < num_messages; pos++) {
> +               struct sysv_data *buff = &ipc_data[pos];
> +               if (buff->id != -1)
> +                       SAFE_MSGCTL(buff->id, IPC_RMID, NULL);
> +       }
>   }
>   
>   static void run(void)
> @@ -175,6 +182,7 @@ static void run(void)
>          }
>   
>          tst_reap_children();
> +       remove_queues();
>   
>          if (!(*stop))
>                  tst_res(TPASS, "Test passed. All messages have been received");
> @@ -232,12 +240,7 @@ static void cleanup(void)
>          if (!ipc_data)
>                  return;
>   
> -       for (int pos = 0; pos < num_messages; pos++) {
> -               struct sysv_data *buff = &ipc_data[pos];
> -
> -               if (buff->id != -1)
> -                       SAFE_MSGCTL(buff->id, IPC_RMID, NULL);
> -       }
> +       remove_queues();
>   
>          SAFE_MUNMAP(ipc_data, sizeof(struct sysv_data) * num_messages);
>          SAFE_MUNMAP((void *)stop, sizeof(int));
>
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
