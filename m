Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011A3C7115A
	for <ltp@archiver.kernel.org>; Thu, 19 Jun 2025 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750325982; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=OXG3nKZMZy5gT7V3N4oANr98TyC1oo7ucUBtVfmMNWY=;
 b=IznDqeBiB1CkSpnAcZYdTZFHjAvpE4aREE4SerNo+Hywl82/P0nh+3moXCasLdq1Nu/qr
 ixiuUpkVJwMSqvUbFs49Bt4Vq29ssskpJ8glTnd7N6ne2qai8PK7Sc8v0MUWd9CCokTm3lc
 ze2Mud1aIR/PH4oLJGmk3HeebKb/o94=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40E153CC5EF
	for <ltp@archiver.kernel.org>; Thu, 19 Jun 2025 11:39:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55DDB3CB67A
 for <ltp@lists.linux.it>; Thu, 19 Jun 2025 11:39:21 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 846E7200743
 for <ltp@lists.linux.it>; Thu, 19 Jun 2025 11:39:19 +0200 (CEST)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-450d668c2a1so11141715e9.0
 for <ltp@lists.linux.it>; Thu, 19 Jun 2025 02:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750325959; x=1750930759; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=waAbHslmLEziiWmi8qx4+nKwb1H+X/Fkf2ZUsH3fOT0=;
 b=CvGAPd+S7U50ltVyY5kPUL5OqvXoOEF6DXwP4fR8qBrILJI3UWcBEYY1UCmuiUviIO
 x7v+eZuELBKosDvj0jwKJQI79zbGo6afXPVVjMF2XfD1w+EZepTCQWLC0nUIhFWK73ko
 gmyPZDFZHCKwQwWqoRdJdnMKTXQoizc5bvDt5XsfXB/Xo146U6WvQ0x450kvwpsT+Bzt
 C+JMgntj5A5iCGxawLh/W7qg97UAEht7PFlrom5C2Mfcz1KyWne2Am/zp8kUHlgpdYdj
 aNGSFpF9RzVu3U2uLor/vfIfUg9XBl3UsOG6osoHXvlzaZeka0ZKbXZjL7aH9eu2QrCN
 gGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750325959; x=1750930759;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=waAbHslmLEziiWmi8qx4+nKwb1H+X/Fkf2ZUsH3fOT0=;
 b=qId3sCu1L/1+NyobotNQw7BQAcFBb013JHk7RYd/qiB5q/CigavLj0UBjJLH7XJ0kw
 UgwdCcfOqnl8M9AWImkQG27YEoZ9WUEDxOht49UsCpMgmDSg4Kb0BnjNZx5E/nBxcmM4
 cHgCj2RTGaAfLa0QaTSgBOZuVNykA5c+U0OeTtCyFvT4vna8jz+ROBqukUjqyBXRGBDF
 QT1rimIgbx0DjazNpGCe5hjkqxSS2BelSjbroyGkM8rOF3EW1cUIPZcZCR9jnAcZAOZY
 OfNQbzQcsqFeA4cJZSsJbDg/1Yyr5jvndBxvzhXZ+vqBqsUpZpF8PzJaEu/zYqp4FWpY
 ZGag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxEhJVqsbFQ3d209KClSS6UFgmxRaUNRCONlva2OjHL26/S3OxzuPAXqAV4bUOGpAt5GY=@lists.linux.it
X-Gm-Message-State: AOJu0YyoliPbv5Tl46KIRLA0jXLkiVSfGipWsYDhNnkboNxMSVZIIxZt
 6iflpXVr5ZbTsbsN67CwPcnrdKRiqhKYDiTwg2Esgpg5+mljknGzDQV3C4Jf0Xw+FVk=
X-Gm-Gg: ASbGncv0l/3NnlR2RR1XWPXVUl+DN8TxBv6C00grg55yxvLX5bgwRNMKsXZLNvZ6JQ4
 pCN+qyNzw7G2aRhHZgXooGFXU1tZuLBqGoQmGlajiXVS6U9n3UUZVnfnhY3wCFd/sCyL02QnUyJ
 RSXaDOc613LDn8fQ3hlJUzO1KcktaI+d/w9cX5ZFLMdENkbm6smQGhzJqksRoY1AwvdTrjUpnmW
 WbmicBlJcx7cxgCXWacUvlO559uzhX+7QTcKcN/RLWd3YayYphJ8uTzQqEAfLEeDrVXSpNFDeIz
 zwAmr5RpHU3TEDGF4CVDpW3DBFjou+kC88BoOl/AyCr19f/QLATgnQLZaH/i6Zh+lRVHW635ndY
 XhKZg7Yw=
X-Google-Smtp-Source: AGHT+IEy5bsbuNJ14wS476jtLJyBFAa+Q6pLr0IoW8H2R/xzEZwoH0zYpSYbgc9/TUATHqo95+NUMQ==
X-Received: by 2002:a05:6000:2b04:b0:3a4:f722:a46b with SMTP id
 ffacd0b85a97d-3a6c971ce5emr1615759f8f.15.1750325958062; 
 Thu, 19 Jun 2025 02:39:18 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.139.27])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-748e7efcf8fsm3461490b3a.69.2025.06.19.02.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 02:39:17 -0700 (PDT)
Message-ID: <f1965005-0f90-4404-afe2-e22a0d2b66c2@suse.com>
Date: Thu, 19 Jun 2025 11:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <aFPRA7FkfMgeb-FA@yuki.lan>
Content-Language: en-US
In-Reply-To: <aFPRA7FkfMgeb-FA@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Formal kernel API specification
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
On 6/19/25 10:57, Cyril Hrubis wrote:
> Hi!
> I just stumbled upon:
>
> https://www.phoronix.com/news/Linux-API-Spec-Framework
>
> I will have a closer look at the patchset but it looks like it may be
> able to generate LTP tests based on the specification, which would be
> awesome.
>
Really good news. I hope it will be merged soon since it would be 
beneficial for arguments validation tests for sure.
The generation of these specific tests shouldn't be a big challenge 
then, just before compiling all the binaries.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
