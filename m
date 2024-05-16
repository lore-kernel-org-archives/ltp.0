Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68428C25B74
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 11:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715860240; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=UIfhyg0QegO8wD0TUuW6UUEWQT8/4jhHyfH1xtHLe7U=;
 b=OqLgVRikocYZtP0ZxNT978+p6AQ0VDoxdsbRH8grJ1UoMb9LMIJu6y7aGd5KAP3NitOwY
 4THh2vpM8sQyCXh5daiFK7kzHkpsPAurHiGT6fbBe0G57l9v9Wd4wiTyxKHzIjH38anU3cU
 UNxr2DF8g0fYsDIFQ8wYqHavihkVelQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D43433CFA0D
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 13:50:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C92D3CC3B0
 for <ltp@lists.linux.it>; Thu, 16 May 2024 13:50:18 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8E7521A00E26
 for <ltp@lists.linux.it>; Thu, 16 May 2024 13:50:17 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a59a5f81af4so291731366b.3
 for <ltp@lists.linux.it>; Thu, 16 May 2024 04:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1715860217; x=1716465017; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jgPfZvkwd7x8w0ZrKtuCtCttXOWfSF8h6fnk/8X8WHg=;
 b=HuYKWH5Hjs+Hm6d9eQ9noAbHjyjjcRPZ3Cayqgqc5uMklNMeIkfNs4wAsnP3kRlTH4
 ygjFIvySMGFl8/WRspv5P6P0M2WgnrLcfQOcIOv5bHrBz8Kj9BwbKdtWMxLSFwsScQRO
 62EZTg3wbboxOcf1VBCtBsoL8Jm/ZYn7qFIDkA24Wl0OgVVRtB977alNf9QGcLRSNcUr
 Vuf+KADBun96HnUc1+XMYT8Xc2caNHN/B2jl1Xp5vPep50XkTMkxPRuHzyXQlSfXwEfZ
 R/J6aB2XozRkuApG8FMh+beZA3JcpjxgnP3QaAMaR1ls7YAwjjjZ3Q21A7YA1gQQgckP
 8pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715860217; x=1716465017;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jgPfZvkwd7x8w0ZrKtuCtCttXOWfSF8h6fnk/8X8WHg=;
 b=ZfKdlMpjNgZ2wEEX26q6dfZQQpLNKQ6QKalpJRdmV/oaW7Qn8oV+dcepWMt49TWR4s
 N1bzXKiVdE3f3t2HnjzPV8txbfTaLRMEM3eE1BN/8n69Q1COWYKKLj67IUOGiY2B7E2/
 xGdrg/DJs5ChgQarJM+2UHLNZpZYF+mdJ99VV3go58bG7QVoFm9+l8oKCnbD9oMaBfws
 1yUcPfRG2uQkl/zX0An3XhUZScOL6LSmzZ5fr9w2viNZJ0pcMeMbEBa2MWt/53B0VxDP
 +YfxfWhyP81YqNpRujqCn/W9bIc1a/Vx+GqPEI/p+ycHCuaTj3mEHMH52+WEPtzAlp9B
 ELAg==
X-Gm-Message-State: AOJu0Yxvved2tvrusOnSo6IUJaACHNnBAH9y2DsZpvwghsrWVGgjRv0C
 nHa0MUXoHSPlXhWjhNI8mjq+pb5+fSjZvz0zYdPn2/FJXFA07m+LJuHxTMQZQTk=
X-Google-Smtp-Source: AGHT+IHZF0aRREpJRDgxDi+nJF9s97rdcQngCwy9DlaR9Xge6JzO4jyZkd9Y+JUTZyYesbKmA4De9A==
X-Received: by 2002:a17:906:118b:b0:a59:9edf:14b6 with SMTP id
 a640c23a62f3a-a5a2d5f2606mr1272921666b.45.1715860216953; 
 Thu, 16 May 2024 04:50:16 -0700 (PDT)
Received: from [192.168.178.40] ([79.140.112.122])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17894d4bsm968975466b.78.2024.05.16.04.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 04:50:16 -0700 (PDT)
Message-ID: <d06e0e62-1827-4699-838d-8ae961ca2905@suse.com>
Date: Thu, 16 May 2024 13:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240515093349.7347-1-andrea.cervesato@suse.de>
 <20240515093349.7347-2-andrea.cervesato@suse.de>
 <20240516013048.GB260285@pevik>
Content-Language: en-US
In-Reply-To: <20240516013048.GB260285@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 01/10] Add SAFE_STATX macro
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

Hi,

On 5/16/24 03:30, Petr Vorel wrote:
> Hi Andrea,
>
> could you please fix these?
Sure
>
> testcases/kernel/syscalls/statmount/statmount03.c: useless tag: format_device
> testcases/kernel/syscalls/statmount/statmount03.c: useless tag: needs_tmpdir
> testcases/kernel/syscalls/statmount/statmount03.c: useless tag: needs_tmpdir
> testcases/kernel/syscalls/statmount/statmount03.c: useless tag: needs_tmpdir
> testcases/kernel/syscalls/statmount/statmount04.c: useless tag: format_device
> testcases/kernel/syscalls/statmount/statmount04.c: useless tag: needs_tmpdir
> testcases/kernel/syscalls/statmount/statmount04.c: useless tag: needs_tmpdir
> testcases/kernel/syscalls/statmount/statmount04.c: useless tag: needs_tmpdir
> testcases/kernel/syscalls/statmount/statmount05.c: useless tag: format_device
> testcases/kernel/syscalls/statmount/statmount05.c: useless tag: needs_tmpdir
> testcases/kernel/syscalls/statmount/statmount05.c: useless tag: needs_tmpdir
> testcases/kernel/syscalls/statmount/statmount05.c: useless tag: needs_tmpdir
> testcases/kernel/syscalls/statmount/statmount06.c: useless tag: format_device
>
>> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
>> index 8de8ef106..43ff50a33 100644
>> --- a/include/tst_safe_macros.h
>> +++ b/include/tst_safe_macros.h
>> @@ -503,4 +503,11 @@ int safe_sscanf(const char *file, const int lineno, const char *restrict buffer,
>>   #define SAFE_SSCANF(buffer, format, ...) \
>>   	safe_sscanf(__FILE__, __LINE__, (buffer), (format),	##__VA_ARGS__)
>> +struct statx;
> Could you please remove this? (unneeded)
That's needed because in some distro statx is not defined before 
reaching that line causing build failure.
>
> With that, you might add for this patch in the next version:
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
