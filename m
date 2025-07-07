Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E25C8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751901300; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=4e2PMUp7lWGxrcRAgfHCJ8K/I1VkjgbFAs3A03vk4mw=;
 b=glKX60kuNzwnema3mfsMgsZXyDbDXuH8SXV7Sr1fEZJvYwiou3hoF5Jm4YMVKLg9sKKUP
 13z4TSQzgFpiasAqRfsI4IGtDFnvUHvRSWhVI1iSFcKkscLlkfX8hD9gkh8yZRie3g1uxib
 DKis738v4i3rZHJ+4uOJtfU+mV6fodk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 438B23CA0F2
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 17:15:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D9853C9AF7
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:14:38 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 96E341000926
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:14:37 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-607ec30df2bso6266321a12.1
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751901277; x=1752506077; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hv8nLtxjlxWMLcZM43m9uZ686M5burgHc0z9ypRH+fs=;
 b=c/WGsXu/1HqUnr774bAlQTJAggkE4lLOSRxZKREdJk/kEBy0iBSJbD/ntpkLZmcw2V
 5Mmlmks+SkbTwtpznSlFeIjm3v0IF1h36L5MTskqpdaVY9JmgJVYo+QN2/Ltfhw67XoX
 gIk5Ggrjf98fGRA0m7qq5pAFeZJ3UpO30BbMG2pT9Fok77JAqcnLcjBFBJUOo5V0SzH8
 uFooJwSJUCZ7ipfUctlSU3+tFM/Iey/BWRz9YCTm7wZHrE+UiBtA+hzEr80JmPSner0x
 JArXg8O/ibcNtYaIeOKEJwtpsbg/Re2AydvN8iVM7j17W0nrUk8YytKhi534TVFub+I/
 jd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751901277; x=1752506077;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hv8nLtxjlxWMLcZM43m9uZ686M5burgHc0z9ypRH+fs=;
 b=fZjJhflrqyM+RcKVBbs+AqMDIrPjSQVT3YSEydMQK3Us3NuTkEB7yhi/VsWdG/hXmp
 tTG/RgHd1neIN6WhNpyk1TN5tdSG7UfDv+ZLs6jJVJZCZUwy/1N+p8km6a0qTgzwoOgT
 b/2clDXVXQWiW+Zk6vNqM1rB01QwbL1JLoKkg+A3IYCaUe+Pw6OmQ7BeX2WsQFK/tduK
 2TbmCN1K1DUdbf5MF9+BaBYqPSYca9cPRvwkPRDwU/i4aJSau7iQbYyDRR33b7GiPrV1
 UeYDtM10QjSyJQ8UbYz25+gfR7SfYFuLKlPfkyVkjQaaFxTjjxSSmic/69BgZ7D6y+TY
 hc9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt4dllQx52lpCcxETF+BNSSLcpvbd5LyGKwWI3ToYIIdeMnRjl8Q+2zKjI9/EiREB0fhg=@lists.linux.it
X-Gm-Message-State: AOJu0YyTvRXYWsXOAJpeRUgU81Rellw8YR3H8qKlX2uwUcyC1r12sKvt
 j5nzyHYMJrrbBIMz4JoICrGkntrIRyyU0tahJZVUCdObWuKZrWYy+d1V+qKm7Xf2RL0S+ok6KOv
 yOGE0kB7k6Q==
X-Gm-Gg: ASbGncuu7nU9eAAimkzjWMLtY+lM8UgwFX3BbB5FI+2EQ/9jkGI5vOGHPIluHgyTgB4
 YWH+LP+q5fSF1tlt/mRfm820bgkeKnh/bjqn87KQHjlhyIuN+n/lW0kED8madMIHWBxwGSc+SNq
 GanV+qgc78SYDv7r7BhIqO50vIFdErAy7ROjHSs+0cCdT6fTk/QEaxZYS5GaYWN430CIKLBrCyb
 2/adX4e2mbyhvZ7Iod8+2FmBk0wqEWGKrvvW9IuDhFDSApcEBGt7hizjDguQqN3KI3hOIl7+5a1
 M2Jh4k+Hyx2bnxXyGzlE33I9GVGgjNthEeVasDxypqt8ieX/MG3wfdgwXGQ1tZDqYnkXimq9fjA
 Pksjb4A6fePApQemzX/epfTmJVKDuMg==
X-Google-Smtp-Source: AGHT+IG06u4LNaNmKVBp7XcXesB0BchVawSAsNnrQws+pRtxKWUAfEHOOlv+dfd0ZDBI5Zy8JzGaNg==
X-Received: by 2002:a05:6402:2101:b0:602:201:b46e with SMTP id
 4fb4d7f45d1cf-60ff40228cemr6846113a12.31.1751901276851; 
 Mon, 07 Jul 2025 08:14:36 -0700 (PDT)
Received: from [172.20.10.3] (ip-109-40-178-88.web.vodafone.de.
 [109.40.178.88]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fca664100sm5737359a12.9.2025.07.07.08.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 08:14:36 -0700 (PDT)
Message-ID: <b7ce7a53-ab60-461a-af92-45e03d18e119@suse.com>
Date: Mon, 7 Jul 2025 17:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250707-conversions-munmap-v3-0-0632537a6c8d@suse.com>
 <20250707-conversions-munmap-v3-3-0632537a6c8d@suse.com>
Content-Language: en-US
In-Reply-To: <20250707-conversions-munmap-v3-3-0632537a6c8d@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] syscalls: munmap03: Convert to new API
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

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
