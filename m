Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B6CC87FD2
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 16:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753806953; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=08gHXqbJYrsP3DwbgLbC0DDwcayWu50SG+hdq24Nopw=;
 b=hUqP/w/1V1LEQE4eWK7EmBLNn3CNubaIqpXU6PNF88scit7j1gXZI2MTpfcP7rfVTHMHs
 C4/Mcwa2iG0NFLRUSggN3uHRFytkC4HUPyFHysOAcLRZ4lHYaDDOYpiM6glSN90/6x/Jh74
 zi+b0vP52j/hsTkmGNDcDzSuKvJ7zE0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31B823CA6BE
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 18:35:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19D103C03F4
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 18:35:32 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 02B6C100075B
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 18:35:30 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b78310b296so1754415f8f.2
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753806930; x=1754411730; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lMQvWIiYOy2qLE6Wf6DtQVwb5vXQV68pdZ/JC6G92Lg=;
 b=X7+6658Yk/IjNxAb8qowfQ4aTFjU9z3vsS8W+0C51nhESX2r93Ry5sDBJyg0XTWdHd
 xDbnr6RWq7GIv5lfSuhUzRWDQJ1XytMwY5UG+fKZbD+8eH1zN8rp+Wuq1ABap0s72Afq
 yenvNMAFAZJ06DmL2LShDa20iAavSVbVczjyV5n0aZAmI5QN5NM+Y0WQCNvRKo4VChJF
 M+wyrghdPG8LZYsjFEeTFV/uxCbPlJC0kSsfOzr+u2JxPBMoKT9Weokpnk7zz0IaYstV
 zmJ5GFFg8zIV1iE0QFx2Rw6jEgQPvWj91FjZ5qFOoJDdBSquIkui9stivUccsNoGvebJ
 vDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753806930; x=1754411730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lMQvWIiYOy2qLE6Wf6DtQVwb5vXQV68pdZ/JC6G92Lg=;
 b=bOdwdEkN7dNjop5PBz0jLQ9rTymR8XxoUexkxYAVDa6/zUP1Q9B13c5AzFIPurS8dF
 +vM38Xb2xxa5HiCoJ8Qfoz2Z33oz+JGwoeOgZ0KuesRyQW8hQJvEcY1zzV6JkXZiw9R8
 qc9Xu54J9DhtTDsWGfU+V4FVjTR4VyzM/oo2pjlHDX16EFRlYMI4WxcSsJyb2fgVbc+A
 PLF6psyxxdwQTRcOlmSf//z0vu3KI31M4k7dp1/AHelNsQlCmUcBUNL7mAkYHbyUCJyG
 4yjsyW2u7kGx4Cch5NxSRYnmyQ41L3udS+DbYY7mAW9R97UgU/9ELIHerzSlCG+uDC+9
 zylQ==
X-Gm-Message-State: AOJu0YxIVxXWCLpb+8zMGRUhK9xvu5erNm4FR4q8eseS2xql1UpAqAN8
 XLqODf5ry7332Uej4+8Q2hgRHUQfukTHvf7g5gXtyuLFuyH9Y8beba7ybqSQgVTWty8=
X-Gm-Gg: ASbGncuUUJI58TvbveeTESULwZtc1Z1m1tJMC51YEgZPh/PchVF/O3zCM4K5oTymh2j
 gJTg5TLt6WwD7+M4o4uF0BVtvu4ZQw8BoiV/W64YKnRPXeVsQmz5YwACh5GIBdZ76iKjNLJW3wi
 JQYko8ej/QdtT+Cm3nFIy1qUFNZ+CK3VGmsqeEuZ1U3DhiwVHL57D2xP8YQ8ik2FiEFV0+imn25
 lbMSj8EwFNziZZQvJs9oNz2Uqvf1tuw8bXc79yFsUXVSo1kPOFyEJUArwJ9IE94ql0e3V+48xNU
 KJTaa2vdB+WlHurAxl6/cW1+ZXjkc9EH5wGPQ8nL5nQE88KXQsfqUGtHUtUEipgkvmUCYAA/LaH
 yKOzSHEbbHgLmyHW70LJ24zsO7vi19UQYlQ==
X-Google-Smtp-Source: AGHT+IHMShEZfpweueunnZVVwc0OJmvo3a3oUcAFEzKQXrdUSVRvjxRAnKkv+xn28xjY6WkH4dupng==
X-Received: by 2002:a05:6000:22c7:b0:3b7:8d47:6f82 with SMTP id
 ffacd0b85a97d-3b795035809mr228704f8f.57.1753806930335; 
 Tue, 29 Jul 2025 09:35:30 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.248.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31ebb37634bsm6822899a91.29.2025.07.29.09.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 09:35:29 -0700 (PDT)
Message-ID: <71da001f-ee79-47e8-95d7-fd57f8bf1f6c@suse.com>
Date: Tue, 29 Jul 2025 18:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250729-ioctl_pidfd_supported-v1-1-985626a0c46b@suse.com>
 <aIjcex1I5qh3gxHE@yuki.lan>
Content-Language: en-US
In-Reply-To: <aIjcex1I5qh3gxHE@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Correctly check if PIDFD_INFO_EXIT is available
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


On 7/29/25 4:36 PM, Cyril Hrubis wrote:
> But we do not close the fd in this branch now.
>
> What we should do here instead is ret = 1; and keep the retrun ret login
> below.

Right, I forgot about it. Gonna fix and send a new version

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
