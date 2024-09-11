Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C375EE49BC
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726067242; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=ysMNWX1eSNe2EwM1CKx36c9nG8DuyzaKiX/yR0Eci9U=;
 b=HSSRiQkMPcoMHh73fUl85xREBlXPtS/ojQAsRE4T2Pkovtsh12GE46qIsYHU1gpvNI0Pp
 2+a5W9+L1jpbXu1S0FapFq3d1xQE0ahlnkgJQopiLhraQ9gl0IJPMjKBZw2/aPfGGE8GQ0n
 L+R7ZQM4MwsKQlodNrYzfm3mynkUGfI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D9323C1D56
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 17:07:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC3AD3C1D68
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 17:06:59 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3413A602748
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 17:06:59 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a90188ae58eso65631066b.1
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726067218; x=1726672018; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6RuuUlhzF/4M0anUvOgT+qksnSvmutxjTvcNEKkoFq0=;
 b=Z11Ea5Ky5WIIrqvKl4msecwqNmYVy/XBM88aOMY7Y5cxhCdRrKlKTEz59SEGszQQjz
 Drt7feUDLHDf4FSJSicyoO1py2KSVdXeQBzUQxMcLcCV7kUNd4FvE3IQ73VWQ9YUVk88
 CLzJACJXN+7vQ0MJHkvHuI5pK1fCjrsYRuS1/3idOAXwVALDhEvFV+vjsP9kwwKPA4z/
 EgSc9+QVJ3hTRjlhwqIg4nwX20MEAdOw2gKGJFLSpP8C58MuayeqN7clMG9PWZtkWZXf
 HIG/Aj9VKSbLUVKap8YMJNkiV6mVXbuECG97GEwA2BniGQGu8zuI+rO2vfklmRV1vli9
 PFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726067218; x=1726672018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6RuuUlhzF/4M0anUvOgT+qksnSvmutxjTvcNEKkoFq0=;
 b=L2f9muwYBQ6nFKYw6MLO+Zg/yHFV22seDcqdagK3fynwYmsAqLqvM7lITQuZeI3cE7
 iW2v+mj/hrq1J8aQDp+ZjQlJkEpMtiu3p2SiZ4ruHGskGQ2uwNnwcxF/9VOnzTt8+EFb
 1VgsOKeVvl2I9/2MqOm9OIlxubBrjfGs4V+QxUuWTNbq5hK2dSLrRtg/BJwIrbv/BfLR
 gNPD6F6HAnOf+jOrgk/Wo5PQE1KWBPHosEudX127P0YgYG8oD5qEmzks+jj4vU1T+W9Y
 8wcHuV3Wb/PeAG9FvMbxKSMtMAawA/8cbuv9/QXc+68XSBe92EDWaHyzEsmPlBRKQ6VR
 YLCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa59xMvDobU+eByQrSJoDw9xIlEEN3PsQpcfU/4CcCz+V9aF8Xu30ep+mb5Qcm+dfmpYk=@lists.linux.it
X-Gm-Message-State: AOJu0Yx6eSU0OAq4ofN+GNN3Q6NG5V78W1zJYwDrWzvZ4Bqm3J8g2eBY
 ug+HhOTKVijLYEy3Q5U2ifKkN0V1TGLa0n2XcDj12ARyM5w8AkMuKFW7unzLY7L/d/IYVohPVY6
 nxnA=
X-Google-Smtp-Source: AGHT+IE4WvziwKE4q9cUL+1j5DFh8Se7jCY/z4PQklGY21DmUXpHGZReuU2a2HqBjIw014amIMCcIQ==
X-Received: by 2002:a17:907:3d94:b0:a8b:154b:7640 with SMTP id
 a640c23a62f3a-a8ffab8f742mr394874166b.37.1726067218458; 
 Wed, 11 Sep 2024 08:06:58 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a4428fsm622557966b.97.2024.09.11.08.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 08:06:57 -0700 (PDT)
Message-ID: <9648313b-9a4c-4aef-82d1-6b4826110cd4@suse.com>
Date: Wed, 11 Sep 2024 17:06:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240911082151.16971-1-andrea.cervesato@suse.de>
 <ZuGcVG_HTNuBlEaa@yuki.lan> <f30db8a5-e679-439a-b6af-258d25308343@suse.com>
 <ZuGwDJVP2YdZvKFl@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZuGwDJVP2YdZvKFl@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] Refactor fork05 using new LTP API
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

Fixed in v5

On 9/11/24 16:58, Cyril Hrubis wrote:
> Hi!
>> Uhm, isn't CI passing enough?
>> https://github.com/acerv/ltp/actions/runs/10812861601
> It literaly does not compile if the code that is inside of the i386
> ifdefs is exposed.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
