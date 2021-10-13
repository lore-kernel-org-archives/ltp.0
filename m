Return-Path: <SRS0=jFKu=PB=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6872AC433F5
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 02:49:36 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B65160F23
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 02:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B65160F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 364B43C1011
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 04:49:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2808A3C0E8A
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 04:49:22 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7FE6D600E5F
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 04:49:18 +0200 (CEST)
X-QQ-mid: bizesmtp46t1634093352tyfc22j9
Received: from [10.4.23.19] (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Wed, 13 Oct 2021 10:49:11 +0800 (CST)
X-QQ-SSF: 0140000000200040D000B00A0000000
X-QQ-FEAT: F3yR32iATbhuiQ+JOQtxovSwEStZBKc19+3UVnYRyN8gbrotyy5kksh3B2Rvm
 ZRyoeMAFGkYzY+uPd9+rxeKVKQ1d8gTlySn4TXxVUJNYhTLGvpokuLjd5SmGYtBZF7jbRdY
 yEjkf7kBJFrZA6ePTVvh/7joSjlgp2+uO3gahnGiDegbBLhpsmxoHmD5KpPiNtKudqoXmPx
 POrjaIolYW2t1uaSoBwPOVpSwWUEJG4jDHN/MFmAjXHo3M27SX+RgruTfHhzfn1MIxULUtw
 EDrz+hdvXBxTRhDGv95UcMjf1oKSsX6apb7Sc+q01stUbxgEgOQGSbNs/SNDzyQkEFosVTg
 SRbebOKYNP2y4jIY8g=
X-QQ-GoodBg: 2
To: Cyril Hrubis <chrubis@suse.cz>
References: <20210923085224.868-1-zhanglianjie@uniontech.com>
 <20210923085224.868-4-zhanglianjie@uniontech.com> <YWVTsg3BLFwZRcl0@yuki>
From: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <41caea86-50f4-ce70-be6e-654fa5892880@uniontech.com>+5FCA4DE9235618E4
Date: Wed, 13 Oct 2021 10:49:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <YWVTsg3BLFwZRcl0@yuki>
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/5] syscalls/clone06: Convert to new API
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
This is a good idea, just do it, thank you.

On 2021-10-12 17:21, Cyril Hrubis wrote:
> Hi!
>> -	cleanup();
>> -	tst_exit();
>> +	parent_env = getenv("TERM") ? : "";
> 
> I guess that it would make more sense to create a new variable than
> depend on anything that may or may not be present on the system.
> 
> What about we setenv a variable instead and use that for the test?
> 
> #define ENV_VAL "LTP test variable value"
> #define ENV_ID "LTP_CLONE_TEST"
> 
> static void setup(void)
> {
> 	int ret;
> 
> 	ret = setenv(ENV_ID, ENV_VAL, 0)
> 	if (ret)
> 		tst_brk(TBROK | TERRNO, "setenv() failed");
> 
> }
> 
> 
>> +	TST_EXP_VAL(strcmp(buff, parent_env), 0,
>> +				"verify environment variables by child");
> 
> Also there is no need to propagate the value to the parent like this,
> the child process can report the result (in the new library) as well, so
> this really could be as simple as:
> 
> static int do_child(void *arg LTP_ATTRIBUTE_UNUSED)
> {
> 	const char *env_val = getenv(ENV_ID);
> 
> 	if (!env_val) {
> 		tst_res(TFAIL, "Variable " ENV_ID " not defined in child");
> 		return;
> 	}
> 
> 	if (strcmp(env_val, ENV_VAL)) {
> 		tst_res(TFAIL, "Variable value is different");
> 		return;
> 	}
> 
> 	tst_res(TPASS, ...);
> }
> 
>>   }
>>
>>   static void setup(void)
>>   {
>> -	tst_sig(FORK, DEF_HANDLER, cleanup);
>> -	TEST_PAUSE;
>> +	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
>> +	buff = SAFE_MMAP(NULL, MAX_LINE_LENGTH, PROT_READ | PROT_WRITE,
>> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>>   }
>>
>>   static void cleanup(void)
>>   {
>> -}
>> -
>> -/*
>> - *	Function executed by child.
>> - *	Gets the value for environment variable,TERM &
>> - *	writes it to  a pipe.
>> - */
>> -static int child_environ(void)
>> -{
>> -
>> -	char var[MAX_LINE_LENGTH];
>> -
>> -	/* Close read end from child */
>> -	if ((close(pfd[0])) == -1)
>> -		tst_brkm(TBROK | TERRNO, cleanup, "close(pfd[0]) failed");
>> -
>> -	if ((sprintf(var, "%s", getenv("TERM") ? : "")) < 0)
>> -		tst_resm(TWARN | TERRNO, "sprintf() failed");
>> -
>> -	if ((write(pfd[1], var, MAX_LINE_LENGTH)) == -1)
>> -		tst_resm(TWARN | TERRNO, "write to pipe failed");
>> -
>> -	/* Close write end of pipe from child */
>> -	if ((close(pfd[1])) == -1)
>> -		tst_resm(TWARN | TERRNO, "close(pfd[1]) failed");
>> +	free(child_stack);
>>
>> -	exit(0);
>> +	if (buff)
>> +		SAFE_MUNMAP(buff, MAX_LINE_LENGTH);
>>   }
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.test_all = verify_clone,
>> +	.cleanup = cleanup,
>> +};
>> --
>> 2.20.1
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Regards,
Zhang Lianjie



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
