Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B703CF6C13
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 09:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767776647; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=6oH7oWmpSugDJaXSzOLFWzmQZQ3vyIKBVRYtaX4qSPQ=;
 b=IzvbH3KZjAZqDW1p6/4ssYDvoT0AZN8pT2R51txbKeg4qZMCMhkcBR91iUCytDAlwtNrP
 DG1J6wOsLPiD32/reOuV6gxn6q7zX5xolTvzQMl/cuY/GSZtgxQZchC4rzwuh3MjryQDD9j
 KvZBG+FrFVKQI0hdDo9XO8Pjr+6qjno=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7C8F3C2F69
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 10:04:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03CB93C2D33
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 10:03:43 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2B43E1A00661
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 10:03:43 +0100 (CET)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b8010b8f078so298525966b.0
 for <ltp@lists.linux.it>; Wed, 07 Jan 2026 01:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767776622; x=1768381422; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EFXsIYpiKaHS3NUd7ohUIi7+PCwq+B/6HFPYgmp3z2g=;
 b=U680LhshshzCwiQOvjs8TSsEvIWJrh5BobYXYQpLKYcInWUQZHrIfArl8IFhnW/0WZ
 hUXY7Mipc8bDVu8QacpXgHDjrH2J/yS0QOL3rRgdMBKbhiE4EN6WLdQ8fUKh5P9klURw
 k8BAdt0USh2HQVmJYEUnstmK/9p1U2Bm5GBu2smyY9LbzNEf07zkfCNoMr82toP3rDZP
 0wFnwD7+DBsXC9BB47x4ovzT9YotfESxxj0F6pAxCxVDamEOjWKaCsZC6UylZEEDXojt
 GAyGWozUML7J0v5Xi5Pk3SQgcxYqcPMWzxfqwO1fLlMGd4HV5u0rUf8nKca0NWI6gDpC
 AkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767776622; x=1768381422;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EFXsIYpiKaHS3NUd7ohUIi7+PCwq+B/6HFPYgmp3z2g=;
 b=N+a1lbjrksev0pysw6i9kK7o3rBCiMmSoezxsvlTsIAKrrC0vAFbrsYSzz9BxzsFpq
 nN/QPuGqHbM9WUugLT0tzAr5QXFW+easJc+tbYBt/T9S+kX2pG/a2G4Qh1SAQNpsE2hM
 6XC53cOobMyLEWulcX3Q7WBaMCYBM/g5Wgqn6qsPo7/T/+ivQQ6E2586VrHoF++MKZIM
 e6JqbT+OXAiSjWDrwpN8vimi74uZVdjR4cE/iqbIpCr8jWUM89pHwkpOL9ML3ZCNK1Js
 wx7sgyYO7RMFayWx/XArcBRX7x/jSH/6lMVSGO4Y1XduuG74vFx7pqTlacOy/HvZ6GhF
 8a+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYsunI+WjsQCSXTOhM1f7BvOTLJXNMfnIlVvHvh7Hd+b5Y5ZVYaqLzj7utORaGsVR5f3o=@lists.linux.it
X-Gm-Message-State: AOJu0YyrSJGArD/N9g8MQyTACst9WXKtL9kzfwnHBRZl5qK45xnhne5a
 gnSJzIcRh+QKlv/Pm9rlzysgRNfZ9+JxMAKU3myfKJbM7GDgZxaBpdX7QFE8y8fTdjxPfrJrzNX
 dXM85m5k=
X-Gm-Gg: AY/fxX5OKKgbfVoxeUec1Bjmw8oh+zPwM024MAmswyosP0NvlrrK7KvvEhuX3EkmcHm
 crw6YQ9Nv6l5vlx8QW/c17FudYJF96bZBRBaochMjIFWz7JzWRQI8pjckOh9UgCYS/UAZ3KaS+Z
 hsb06xVeH3Afhgtd7CzHgD8ZckO9jD1pqKKhWPj2VxE+suLH8TvQcr5KS3Euuj09sYdB7qQHLCZ
 cZsBqEJI3ea31ea+lVe6lH3/1JPD8xT0wQcy7pHf+NIohLgwMG/j6Nte13Ewt5bVPQ7XsxWStvE
 TVMKhCXtS+7nk41N0EBy0AgqMo5tlcGG0c1IvHywQ0/r6LHvcP7Meg8Py1NFLirHPAaRANXhRS5
 feX9QS6FBz8zK++KiXWN+9MFKxoKRfh1a+orIx/f9CQ6amtd89wHobgDCAGTLoDYM69H4n3dd7Q
 htZPJoduAeynRxcblGk7tRgXYrliEGWEr1W3BmIuUPUDECpvzIxb1CPM0mcmWpNoQVr20Ud0Umw
 ZTmW0w=
X-Google-Smtp-Source: AGHT+IFHp76kL5unCs3W9efOM/7SOon9shmmMZUvPlrzljUmWQVkgFU2N0sWT2kf8iDNM/0dO1fTwg==
X-Received: by 2002:a17:907:25cd:b0:b84:40d3:43c6 with SMTP id
 a640c23a62f3a-b8444d4ea73mr173506966b.11.1767776622310; 
 Wed, 07 Jan 2026 01:03:42 -0800 (PST)
Received: from localhost
 (p200300ef2f19f800fd6433c69db8d45a.dip0.t-ipconnect.de.
 [2003:ef:2f19:f800:fd64:33c6:9db8:d45a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a563f0esm464581866b.60.2026.01.07.01.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 01:03:42 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 07 Jan 2026 10:03:41 +0100
Message-Id: <DFI8IGORXLRO.12S960873D0R5@suse.com>
To: "Po-Hsu Lin" <po-hsu.lin@canonical.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260107080659.342698-1-po-hsu.lin@canonical.com>
In-Reply-To: <20260107080659.342698-1-po-hsu.lin@canonical.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_security.c: fix lsm parsing failure due to
 uninitialized buffer
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thanks for fixing it. Merged.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
