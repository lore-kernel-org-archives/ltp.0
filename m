Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67B4C25B74
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 20:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716323125; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=86vlqW2AKPPSbMjB6tNif0Nq9F9yxcRDCQIPadSaCWs=;
 b=Ng+bQW+msLich05jQXd8cFhPi4qe4OduXyyX7tFSCyzm/HjpsykoYqUtfKw2KLTDrhMZt
 qpRP7EymO+XgDJVyQWzW17K6fsA31OKzcDXwAo2KJeSL5IQeCV6KSWOHkLeHTDXcxuoqoIU
 e/IB/sfYxNPm+LsR0J2e4Guwd2sBsbM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D30763D00AF
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 22:25:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2280A3C18A9
 for <ltp@lists.linux.it>; Tue, 21 May 2024 22:25:04 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 961C06012A8
 for <ltp@lists.linux.it>; Tue, 21 May 2024 22:25:03 +0200 (CEST)
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5238b5c080cso7282235e87.1
 for <ltp@lists.linux.it>; Tue, 21 May 2024 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716323103; x=1716927903; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0D8+FAPfdvLHVUslUkDqNY9Q7Q+ft1fha2BE9i86aD0=;
 b=IhUl2MZMNcdt1Jd+b7UIMuIbGBAKpZlVWOzumfRajYhRuWsmy42FqwLj+zlr6p2xqd
 s3pwQOEMohSNOm4Swm/wCOKknl8P/M5FTF9LI9PH7f/BAj5qz1Vhpow9Q33G+8uB5g/f
 KYvz3FAXs5Ys7QuCfIITd4GiLDrmErxm5GzZWvCo/YD6VLL8CRds3tnnJsbaa7UflNMH
 ShMlNCRCtr5gbsfEoKT+H9kZ0B6WFOuYr6UvhRrfiz602bPPmYrKxpGm3P1/jFUTWBJa
 2c2jnjG4Q9HQUpmmObK6jRYOe+BqCgdccVTLdsxotI8ny3rvixyi9DgWiMfz7tOQGpvF
 wVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716323103; x=1716927903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0D8+FAPfdvLHVUslUkDqNY9Q7Q+ft1fha2BE9i86aD0=;
 b=E3OhN+KmpZo4ivTAOy5vN5h9yc3Ove9sRymRjFj0AAJBiJWyZCrbOJZvga9C7/pgFl
 /gciHBacoNk9HvXIMTjx883wgns9C+Mz0vQIxIKVgmvrTNOyNEFxjYbX6x1e16+Ny+iP
 kWExAAaEUGahY1ZyTK9VMvwaiCvPqi3VwqOA7f5c8hb3rXb6VS5KvDNgnjTmAdv9JpRg
 PEcQW3aDXyjE3UHOQXVghNKCfbizcnyr7UMBNAUw/7GZgIydhJWNdhTVYqV5uPoSLT2+
 FliQUMyz5ZbrI1L0kC80L4LhQCKh/uaz0yZ5E+ddtJsu15TAYItfK139D7HFcHhACeoz
 yR2Q==
X-Gm-Message-State: AOJu0Yxt+whVzkC122BjoTaP3d7jPBank52xsfHpBPVoOxmdoC0hS7aR
 +op0sHorIQ//hJIZo/tLj5zZpFnPvRFDmGCykQrexPGFmJDXkhblW1GcJfo4QVQ=
X-Google-Smtp-Source: AGHT+IG8DVT1IPh2AGZDnuHLPLtgeU5pckDZHrM918GJNS6x6F3LSahxGVPrPhk+fUlb1DsPiBz7IQ==
X-Received: by 2002:a05:6512:138e:b0:520:5261:9cd0 with SMTP id
 2adb3069b0e04-5221006cc86mr24739359e87.57.1716323102810; 
 Tue, 21 May 2024 13:25:02 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:843f:e00:d596:e8e:78c7:ff41?
 ([2a02:a31b:843f:e00:d596:e8e:78c7:ff41])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f38d8bafsm4770708e87.235.2024.05.21.13.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 13:25:02 -0700 (PDT)
Message-ID: <1299f2f7-cd20-41df-8c68-1e2b59a0c3a7@suse.com>
Date: Tue, 21 May 2024 22:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240119092909.22806-1-andrea.cervesato@suse.de>
 <20240521184354.GB207312@pevik>
Content-Language: en-US
In-Reply-To: <20240521184354.GB207312@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewritten symlink01 test
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

On 5/21/24 20:43, Petr Vorel wrote:
> Hi Andrea,
>
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>> This test has been split and rewritten. Now it verifies the following
> I had to think twice to realize that the code has been moved to other tests in
> different commits. Putting short hashes (e.g. 3fe59efe4, d824f59a2, but there
> were more) would help 1) to review this 2) help anybody who tries to dig into
> the history in the future.
Yes, this patch-set was a mess since the beginning. Won't happen again.
>
> Kind regards,
> Petr
>
>> symlink() syscall features:
>> - symbolic link is created from a non-existing folder
>> - symbolic link is created from existing folder
>> - syscall raises EEXIST when symbolic link already exists
>> - syscall raises ENAMETOOLONG when path name is PATH_MAX long (or above)

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
