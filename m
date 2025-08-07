Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD985C87FCF
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 06:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754548792; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=vW9vyPnfymNT3uFYOYNUeyf/tYNAEEJxkOGKTF87NBA=;
 b=AnVIc72XnkLSjPpDOCyRk2ZCXogVVeeWhaWrTpepx40K/Jga57o7FAIhLxLxpFdOuSmIn
 vnc5bvjQHLEqqW0xMdEyrKls19O9TKhFigOeXjI0kk9b1eEYtmwbZMw20Wm62nvxamJNOgP
 F1iWdnN2tD6zXkXKJezAlE9fmkiIpBw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DFEE3C921F
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 08:39:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0E003C07BB
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 08:39:31 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A8DFE140007D
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 08:39:30 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4589b3e3820so6601755e9.3
 for <ltp@lists.linux.it>; Wed, 06 Aug 2025 23:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754548770; x=1755153570; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=msKcsw/J64OV1/Dx/0MbIPJcc4So3eaL57CDve4xF0w=;
 b=LzDWGO8+6oiYtSHu2NFipePBAPKsV4fAdUik9sX/wiiMUrC9Uatik7VfwrqvJUpa2S
 VEpx+KxSDqhIabxWcB3BZ5KRh30w95axuZNs05BRiIwzGsT4homY0JuePdtDwbE1x4A6
 dsne5RePJEQ1ekQ0xchWyfquvPeI+pt9vfF9QGZ+g03F+UOCnbtq05nORVX/EF0/QN9y
 SjVxQoYfwuZv5NhaWwftOTT0kWXqseJkVWnwl+ycE1A8lKfC8XaV18AWHxgNUSpYQlW+
 UKgQsplAJctFvu1c4RsTanEeUeCxD7RUC5TPKdahxXtYfEN/UfYP8zbSa9froZ7gXTZE
 uadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754548770; x=1755153570;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=msKcsw/J64OV1/Dx/0MbIPJcc4So3eaL57CDve4xF0w=;
 b=BcgjHqaW26IxMJURmKBbhqZabJuwbYcSi+OwupYRrQ2ulvYcxCDpdly/J7u1ZngJc7
 6k+ki6bA7BocqBcnMwKycF+5EYP37ly7Y9MOeNu5ta8Yc6ofkV8k7YdHWlpbP4HK6Phz
 aW1V6+hwWCpfpYxDM6kDiX1knOJ0h454OEnciqsanKe7E8/UKb6PPItK+CF7JGbnn2Fl
 gSXR3tqj8aL0D1aEYAi8YiK7pY4i0bCGoQczyThOU4ZRYMUW0ECyTsYgvRAkqPjUh5oy
 7rxH76eoFA1QetCUKJEukTVbs490WbH+i2ftfKtAwulZe837vjFWD8iOLrdip/Ub4PCp
 CsJg==
X-Gm-Message-State: AOJu0Yy7TPPN1CbvR7oJWeoFZxYGDj9SZBZE37D2Vx7TPejrgJgKRcDf
 AGOhWPTtla7If45vRzune++Gg2O4p4gf28+DN9NrV7d2/fmFwFK9U9xUmTGGBI9Jr6c=
X-Gm-Gg: ASbGncsz8yzVurkGK29vzaYFE4X9Ydt37vyYPHgRdXPhZuansQlNkQUNMfi8tuEOYbw
 P/ZlzFv5ZoJ+rQ3j7Gi/WGEKgEytgPQ9D+dUU/aHPkSOXONU5UymWirDk0eOaCkClPzFI3Fuf5l
 g6RQRozx2lqGgsAckBlBy3N+Zp2r9r9trFvcfQRZnym6X5AhGWIr40phqEYMKJIuvk6OTinWoQ6
 Q3bViGUTEr+u0/ve5HnBnlLH3IOoQVwp+BrU2f4DrVbbBpyCSr/Ajt/VcZBieV63xOGtkEuX9sE
 bp+9KCMjAvWVFTTtuY44JZKEI0UyoY/14a1LkFes1O74/LlWV+vKBJFmtLTvA6S/O4e5FSoYCBS
 Vv01yAvETuybo+B9H4GVQU8O89k8wpjPmXA==
X-Google-Smtp-Source: AGHT+IE+UZDKgyZgSSYXuQ410ZtXYIegxK6DKJnwdtyXkFOTPV6w4SzfSGptyxixQdDwB/JjCkdRqA==
X-Received: by 2002:a05:600c:190d:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-459e7079767mr54045335e9.4.1754548770020; 
 Wed, 06 Aug 2025 23:39:30 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.195.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5843021sm87075985e9.3.2025.08.06.23.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 23:39:29 -0700 (PDT)
Message-ID: <f3866144-54bf-4bec-ad75-e32fda873ba7@suse.com>
Date: Thu, 7 Aug 2025 08:39:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250805-file_setattr_getattr-v5-0-2bc4d18e0033@suse.com>
 <20250805-file_setattr_getattr-v5-3-2bc4d18e0033@suse.com>
 <aJN2YH2KYFpz4X-o@yuki.lan>
Content-Language: en-US
In-Reply-To: <aJN2YH2KYFpz4X-o@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/7] fs: add file_setattr/file_getattr fallback
 definitions
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

On 8/6/25 5:36 PM, Cyril Hrubis wrote:

> I wonder if we need configure checks for these (i.e. if glibc is going
> to add these as syscall wrappers) but I guess we can add them later on
> when needed.

Better to do it now, they seem to be an important update in the kernel. 
I will send it in the next version.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
