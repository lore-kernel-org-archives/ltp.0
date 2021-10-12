Return-Path: <SRS0=5AcX=PA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE70C433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Oct 2021 06:40:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41A560F21
	for <ltp@archiver.kernel.org>; Tue, 12 Oct 2021 06:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A41A560F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0C1A3C0E10
	for <ltp@archiver.kernel.org>; Tue, 12 Oct 2021 08:40:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AFD53C0BC7
 for <ltp@lists.linux.it>; Tue, 12 Oct 2021 08:40:07 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B84B2154D1B6
 for <ltp@lists.linux.it>; Tue, 12 Oct 2021 08:40:02 +0200 (CEST)
X-QQ-mid: bizesmtp44t1634020795ts9q8v99
Received: from [10.4.23.19] (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 12 Oct 2021 14:39:54 +0800 (CST)
X-QQ-SSF: 0140000000200040D000B00J0000000
X-QQ-FEAT: ZHWZeLXy+8fV3rN+NNkyupZzR1pD3TvNV5tcjR+grq9X1f9XzTGO/wetM3QfX
 BaudQLTY14Vg+jcc1pQ2KMJryITc1YsjmdJ4lCwNlWUj7MacyXMKz0or/gGowvxDa3JjPCm
 RWNIGwAc8npTAW/OGJSpc3/R0uxVgkZvjvnYgT0FdwJeC7dQNKRRMpwohqr7QjkRmTKvoZG
 XETspvB7T/2rOU8/wnRBrHsfgYKlHKaRhGkl5a9xK1a+ITDv2+RDgUS2SHnah1sBaTX7LUN
 8/Zp7Mo45ev0djtxnGPgwuULHvuSsBUwYg+HptpVU7iN6Y9ldbLyPr31nBg2YHG1/OnuNxf
 em1iSaJAZMdfK+CTLU=
X-QQ-GoodBg: 2
To: Cyril Hrubis <chrubis@suse.cz>
References: <20210923085224.868-1-zhanglianjie@uniontech.com>
 <YWRa4VvL33YclVX3@yuki>
From: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <e5dc6a57-21df-61d6-a353-ad07598283ca@uniontech.com>+76D9C6F0C52992F2
Date: Tue, 12 Oct 2021 14:39:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <YWRa4VvL33YclVX3@yuki>
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/5] syscalls/clone02: Convert to new API
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
I will revise it seriously, thank you.

On 2021-10-11 23:40, Cyril Hrubis wrote:
> Hi!
>> -/*
>> - * test_SIG() - This function changes the signal handler for SIGUSR2
>> - *		signal for child. If CLONE_SIGHAND flag is set, this
>> - *		affects parent also.
>> - */
>> -static int test_SIG(void)
>> +static void verify_clone(void)
>>   {
>> +	TST_EXP_PID_SILENT(ltp_clone(tcases[tst_variant].flags, child_fn, NULL,
>> +				CHILD_STACK_SIZE, child_stack));
>>
>> -	struct sigaction new_act;
>> +	if (!TST_PASS)
>> +		return;
>>
>> -	new_act.sa_handler = sig_child_defined_handler;
>> -	new_act.sa_flags = SA_RESTART;
>> -	sigemptyset(&new_act.sa_mask);
>> -
>> -	/* Set signal handler to sig_child_defined_handler */
>> -	if (sigaction(SIGUSR2, &new_act, NULL) == -1) {
>> -		tst_resm(TWARN | TERRNO, "signal failed in test_SIG");
>> -		return -1;
>> -	}
>> -
>> -	/* Send SIGUSR2 signal to parent */
>> -	if (kill(getppid(), SIGUSR2) == -1) {
>> -		tst_resm(TWARN | TERRNO, "kill failed in test_SIG");
>> -		return -1;
>> -	}
>> +	tst_reap_children();
>>
>> -	return 0;
>> +	TST_EXP_PASS(tcases[tst_variant].parent_fn(), "%s", tcases[tst_variant].desc);
> 
> Can we, instead of this, print PASS/FAIL for each check we do, so that
> if something fails the log explains what exactly has failed?
> 
>>   }
>>...
>> - */
>> -static int modified_SIG(void)
>> -{
>> +	/*
>> +	 * Open file from parent, which will be closed by
>> +	 * child, used for testing CLONE_FILES flag
>> +	 */
>> +	fd_parent = SAFE_OPEN(TESTFILE, O_CREAT | O_RDWR, 0777);
>>
>> -	if (parent_got_signal)
>> -		/*
>> -		 * parent came through sig_child_defined_handler()
>> -		 * this means child has changed parent's handler
>> -		 */
>> -		return 1;
>> +	/*
>> +	 * set parent_got_signal to 0, used for testing
>> +	 * CLONE_SIGHAND flag
>> +	 */
>> +	parent_got_signal = 0;
> 
> We have to make sure we reset the $PWD, variable, got_signal flag and
> open() the file before each test iteration otherwise the test will fail
> on subsequent iterations with -i 2 command line parameter.
> 
>> -	return 0;
>> -}
>> +	def_act.sa_handler = sig_parent_default_handler;
>> +	def_act.sa_flags = SA_RESTART;
>> +	SAFE_SIGEMPTYSET(&def_act.sa_mask);
>> +	SAFE_SIGACTION(SIGUSR2, &def_act, NULL);
>>
>> -/*
>> - * sig_child_defined_handler()  - Signal handler installed by child
>> - */
>> -static void sig_child_defined_handler(int pid)
>> -{
>> -	if ((syscall(__NR_gettid)) == child_pid)
>> -		/* Child got signal, give warning */
>> -		tst_resm(TWARN, "Child got SIGUSR2 signal");
>> -	else
>> -		parent_got_signal = TRUE;
>> +	SAFE_MKDIR(TESTDIR, 0777);
>> +	sprintf(cwd_child, "%s/%s", cwd_parent, TESTDIR);
>> +	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
> 
> Can we use the guarded buffer instead of MALLOC in this test as well?
> Just as we do in clone01.c now.
> 
>>   }
>>
>> -/* sig_default_handler() - Default handler for parent */
>> -static void sig_default_handler(void)
>> -{
>> -}
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_variants = ARRAY_SIZE(tcases),
> 
> This should rather be .tcnt and .test = verify_clone instead of
> variants.
> 
> Test variants are usually used when the whole test is exactly same but
> the TEST_*() function calls different variant of the syscall instead.
> 
>> +	.test_all = verify_clone,
>> +	.needs_tmpdir = 1,
>> +};
> 

-- 
Regards,
Zhang Lianjie



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
