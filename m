Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A53FC54E41
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 08:49:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91BD03CE9D4
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 09:49:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88DC63C2A69
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 09:49:27 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dbrendel@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3A6DC600CF5
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 09:49:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709714964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FcI21iMKqu3RRnOZ981gMQxDcVZ3pnsYQv9OC9RLyE4=;
 b=ek8NAF7LHmnuG+9MHMxT7AYJmpOXFpTUz1HhyTYA7qGNpTmtc/m2FE4wfEdxwGR/9mDMxD
 Yq/MxM/nBJ3guOpkWq+ufJ1rm4FV/cYwjrN8y9ubPwpQi1/u7E4ZprVraTfVAPGxY5owhj
 hKKLhv+PauT4qMU9y9H+USolg7gBai0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-hxnr8Y5NORGy7RiVulh_GQ-1; Wed, 06 Mar 2024 03:49:23 -0500
X-MC-Unique: hxnr8Y5NORGy7RiVulh_GQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6904f4bc70bso86997046d6.1
 for <ltp@lists.linux.it>; Wed, 06 Mar 2024 00:49:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709714962; x=1710319762;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FcI21iMKqu3RRnOZ981gMQxDcVZ3pnsYQv9OC9RLyE4=;
 b=IUp0Zpo/A+VVW3IGO3Sl6np3KtJqhAA1GGTIGvdS7ARnHrkv08FDu10Rt5rgmu4aXp
 ma8lJFUB69r+NaWbNR0welHRAtU66aE25rvXQGvVdGfwxqiz7BwG92IQsmduuLrLH2k+
 BAYeadDnKxXBHrSsDvd43ikWNcAgx5v3wVVIo+LJmbhFJhBLDV0BzgVl7MOtG7Eftagi
 yG2W5hyrccTxky9xXrLD0L4SJDb9b+0hOwpX6A0wkcIxIN0+HXf+EHJw6vEY83tCW0DD
 /jN7FiocyWq/2V6p/tifQSxD0+FHP1Ddyxh0WXVQQa5V+SnQ1nQjgopeaWZJjuq9o5yy
 0U+g==
X-Gm-Message-State: AOJu0YxX3jsQut0H6pJOz8/DeHJ5hrZ2foT83WCRKJvs7ddsM1WCXsqr
 JZ9ExnmP4mA96j1R6ebnOgU8u5cik5/N7HssjEAxZIBZ8FX9OI9/klwIXqHewZTsMxr3ynJ9C66
 MovDfzfoHgeZjr7mlrPIe2pWq2jCEPeY78WrnYJRmQsWiDSVC
X-Received: by 2002:ad4:4701:0:b0:68f:e80f:a285 with SMTP id
 qb1-20020ad44701000000b0068fe80fa285mr4389942qvb.59.1709714962708; 
 Wed, 06 Mar 2024 00:49:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXXt7g49553qDxBaXIb5PMYKCn39FYmgRRyLRibdFikJdErx+9f2puuLmRlWjkgI0Z1LOsFg==
X-Received: by 2002:ad4:4701:0:b0:68f:e80f:a285 with SMTP id
 qb1-20020ad44701000000b0068fe80fa285mr4389927qvb.59.1709714962256; 
 Wed, 06 Mar 2024 00:49:22 -0800 (PST)
Received: from [192.168.176.20] (103-200-156-095.ip-addr.knet-kl.de.
 [95.156.200.103]) by smtp.gmail.com with ESMTPSA id
 dw19-20020a0562140a1300b0068fcaa599f6sm7089237qvb.67.2024.03.06.00.49.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 00:49:21 -0800 (PST)
Message-ID: <77587bec-7fe9-4337-b70b-3dff9ea6499f@redhat.com>
Date: Wed, 6 Mar 2024 09:49:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <6dfa210d-1c9a-4888-9408-eccc3068cd2a@redhat.com>
 <20240305213050.GB44833@pevik>
