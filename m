Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864BAE64A80
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 11:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733226227; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=OoI3q8SIqh7j9cSCx8mMJ58fmLAGBxwAyy64Wh8icsE=;
 b=Vl+LvtFNcXSZywuya6ZK+sNboc/Yy77i78zRHlwXMFJZFL9dYfVQu5Srz+FCvq1R/3tIM
 ssEAJuZ7feqbYI9tqqrCD6jIMoic4dyq7RG7G90HFDQWM8oUWRKXOQMzK6Z4dVC7wiY6Ecl
 bSkbwX1jsooe2ODvdjOkM4JXdzRH1yU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C49643DDED3
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 12:43:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFE8E3DDECA
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 12:43:25 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 337B866F4C2
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 12:43:24 +0100 (CET)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa549f2f9d2so667390366b.3
 for <ltp@lists.linux.it>; Tue, 03 Dec 2024 03:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733226203; x=1733831003; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1z9tsqvVi7TChEUXE0NHs/YHezfswqbdr0SmStQWu0A=;
 b=fTDYVs9LFFT5xry2cGjjGZ6wXW5IivZ95V6Ecr/tVyDiNcFeR2S+I9Ndl61EmYUiA6
 hq9dTtPlxvvZA+PhMdI7zMurj1UqSaOxZig9NZZtqZxLFksdcdR3jBZPicoDhKAFCEBz
 PclWORfJbOhXlYXDNT9I/AyLhLXFAN8cEnht6sHM+OJkCaM1uZfeUqiNjwupdr+/uSCA
 PVkXARHEzw68uz61eMktcoQeslOIjlsn2BOwKktAi1EERPYMxU/Qn1ip5IueHZxN/cQB
 6QswDPoaK0gslA6in4o574AAA4NL0bgT3mbFquvt5UKL3U9ipSc/KbecjYeweCcPw2RP
 TP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733226203; x=1733831003;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1z9tsqvVi7TChEUXE0NHs/YHezfswqbdr0SmStQWu0A=;
 b=l1MkUX9NQutj/y4UaSpmk/wbZMZsLegHo0cmgF/flGdzpT+g4kmGVR7FdqfRQfiDsH
 arWOAdgU37to0oq7p0aHOGI8SxHeSQrnLJMBhRx37prnCiWQRQ3rESCiOQ0+4bAWt38h
 pzsx2KHLEm6fyUbExAYf+c/tp7csadv+/MdkHK+tb7fcYCnfxq0Q2kRKva/bNZcqzWR9
 S7/Dt7uL3RfHa6pFVedSd4AZnJZ/pKYjBSiHgMNHHVIzD0LQPPa/UYqsppd/5AGV0gEM
 e2c4gfz2wLSWz2OhJj9TehI9X3oco2gENY8x8LbCYvaVT1/EwROthhUoZ5Gk/fhAVW2U
 E6GQ==
X-Gm-Message-State: AOJu0Yzj0JTKApvVkryZ3st9s4Mp0rNYSgTKeUH+JKDWO7Hwpdq5lFtH
 OlEEewvtn1bhl3m+59lyaH0QK56opIYyWBoHQMm274wnPZuGGRoIMm2iPtDXALCBuEGx6r+lw37
 GippxGg==
X-Gm-Gg: ASbGncsheLhZL6w95v4rxsemdxF7juEpF6MkoT3m2ZTGwybkZc2gVPrYBCZ+RmOmZ9Z
 K83WmSgGNbPV/xjrRg8B+POtEIrb7h0FCH4sEdvB2ey2yK4/WYJSPipfEAJSQ7cAdMsSH6I9gHm
 rVaCmlRFzelhQsz44mDTfCKX9IM0z70gRfuL9GpqewG3wg/snN2s/z6+BsV6mVpH5ZHfWKHcLRi
 83LI7kltiiHOtW9+JOIZTSdUEgJVlWkRc1WN/JNxzBs0hN9BhkHdViy84J3
X-Google-Smtp-Source: AGHT+IG218dSMaJ5Z2xGrApN+UAlUSEMceTNZrqmmWm6/o9+mkOS0wJCdqZLvZEVRJ7JIrJB4dxv2Q==
X-Received: by 2002:a17:906:2921:b0:aa5:d7c:2acf with SMTP id
 a640c23a62f3a-aa5f7ccee88mr145339266b.12.1733226203624; 
 Tue, 03 Dec 2024 03:43:23 -0800 (PST)
Received: from [10.232.133.32] ([88.128.90.63])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5b1b9adcbsm477389766b.183.2024.12.03.03.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 03:43:23 -0800 (PST)
Message-ID: <6a2de57a-81c6-4d9b-8c77-d6978e946221@suse.com>
Date: Tue, 3 Dec 2024 12:43:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241202-input_refactoring-v2-0-369609492896@suse.com>
 <20241202-input_refactoring-v2-6-369609492896@suse.com>
 <Z07szYg2_To9zNEk@yuki.lan>
Content-Language: en-US
In-Reply-To: <Z07szYg2_To9zNEk@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/7] Refactor input06 test
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

Hi Cyril,

On 12/3/24 12:34, Cyril Hrubis wrote:
> Hi!
>> - /*
>> -  *  Create a virtual device, activate auto-repeat and
>> -  *  and check that auto repeat is working
>> -  */
>> +/*\
>> + * [Description]
>> + *
>> + * Verify that auto-repeat is working on a virtual device, that in our case
>> + * it's a mouse.
> This is wrong, the device is a keyboard with a single key, at least that
> is what is being constructed in the test setup. The original description
> was at least correct...
>
>
> The rest of the conversion looks good.
>
You are right, my bad. I'm gonna fix it and merge the testing suite.

Regards,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
