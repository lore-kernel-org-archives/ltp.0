Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553C9C83F17
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753961227; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=DnIhjbRy5Vns4lyNhVuS7bZ2FG6SgG9l0MslrgSwWlU=;
 b=XwVFYBJc9wNKap0zckaHxwaw+AxxPKvGnoXrk0CWtbdwWFyQMLINNgXfQIsVDiH5drCEV
 A4tc4Rf+E8FKyvpx/n+nRmVw49KGx6V01E/PrE5/xtoO7Dt9zzZFME3sMXV9n09b1iasLl2
 oWtLK0p5IylhL1qTWXb0CQbbzx3Yr+4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBA5B3CBFDA
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 13:27:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE9153CB93E
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 13:26:45 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F34371400351
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 13:26:44 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45600581226so8504055e9.1
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753961204; x=1754566004; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cdar2TOqSWT9Vjo8xxzpSYo7dYfQVBm6UVvwHPtTRgw=;
 b=R9gtWsQ4frDtiavBybEBaBXa0YQBXdT5cI8eku/UbFCEYdtrmuKedPAcRV0PwncxJC
 jZjGPhjZEhpJNx2OlRZlDyyG/CtYZIX2fcSu5agB2mhVbkj9jXSmtSGhsYVhgCOjsH+c
 Vkrv3M9Nb/jIY2sPwRazXihpXBquVZ370wJyalP0G44icLtLwDOjD8TXKk9qgyFtRsgP
 09aIDE8Xh4f8F7CCwbMPhVF4hWSVhj2ChU73NYhKbmO81DYETEhpWaBjz6Dq0ejIioWC
 0MVP3i2eIwkxBOVnBO1zkiomUnh7Z3hQ/r/sD+2Oy0CRpKTOafzVNKWLjlX0cbJL0eRD
 x41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753961204; x=1754566004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cdar2TOqSWT9Vjo8xxzpSYo7dYfQVBm6UVvwHPtTRgw=;
 b=kUFtcUTby4/qZrXoP5BdABc3YsuJs7rl9+hOMeU0AlTCpcEZnN+Ys1rtzWlhyO3lpM
 yHQ0uqSdyJAGnekmIM/gqwBLTnPRLb8qasi2pch3CJ3zPM5HBXBTAf90v71Pt9acM9Xr
 RNeKnOGoO4ACGzx+0HZCN1N4oQpGei8a6iI5wQHd30H1XVSATf+D+DgCj21TSsZAZsuH
 aYVR0xPO5Yi6/oehpWh10WpzefMcOXEq1kPIxaY2wWi4g0vUwuhvTR3Z8dUg6WYfxqeI
 trEPGCD3ZdiYfhb+4nKwLpGyOHDxy+WJZT48rrW+forPALr/L2dV0/XhHXqi23igIKKS
 ge4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKUTLT36zpXBQw2jV4MCRAylilcnCd02LcrsaE2gyBQrtznvzMGfx5sIXJY12rsON7Yg8=@lists.linux.it
X-Gm-Message-State: AOJu0YxDQrTB/K+y//xba9nmuQQvmuVRNYWVjEZhsnS1rlbFMZvMQMS/
 O3acN+1NKVL6nB0yInSTeBdE8ZuWOBG6JdSBE0KMWg26NwQDRJa3U+q336Ir1C0P1hcd4x2zW8V
 AIs4cDpQ=
X-Gm-Gg: ASbGncvIhdfnrD6gY3h7qjdryvUdFhN7pfi8rs9uaWcUcYQGpUk8EHLWH7XmaoCcr8V
 83bJfKlH8bNMgxtnfzzWJOiepwdtSdPHvxHw2aka5SQirbUbJBnKGTvmCgbtXXUD8hKCwl0NRS6
 qIdd2KrlzuZuYqV4H62svLrBeiEJR+pOvNT3/o8+JadMpPhMR3yxUxzLW3wgbmH+OLT/I8ISPfh
 Pxg05suuy8IgiIg7X2p2mE4MQewlbBhedRCMgiRgTNJML4gBYriC2/0WzvYbrj3lgfUP+LWWsYn
 ehquTDr8wlW83uSNSt9KwOeC4Eb/LxZPHB/62PkYY3nvVvJlIieJdv7BbueesTZ7OguHd0deT1N
 lle08JLDVmAPYNUI+8LvU30vshf++UTJrHQ==
X-Google-Smtp-Source: AGHT+IEg9gU0WbZ2cMAdfamF+rpPwBr/swrWiZbvjDdevoM0Bo5GhJPE1qzJCNxdYeFgfiGvtWc6lg==
X-Received: by 2002:a5d:584c:0:b0:3b6:17c0:f094 with SMTP id
 ffacd0b85a97d-3b794fecd5bmr5878386f8f.14.1753961204144; 
 Thu, 31 Jul 2025 04:26:44 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.222.116])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfdf9bdsm1389394b3a.111.2025.07.31.04.26.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 04:26:43 -0700 (PDT)
Message-ID: <53d86959-f4a0-4f75-a623-8ede62b4383b@suse.com>
Date: Thu, 31 Jul 2025 13:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250731-fixes-munmap04-v2-1-41cfdd2367e5@suse.com>
Content-Language: en-US
In-Reply-To: <20250731-fixes-munmap04-v2-1-41cfdd2367e5@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/munmap04: Increase target map address
 in case of EEXIST
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

Merged! Thanks

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
