Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACEAC6FA8F
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 09:22:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDCB03CC125
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 11:22:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F02A3C9762
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 11:22:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 14CD01000EC6
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 11:21:58 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 86BAA211DE;
 Tue, 29 Aug 2023 09:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693300918;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d6eOB1F+Z7Xf1mxe4o8jQ8/k0zodMP2o5ArFQNi+rvw=;
 b=fhdqokkzSuW1yHPpcgn9J3+fPnbPUiCJ9bCp8XJ2yzM0dvFFCudq0bbIQE3r0LTLvJQZoI
 St6XpnMaLR0wmskE+16dizxaKHDmQbkENNB2fpctN8+hvwg3XI8igMkRJj+oNMUzm/YQ18
 WBHWwgv0LswSoOczOD0NMj2PRQ8RKOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693300918;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d6eOB1F+Z7Xf1mxe4o8jQ8/k0zodMP2o5ArFQNi+rvw=;
 b=BIKZTSRD45szHR/HLFT81Is4lTnWME6+WARPgnlSlY0l4pwKxWz5UZsG+ilPBswqSpsI2y
 K1O0cT7zSOn36IDA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B390C2C142;
 Tue, 29 Aug 2023 09:21:57 +0000 (UTC)
References: <20230316072231.19157-3-wegao@suse.com>
 <20230530120723.29745-1-wegao@suse.com> <20230621102506.GB393195@pevik>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Aug 2023 10:20:44 +0100
Organization: Linux Private Site
In-reply-to: <20230621102506.GB393195@pevik>
Message-ID: <874jkijj9p.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [v5,2/2] semop04: Refactor with new API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Wei,
>
>> -void delayloop()
>> +static void delayloop(void)
>>  {
>>  	int delay;
>> +
>>  	delay = 1 + ((100.0 * rand()) / RAND_MAX);
>> -	if (verbose)
>> -		printf("in delay function for %d microseconds\n", delay);
>>  	usleep(delay);
>>  }
>
> ...
>> +	for (i = 0; i < LOOPS; i++) {
>> +		semdown(semid);
>>  		delayloop();
> Why not just:
>
> 	usleep(1 + ((100.0 * rand()) / RAND_MAX));
>
> and delete whole delayloop() function?
>
>> -		if (semup(semid)) {
>> -			printf("semup failed\n");
>> -		}
>> -		if (verbose)
>> -			printf("sem is up\n");
>> +		semup(semid);
>>  	}
>
> ...
>>  	/* set up the semaphore */
>> -	if ((semid = semget((key_t) 9142, 1, 0666 | IPC_CREAT)) < 0) {
>> -		printf("error in semget()\n");
>> -		exit(-1);
>> -	}
>> +	semid = SAFE_SEMGET((key_t) 9142, 1, 0666 | IPC_CREAT);
>> +
>>  	semunion.val = 1;
>> -	if (semctl(semid, 0, SETVAL, semunion) == -1) {
>> -		printf("error in semctl\n");
>> -	}
>
>> -	if ((pid = fork()) < 0) {
>> -		printf("fork error\n");
>> -		exit(-1);
>> -	}
>> +	SAFE_SEMCTL(semid, 0, SETVAL, semunion);
>> +
>> +	pid = SAFE_FORK();
>> +
>>  	if (pid) {
>> -		/* parent */
>>  		srand(pid);
>>  		mainloop(semid);
>> -		waitpid(pid, &chstat, 0);
>> -		if (!WIFEXITED(chstat)) {
>> -			printf("child exited with status\n");
>> -			exit(-1);
>> -		}
>> -		if (semctl(semid, 0, IPC_RMID, semunion) == -1) {
>> -			printf("error in semctl\n");
>> -		}
>> -		if (errors) {
>> -			printf("FAIL: there were %d errors\n", errors);
>> -		} else {
>> -			printf("PASS: error count is 0\n");
>> -		}
>> -		exit(errors);
>> +		tst_reap_children();
>> +		SAFE_SEMCTL(semid, 0, IPC_RMID, semunion);
>> +		tst_res(TPASS, "Semaphore up/down check success");
>
> Maybe here use plain semctl() verified with TST_EXP_POSITIVE() from
> tst_test_macros.h? This way we'd get TFAIL on failure instead of TPASS.
>
> Kind regards,
> Petr

Setting to changes requested in patchwork.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
