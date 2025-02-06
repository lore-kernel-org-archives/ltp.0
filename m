Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBAAC02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738852920; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=kGkse94i1K+8R73ynQwTtrWu/dz51tkRPXXGo3OQLVI=;
 b=DLu6CcXL84ovhhVMFg46kRUUnNY544kAGpHlK36gnZf6p4hYNKlbE0y3l6HSjvBlybUD/
 qoqxBEFIihGPIrtnIj5k1Qqe7Fvv0UWuqQIAivTEoBpu15ZK/XFSf/giTWsXyu5hW1eFcng
 5L9/f/wxV8jGMkq/f7kSZSrN5TOVokg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DD443C9285
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:42:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAE0E3C01B2
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:41:39 +0100 (CET)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8F4861032C3B
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:41:37 +0100 (CET)
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so162543966b.0
 for <ltp@lists.linux.it>; Thu, 06 Feb 2025 06:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738852897; x=1739457697; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l6QXVqF7OVDqHO1Lx4W6ZvR+PQKcivaUHe2qlm6sHPc=;
 b=eicWqueKGzg06mePxxxknblYxa28fNJVwjFSq/54c5EWv+SZX/dEJhXIJNdjXGm1VK
 VqDGb0/rtcx5OgYm0UKKM1+F2ubpbZhy8DsG9b+X/Gm5ryUy2fPE5jm+58aMZSgU6hB5
 qEBs0KHaebvkPrrRJ1hSrHF9Ex4uJKRvPckH4vL3Q6CCXHHsejGomMfR0IHvRCimwXaK
 x99FZwHEmCFmMWBzctcnP1UXqGZ2Q0zcoEwAjgUcAbJr4jyyUhqxHrhYWKqd0cw6EsLB
 gBQdiSrhoy/WCAn/H0gak37boiaD7ztZnh2NJwGgxy9lEkZ79GkbB2S5OjZeQ0hJ5Xei
 YGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738852897; x=1739457697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l6QXVqF7OVDqHO1Lx4W6ZvR+PQKcivaUHe2qlm6sHPc=;
 b=tVFs20YGgIBrpgq9x6OkS+gjODtMXPIifJxDSmEb0UcII8iRgVv2dl2d3ryPaTSA+9
 ahxf2TeZ6DqogRLLg0NfLDbqeRMB24casvgrwypB36OEBaueQBcXfNiBModz0V7gmkhb
 WmH/Ssn3AhrV8SO09c5Ij6eRJ4BHq8u/+VwLsjVgPDZWzusnILS9aMELKbdif0dojSHu
 cf60w8lUXSzyy/H1O/FELl+a3GEmzR3399ZnNrXrGiM2vWUxRNJWMWneTOHDkBTpALBl
 REX0wfqfjkDvEnk2vCRcZzwmmLDQjUJuyv9Z+8F0bfsvMHwEQg9lY0V50Phzd280pz87
 PTQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAYtKhr8c75iX/mbSz5Pa9BvEG8Ty10s5JndKKtXJy807aOBdP007XDeHhbWmLtw2vg+o=@lists.linux.it
X-Gm-Message-State: AOJu0Yyd5HWEAaU2MnoaM2J2+RJrsV+pTAnBNRjTZBKe/yrj5bcILIqe
 H7nx7Qp/3kLmOwGP0jklEWlXWAzUS1+TgEWrvdEbBk1Jg9dHJag3lXqtzwGKh+pcRFHxRpjGaXY
 28wigQA==
X-Gm-Gg: ASbGncv4PT4BOD9bx0EHI3DJ032o9fhw4lcy404oTLF0HZyEAJWirrzv0RmN3VMu+lH
 xZQU99VB00h6R1ANR3MHJdyHzwD8W9B7ByD05E8JzBesG9uo4M53ZM3fBdnCeFtEniP8WNJeIDA
 zkWMEwEj1/fn9ya1Mf8HHGaVpdjBF0v7K0pyNOKXsiJVUyUbsury1acmeLKZ84VRxtPiuDfDutR
 If8C0+gRiQMnZN6+vTlB4axyvy/Uccfa5rs/m9h4LgdQPgLJKO5uBxs8FfX84okAaet4RT9H/O8
 wd6wvMjtYswxJSvjWRt4GqOhSeQDFBMDiCcZl9q3AG4Mcgz+FfkPHDf209LUYLF5eu7xB7FST7f
 KaCK7m/Ij1mETyV9/axeVqqA9JNUpcPNhi7GHng/PL9Cmw/KniS4=
X-Google-Smtp-Source: AGHT+IEpdSYh5Fx3SaWyIL1+jseZiSblimX6jUhIyL6+e4lUOoarE3kx5m+6WRxf51Dq3PPJnr7/JA==
X-Received: by 2002:a17:907:6d18:b0:aa6:7470:8efe with SMTP id
 a640c23a62f3a-ab75e243210mr862979766b.13.1738852896865; 
 Thu, 06 Feb 2025 06:41:36 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7733399acsm108863766b.145.2025.02.06.06.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 06:41:36 -0800 (PST)
Message-ID: <0862e1dd-624c-49a6-826d-173e50e32a5e@suse.com>
Date: Thu, 6 Feb 2025 15:41:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250206-doc_tests_list-v5-0-52110e1421a9@suse.com>
Content-Language: en-US
In-Reply-To: <20250206-doc_tests_list-v5-0-52110e1421a9@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 0/2] Tests catalog
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

Merged, thanks for the reviews.

Andrea

On 2/6/25 11:16, Andrea Cervesato wrote:
> This patch-set is meant to introduce a new page in the LTP
> documentation, showing tests which are currently available with their
> description and information.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v5:
> - add hugepages, ulimit, resource_files, save_restore
> - add more comments in the code
> - fix multiline table cells
> - Link to v4: https://lore.kernel.org/r/20250205-doc_tests_list-v4-1-ae46e56073bb@suse.com
>
> Changes in v4:
> - show maximum runtime with timeout text
> - correct timeout text
> - Link to v3: https://lore.kernel.org/r/20250205-doc_tests_list-v3-1-b60649cdea6a@suse.com
>
> Changes in v3:
> - fix table widths alignment
> - add warning at the beginning of the test catalog
> - Link to v2: https://lore.kernel.org/r/20250204-doc_tests_list-v2-1-9d29aeacc3f3@suse.com
>
> Changes in v2:
> - add setup
> - cleanup code
> - Link to v1: https://lore.kernel.org/r/20250203-doc_tests_list-v1-1-5fe69c07b1ab@suse.com
>
> ---
> Andrea Cervesato (2):
>        doc: remove margin for multiline cells
>        doc: add tests catalog page
>
>   doc/.gitignore             |   1 +
>   doc/_static/custom.css     |   5 +
>   doc/conf.py                | 274 ++++++++++++++++++++++++++++++++++++++++++++-
>   doc/index.rst              |   4 +
>   doc/users/test_catalog.rst |   7 ++
>   5 files changed, 287 insertions(+), 4 deletions(-)
> ---
> base-commit: 7f3922a2499ebff6134c37a17a0de6012a318fb4
> change-id: 20250131-doc_tests_list-1b82f51e43fd
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
