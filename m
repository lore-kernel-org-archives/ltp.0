Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D62CC48BC3
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708431643; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=nrn73+6vcKkFJgKNUhrSiqstUkzF0OJVTz/1fYarJ6U=;
 b=gYpfeWRKBn41CdOPZNA5+1roD3i0i0od0O29EyIS+6hvsablpW9XNtMgcIdgdtxER0BHp
 YARCxaKL1s56Ow7MmtEWedbaG8QhOnjuxro6XoPVvOip3PIYR1WdyNVk3440VuMtTNHKD5j
 E6VtVvB4ExUYnDV2U6wZKtkCQfxH1as=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0AAB3CF1E1
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 13:20:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 261C53C08CC
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 13:20:21 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4660F1400F9C
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 13:20:20 +0100 (CET)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d1094b549cso78641071fa.3
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 04:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708431619; x=1709036419; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OAOajJLt5piUUO/NBGmOpliXuG++DZ+RYu5XsuQjRIs=;
 b=GKw6k855SBxQAVMV9jgGPS057znkZBE+sbyU9EnyWHrQ5Y5U2bZEAKaRDO8cIkdQYX
 sMonTN44w3HEbyX6RGDCOlEfRU4MvPovDMQ4eEF7Cd9isofa2y0xAsLgupOIrRNOcJJn
 mVK8UsXn1AcW4CTrHI+S17z9WD/dixI0QVzNbrZPpjnRn2wMc5RLROoiSaY8Nahd8Pap
 R2hL/j+YaMi/sOIYSY1vxA6V2S9T7MeZU+rr+zUQwe8gSbNXsZekVSZTqxEV+PshsOlA
 4t8ahov9j9Z4mW2USULlEs5y4hGa6UlHXraUqMKsmbA8/ccf4PyqEuE8Eq9PldWyo3Bh
 UiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431619; x=1709036419;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OAOajJLt5piUUO/NBGmOpliXuG++DZ+RYu5XsuQjRIs=;
 b=sjWqLKCO9AHljmW2yXRwF9P61jFiqyvLOX6TE+RODB9+yHmhShyNPtHVDxGbNbEXn1
 kKMrqL4lWSSjnR7lDUoBPxOAStYiKvnqKT4cEbvWLCnLkt4ZfVlBmZb0wdE7EofNSgB3
 jOhjOO8O7tWlIfdxAAqe6LY2MYu5MD+G4nVNEEcf9jusOd/jZ5vSpula/kU8mTv97kvL
 RED2IFXM3N1xZJQFWgHjrrkJibJcLeGhn2faNWb/bv6xhfSprMejCL1PmOCJ4R5TAEoU
 lOyrs/J18dMmpj6ng3OpxGcfRgIaGrWgIQa4HGBVtjref2U2u8sysGfxxKA64MSa6mR+
 rPIg==
X-Gm-Message-State: AOJu0YwpechMk75PrfC686x7AZj/Dwy6Nx3+B3JoRwpe53Su2UE3xRpI
 ugHDSa5FB5qkQ4hZYVxUBfl1kQYsvAOpbrxp8iR5Pywq5jGtbi44HGTiv78rY3w=
X-Google-Smtp-Source: AGHT+IF1DvNobDl2OcI4LeQv+thk1vZJ++5aUsVVYO5xTfCBBuue7HbaC3XjYTXcS6AHZNEEjjNHnA==
X-Received: by 2002:a2e:a9a5:0:b0:2d2:2fc3:7b03 with SMTP id
 x37-20020a2ea9a5000000b002d22fc37b03mr6879684ljq.41.1708431619436; 
 Tue, 20 Feb 2024 04:20:19 -0800 (PST)
Received: from [10.232.133.61] ([88.128.88.10])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a7bc4d3000000b004126101915esm8662288wmk.4.2024.02.20.04.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:20:19 -0800 (PST)
Message-ID: <2f6927be-951b-49fb-bbeb-013746afc3a4@suse.com>
Date: Tue, 20 Feb 2024 13:20:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240119085939.11801-1-andrea.cervesato@suse.de>
 <Zb0jtL90aF5K0258@yuki>
In-Reply-To: <Zb0jtL90aF5K0258@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add chdir05 test
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

this patch can be ignored due to code duplication.

Andrea

On 2/2/24 18:17, Cyril Hrubis wrote:
> Hi!
>> +/*\
>> + * [Description]
>> + *
>> + * This test verifies that chdir() is working correctly on symlink()
>> + * generated files.
>> + */
>> +
>> +#include "tst_test.h"
>> +
>> +static void test_chdir(void)
>> +{
>> +	char *symname = "my_symlink0";
>> +
>> +	SAFE_SYMLINK(tst_get_tmpdir(), symname);
>> +	TST_EXP_PASS(chdir(symname));
>> +
>> +	SAFE_UNLINK(symname);
>> +}
>> +
>> +static void test_chdir_no_path(void)
>> +{
>> +	char *symname = "my_symlink1";
>> +
>> +	SAFE_SYMLINK("bc+eFhi!k", symname);
>> +	TST_EXP_FAIL(chdir(symname), ENOENT);
>> +
>> +	SAFE_UNLINK(symname);
>> +}
> This two should go to chdir01.c and possibly chdir01 should be split
> into positive cases and negative cases when you are at it.
>
>> +static void test_chdir_loop(void)
>> +{
>> +	char *symname = "my_symlink2";
>> +
>> +	TST_EXP_PASS(symlink(symname, symname));
>> +	TST_EXP_FAIL(chdir(symname), ELOOP);
>> +
>> +	SAFE_UNLINK(symname);
>> +}
> This is already in chdir01.c
>
>> +static void run(void)
>> +{
>> +	test_chdir();
>> +	test_chdir_no_path();
>> +	test_chdir_loop();
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.needs_tmpdir = 1,
>> +};
>> -- 
>> 2.35.3
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
