Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160E6C52D7C
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723548493; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=e/o6koQCOrk5RKR1DNVpZU9GC5AjmmDtDr2ITmzjIKI=;
 b=FVSDoK9xgQXnFYxTV1hts9VqjqeO+bUPqEDfW/MxRz/b27T+0DFStdOCIAv3UXOp5jjMR
 DhEvlSsfEalxA4NnrcwWEKCMmN5cwZGR54Vr1uomHhZ94Iec64DhatKt8gQdKrKJ/5dsHq3
 2yn2rwAK22I7wcZusNv2KFftK0EpzFE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 783273D211B
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 13:28:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 287403C8914
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 13:27:51 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F1BCE600C5F
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 13:27:48 +0200 (CEST)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0468so68367921fa.0
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 04:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1723548468; x=1724153268; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uuMd61AiewSHjSu2XOcQVv+casRBrSZoaP1if3gAJsQ=;
 b=K5+6zoqkdUP05ntCnWs39UrhwUpkb15dOh8txOi6PnSY554zeXP+4sG0amFpMaqftU
 7vnppir5/0rFOwJ+KtCse2mUuf7q2zzi+kZ9+ChRvwepb5kxlDqNjTlyappXfR29n3tP
 1zI1MEjwuEBnv2/ESoYBbxicI305RqQapm37Ele6ofq8QLMKY8s14B2xzO3vxktaeosm
 L08tZ9AXAeq34r0+QJiuOmcwzR4xywI7ubvJoJWeX0lLcyMpnZzz1bztUbwzEzujhadH
 7V6zFecYtGptQ0WvbMgAfO0IUAhJDRgLIlePmWsUAlvl0DvyQKgdRCdvshdOivXOSl8j
 I/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723548468; x=1724153268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uuMd61AiewSHjSu2XOcQVv+casRBrSZoaP1if3gAJsQ=;
 b=tYV9Uq1Fg4YDHwxwuVtavFhnsChLvuucJxZBwRJR/6UTwRZwDH4+i9dAvfkEfM/LS4
 lKoxl+pDwPRRM/VdKUjPtLbKMSw/olm25emq5/0MYGFs3Rb2hjgs1iIGIQyfQ+dOSuoU
 KerU0SgrzRwA5PZ03pK9pM5SJoMeTzO90xxSrC6NSEDF/q0OrAZBZZOUX1ZKiu2uHUb+
 MUzf62Qm5lumECHhV2wZTdkb8GIOl3NZSX32zRMNjL1tag5RxSNl/Nfda0vvIkO3b/QH
 j1GIfBLnb14F9Ubdpzue3fngCR3oKmg1U+kp//C+PQS15UXso0ry7bL93z6sCZUX8oSE
 xzng==
X-Gm-Message-State: AOJu0Yy1ZAQTn7qSqJUQ2EcgRk22mKt7i8CzxQhX39urHeqF8FtAs3T1
 hD3ACJj85GP8v3PQ4rX2Dvpgz7/i9FRjT+0SZp02NSmNWN73qfpPbcFIl5ynHA8=
X-Google-Smtp-Source: AGHT+IFQFIjdPCGY5W+FNdPCaSLFFprVh2aQ1CnwGFUO8z0tKuBY3MYHFENd+X/eI0UvvfXiSGOp1g==
X-Received: by 2002:a2e:a543:0:b0:2ec:568e:336e with SMTP id
 38308e7fff4ca-2f2b712fa29mr20885971fa.1.1723548467415; 
 Tue, 13 Aug 2024 04:27:47 -0700 (PDT)
Received: from [10.232.133.86] ([88.128.88.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3f47b34sm62580666b.31.2024.08.13.04.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 04:27:46 -0700 (PDT)
Message-ID: <fa0de146-ed5c-4172-9635-2c5da6808646@suse.com>
Date: Tue, 13 Aug 2024 13:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andreas Schwab <schwab@suse.de>
References: <mvm7cckdeqf.fsf@suse.de>
 <4b3c0504-93c9-4359-ab50-35fef5f7ee9c@suse.com> <mvm34n8dd1q.fsf@suse.de>
 <210cbd45-5df1-466f-897e-069a51c40d24@suse.com> <mvmy150bxgu.fsf@suse.de>
Content-Language: en-US
In-Reply-To: <mvmy150bxgu.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix landlock06 test
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

The patch works well in Tumbleweed: 
https://openqa.opensuse.org/tests/4401154#step/landlock06/8

I will push the fix in the upstream.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


Thank you,
Andrea

On 8/13/24 11:09, Andreas Schwab wrote:
> On Aug 13 2024, Andrea Cervesato wrote:
>
>> My question was if you tested it locally,
> Yes, I did.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
