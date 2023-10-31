Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9674DC4332F
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 09:32:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B92483CE9D8
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 10:32:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DB213CC936
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 10:32:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8892F10000EB
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 10:32:42 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DD3031F45E;
 Tue, 31 Oct 2023 09:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698744760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNHMeD3ANrr+OH9QkfhHBGbmdz2HlJHOcfy1+9/aPUE=;
 b=EDVNzhYWMUyPnEn74gHiauvfIbzeNM2F+yL96Eq4LrUZl5UPNkToWRJSSj2SznreIWKBjn
 9oJgx0/ZPvCHDfW8Fo2OtlStWZ3WeXaWY+5EpUrPC2lxR2+RInKdkMwkskPQMoOSENRo1d
 6/0cROa2te+fdvU9+nPhMEpG+VF1B8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698744760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNHMeD3ANrr+OH9QkfhHBGbmdz2HlJHOcfy1+9/aPUE=;
 b=FGp4PcTtuzfjbVnX8rhOfYw+rgWORLhc92Zyvd+L44WQCPoax95Y+B6Sc3xQqSiE/apm03
 ySTCa0mXshR4aGBg==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5C4D32D272;
 Tue, 31 Oct 2023 09:32:40 +0000 (UTC)
References: <20230906080950.23155-1-andrea.cervesato@suse.de>
 <87a5sw10qb.fsf@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: rpalethorpe@suse.de
Date: Tue, 31 Oct 2023 09:30:02 +0000
Organization: Linux Private Site
In-reply-to: <87a5sw10qb.fsf@suse.de>
Message-ID: <87zfzzrvbc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor fork12 using new LTP API
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

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello,
>
> Andrea Cervesato <andrea.cervesato@suse.de> writes:
>
>> -	cleanup();
>> -	tst_exit();
>> +	tst_res(TINFO, "Number of processes forked is %d", forks);
>> +	TST_EXP_EXPR(TST_ERR == EAGAIN, "last fork() failed with
>> EAGAIN");
>
> I think it should at least accept ENOMEM as well.
>
>>  }
>>  
>> -static void setup(void)
>> +static void run(void)
>>  {
>> -	tst_sig(FORK, fork12_sigs, cleanup);
>> -	TEST_PAUSE;
>> +	int status;
>> +
>> +	child_pid = SAFE_FORK();
>> +	if (!child_pid) {
>
> Maybe here we should start a new process group which we can kill later
> in cleanup.
>
> I guess you would call SAFE_SETPGID(0, 0) here.
>
>> +		start_forking();
>> +		return;
>> +	}
>> +
>> +	SAFE_WAIT(&status);
>>  }
>>  
>>  static void cleanup(void)
>>  {
>> -	int waitstatus;
>> +	kill(child_pid, 0);
>>  
>> -	/* collect our kids */
>> -	kill(0, SIGQUIT);
>> -	while (wait(&waitstatus) > 0) ;
>> +	if (errno != ESRCH)
>
> Possibly errno is undefined if the call to kill was successful. Also
> there is a race here. You probably should just do an unconditional
> SIGKILL to all the children.
>
> If you have a process group as mentioned above, then you should be able
> to call kill(-child_pid, SIGKILL).
>
>> +		SAFE_KILL(child_pid, SIGKILL);
>>  }
>>  
>> -static void fork12_sigs(int signum)
>> -{
>> -	if (signum == SIGQUIT) {
>> -		/* Children will continue, parent will ignore */
>> -	} else {
>> -		tst_brkm(TBROK, cleanup,
>> -			 "Unexpected signal %d received.", signum);
>> -	}
>> -}
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.cleanup = cleanup,
>> +	.forks_child = 1,
>> +	.max_runtime = 600,
>> +};
>> -- 
>> 2.35.3
>
> BTW, tests like this seem to cause containers to become unresponsive. If
> Kirk or LTX are running in the same container without any further
> isolation then we could use all the resources assigned to a container on
> forking. We can lock LTX in memory, but that still leaves CPU.
>
> Perhaps the test could reduce its own process and memory limit? e.g. with prlimit

This test also randomly fails outside of a container. Also other tests
that are testing the limits. This makes me think more that setting lower
prlimits is needed. Also this rewrite gets higher priority.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
