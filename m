Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7CAC64EC7
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 10:52:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 440C33CBA26
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 11:52:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 092143C01AA
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 11:52:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9517E200754
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 11:52:29 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 163FC21A53;
 Tue, 28 Feb 2023 10:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677581549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sM2aAYvvDv7mPR+A4FuyDzmWAzKccxdDVs55Ga+S1LM=;
 b=zHTHyEjc4ylJmRWnULQZr0AjHK/TYERKhWfEj8nm/FIsZZYXzifuSNybtvyBzRReA5SZw3
 1NB3HfxYSoPaaZX5D6vCU/DYYjuIiUz8J5d5Hzig4zzF2EXKlC5KZrTntpVJSW7NVKp4+L
 LogImql7modWLi4M46hXufwlAvkdbTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677581549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sM2aAYvvDv7mPR+A4FuyDzmWAzKccxdDVs55Ga+S1LM=;
 b=QfGk1Cvmw7ZY4sdMkm7G08FR9zhz0cKzaLwGO4+ydeQtTkcBGpqZTLgOTJ+/tiv9J+zPQ1
 0oL4+DrVsVVIgKDg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DC5302C141;
 Tue, 28 Feb 2023 10:52:28 +0000 (UTC)
References: <20230215101615.27534-1-andrea.cervesato@suse.com>
 <20230215101615.27534-2-andrea.cervesato@suse.com>
 <87wn42t696.fsf@suse.de>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 28 Feb 2023 10:52:09 +0000
Organization: Linux Private Site
In-reply-to: <87wn42t696.fsf@suse.de>
Message-ID: <87sfeqt637.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 01/10] Refactor userns01 test
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
> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>  testcases/kernel/containers/userns/userns01.c | 27 +++++++------------
>>  1 file changed, 10 insertions(+), 17 deletions(-)
>>
>> diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
>> index 8ed7a9f41..cbe0da245 100644
>> --- a/testcases/kernel/containers/userns/userns01.c
>> +++ b/testcases/kernel/containers/userns/userns01.c
>> @@ -20,9 +20,9 @@
>>  #define _GNU_SOURCE
>>  
>>  #include <stdio.h>
>> -#include "common.h"
>>  #include "config.h"
>>  #include <sys/capability.h>
>> +#include "lapi/sched.h"
>>  
>>  #define OVERFLOWUIDPATH "/proc/sys/kernel/overflowuid"
>>  #define OVERFLOWGIDPATH "/proc/sys/kernel/overflowgid"
>> @@ -30,10 +30,7 @@
>>  static long overflowuid;
>>  static long overflowgid;
>>  
>> -/*
>> - * child_fn1() - Inside a new user namespace
>> - */
>> -static int child_fn1(LTP_ATTRIBUTE_UNUSED void *arg)
>> +static void child_fn1(void)
>>  {
>>  	int uid, gid;
>>  	cap_t caps;
>> @@ -45,10 +42,8 @@ static int child_fn1(LTP_ATTRIBUTE_UNUSED void *arg)
>>  
>>  	tst_res(TINFO, "USERNS test is running in a new user namespace.");
>>  
>> -	if (uid != overflowuid || gid != overflowgid)
>> -		tst_res(TFAIL, "got unexpected uid=%d gid=%d", uid, gid);
>> -	else
>> -		tst_res(TPASS, "got expected uid and gid");
>> +	TST_EXP_EQ_LI(uid, overflowuid);
>> +	TST_EXP_EQ_LI(gid, overflowgid);
>>  
>>  	caps = cap_get_proc();
>>  
>> @@ -68,31 +63,29 @@ static int child_fn1(LTP_ATTRIBUTE_UNUSED void *arg)
>>  		tst_res(TFAIL, "unexpected effective/permitted caps at %d", i);
>>  	else
>>  		tst_res(TPASS, "expected capabilities");
>> -
>> -	return 0;
>>  }
>>  
>>  static void setup(void)
>>  {
>> -	check_newuser();
>
> User namespaces have been in the kernel a long time, but they can be
> disabled at compile time.
>
> So we need to check for CONFIG_USER_NS in the kernel config.

Ah, ignore that, I see it's already there.

>
>> -
>>  	SAFE_FILE_SCANF(OVERFLOWUIDPATH, "%ld", &overflowuid);
>>  	SAFE_FILE_SCANF(OVERFLOWGIDPATH, "%ld", &overflowgid);
>>  }
>>  
>>  static void run(void)
>>  {
>> -	int pid;
>> +	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
>>  
>> -	pid = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, child_fn1, NULL);
>> -	if (pid < 0)
>> -		tst_brk(TBROK | TTERRNO, "clone failed");
>> +	if (!SAFE_CLONE(&args)) {
>> +		child_fn1();
>> +		return;
>> +	}
>>  }
>>  
>>  static struct tst_test test = {
>>  	.setup = setup,
>>  	.test_all = run,
>>  	.needs_root = 1,
>> +	.forks_child = 1,
>>  	.caps = (struct tst_cap []) {
>>  		TST_CAP(TST_CAP_DROP, CAP_NET_RAW),
>>  		{}
>> -- 
>> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
