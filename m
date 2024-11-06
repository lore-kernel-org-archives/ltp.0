Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A716D44D4C
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 11:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730890921; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=IYeq5Dlt/44ijwDiHBTVZxf/aHMvsZZ+HLTK7JDrvs0=;
 b=a/t0Vtn4kwIdxmhVctGReLSgSgHktPUyi0cTruEHwdTNJ6p8bWV3uYqhpTr6z5IfZBkfq
 zYbrkqFOcN5Sw22cKzOpuSXAuEqoOe5Ss+W7N78MuLgyss2Cx3M6gewCjeJ3zdAH887XJUC
 CCpZJPXN0pqVZLMYsNOo+1qQCY7HDrU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2699A3D319E
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 12:02:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37C0D3CB887
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 12:01:41 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AFB7F200923
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 12:01:38 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43158625112so57628785e9.3
 for <ltp@lists.linux.it>; Wed, 06 Nov 2024 03:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730890898; x=1731495698; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qmerLgfcRtxnRbMwCgH8RHyy6gJTe5UV1U7GUbulYa0=;
 b=Kw0BFgBz3haQD2/E4Xou6dShMMA5G3uw+3y1Z3bq6obpCkQsy2wVRDJWxa1dKY2S+x
 hlr6MPCLKaeb452O7RVWN6Ml7Rcxo0b5SQw6ylNkDTI74C9DYkb0lpK+22ibNZw4LW6Q
 EHY8okLXylqFR+nZyX5N4vud3vx1xLtW9234VMxpOeiiRrK9nF77dTZSUk/SZQ48qP7C
 Lt7+2S6lCkTXrrggkDEcOnPwNT4JhHyw1t3AlW+zd+++eS8yTDoCRcy1nBwdBPQRX22O
 oDkb4qTd6wPhPe9rsnAJdFFwZPtMRaGs+avZ6QqKEFojTgMOElH1i+tC0h/l1+iN9Aak
 acmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730890898; x=1731495698;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qmerLgfcRtxnRbMwCgH8RHyy6gJTe5UV1U7GUbulYa0=;
 b=LfM+UiEryo8QfR0Iq+SiJb+RGEXCtf02BJhF4RH06GAn8GBDFjgPnPA75FA5NyX6FJ
 HLHgTqaIJZOC4ViMeaUzrV0MTPLyPlqfHHAWiIPSM2APg/zsOsG6KgopmBkabA2Rad4Z
 3yq3Rz1l3bnpIzJ+D9ZCwuoM8YsRxh0RTk0jx9sH9At2Ay7uWgtru4ozbZPEjrfjQced
 gu74imrDx9LTZgGHSHDrPavPtVqW2yWk8OsbEKjVp+O22SA1cPZizgsiigNJJjoRSokV
 0FoCD/5CsDp1vsqeRHgn59COP0UqTmxawmbY9VnlN9wdcuFZjg7tEQw4En4Ay5idaQQV
 awQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9lf/d+C8DQHjoIMfRmYdjrWqu0IY1E1XeoQcCppmkZRYYGbg6qtdFxASzp7DEFjql9Tw=@lists.linux.it
X-Gm-Message-State: AOJu0YwTr9P97f5xdj0BFItRbZWVhapqkI7hq0lQkzyuesheZEhmdcPM
 G7uWFwqJ3h78q8bAF5jvdEZeeJjcilsm4NZ1AC02x8IMwdYBqNKoBF6mrl3f8Dg=
X-Google-Smtp-Source: AGHT+IEvZ7n4vM+yyvrUkkZ1ERifykSuM7eoHTNX356UEEuKSObd6kkXU32Sy899O5TFyssHKMW//A==
X-Received: by 2002:a05:600c:4e8a:b0:42b:af5a:109 with SMTP id
 5b1f17b1804b1-43283284867mr145362685e9.24.1730890898105; 
 Wed, 06 Nov 2024 03:01:38 -0800 (PST)
Received: from [10.232.133.32] ([88.128.90.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6e6fbcsm17818565e9.34.2024.11.06.03.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 03:01:37 -0800 (PST)
Message-ID: <513de0d7-d138-4e64-9198-01c65b2e925c@suse.com>
Date: Wed, 6 Nov 2024 12:01:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
 <20241105-landlock_network-v2-4-d58791487919@suse.com>
 <Zyo8I-32MuJz_EFw@yuki.lan> <d3f0719e-a1e3-4eb1-8613-1506d137351a@suse.com>
 <ZytHE-4rpsrycuI_@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZytHE-4rpsrycuI_@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] Add error coverage for landlock network
 support
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


On 11/6/24 11:38, Cyril Hrubis wrote:
> Hi!
>>>> -	verify_landlock_is_enabled();
>>>> +	abi_current = verify_landlock_is_enabled();
>>>>    
>>>>    	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
>>>>    
>>>>    	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
>>>> -		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
>>>> +		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi4), 0));
>>>                                  ^
>>> 			       This should be abi_current otherwise we
>>> 			       will fail on v1 only system.
>>>
>>>>    }
>>>>    
>> In what sense? abi4 is already the last one. At least the last supported
>> by LTP.
> Because if we request abi4 it will fail on kernels that only support
> abi1. We try hard to skip the abi4 tests, but we wouldn't get there at
> all on abi1 kernel because we would fail to create the ruleset_fd in the
> test setup.
>
> And we cannot initialize the abi to anything newer than abi4 either,
> because we pass abi4 structure in the test. It's fine that we pass abi4
> structure on abi1 system here, because the test only checks for invalid
> cases and all we need here is to pass a valid attr and size so that we
> get rejected by the kernel on the rest of the parameters.
>
I can instantiate both ABI1 and ABI4 structs, then I pass it to the 
tcase accordingly.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
