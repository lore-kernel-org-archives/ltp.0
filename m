Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B99ACEBF7F
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 07:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727423102; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=UJRvIx7q5sXbeFmJJkgZBCmIiQ/WYNCamE1OXRp9r70=;
 b=WXbwIIvZ+Teu8e2/nwqqS0yWYk/wlgSh+5bdiKoRipA1ShUQSCZ4tSxnHDcXsdSvFkShT
 Zg4KoR4/L1b//a/yEQ1bRfKMbxXyAqOaCK8oGu7V45lcGy4BrMICLYg5FYKObz3dyH6yK4I
 QGE4EyR4zxMv0QmXoEB1ksHsCy6oNOI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C32473C4F57
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 09:45:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AC243C0063
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:44:41 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ED506600468
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:44:39 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c8844f0ccaso337173a12.0
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 00:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727423079; x=1728027879; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w/+385m8HjNQhoeQSKeb6xeKqsfSFtquoT0coRFe+T8=;
 b=BDas1/3a0V9xGZ2KTHdpRT3T7dDY2Tbkw7qCcZgU7RSHYYkrhDbYjCBMAwnoNq0kKp
 hePbxdFdkkexH43cmt6vFcihwOCvtqc4svHPF7hOcIK0DGA0MqP4LmSAsKptGnIX5SUI
 bM2J9drt/Z5G/8VPYtajHhygn5E6YztPiy7mwyXLPkQq5BjyOkoERtzyNm8IxeG3Umub
 yvSiIfDHKkfiZdpi/eVn502SfQ/jS5f+PKtM+FgiFfgN+Mm9Hv0APlAnVAwFlFan9Ckr
 UaL/bgsZSAjEnzpQnjvaYGD8oYbl0KMGcT3anFEqDMv6k776CEVZgxxNjyHotbEk7lq9
 lJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727423079; x=1728027879;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w/+385m8HjNQhoeQSKeb6xeKqsfSFtquoT0coRFe+T8=;
 b=W/qrQ7gwZe/Y0TpjIDJ6ujaI3Deiv1/dv/1cjBvVmaObdnSRqX7H0wqvQnaQ3PHSML
 sbV69uIEN4KwB3iOu9emQe5QnBRErDs0ar6BjumudFBGGfdIYR2YbYmcXlV3PuJfdb65
 dlcl18lnvbZCKsuhQ9QpJzc8cFsrzY8FdapUjTEMNeexaWYM2kigbXQnWrUETAlctAX8
 /rH4RyLnLAF14PBb0IZGR0lBO9IPJG+6FdM2gD+qnIX7fyxBpqNyo6UzKiwmNKliKKv6
 Vh6va5DVkU4Zl6b+mUYu50Q613ZmQ63KnRcw5zMTNCIYYMJAXFB9Cmqdu3Br77Pmkajn
 86ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1QXKUqkmxVstxHYGovseGQQFfztrT8rimcvVYOjzZptEKRh7qALaAdlnyy7b92p7hRWA=@lists.linux.it
X-Gm-Message-State: AOJu0YxB+v3fhrXAPPGVVMnp+DBFh0x3+W2i1VmyM3QD5N9PpOhwlg3A
 LxJGtXNsT//zYoFK6kfX3Cm1GdvXP0MXeOM0CappY6fXzaDiLMIUvVpWnL3Fydc=
X-Google-Smtp-Source: AGHT+IH1WDkfsweo8o5FhRyoWp88tO4dI6KBeZYpF8HgUo4VNl6FwXJdfUCfbk/Y0s2z8o1d6Vo2OQ==
X-Received: by 2002:a05:6402:3812:b0:5c4:2ffc:cc2 with SMTP id
 4fb4d7f45d1cf-5c8824d6303mr1831199a12.13.1727423079305; 
 Fri, 27 Sep 2024 00:44:39 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.47])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c882495491sm798342a12.87.2024.09.27.00.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2024 00:44:39 -0700 (PDT)
Message-ID: <992df85a-9e44-48a4-bb89-be1be0a6a813@suse.com>
Date: Fri, 27 Sep 2024 09:44:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240924-ioctl_ficlone01_fix-v1-1-7741e2e13cc2@suse.com>
 <ZvVMJQhI_4tTFfYB@yuki.lan> <e28fb881-d48b-4390-997e-a366574b2ea2@suse.com>
 <ZvWAXq2Uodu9sUVQ@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZvWAXq2Uodu9sUVQ@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix ioctl_ficlone on XFS without reflink support
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

On 9/26/24 17:40, Cyril Hrubis wrote:
> Hi!
>> I'm not sure if it makes sense to add this feature if we already have
>> .needs_cmd and .min_kver. It's better to keep things simple in this case.
> That will obvioiusly not work because we need to skip just a single
> filesystem not the whole test...
>
Right, so the discussion turns into what mkfs.* commands we want to 
support, because we need to create a parser for each one of them and at 
the moment I see mkfs.ext4 only.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
