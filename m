Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C295BC54F30
	for <ltp@archiver.kernel.org>; Fri, 30 May 2025 07:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748589827; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=UFEafH5vZLCKx9ICKyV+m5lcHdhAv7RfHyUbLjMtpQU=;
 b=GLDQ+MFDbBS7y0MHKS3rLIyQt6RvV6sT8JBG4sPWzRP0yAyZxTU/TaKiVQF/dW86qnzxH
 MeSCNTce+72A7LAhvXJ+pGKA0d2rbAgi6z43qLvzuBt9wCIsJJQ6SLw8FgxT1xS18xbQe1m
 6SlGSTkWKmcKOK4o+15MWFK82JfkUpI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA8A23C924D
	for <ltp@archiver.kernel.org>; Fri, 30 May 2025 09:23:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A73B83C0546
 for <ltp@lists.linux.it>; Fri, 30 May 2025 09:23:26 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CD7851A0111B
 for <ltp@lists.linux.it>; Fri, 30 May 2025 09:23:25 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-442ea341570so11293335e9.1
 for <ltp@lists.linux.it>; Fri, 30 May 2025 00:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748589805; x=1749194605; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HTKYO7p0jdU5lvye3JuVkN8Z7/6aErHPLsTF16afrrA=;
 b=M2Jm2x68GFPKs1AfPORbDmnrNclekw21ptf5OZ1YM+htdAPecBcVA40k5QjNQaFnhM
 LSg/7twLqu5Tv4UMkxm29rYrQs0SSGN33P6WKJaPOFCQjyEpVsjKu3mtr6b4+4nHhn07
 Zv/67n9/2N61yREmINIO8lOAD5M3/DZ3wO0lh0qaB6htx6Q5GnMlVlIYZiJ15BffSge0
 SF+UzoJzcmKfcI8apXPoppWamZuqISjQslQYCgQq1hF8XFCWKVor0iWdlICb52/Axkvy
 LDClbO7Atl4xia4pqqiG7eyB0OhRYvssI47V4fE+QgDxRwqs6tbrrm0xpYHxH9lR1Hf2
 5KjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589805; x=1749194605;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HTKYO7p0jdU5lvye3JuVkN8Z7/6aErHPLsTF16afrrA=;
 b=K7mzudLs81VgILssZtfbvftU7rtCAYEkpAT5fb6NiIrkx/VFf4QlaDrZnOQxY0bBgA
 KsBlnV/uTfrswwCBQxnC9adEHYjM9hIIVjAhLHtMNcF0z7iUjXjzijQcZnfhpSPtKBDz
 TomeuipTwnc8VYrmKFOApxfpdo8kJ+W93veSmBqRIhOS5kJf/OKOrHzFCwOtXblWz6MI
 Zk5BB4VKZxSeK1jCvR6bzDlo/i9nqm7zXeqza35r3W5pdHcZxRnRQQIvBg8fMnvQ9MpX
 56WB4mkSDWdYHx8YJ4vpDNJY1BkP9fZrvfY8XFoM83Q9yiHO7wM6YRsfsKZ1hkwlmrOK
 gg5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrJokV63tYS7kPRK2rIuVOvR1tHi+/8L8keSPVAsxVnTL7aqsvc++Kg5rIy1JIyODI3JI=@lists.linux.it
X-Gm-Message-State: AOJu0YwuRdqciKIKd+V+clQlEjGPz4D8adS7lr4ucFpfrgIEKIbWzaqg
 3KyYpgS/5sT2hpXe0PH5Wzma5PYJHGP28I3KN4mqyt+hhFfymOuFyTyMSWZxtzji7Ok=
X-Gm-Gg: ASbGncuWPnmyLhx9XT2TvcxnRMl3O1aDXXYOIEupzEX3qrdYzWyCC0KhhWmILh/KZfc
 ZfHt1z3UuNaurf9hmU4SIPYBdoUfiiekeMLx9nbyN+ROOI9fC3hu5hwHW5vJfxnXYDKL5KfbBe5
 G/fs3CZVw6lyXTZeykAOvhYI0exWlevVr31blCVjs4VGUULPEU3MFTzfKPCyJUOm0zjGbZD3XRl
 FJCF3/dXaMnsJDlEzZPCCJMm8frWR/u5kY95E79y0SY0nai2kfi1A+gBFfUB9dwN/l3e1L2iR9+
 R9QYdbez/rIp/ouCHa8zmTdLyqQXOsx2WSptBbYx1BxaLJO5jkS5nc2x4mHheFl+Il4z3kfoRTo
 Jo9nvOBHPxXJXZpr4J+ieUlhMF1LzICRh3SoqdYU95QuhSV+G0jvb/l7oJwF3f0ROaettQ4Zlwg
 PsaWLtZOTRkKCSgg==
X-Google-Smtp-Source: AGHT+IEZAI9whWRhIQ7cL81226HDwPERtlfG833E3PdigZQenNKKxFxI+k32tLw9f6ue9wazrqSmmA==
X-Received: by 2002:a05:600c:3e83:b0:43d:7588:667b with SMTP id
 5b1f17b1804b1-450d8846c1dmr11736635e9.10.1748589805161; 
 Fri, 30 May 2025 00:23:25 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa2566sm9899195e9.13.2025.05.30.00.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 May 2025 00:23:24 -0700 (PDT)
Message-ID: <5c292338-9a13-460c-a08e-fb297c7e7332@suse.com>
Date: Fri, 30 May 2025 09:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>
References: <20250527094415.4760-1-andrea.cervesato@suse.de>
 <CAEemH2eGQP6k1cSDH42c=ZXLHtXdekDh5H_nWSr0o1_=j1i8ug@mail.gmail.com>
 <81a131e7-acef-4aa4-b1f2-97dc30c45983@suse.com> <aDcNer6dHSI2bveR@yuki.lan>
 <CAEemH2dSAfRiDwVLnHRLQ6=7wUCM=sBU11Y06kjhmj=iXvuEJw@mail.gmail.com>
 <aDhFy4DGP0w6JB0_@yuki.lan>
Content-Language: en-US
In-Reply-To: <aDhFy4DGP0w6JB0_@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] kirk: version 2.1
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

Merged!

Thanks,
Andrea

On 5/29/25 13:32, Cyril Hrubis wrote:
> Hi!
>>> So are we going to wait for the PR to get merged before we update the
>>> submodule or do we merge this patch? I'm fine with either one, but I
>>> have to tag the release on Friday.
>> No, we don't need to wait for this PR merge before release.
> @Andrea feel free to push the patch with my Reviewed-by: then.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
