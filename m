Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC444C83F1A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 11:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753271545; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=XAHy0MN+vv7FsxexxkQ5anAT6gJ3upRYkqcw+Hee2mw=;
 b=gNmla90XFt0I8/agULcc9MmWttgK2LfYBJRr3jXPo4zDpNtkA2h0uIn2GHVCzxEINOSwL
 RKqvKFeqxoYaezPPbYwJA7DRJfMtKLuCmbyNkXVvbs7F+jKhdvcCGiA8CjjPXh0Hy/K3dRT
 oa/GwYWwZD8pjktFygvPxFqXxuJLYus=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 096F93CCD6F
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 13:52:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DFCC3CCD39
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 13:52:04 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 98C74100034A
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 13:52:03 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4555f89b236so65248785e9.1
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753271523; x=1753876323; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k1+b2p/G6HMwDoClF2VHiHLNz6MEYlbVu6TNrlbWPBQ=;
 b=P1pLT8goeyjioNRPc6VSBqRud4WrUTPGJqkhQ2umW+cMCUDVAS9YkyQKT4wH2tuzsQ
 MiEfnqjVVDhy+jZ/mKAM42HeajoBhIqF36TnBoCxXG62mrOO2zjCohq3hU9srTBxkS/W
 roPdiSIjLR9M7QW8bZfU9V+tcCeF9j+KOW6K965wCM5PBbs4Ov9c2xPaKlvjqMFJPlcN
 Jne+fQNIWdx1AfE90KO45lU6LAGZQSPZjyAFkJOYjzGX/XytLe/9j4i0YJJZuHiAhmOK
 clwSoBgj84vBiByM89SsLxpL30Gzd4H4ty7JUP02Tu6eZobk0o1zFZONa9fkN5isiTWR
 mgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753271523; x=1753876323;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k1+b2p/G6HMwDoClF2VHiHLNz6MEYlbVu6TNrlbWPBQ=;
 b=ZB3+ckzJyW7v8lNbZ0clsl799k75SFCweQss0x3QSrVEHXN178qxDjHIOigC7ATo60
 t6QeXujAKq6FJ8W92KNYNm+9z6Uql4NR1KHW2DuAXXoLNA+NgZ/HwDJgIdEl52o8GQAS
 jOMgz9HSomNwqtZYjmtNIIzDknvjWFEqQ7Nf/p8wVQIPjodPydmwTZyBHPe1UBMqTvFz
 Z4yr8VxAOMDb2drswBklPMKdYG6AeLQGuzABUSvr+8EssWYD+MX3xLEZgM88zXJAFePJ
 /ONHdd9DxR+J3IiuAiKLAGtRT3xh2sTmvv8k5D9HQTsIRu3UOQwGksyEXT6dved67hEO
 YOTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX0194gLDAFJPuNg9/inpH2SR1qcQy4lORU/wHKfJ7pHK/Iu9VJSfu2XtgdlIxZi5B6/o=@lists.linux.it
X-Gm-Message-State: AOJu0YxQspuWmsisn7w7m5CLCy7SGhX6qRkVDTByvEnP2w7DeKjcdeWO
 b3wUEZ/ceb+SgaCcjLVhAw/3kmKKeNUo0eRtQ0RYfSmioTnWxufLzeLuRsYqqUBc08g=
X-Gm-Gg: ASbGncuEE3+ea0rgegzFuHZCJjTHCOX7h2QzNNzrFeGKgDLccbeRANsdnAeJcV4EBOl
 Hktcen6Hq1ZMMD78g3eCSlq8RxOu5aaLJBHnVNKlMaxgQc29u+fWb91r2V/dYALW9AuOnG3UMNX
 dSX2TtKeAVdPB+R1v6TRMhnbGrPQxx7VqfRV9ix7VeEd3FQwVylW6SN6XHdtfO/1TNGPFYxFWLl
 QeWKWckEjPZnNfiFX0b/gTIe0xK4qW0ANyp4765YYIy5wj8J7fE4wpVNayBi2smkLQ4KOvVSdnh
 yxqqUg7d3zYF+KXVoZuXuaq2MHPxFtZ7iBczZYYnF7183w6k9xYAFUXg5C6f/3hMiBtyqq1e5fD
 3pK/8WreIG5uWfyDcN0+VJbUQ1NTKzlLizBWFHAsBW8xQbDpgfQgK9D85CJu4e+md8bK9GxcSd4
 WBmZKLCxbAxGyPpoT+ZzJnviBDR8W7AKX+tulGms0ZzoZGtbrItvlzJj5xRo8zBg==
X-Google-Smtp-Source: AGHT+IHwm0+nkcZfuEkKXM7TgouPJ5I+v1PamjqFJe8nvXElV5tEaYjLi7fb569PFpWQqsNHytCrfg==
X-Received: by 2002:a05:6000:24c5:b0:3a4:cf40:ff37 with SMTP id
 ffacd0b85a97d-3b768c9e3ffmr2258033f8f.6.1753271522833; 
 Wed, 23 Jul 2025 04:52:02 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e51b93862sm1528809a91.34.2025.07.23.04.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 04:52:02 -0700 (PDT)
Message-ID: <89088be6-3a3a-4c90-96f2-1ec77050a7e2@suse.com>
Date: Wed, 23 Jul 2025 13:51:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20250721200428.2627117-1-wegao@suse.com>
 <20250722185503.3224765-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250722185503.3224765-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] mount08.c: Restrict overmounting of ephemeral
 entities
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
