Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE6CC433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:57:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED3060FE8
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3ED3060FE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99DBD3C8F70
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 10:57:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B440C3C1C6E
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 10:57:02 +0200 (CEST)
Received: from smtpbg506.qq.com (smtpbg506.qq.com [203.205.250.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 726BD10007C5
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 10:56:59 +0200 (CEST)
X-QQ-mid: bizesmtp33t1632387414t5jeki0e
Received: from [10.4.23.19] (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 23 Sep 2021 16:56:53 +0800 (CST)
X-QQ-SSF: 0140000000000040C000000B0000000
X-QQ-FEAT: 3uawQE1sH+0vYNmszzwFMgxxns3ZIEhJ1upY2qRw+JY6iPzSbx7A+jscNppQ5
 B+skq9N8GYe6B+k8T8uWedr2VecQYh8cKu6lQ57gs/k6ACytKJjNAFZGWACVORkKjFBAzCz
 VF1atJjI5UwQJhHOF3P1zGHOFEmoDECA21Y4NdgMHBUyt/mU/tTTpl11TqiTYRvJ3yCUKFL
 iUQrAxuzZnPdPKxgZnGaj17KJnZWJ0f6Y5uZWV0viPK5qH7yCVWbiDAO05pg++9iGbucHox
 2Ze+6vyhrgKje439VEwldMm+ZLZaCHb1X+J7iEazrzP93EWJsybCRBvcblifrV9mznvJD7I
 hnmCr5PKvXR181IGk5cWwZV4xjsUw==
X-QQ-GoodBg: 2
To: Petr Vorel <pvorel@suse.cz>
References: <20210902010814.32448-1-zhanglianjie@uniontech.com>
 <YTBo6ZS2GKWb8edF@pevik>
From: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <c0a5fa20-dd40-161c-352f-407b8a2d6b08@uniontech.com>+216A607F335762E5
Date: Thu, 23 Sep 2021 16:56:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <YTBo6ZS2GKWb8edF@pevik>
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] syscalls/clone01: Convert to new API
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
Please ignore other patches about clone testcases and just focus on 
v3.thanks.


On 2021-09-02 14:02, Petr Vorel wrote:
> Hi zhanglianjie,
> 
> ...
>> +static void verify_clone(void)
>>   {
>> -	void *child_stack;
>>   	int status, child_pid;
> 
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	setup();
>> +	TST_EXP_POSITIVE(ltp_clone(SIGCHLD, do_child, NULL,
> Shouldn't be TST_EXP_PID_SILENT()
> Because TST_EXP_POSITIVE() prints extra TPASS which is useless:
> 
> clone01.c:31: TPASS: clone() returned 11556
> clone01.c:37: TPASS: clone returned 11556
> clone01.c:43: TPASS: Child exited with 0
> 
> but with TST_EXP_PID_SILENT():
> clone01.c:37: TPASS: clone returned 11986
> clone01.c:43: TPASS: Child exited with 0
> 
> and on deliberate error (using -1 as flag):
> clone01.c:31: TFAIL: clone() failed: EINVAL (22)
> clone01.c:34: TBROK: wait(0x7ffed515f3ec) failed: ECHILD (10)
> 
>> +		CHILD_STACK_SIZE, child_stack), "clone()");
> 
>> -	child_stack = malloc(CHILD_STACK_SIZE);
>> -	if (child_stack == NULL)
>> -		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
>> +	child_pid = SAFE_WAIT(&status);
> 
>> -	tst_count = 0;
>> -
>> -	TEST(ltp_clone(SIGCHLD, do_child, NULL, CHILD_STACK_SIZE, child_stack));
>> -	if (TEST_RETURN == -1)
>> -		tst_resm(TFAIL | TTERRNO, "clone failed");
>> -
>> -	child_pid = SAFE_WAIT(cleanup, &status);
>> -
>> -	if (TEST_RETURN == child_pid)
>> -		tst_resm(TPASS, "clone returned %ld", TEST_RETURN);
>> +	if (TST_RET == child_pid)
> 	if (child_pid ==  TST_RET)
> 
> => run `make check-clone01' to see this error (and run make check-* for other
> tests).
> 
> 
> Kind regards,
> Petr
> 

-- 
Regards,
Zhang Lianjie



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
