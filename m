Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FB3C87FCA
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 11:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754564567; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=sjIEXI0dvcW2HtYzo/KVnQiWxNo3hXUpsDWSmiYSUXs=;
 b=JavJjO0S0jGaph8gHGNb61cxh5qgrgtJB7+0buDciful3oguea2haRIPlbuWTLAVQbitf
 StED7O542ZIeaSXDH6iiXhAgZeQLEYvUpPQUlPlVcF1idxqQm7DuZgwHapEaZ/aVNLa5zeT
 BFXH9tQjT45jKQ4WtB7OdbG4e2OjIvE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1122A3C993C
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 13:02:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DAA63C1D56
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 13:02:25 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2E1BE1000926
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 13:02:25 +0200 (CEST)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so131871466b.1
 for <ltp@lists.linux.it>; Thu, 07 Aug 2025 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754564544; x=1755169344; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qrSCBiBykZNwtydAFW50gq0hQyW80s3+ZIrteAUj/Xo=;
 b=HpBAP9lrTQXb3qgTCYPUAvFtlDiL2vSPrKdC+dg/qy3Ai5Y6ktZuQzJCbmoqojqoTx
 7TtD8HkMfwb5eqAobC4Y2e/cZpLm1BeBCyIRElUZqcqRGO9ZwDvGtNl1h6MHy/t7olHm
 dQGe/QMnmPbTUSJcKlxrDRHRMRCGWmzCt8yHrpbNqS26KgbwUaq7cNRKOjDeti6KPpn0
 Qi0/9JfPY5XP9liecwlvcgSvJeyYfPQzHj43MdJKTzuKiqvPJjVa88lDdN7Bht58HkQq
 ffBkEWA5vkO4sHNfdj2aLZ+iF1/Mfko5cOir215HUgWQdqBQ4gNBQ8vQ6QrQA1PShZ11
 TWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754564544; x=1755169344;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrSCBiBykZNwtydAFW50gq0hQyW80s3+ZIrteAUj/Xo=;
 b=UD1KgKz67uZaWMwmzO4LlnBFjfKzvwGMsQdMxC53u8mGL++MsfVZa/kGKyqBWSUM0U
 luLvqxiwwcxP6hHojXrYPT+pWb0+JUJcR2ohGqhfo9hac4N37ANyyQddqMMsIrJvtBEK
 +qYQAbT0C1+TDEnT4uUH77vfQ/wtMCfj0CSPXx8947mpAaKlmXbErC/GqYRX0S/fQ2dB
 cK5j61LJu9li4q5jcECa6tRQCj5RvdvIdVQeaKrU5qh1M/XrFCNollU5tqB1YfKV2aC9
 q5qXnMuOux14iM+qGKEq4jquuVZCZW8kKG30nXbS5gBWzqzHyeTZ+R4OVplq1wRJzPXZ
 TpXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU74VcvyZCHECpuSiO/JqbZYSRX6T/dh+nwzVvAYNye+ECuBk/kO/PJebspninnSRw+OvY=@lists.linux.it
X-Gm-Message-State: AOJu0YyehygEJxuqzSjKg8BYDaKSbeQFU1aO1ss2GwY5A81vuLKhm/zS
 QzxOrBkDK/vNo2miqGhbHYdLR4Uz3bvK96bBYlbcHX5L91e4YtCx6d7/hvRJYBNHr24=
X-Gm-Gg: ASbGncuR5GQtBRCVitjMzGTVXnlqlS/C/ijvomr9b8SRDn7MUXDS8aARChJledTjDTI
 UI0VegDNKm25Nabx38wgHR648FyJhE+7L2/B/XHQhk4arB5pz5JfPIDiupRoJr0CHd8IWMXMndm
 18bYO9gUXgDZ7a4TQidbooUblDXFWjGgJFp0NNxcYkiKyIhK1DxcyzH4A62jqmDuOVDwolkyumN
 IkH5YDpd1/XEnXCWuitbWNVh7Xz57MYLtJdV8XI0pHnrwYrIuvRUS3C5jbcTZtmj/gL/8WvyqdN
 RFXa7juDMiv7RZ3R4lBgoVKHVP1D4NFRWj1hw4W/dlZjCGCtQ76cwMsUN8ElJRqzi8iLh9gRjH9
 +HbWl048jT28vZIHaRVlCAGFO9NtTubA3+A==
X-Google-Smtp-Source: AGHT+IEemNHPu0tv/LTD8PmV/vESOMOYeoPNgVKYafkoeOxkYvMzaZUJ1tIoutoR1m9Z01BFRi8cmQ==
X-Received: by 2002:a17:907:9452:b0:af9:4071:14fe with SMTP id
 a640c23a62f3a-af9904c1769mr602771666b.60.1754564544379; 
 Thu, 07 Aug 2025 04:02:24 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.217.151])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a078afbsm1284535966b.4.2025.08.07.04.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 04:02:24 -0700 (PDT)
Message-ID: <1b889d87-1b5c-4675-8d30-7df2652e9190@suse.com>
Date: Thu, 7 Aug 2025 13:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250806-conversions-lchown-v2-0-345590fefaae@suse.com>
 <20250806-conversions-lchown-v2-2-345590fefaae@suse.com>
Content-Language: en-US
In-Reply-To: <20250806-conversions-lchown-v2-2-345590fefaae@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] syscalls: lchown01: Convert to new API
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
