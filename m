Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65673C54E58
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 12:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710332939; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=yk3MzzrjE6u32SbdEJUFJZs9NS4kwJ/KY74Ny9CcxZs=;
 b=pay5Br/+IZVg3q/mOOeiiw8qzBER7S6XA4snuvV7lChI57qkeCr4CCbYk+51/I/IF52Ni
 In7qIuEELOqhkx/dVbPit57xqWDVjE3kN4KPtqYke1zHp5czf8i+xAuJh9Rgum3RzsyT8GP
 lGmT56mbBZlq09S1O4YAoy7qs1Ns15c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C0343CFD70
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 13:28:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBA413CD6D9
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 13:28:34 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9441C600824
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 13:28:33 +0100 (CET)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5686677bda1so1523966a12.0
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 05:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710332913; x=1710937713; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oqiTF3Pt1xYaS/s2/tXpb9hFY0/r018liF6sJzclPSw=;
 b=coqnUB5GWavzZQt0+YZtcX5zPKgAUNYQcaPy1gj4vSmo1VMPJnjdvmZ9h4aITOcV5b
 bj42utp2Lg4ByV8kxIQnARPg59uycAq7rcke5xquDVFP1ODlmiJ2zlvwvAPxATwnDywB
 n0GLV2k5jSKhQQ/thSOqOG+UY2Qaickw5fJvOebwLruhsKScjgQcUlhPgSlTmMhbGwDS
 nluDJ0u2oY73UhiP5k52x5M4WyBxB5HVNXSVMLRL0plT/OP+exsXucz6kdrdxUA8YPgR
 UjHhX4XMMw7JKI5ARaaN7+A8PNOEDiIXCKPcb1BaU7iaOpifdbIueTVZAGzTTD3MMNf2
 Geeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710332913; x=1710937713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oqiTF3Pt1xYaS/s2/tXpb9hFY0/r018liF6sJzclPSw=;
 b=XVnOY3rFcMKxOWakmsHTxo1dp4nriKZujBTd5wULKnihB4CB+vy9z8+XtChTjiXMXn
 Eba2qw9iZOazlPPleJ+jiFZOQI/DStjprkEVk0hbMh3TeYnxwzTp+XsdMg7OrCmsZ9Dn
 fYBSUICMS8+RxMB5F0isvQ6gfVgnBbqs2nD31JAg7LhUQzMpSe1V3j0t6q8mnGJn/s/h
 fiiM6yzEUQvTC3yV52vHmnesU5Oce8koeFewcI55CRgjXfqqmMVIcY6P1pTaUzf+nbwu
 6b7jBYDEGBzA0Wx9jXOXhcnrz04Sw8TLhyZ7KLajZsw/v8DqX9ulxbUIpB+Hvq/F68nf
 LTOA==
X-Gm-Message-State: AOJu0YwRYBKi9DdgEHKMrWbuwje61ni+LfyEdlIzLwu16CAouGCZ45+e
 gXzMujzQaS5lrlWnWcVCJ4/ratXIAowolUiT8RiuRl2Z9f9bu/ockLIe+Jn82c3nGQYrdpo/JZy
 4rNc=
X-Google-Smtp-Source: AGHT+IH/TEVRKoyZqMzLv6rpRLdjHSsD4+Z0TbNSzDs1Ahru9yGT3yUIIlqIKNtMR7lBebuFWJ2JKA==
X-Received: by 2002:a17:906:260a:b0:a46:5df:ad98 with SMTP id
 h10-20020a170906260a00b00a4605dfad98mr2107069ejc.21.1710332912851; 
 Wed, 13 Mar 2024 05:28:32 -0700 (PDT)
Received: from [10.232.133.97] ([88.128.88.111])
 by smtp.gmail.com with ESMTPSA id
 d22-20020aa7d696000000b00566d9c8e6cesm4976092edr.21.2024.03.13.05.28.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 05:28:32 -0700 (PDT)