From: Dennis Brendel <dbrendel@redhat.com>
Autocrypt: addr=dbrendel@redhat.com; keydata=
 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
In-Reply-To: <20240305213050.GB44833@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] munlockall: add test case that verifies memory
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

Hi Petr,

Thank you very much for your feedback! I'll send a v3 which considers your
suggestions.

Dennis

On 3/5/24 22:30, Petr Vorel wrote:
> Hi Dennis,
> 
> Generally LGTM, thanks!
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> you should also add test into .gitignore and to some file in runtest/ (in this
> case into runtest/syscalls), if we don't simply replace your test with munlockall01.c
> as Cyril suggested (I would also vote for replacing it).
> 
> FYI you can have look for what we check:
> 
> https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist
> 
>> Changes to v1:
> 
>> - use a docparse comment
>> - use tabs for indentation
>> - report broken test and exit if any preparation/confirmation fails
>>   by using tst_brk(TBROK, ...)
>> - fix further violations reported by `make check`
> 
>> I did not yet replace munlockall01.c because I am not familiar with
> I guess Cyril meant just to replace munlockall01.c with what you wrote.
> +1 for this, there is no point to keep original munlockall01.c.
> And because you replace, you can delete the original copyright and can use
> GPL-2.0-or-later (original test was GPL v2 only).
> 
>> that (legacy?) syntax and why uclinux needs special handling.
> 
> uclinux is for nommu, we don't support it in new API (and nobody from the
> community standup for the support), it can be just deleted.
> 
>> ---
>>  .../kernel/syscalls/munlockall/munlockall02.c | 51 +++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 testcases/kernel/syscalls/munlockall/munlockall02.c
> 
>> diff --git a/testcases/kernel/syscalls/munlockall/munlockall02.c b/testcases/kernel/syscalls/munlockall/munlockall02.c
>> new file mode 100644
>> index 000000000..06f781d86
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/munlockall/munlockall02.c
>> @@ -0,0 +1,51 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright Red Hat
>> + * Author: Dennis Brendel <dbrendel@redhat.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Verify that munlockall(2) unlocks all previously locked memory
>> + */
>> +
>> +#include <sys/mman.h>
>> +
>> +#include "tst_test.h"
>> +
>> +static void verify_munlockall(void)
>> +{
>> +	size_t size = 0;
>> +
>> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
>> +
>> +	if (size != 0UL)
>> +		tst_brk(TBROK, "Locked memory after init should be 0 but is "
>> +			       "%ld", size);
> nit: I would not split string (kernel source code also relaxed to 100 chars
> instead of 8O).
> 
>> +
>> +	if (mlockall(MCL_CURRENT | MCL_FUTURE) != 0)
>> +		tst_brk(TBROK, "Could not lock memory using mlockall()");
> Maybe use tst_brk(TBROK | TERRNO, to get errno printed?
>> +
>> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
>> +
>> +	if (size == 0UL)
>> +		tst_brk(TBROK, "Locked memory after mlockall() should be "
>> +			       "greater than 0, but is %ld", size);
> I suppose < 0 really means no memory locked, thus really safe to quit before
> munlockall(), right?
>> +
>> +	if (munlockall() != 0)
>> +		tst_brk(TBROK, "Could not unlock memory using munlockall()");
> Also here use TBROK | TERRNO ?
>> +
>> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
>> +
>> +	if (size != 0UL) {
>> +		tst_res(TFAIL, "Locked memory after munlockall() should be 0 "
>> +			       "but is %ld", size);
> nit: also here I would join string to single line (still below 100 chars).
>> +	} else {
>> +		tst_res(TPASS, "Test passed");
> nit maybe:
> 		tst_res(TPASS, "Memory successfully locked and unlocked");
> 
> Kind regards,
> Petr
> 
>> +	}
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = verify_munlockall,
>> +};
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
