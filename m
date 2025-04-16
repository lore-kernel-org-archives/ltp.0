Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7130C369BD
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 13:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744809081; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=UQBUBzUz4l0fbzEjX5474iEueRVXwtBUJ2aWZS1DjWE=;
 b=T9B68eXm+2jxOEWpasI9fthhY02wDdy2SZCt1OeJUtaqHZWX+PUDjI5G8/wqcWWchjxo6
 0dQkJA9MFmBf55egy9RDOxq6RE1+okcEPCmcltB/DezHIPBtsm1DCM4PbT09GihvH/HDSqx
 uu5ltyDKm2fmwDNsdYVHatR+0g50yg4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E5FA3CB979
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 15:11:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C65023CB94A
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 15:10:59 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0B4C56005C7
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 15:10:59 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so57088465e9.3
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 06:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744809058; x=1745413858; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UwPOljDPuORWTQLPU0+Q2W0q27PkiGKAZAee7Tbze3M=;
 b=ALMFNSxy+PM4P4a/2+SImuJJhiu+Qr28Mws0hs92IfFa56u2wUAhdpug/G52TViDh7
 1hRU0sAA3Lh7YI+JCG2eBZlcho02ZmtPYnYlNO15D54gZTCYSIwQ//p/gbVKthdbbPay
 gVdEuC0dxB3jEwDjfsFl455jb3qp7rfRlj3knV36V8xCGKRHuJWEJEFbs/eZsabISRBS
 oDbhytZqmXyydJInNlxnEecDYb9ztimLyq+SEiINxm6nWAqU2HADB7+Udk1u1tKVKwbo
 9auF7YLaEWwG5VRb8oz2K4WHyDtT0zNb4jMnHDGQr1kg+wkV4yV/4ac1TIc2LKzXEk8P
 2log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744809058; x=1745413858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UwPOljDPuORWTQLPU0+Q2W0q27PkiGKAZAee7Tbze3M=;
 b=gpgFxvRI3fpfi5/Epq9ZxKFw7L6et5HjNzex6BBq3/rOtRy6EpdcRVDWnr9o44A5KY
 w9jzqylY3F57MJJ/XmTfWAG/zFVJsW1WvY66XB82KCtGfTJ030bSRZTqtcGYOsOhmhYQ
 68su6xZNwm3zj8TPE2ZHxbvvUEvBorRcW0Yg9TL/xNb/dVzFHnzVLZte18hoept51xLf
 95WnRzFxuma7HNtDTT1hcQBOtnKrT2elFGWakf3stp6aLury381Adx8rulxePFZe+ieC
 NWA/2CZbZMVZADwTNbZ+DB20WVTQKrRH0H0KLCQoXk3pf8dIxW2YWH7uoCHg5YYdgyDf
 fQgw==
X-Gm-Message-State: AOJu0YwI8nK26Li2JIR+QmtTZ8KLxwbMKM/DrRMqTUcQIOyynOioafHm
 MlhKUXEXiSFtrIaSXQOSyx/9GI8nO2wEqPdyZAwfSdcwGeDqrZhw1R5fTclTLMU=
X-Gm-Gg: ASbGncv3b5JlGfQDmizucvXvTCXbKR4cShpecmY73pKlEsBYhVEUeQM/Z+PzXnCFPvb
 AgB0nDpD+1yd0/3E7cDe8RKY4tT6uhulUBuF04koqCc+ZD2vUIpaa+36xM6fbPotRoZrvIfgZHE
 nUgJceD1dABCkmQUuVP8JuVbqLIHjJgoNxberXkDNNKnZxYu0vjKqiLKIV0W9du6WEH4X3tIcCT
 l2vLisvjD/PJawxp+TRIFwuqVgXhfxfEiZSdpiomSrRUrMwbxXBifn8+py826ZgavA0DlbRctH6
 sDiRR93VFfTL9/yJE0KnY1zaMc2gacyQ8xIMCxinI+opBYSAVY4l2sPsoU2iLnoeTG3nR3GSIIu
 sZC9fUBQ5fbfENRNbbyyegVn76tkZTFOEClrEApAxVHdX+nYZJ2BjDDLudlwvf1tC+ICpYNfcoM
 zdj698Xw61avwXaA==
X-Google-Smtp-Source: AGHT+IHbwrt04xnlQXWWn+6TCJURwcskFXKG+vr71QR8Wh6EsIK3rh9DYRfA4vAI3Z/SOuQJ0N7dpw==
X-Received: by 2002:a05:600c:3151:b0:43b:b756:f0a9 with SMTP id
 5b1f17b1804b1-4405d61d03cmr18581795e9.11.1744809058369; 
 Wed, 16 Apr 2025 06:10:58 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b50b897sm20841745e9.26.2025.04.16.06.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 06:10:58 -0700 (PDT)
Message-ID: <f6632800-7344-4cfb-b8d2-60fd0affd71e@suse.com>
Date: Wed, 16 Apr 2025 15:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250416-fix_docs_stats-v1-1-2423b7602690@suse.com>
 <20250416123035.GA602141@pevik>
Content-Language: en-US
In-Reply-To: <20250416123035.GA602141@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: fix stats page
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

Pushed thanks.

- Andrea

On 4/16/25 14:30, Petr Vorel wrote:
> Hi Andrea,
>
>> In the last documentation builds we faced syscalls file download error.
>> In particular, git.kernel.org communication started to fail with 403.
>> The reason seems to be realted to the server configuration, that is now
>> requiring a specific User-Agent. Set User-Agent to 'curl/8.6.0' to avoid
>> this issue.
> Thanks for fixing this! I also noticed this, was in my TODO.
> I also prefer to keep using korg if possible than start using
> github/torvalds/linux (which is not official, might be outdated or also limited
> similar way for bots).
>
> IMHO this is part of the changes in the korg infrastructure detecting bots.
> I guess they need to reduce the traffic.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
