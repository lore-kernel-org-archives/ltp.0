Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5689C48BF6
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 07:41:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 511A23CE9B4
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 08:41:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCFB43CE984
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 08:41:20 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dbrendel@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 426E6100EEDF
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 08:41:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709797278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t/uvPqhWA3fal0U1txxtr5n++9yqAGrmXxtJwevpts4=;
 b=E0B/Vjmr7+4lp/vSKQinv1ePt2i81HVhYH4+W4Bh4p+B6YUal1ETM/sIN8s0nOVbOaXv9N
 65iV/lspd8p/LDx81W4a3L5v+hXcyf0tPXAknlf4cXc5itQMzFlFTAdxmaMmjaRSAA4n+N
 Kx3D/aW4NbEdOqhFAbeckV+15yGshLE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-f1IYtYSpPl-cbhqJxCYhkA-1; Thu, 07 Mar 2024 02:41:17 -0500
X-MC-Unique: f1IYtYSpPl-cbhqJxCYhkA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-69045d681ceso5952046d6.1
 for <ltp@lists.linux.it>; Wed, 06 Mar 2024 23:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709796976; x=1710401776;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t/uvPqhWA3fal0U1txxtr5n++9yqAGrmXxtJwevpts4=;
 b=Tg1G4dHy/ssGYj4pFrNunCEi2G6AwwVk9CFdNx0tq/OJ5zSc8oSRUvbuH6Q2SzAKsQ
 GxRwkp9Op0skNf+oAzeV8nyWZXYYKpZc6m1itpdpDPt/UoBRllP3nDuwiMcIj5d1bN3k
 Gg0JjA5AKBiu/WH4wknh94HHGjmKPk1cKTdZfNvLzD3Siz2jDQRX27LNiVfOKGKHQ1Ph
 W0rJT6Rh/Ec1OJuOjR4OZvWctR2FTuUgU/kFfjMPf7F6cYIxa7NEQHnFiuuaKpf6I4Bx
 zhr4i+Lz2TqHYKmCT9wi7CEyYAuho6EkfDvcR1E2a7tWROrEFemcEzHQmvPpGvEdCR9F
 wwkA==
X-Gm-Message-State: AOJu0YwBUPM63pfdwtorPB47lKlIDRIDgqPySj3BuT30JmUwJZM47lzA
 EN6CBQhXSO7MYt5cM9aIt00LPLnL24jizYTqJLBR7paVl1F19TvfHKKtAFHi8fm1H07CK5Kyhy2
 CDWLn7FJxeIXewW4A8QEiXqwsFPv5W9jOp43lEOdlJQYsFd8l
X-Received: by 2002:ad4:420c:0:b0:690:870d:7662 with SMTP id
 k12-20020ad4420c000000b00690870d7662mr7452954qvp.46.1709796976190; 
 Wed, 06 Mar 2024 23:36:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgYkmb3e3otihSYaC9HdJUSxDwtQhgaVl64hMeQ4r52XCcpMtjrbfvG0ujXW7FCTS1UrKEXg==
X-Received: by 2002:ad4:420c:0:b0:690:870d:7662 with SMTP id
 k12-20020ad4420c000000b00690870d7662mr7452935qvp.46.1709796975849; 
 Wed, 06 Mar 2024 23:36:15 -0800 (PST)
Received: from [192.168.176.20] ([185.44.203.230])
 by smtp.gmail.com with ESMTPSA id
 ld8-20020a056214418800b0068fef1264f6sm8314244qvb.101.2024.03.06.23.36.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 23:36:15 -0800 (PST)
Message-ID: <71084990-17ef-461e-907e-e2bc39c2b236@redhat.com>
Date: Thu, 7 Mar 2024 08:36:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240306085254.534940-1-dbrendel@redhat.com>
 <ZeiLMOR4rXMY7Sr4@yuki>
From: Dennis Brendel <dbrendel@redhat.com>
Autocrypt: addr=dbrendel@redhat.com; keydata=
 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
In-Reply-To: <ZeiLMOR4rXMY7Sr4@yuki>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, de-DE
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] munlockall: add test case that verifies memory
 has been unlocked
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On 3/6/24 16:26, Cyril Hrubis wrote:
> Hi!
>> +/*\
>> + * [Description]
>> + *
>> + * Verify that munlockall(2) unlocks all previously locked memory
>> + */
>>  
>> -char *TCID = "munlockall01";
>> -int TST_TOTAL = 1;
>> +#include <sys/mman.h>
>>  
>> -#if !defined(UCLINUX)
>> +#include "tst_test.h"
>>  
>> -int main(int ac, char **av)
>> +static void verify_munlockall(void)
>>  {
>> -	int lc;
>> -
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> +	unsigned long size = 0;
>>  
>> -	setup();
>> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
>>  
>> -	/* check looping state */
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> +	if (size != 0UL)
>> +		tst_brk(TBROK, "Locked memory after init should be 0 but is %ld", size);
>>  
>> -		tst_count = 0;
>> +	if (mlockall(MCL_CURRENT | MCL_FUTURE) != 0)
>> +		tst_brk(TBROK | TERRNO, "Could not lock memory using mlockall()");
>>  
>> -		TEST(munlockall());
>> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
>>  
>> -		/* check return code */
>> -		if (TEST_RETURN == -1) {
>> -			tst_resm(TFAIL | TTERRNO, "munlockall() Failed with"
>> -				 " return=%ld", TEST_RETURN);
>> -		} else {
>> -			tst_resm(TPASS, "munlockall() passed with"
>> -				 " return=%ld ", TEST_RETURN);
>> +	if (size == 0UL)
>> +		tst_brk(TBROK, "Locked memory after mlockall() should be greater than 0, "
>> +			       "but is %ld", size);
> 
> This line can be shorter:
> 
> 	tst_brk(TBROK, "After mlockall() locked memory should be >0");
> 
> We already checked that size is 0 so no need to print it.

Agreed :-)

>> -		}
>> -	}
>> +	if (munlockall() != 0)
>> +		tst_brk(TBROK | TERRNO, "Could not unlock memory using munlockall()");
> 
> We are testing the munlockall() syscall here so it would be better to
> use the TST_EXP_PASS() macro.

The actual purpose of the test was not checking the return value of the syscall
(wrapper), but the behavior as reported by the kernel through /proc - but fair
enough, it does not do any harm :-)

>> -	/* cleanup and exit */
>> -	cleanup();
>> -	tst_exit();
>> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
>>  
>> +	if (size != 0UL)
>> +		tst_res(TFAIL, "Locked memory after munlockall() should be 0 but is %ld", size);
>> +
>> +	else
>> +		tst_res(TPASS, "Memory successfully locked and unlocked");
>>  }
>>  
>> -#else
>> -
>> -int main(void)
>> -{
>> -	tst_resm(TINFO, "test is not available on uClinux");
>> -	tst_exit();
>> -}
>> -
>> -#endif /* if !defined(UCLINUX) */
>> -
>> -/* setup() - performs all ONE TIME setup for this test. */
>> -void setup(void)
>> -{
>> -	tst_require_root();
>> -
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -
>> -	TEST_PAUSE;
>> -}
>> -
>> -/*
>> - * cleanup() - performs all ONE TIME cleanup for this test at
>> - *		completion or premature exit.
>> - */
>> -void cleanup(void)
>> -{
>> -}
>> +static struct tst_test test = {
>> +	.test_all = verify_munlockall,
>> +};
>> -- 
>> 2.44.0
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