Message-ID: <387c48d3-69bc-4ae0-a56c-255554b7b6b3@suse.com>
Date: Wed, 13 Mar 2024 13:28:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240312151324.13236-1-andrea.cervesato@suse.de>
 <ZfGSsIEG_k2htig8@yuki>
In-Reply-To: <ZfGSsIEG_k2htig8@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor fork05 using new LTP API
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

On 3/13/24 12:49, Cyril Hrubis wrote:
> Hi!
>> + * On Friday, May 2, 2003 at 09:47:00AM MST, Ulrich Drepper wrote:
>> + * >Robert Williamson wrote:
>> + * >
>> + * >>   I'm getting a SIGSEGV with one of our tests, fork05.c, that apparently
>> + * >> you wrote (attached below).  The test passes on my 2.5.68 machine running
>> + * >> SuSE 8.0 (glibc 2.2.5 and Linuxthreads), however it segmentation faults on
>> + * >> RedHat 9 running 2.5.68.  The test seems to "break" when it attempts to run
>> + * >> the assembly code....could you take a look at it?
>> + * >
>> + * >There is no need to look at it, I know it cannot work anymore on recent
>> + * >systems.  Either change all uses of %gs to %fs or skip the entire patch
>> + * >if %gs has a nonzero value.
>> + * >
>> + * >- --
>> + * >- --------------.                        ,-.            444 Castro Street
>> + * >Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
>> + * >Red Hat         `--' drepper at redhat.com `---------------------------
>>    *
>> + * On Sat, Aug 12, 2000 at 12:47:31PM -0700, Ulrich Drepper wrote:
>> + * > Ever since the %gs handling was fixed in the 2.3.99 series the
>> + * > appended test program worked.  Now with 2.4.0-test6 it's not working
>> + * > again.  Looking briefly over the patch from test5 to test6 I haven't
>> + * > seen an immediate candidate for the breakage.  It could be missing
>> + * > propagation of the LDT to the new process (and therefore an invalid
>> + * > segment descriptor) or simply clearing %gs.
>> + * >
>> + * > Anyway, this is what you should see and what you get with test5:
>> + * >
>> + * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> + * > a = 42
>> + * > %gs = 0x0007
>> + * > %gs = 0x0007
>> + * > a = 99
>> + * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> + * >
>> + * > This is what you get with test6:
>> + * >
>> + * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> + * > a = 42
>> + * > %gs = 0x0007
>> + * > %gs = 0x0000
>> + * > <SEGFAULT>
>> + * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> + * >
>> + * > If somebody is actually creating a test suite for the kernel, please
>> + * > add this program.  It's mostly self-contained.  The correct handling
>> + * > of %gs is really important since glibc 2.2 will make heavy use of it.
>> + * >
>> + * > - --
>> + * > - ---------------.                          ,-.   1325 Chesapeake Terrace
>> + * > Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
>> + * > Red Hat          `--' drepper at redhat.com   `------------------------
>> + * >
>> + * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    */
> Uff, this renders very ugly in the documentation. Can we at least drop
> the email signatures and rewrite the text a bit?
Yes it's horrible, but I didn't know what to do with this. I will try to 
do my best..
>> -#include <stdio.h>
>> -#include <fcntl.h>
>> -#include <unistd.h>
>> -#include <stdlib.h>
>> -#include <sys/wait.h>
>> +#include <asm/ldt.h>
>>   #include "lapi/syscalls.h"
>> -#include "test.h"
>> -
>> -char *TCID = "fork05";
>> -
>> -static char *environ_list[] = { "TERM", "NoTSetzWq", "TESTPROG" };
>> -
>> -#define NUMBER_OF_ENVIRON (sizeof(environ_list)/sizeof(char *))
>> -int TST_TOTAL = NUMBER_OF_ENVIRON;
>> +#include "tst_test.h"
>>   
>>   #if defined(linux) && defined(__i386__)
>>   
>> -struct modify_ldt_ldt_s {
>> -	unsigned int entry_number;
>> -	unsigned long int base_addr;
>> -	unsigned int limit;
>> -	unsigned int seg_32bit:1;
>> -	unsigned int contents:2;
>> -	unsigned int read_exec_only:1;
>> -	unsigned int limit_in_pages:1;
>> -	unsigned int seg_not_present:1;
>> -	unsigned int useable:1;
>> -	unsigned int empty:25;
>> -};
>> -
>> -static int a = 42;
>> -
>> -static void modify_ldt(int func, struct modify_ldt_ldt_s *ptr, int bytecount)
>> +static void run(void)
>>   {
>> -	tst_syscall(__NR_modify_ldt, func, ptr, bytecount);
>> -}
>> -
>> -int main(void)
>> -{
>> -	struct modify_ldt_ldt_s ldt0;
>> +	struct user_desc ldt0;
>> +	int base_addr = 42;
>>   	int lo;
>> -	pid_t pid;
>> -	int res;
>>   
>>   	ldt0.entry_number = 0;
>> -	ldt0.base_addr = (long)&a;
>> +	ldt0.base_addr = (long)&base_addr;
>>   	ldt0.limit = 4;
>>   	ldt0.seg_32bit = 1;
>>   	ldt0.contents = 0;
>> @@ -154,49 +90,34 @@ int main(void)
>>   	ldt0.useable = 1;
>>   	ldt0.empty = 0;
>>   
>> -	modify_ldt(1, &ldt0, sizeof(ldt0));
>> +	tst_syscall(__NR_modify_ldt, 1, &ldt0, sizeof(ldt0));
>>   
>>   	asm volatile ("movw %w0, %%fs"::"q" (7));
>> -
>>   	asm volatile ("movl %%fs:0, %0":"=r" (lo));
>> -	tst_resm(TINFO, "a = %d", lo);
>> +	tst_res(TINFO, "a = %d", lo);
>>   
>>   	asm volatile ("pushl %%fs; popl %0":"=q" (lo));
>> -	tst_resm(TINFO, "%%fs = %#06hx", lo);
>> +	tst_res(TINFO, "%%fs = %#06hx", lo);
>>   
>>   	asm volatile ("movl %0, %%fs:0"::"r" (99));
>>   
>> -	pid = fork();
>> -
>> -	if (pid == 0) {
>> +	if (!SAFE_FORK()) {
>>   		asm volatile ("pushl %%fs; popl %0":"=q" (lo));
>> -		tst_resm(TINFO, "%%fs = %#06hx", lo);
>> +		tst_res(TINFO, "%%fs = %#06hx", lo);
>>   
>>   		asm volatile ("movl %%fs:0, %0":"=r" (lo));
>> -		tst_resm(TINFO, "a = %d", lo);
>> +		tst_res(TINFO, "a = %d", lo);
>> +
>> +		TST_EXP_EQ_LI(lo, 99);
>>   
>> -		if (lo != 99)
>> -			tst_resm(TFAIL, "Test failed");
>> -		else
>> -			tst_resm(TPASS, "Test passed");
> Huh, why have you dropped the only TPASS/TFAIL in the test?
>
We have TST_EXP_EQ_LI()
>>   		exit(lo != 99);
> 	This should be just exit(0).
>
>> -	} else {
>> -		waitpid(pid, &res, 0);
>>   	}
>> -
>> -	return WIFSIGNALED(res);
>
> I guess that we can do waitpid() for the process and fail the test if we
> get SIGSEGV here as well.
>
>
>>   }
>>   
>> -#else /* if defined(linux) && defined(__i386__) */
>> -
>> -int main(void)
>> -{
>> -	tst_resm(TINFO, "%%fs test only for ix86");
>> -
>> -	/*
>> -	 * should be successful on all non-ix86 platforms.
>> -	 */
>> -	tst_exit();
>> -}
>> +static struct tst_test test = {
>> +	.run_all = run
>> +};
>>   
>> -#endif /* if defined(linux) && defined(__i386__) */
>> +#else /* defined(linux) && defined(__i386__) */
>> +	TST_TEST_TCONF("Test only supports linux 32 bits");
>> +#endif
>> -- 
>> 2.35.3
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
