Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F90C02192
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 10:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738752343; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=eYspj2gJVCtLzC5AlYs6gyBHZSMF1OC/2x+ujCJLjOk=;
 b=JZwMqNSr7eVqhDg+NwgaOTddwIPE/aIbxyTaE6Ps030cdQFo2cREMZ0RLposxu2tIkC9o
 hfaycJtL6qKLxQyoOHQYdbVScRXVMTt+caMPCuib4bXLxr1HxwfgcWaO0typKbuNt489f45
 m//KSBkCaqqJneGArP6Am+BSPNkCGK4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69EAE3C91EF
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 11:45:43 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4B833C91A7
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 11:45:21 +0100 (CET)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0F9EF1BBBB7D
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 11:45:21 +0100 (CET)
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-5dcc38c7c6bso3669722a12.1
 for <ltp@lists.linux.it>; Wed, 05 Feb 2025 02:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738752320; x=1739357120; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GHK71H6WNrzXVpM9ZS8ZVR6eYI21wsptTbykvNmcjzs=;
 b=gzIIYQGzYvhZoxroIn2PqoeOSHTGySip22oGH7xK4FMHNmJIz3XzXEvte9jZbLmoCa
 lr2TemCbaxgmfgI/eUT4qepZr9VMA7vKXJfw3S9H+Y7e61Q8rM7RkpJuIIgGOeKJjdqC
 oedH6K0zfgFriUBPVPlj8rFiDkQYuhp2UNQRuH7opbZDrqPQYmE0pIKcLo69B5RGkGgo
 bGyjBOuBD6ItmNAF9wbpEy5W04StqSwuE51TFff2hWuRA4+ql2KD+nnZ/QDfuDBGH5+/
 jtgfDT9JbW8PC4w+XWje+4I+0uq9YAckfRTMGOhIH6+sgOOBi8PS0G9XZo4sp06tjS9G
 oyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738752320; x=1739357120;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GHK71H6WNrzXVpM9ZS8ZVR6eYI21wsptTbykvNmcjzs=;
 b=EdYaV9wVmt88kUY60ybuFSVnL0uA2xMXbJOw4/Tk3IViX0tcKc8LL1a1xsZkjZ+mzz
 +4ie8r/3+0BB4vjvVqM6F3Vs7Y8qEciofeZuHIRjIRncPBSPs7XWbt/xX9w84Zv0Wqco
 RIskfIkwkK7zgTF+QkKKQyb/K8bP/6x4Cc8PcPivqvbAxo/i1iPXYYTrUVARqMJlJQ9t
 OYwpdQu9Ay7YakA0lZRzQgyMruVty4A7lTVmLePpnEhw3oQ3bI8cqU5VO/MAAFakwSMr
 spbJz6NHl1wDHMbRGkYxJSaM2ul5FblskDBZWj5kmmsZnC2z/Vfl3yvljN93DSSimft0
 BIGQ==
X-Gm-Message-State: AOJu0YxAU6s6iJrW8ToL/RkZDPtcmN7zVTF5IMChX0QVqI0pdh7RQYaV
 IvWFoK/hDV8m4ujB+1rBtQWVGWw89trVO/JB7RmNiU7ofEzxkVRkvZsixWrRF0AjvnyZTa9zV5m
 xpg2Yrw==
X-Gm-Gg: ASbGncv3iGrNdB/j7F/wGDSNYRC6AUI9AX3FkbxuN2XCvXEMfKHCSfNW+9TA1GbM6ZP
 oyTCXuqTiJGD1XzP9cHJS48Nm1O/albot6iTa4NNzs3/EeUE9ndIUMVKrM/S/E4n+J5UWyINwKO
 aGfbDtKzsAK7usF/v3GQlef+/zhVVb+h+6J3SsbukwpqlCx6GStratIHedYP4vnTyNgHh3Xa5PT
 Z5HXxnf3ACwDqNYk//nVWH4HA/eBJH9o1DQDn9JvnTMFm6QpAFfmW9ByPMwVNTFI9zXm3H4oKoz
 Sq+3L5PA5OMQzzI6Ftte/xQRhA==
X-Google-Smtp-Source: AGHT+IHEj7IfmHsKHvygHDX4hlKso4hgzXEN/fkZ7Ek3G1qWmIRxFrDE8G0+o5IhFGNKnDXyqlUiaw==
X-Received: by 2002:a05:6402:234f:b0:5da:9d3:bc23 with SMTP id
 4fb4d7f45d1cf-5dcdb778c9amr2624281a12.24.1738752320454; 
 Wed, 05 Feb 2025 02:45:20 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc723d0006sm11090687a12.2.2025.02.05.02.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 02:45:20 -0800 (PST)
Message-ID: <3128adbe-cf4f-4b55-9511-24d6fec206c9@suse.com>
Date: Wed, 5 Feb 2025 11:45:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250204-doc_tests_list-v2-1-9d29aeacc3f3@suse.com>
 <99e715d2-d30c-4bee-bd0a-30ab6929e58d@suse.com>
 <20250205093918.GB1473026@pevik>
 <7a5638e3-cb49-479b-9b80-5c6f148f9521@suse.com>
Content-Language: en-US
In-Reply-To: <7a5638e3-cb49-479b-9b80-5c6f148f9521@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] doc: add tests catalog page
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

On 2/5/25 10:57, Andrea Cervesato wrote:
> Hi Petr,
>
> I sent a followup message for the broken format after sending the v3 
> patch.
>
> On 2/5/25 10:39, Petr Vorel wrote:
>> Hi Andrea,
>>
>> first, thanks for doing the migration.
>> I haven't checked whether all necessary keys are shown (will do).
>>
>> It would be nice, if the keys (e.g. mount_device) were references, 
>> then user can
>> click to the documentation.
> I can check how to do that
>>
>> I'm also thinking that splitting tests by alphabet would help to have 
>> shorter
>> page + not that long list of the tests on the left side. But for 
>> searching it's
>> better to have all tests on a single page. WDYT?
> That's quite a thing. It requires more code and I don't know how to do 
> it honestly. It would be nice to push the patch and add this feature 
> later on eventually.

Perhaps we don't have this possibility unless we rewrite the C API 
section. We can only point to the whole `struct tst_test`

https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#tst-test-members

>>
>> Kind regards,
>> Petr
> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
