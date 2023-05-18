Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEA5C7EE22
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 08:37:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F1D83CD447
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 10:36:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 590B13CB2AC
 for <ltp@lists.linux.it>; Thu, 18 May 2023 10:36:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4F2A1200A10
 for <ltp@lists.linux.it>; Thu, 18 May 2023 10:36:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 98D511FD69;
 Thu, 18 May 2023 08:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684399004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9A58KCvKheCr3G7ymluzUUxz+VXWE++/nAmUnVOxMEM=;
 b=WrBW3lRHAttc6Eof9OfuWYRSQEulrenLlkjES6BHI1wAxu1jbf/HRvwQkrwkNQDLzwzuYL
 xidKKpVZrESyf8bw+EyAmkaITamGUDYiNe9hA7gU1H0BAKJp2KpHPkxt6qw+Sd7cww78cX
 60Kib47GFfZb70psZUkUQJcNVKfgVrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684399004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9A58KCvKheCr3G7ymluzUUxz+VXWE++/nAmUnVOxMEM=;
 b=gOqf+KwxuQ3nmjrFQWqdj4xmOXh+U7kGVZPUgndnTpqO01ytEE3T7eYE7srR9mEThd36U0
 GF+fiSXn4ba8COAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77FDD1390B;
 Thu, 18 May 2023 08:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id n9pwHJzjZWQtPgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 18 May 2023 08:36:44 +0000
Message-ID: <18915cfd-8866-a01f-8562-1c6023a8e47f@suse.cz>
Date: Thu, 18 May 2023 10:36:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20230517153642.26919-1-mdoucha@suse.cz>
 <20230517153642.26919-5-mdoucha@suse.cz> <20230517224746.GC8914@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230517224746.GC8914@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/7] KVM: Add async communication helper functions
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
Cc: ltp@lists.linux.it, Nicolai Stange <nstange@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 18. 05. 23 0:47, Petr Vorel wrote:
> Hi Martin,
> 
> Acked-by: Petr Vorel <pvorel@suse.cz>
> 
>>   /*
>>    * Result value indicating end of test. If the test program exits using
>>    * the HLT instruction with any valid result value other than KVM_TEXIT or
>> diff --git a/testcases/kernel/kvm/include/kvm_guest.h b/testcases/kernel/kvm/include/kvm_guest.h
>> index ec13c5845..96f246155 100644
>> --- a/testcases/kernel/kvm/include/kvm_guest.h
>> +++ b/testcases/kernel/kvm/include/kvm_guest.h
>> @@ -64,6 +64,20 @@ void tst_brk_(const char *file, const int lineno, int result,
>>   	const char *message) __attribute__((noreturn));
>>   #define tst_brk(result, msg) tst_brk_(__FILE__, __LINE__, (result), (msg))
> 
> BTW (unrelated to this commit, as it was not added to this commit) tst_brk()
> definition from include/tst_test.h contains also
> TST_BRK_SUPPORTS_ONLY_TCONF_TBROK().
> 
> And tst_res() has also TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN().

The support macros are not needed, the controller program always handles 
TBROK using tst_brk() even if the guest incorrectly called tst_res(TBROK).

> We could rename tst_res_flags.h to tst_res.h and add there tst_brk() and
> tst_res() definitions and tst_brk_() and tst_res_() signatures.

I don't think that's a good idea. The guest library currently does not 
support variadic parameters for tst_res() and tst_brk() so the function 
signatures are slightly different.

>> diff --git a/testcases/kernel/kvm/lib_guest.c b/testcases/kernel/kvm/lib_guest.c
>> index d3b2ac3d5..f3e21d3d6 100644
>> --- a/testcases/kernel/kvm/lib_guest.c
>> +++ b/testcases/kernel/kvm/lib_guest.c
>> @@ -155,6 +155,22 @@ void tst_brk_(const char *file, const int lineno, int result,
>>   	kvm_exit();
>>   }
> 
>> +void tst_signal_host(void *data)
>> +{
>> +	test_result->file_addr = (uintptr_t)data;
>> +	test_result->result = KVM_TSYNC;
>> +}
>> +
>> +void tst_wait_host(void *data)
>> +{
>> +	volatile int32_t *vres = &test_result->result;
>> +
>> +	tst_signal_host(data);
>> +
>> +	while (*vres != KVM_TNONE)
>> +		;
> Interesting there is no any usleep().

usleep() does not exist in the guest library. And even if it did, 
yielding the CPU to the host would prevent kvm_svm03 from ever 
reproducing the CLGI bug.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
