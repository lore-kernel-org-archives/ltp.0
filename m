Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E18C433F5
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 10:28:00 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C604463217
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 10:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C604463217
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9C873C875F
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 11:27:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC6143C668B
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 11:27:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 272BF200962
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 11:27:47 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6416E1FCA1;
 Tue, 16 Nov 2021 10:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637058467;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9nIqg1h57y0y+AdliokCSnTQbMQxDtLNvJai2yJdyLY=;
 b=MJk+6M1QSn8sYoYKn7HfbCXo3pMPtUW8VMF0zGR3NtSAvSbvosRuBc9YzRsghPNNS20ygl
 6v2pyciQ2LtS5XWj+k1ZnINDZeSlrP8bhj+de+GwxFK0JQe8HR1Re4v99pfyYVJaYRcNXB
 kJOXCaI4w6yLpMq1bw7RTXc9JiZlFj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637058467;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9nIqg1h57y0y+AdliokCSnTQbMQxDtLNvJai2yJdyLY=;
 b=zysfwqTFZyQ+JMX1o1XZ6rA3REQ1SRpFn+mAsKCzupqF+MLGaC2VT3JtEelcnIY2hNJLBD
 tLEcOaZ/XwzkyeCA==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 222A5A3B81;
 Tue, 16 Nov 2021 10:27:47 +0000 (UTC)
References: <20211109130910.1583233-1-liwang@redhat.com>
 <20211109130910.1583233-2-liwang@redhat.com> <YYqghWs62gwfQZqR@yuki>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Nov 2021 10:27:00 +0000
In-reply-to: <YYqghWs62gwfQZqR@yuki>
Message-ID: <87czn0bdjx.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/3] testcase: make use of .supported_archs
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

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>>  static void run(void)
>> @@ -58,6 +50,11 @@ static void run(void)
>>  	register long mode __asm__("r3");
>>  	register long node_mask_ptr __asm__("r4");
>>  	register long node_mask_sz __asm__("r5");
>> +#else
>> +	static const int sys_num = 276;
>> +	static const int mode;
>> +	static const int node_mask_ptr = UINT_MAX;
>> +	static const int node_mask_sz = UINT_MAX;
>
> These shouldn't be static anymore.
>
>>  #endif
>>  	char stack_pattern[0x400];
>>  
>> @@ -78,7 +75,8 @@ static void run(void)
>>  		:
>>  		"memory", "cr0", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
>>  	sys_ret = mode;
>> -#else /* __i386__ */
>> +#endif
>> +#ifdef __i386__
>>  	asm volatile (
>>  		"add $0x400, %%esp\n\t"
>>  		"int $0x80\n\t"
>> @@ -114,15 +112,14 @@ static void run(void)
>>  
>>  static struct tst_test test = {
>>  	.test_all = run,
>> +	.supported_archs = (const char *const []) {
>> +		"i386",
>> +		"ppc",
>
> And we should add "ppc64" here as well, right?

Nope, I think this is only 32-bit

>
>> +		NULL
>> +	},
>>  	.tags = (const struct tst_tag[]) {
>>  		{"linux-git", "cf01fb9985e8"},
>>  		{"CVE", "CVE-2017-7616"},
>>  		{}
>>  	}
>>  };
>
> Other than these two:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
