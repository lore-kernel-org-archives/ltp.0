Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A964C25B74
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715871566; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=iDaec7b9esAa9M6yx4upj9zPL0TAjP3koq5lSOm7OoA=;
 b=WUVmtjUmtNfrtsqffQ7P3gTXJx9gzhMLqbaApVH2hwpfgo/WAcjesTJ0N41+u68dT3DCy
 IH2scjcCKw7gYEUua8faV5sZcTWYOMCXlrotvS2s8T8fUGRpHGyXekGOsZtXvvYporh+5FT
 LwIBQh5NGdvaW4N4cwBoS4qRf/QXhFw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AF8F3CFA6A
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 16:59:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89EC63CF846
 for <ltp@lists.linux.it>; Thu, 16 May 2024 16:59:04 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 79A38204B5E
 for <ltp@lists.linux.it>; Thu, 16 May 2024 16:59:03 +0200 (CEST)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2e6f51f9de4so13061831fa.3
 for <ltp@lists.linux.it>; Thu, 16 May 2024 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1715871543; x=1716476343; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Of52liBrDlYOxcTixZDQ4y5O8dVuY0sMEFgEHUX+Rrg=;
 b=Wj+wzJmioBK1W5A+q+aqw1eXGetmQ9lq52I4qe4byIgjgkKng5lNc0PJcucgrjyaTw
 on5nlAyaGQuQO+7IJ11UKQKkHgi/Xk2lFkE5AzOB9RBZEhofa2lF8wkt62IVZvGsfVSJ
 uU36PTTNjpoRVRxmjL2oUw/UBNdlL5LBRr+BBy/3jPS6vLDth0wEHWVuk1nup9JKDd82
 UrUj32ST7t9Rn32UhltSz3Clt1d08F9+4cTDgcCFnO4bg2gMLjEhKG3MFlWHfc8zU2Le
 0q3vyVkYNtCnw0PohLuzyJNoXpts2lsUt5IcIw90jW4NiLsVBNS8xKEuR+9cL72Airtq
 grWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715871543; x=1716476343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Of52liBrDlYOxcTixZDQ4y5O8dVuY0sMEFgEHUX+Rrg=;
 b=AkA8pTA2iMf0xn2qqbuya9V+GrrvQAZh2UwtWnPR7cFXGoyN7roX2VrNeKks6DwV4C
 YC2A0aFVjJe2ZYou1EFJo88Eyh0duEYeb8CcW+W96ixPacH7GNAjnCndNRsIE5wbjyV8
 psZFXWtIhRKSabWIs37n4cSrVWwCinhhsmoLyg0oHKEwMdEqUMy4J21ihUVs+B/eIcJU
 LacyashshHWfNikUL+qIQsiq/uv8SImI33sLGPEgg8RRzdUdxPMC4exGfCOypgnvQW8k
 2c5oJjUW2lObFdXAEYsNASxmH5ONJgAzKJF+gQIA+NG4yKRngyOQG05m8l87MB+Ta+nv
 zmYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV53E6OqQpiNQsRTRssEcFIxb+GOQmxEAOT6QM7Sdq/Va6smpUUQ+MVXp9yDH4Mj8hefoDDk9t7zpORY601hVVC7mw=
X-Gm-Message-State: AOJu0Yx81NUnm9ZN4JpvH+eGkqCHBlQTbj3qhClMeG8w6XHQW+kEJwya
 QatkFLKfj1L9zQnisC/YlzCHRyWUdgZsY4q8oAm6FOW42GZDnSmD2Rt+YnHntR8=
X-Google-Smtp-Source: AGHT+IHaG1w72lqEA8PgJ4Fkv9Z8euTFKsyGAz2pSb4TJ7YfKKuYhEw0w4DqkN311kb9YXFTKkc92w==
X-Received: by 2002:a05:651c:198b:b0:2e1:c636:168a with SMTP id
 38308e7fff4ca-2e51fe57d59mr182748461fa.24.1715871542564; 
 Thu, 16 May 2024 07:59:02 -0700 (PDT)
Received: from [192.168.178.40] ([79.140.112.122])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7f49sm986213266b.101.2024.05.16.07.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 07:59:02 -0700 (PDT)
Message-ID: <2f999e65-26e6-442e-886e-7f98cce6dd19@suse.com>
Date: Thu, 16 May 2024 16:59:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20240515093349.7347-1-andrea.cervesato@suse.de>
 <20240515093349.7347-2-andrea.cervesato@suse.de>
 <20240516013048.GB260285@pevik>
 <d06e0e62-1827-4699-838d-8ae961ca2905@suse.com>
 <20240516144945.GB317330@pevik>
Content-Language: en-US
In-Reply-To: <20240516144945.GB317330@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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

On 5/16/24 16:49, Petr Vorel wrote:
>> Hi,
>> On 5/16/24 03:30, Petr Vorel wrote:
>>> Hi Andrea,
>>> could you please fix these?
>> Sure
>>> testcases/kernel/syscalls/statmount/statmount03.c: useless tag: format_device
>>> testcases/kernel/syscalls/statmount/statmount03.c: useless tag: needs_tmpdir
>>> testcases/kernel/syscalls/statmount/statmount03.c: useless tag: needs_tmpdir
>>> testcases/kernel/syscalls/statmount/statmount03.c: useless tag: needs_tmpdir
>>> testcases/kernel/syscalls/statmount/statmount04.c: useless tag: format_device
>>> testcases/kernel/syscalls/statmount/statmount04.c: useless tag: needs_tmpdir
>>> testcases/kernel/syscalls/statmount/statmount04.c: useless tag: needs_tmpdir
>>> testcases/kernel/syscalls/statmount/statmount04.c: useless tag: needs_tmpdir
>>> testcases/kernel/syscalls/statmount/statmount05.c: useless tag: format_device
>>> testcases/kernel/syscalls/statmount/statmount05.c: useless tag: needs_tmpdir
>>> testcases/kernel/syscalls/statmount/statmount05.c: useless tag: needs_tmpdir
>>> testcases/kernel/syscalls/statmount/statmount05.c: useless tag: needs_tmpdir
>>> testcases/kernel/syscalls/statmount/statmount06.c: useless tag: format_device
>>>> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
>>>> index 8de8ef106..43ff50a33 100644
>>>> --- a/include/tst_safe_macros.h
>>>> +++ b/include/tst_safe_macros.h
>>>> @@ -503,4 +503,11 @@ int safe_sscanf(const char *file, const int lineno, const char *restrict buffer,
>>>>    #define SAFE_SSCANF(buffer, format, ...) \
>>>>    	safe_sscanf(__FILE__, __LINE__, (buffer), (format),	##__VA_ARGS__)
>>>> +struct statx;
>>> Could you please remove this? (unneeded)
>> That's needed because in some distro statx is not defined before reaching
>> that line causing build failure.
> <sys/stat.h> are included in lapi/stat.h. I wonder if <linux/stat.h> would fail.
It's related with distros which need to use fallback. There's no 
fallback of "struct statx" when defining the
statx() syscall wrapper, so it fails during build.
>
> If the definition later works it should be fixable by including the needed
> header in lapi/stat.h, right?
>
> Could you post link to CI job which failed?
>
> Kind regards,
> Petr
>
>>> With that, you might add for this patch in the next version:
>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>> Kind regards,
>>> Petr
>> Andrea

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
