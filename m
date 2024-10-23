Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B3FCF5396
	for <ltp@archiver.kernel.org>; Wed, 23 Oct 2024 14:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1729693870; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=1vQQdtf0fGwfw82CXt25uLYncnwNctfaprcZhf/p+zg=;
 b=H1qJRRekxvLhNoLFoQ32X7119onGnj/86KPpGkikF3GxDMH4n14n4ND72P6tZuUZgGI29
 eRDIAyLN3r1udAKqmyHW5FFWBDpZpVIvwOl8nTpqb/KP24crkuws09bv9fidQw4NkWtyQ5w
 gL2udFqxBmwi4ADAaEZGiy4iS6jwlRg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 234AB3C7087
	for <ltp@archiver.kernel.org>; Wed, 23 Oct 2024 16:31:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7E0A3C69BF
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 16:30:49 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BB72D208F9C
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 16:30:48 +0200 (CEST)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c9428152c0so8797257a12.1
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1729693848; x=1730298648; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6InseROsoVIDCYKOjzslOvMKeAF8nHshy6OmPHQuV30=;
 b=GIgQFq/cSW9NLoUaWeZHHjret6FRtoVS4RDt1pGziICDBchcgXrI5XWFLLbVAcH/nA
 CcgWxmRuRcR+HVZINqlBi7olIl3TwWitxZwCMbb1wNt0eLnqO2pct8Sh+C4AE4AJmjcr
 HNIDUwFuXSHG95udYe5A6qoJYWECdgioL3dF4YfSUyMKAQPVjb+p6K12KfbkF+IOUFff
 1Zeq5eYKNeB4Qo0urjMOUXpnyAMuzpV/Jb9Dd77w840FnKoJ3ydcTVmjpGlFY2wTOHvi
 aL9Sxmcry/ueNNGvfHFTK+bMJ8v8WXp6qlPWWQARCnJVE3fx4Jov8q/8UXDglZ9tYm9S
 s7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729693848; x=1730298648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6InseROsoVIDCYKOjzslOvMKeAF8nHshy6OmPHQuV30=;
 b=EkYGOBzqwFwPJ4y3kzNDoAOMY3y+x8F5xgG1CyTqQQjvghLTAk/RmVT4sG12e5fIjW
 EdndHCifmcaNHpcWmMZXZSiwNYnDFgkKdqJfiNtFR0lgDdy0aDpVIDE+7E1xtWmkSwDx
 u2iBkwWgRNfJVXubFiu9GT4GbYFY9pT1rdae1LYeINv4p5SAqmiQoh6ApflYSmVBsS2m
 N3jg1zgdVCWxSOh/0F3M9Tz38NV1Lut0QSdV875O5hdbaOSymwXyB8n2DbSGebWU5WA8
 R/HMoP/dRjBa4pDZN2ga1nBsfepDATdAboaajssKvgqhaadU7BVCmxmt94+uHPFrNfq+
 rV5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8bCt5jSOYHgShObioUbjwJLMi66iU4H1sOd3R9lwqJyNkTOHsunKyoSWSsYq9yQmGE/k=@lists.linux.it
X-Gm-Message-State: AOJu0YwFAYx4vw9Zo9pMJh7qualoxnGCng+B2gIVbvWool6O64nQDRCx
 bIRyKyV8TH9ECoAGIQy7WRNGhiFhpmA5iJ8IorN7l4AcN4qZUdEVfvX1v4fTpvg=
X-Google-Smtp-Source: AGHT+IG0WfPDz/ufYDxlbW1lYGJOD2H7qVQqroKydExoOIzexqVqrw6pFraw/9MHcVE/PtXKCriDKA==
X-Received: by 2002:a17:906:dc94:b0:a99:46aa:69d3 with SMTP id
 a640c23a62f3a-a9abf961c00mr279734466b.53.1729693848107; 
 Wed, 23 Oct 2024 07:30:48 -0700 (PDT)
Received: from [10.15.23.93] ([213.61.187.218])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d6579sm484617766b.41.2024.10.23.07.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 07:30:47 -0700 (PDT)
Message-ID: <2857ad7b-9d0f-496b-bed8-566508d7b9d8@suse.com>
Date: Wed, 23 Oct 2024 16:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-4-5328a785bbad@suse.com>
 <CAEemH2fnQ+H83o4L6Rx1p-e7s3ExFAwK9PNRkbGZuc2OFYUEYg@mail.gmail.com>
 <CAEemH2fyP++1HsNyN_EUjOAXj+XOKjnMXs4muzP-V4Dtnq1PQg@mail.gmail.com>
 <20241015171717.GA36237@pevik>
 <69c655f5-3635-48c7-a925-544ad2af05ca@suse.com>
 <20241023125707.GA594199@pevik>
Content-Language: en-US
In-Reply-To: <20241023125707.GA594199@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] Update syscalls files
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



On 10/23/24 14:57, Petr Vorel wrote:
> Hi Andrea,
>
>> Hi Petr,
> ...
>>> Also, this 4th patch also does not apply. Unlike first commit there are more
>>> conflicts (applying of course on the top of the 3 previous patches):
>>> Description: [v4,4/4] Update syscalls files
>>> Applying: Update syscalls files
>>> error: patch failed: include/lapi/syscalls/arm.in:1
>>> error: include/lapi/syscalls/arm.in: patch does not apply
>>> error: patch failed: include/lapi/syscalls/arm64.in:294
>>> error: include/lapi/syscalls/arm64.in: patch does not apply
>>> error: patch failed: include/lapi/syscalls/ia64.in:341
>>> error: include/lapi/syscalls/ia64.in: patch does not apply
>>> error: patch failed: include/lapi/syscalls/x86_64.in:349
>>> error: include/lapi/syscalls/x86_64.in: patch does not apply
>>> Patch failed at 0001 Update syscalls files
>> This is really strange. It's not happening for me even with the latest HEAD.
>> Did you rebase first?
> I was applying to the master (as I wrote first I need to adjust first patch
> which also didn't apply, but that's just a single line). Don't bother if the
> problem is really on my side.  But pushing the patchset to your fork would help
> me to actually test the code.

You can check it out here: 
https://github.com/acerv/ltp/actions/runs/11480881574

Andrea

>
> Kind regards,
> Petr
>
>>> Kind regards,
>>> Petr
>> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
