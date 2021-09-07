Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00552C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 11:10:23 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB0E6105A
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 11:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAB0E6105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D2D93C2453
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 13:10:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D8F53C2414
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 13:10:09 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 591A41A00E34
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 13:10:05 +0200 (CEST)
X-QQ-mid: bizesmtp51t1631012996tckl5c3w
Received: from [10.4.23.46] (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 07 Sep 2021 19:09:56 +0800 (CST)
X-QQ-SSF: 0140000000200040C000B00C0000000
X-QQ-FEAT: soIjdELXxCIg1htkzdUpaYY7yezEod+Ie2WV9Yb3WRuR0fj6r/J+vTSbpIPXS
 XPrY0AaKb2dErJCd2IzPFPSKiT9edp/IqeMOqXDUdL/CjQvadjuotLay5chQUTvhsMd17ec
 1dmd86G1C/o6Gs/wvJ3Rj6IcuJ6DIJRs2OfSucZYqwNZj/lzPCIga55ow1ZmBu8hGTayKtd
 2T4kMXJjaxLLkU+AdCYWH/Z9A7fKjP17ZoPW6tR1PeQd4GXtVxwFFWTbMQLTRCkw9Pj0kOd
 dj/wS8gYPeCMNQa3xozI20vEZbazJR1cwKyO+t0UZFLVB7ZIrXluVtHxxQhAzeOOkd6mRLb
 i4sexeBiiUi+SsP3YY=
X-QQ-GoodBg: 2
To: Petr Vorel <pvorel@suse.cz>
References: <20210902010814.32448-1-zhanglianjie@uniontech.com>
 <YTBo6ZS2GKWb8edF@pevik>
From: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <1997ecb5-b3d3-fab5-05cf-115414714311@uniontech.com>+6A238C8E2B32DFED
Date: Tue, 7 Sep 2021 19:09:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <YTBo6ZS2GKWb8edF@pevik>
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Message-ID: <20210907110955.hpeqgpgG0Td_cLOYklpSncT7dz7Ap1-O0BIjiZOCxRM@z>

Hi,
Thank you I will resubmit.

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
