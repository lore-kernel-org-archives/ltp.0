Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886DEC3DA59
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721045703; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Z5/gm0o9GXd6qDhVXhDqMQcm9rkUWujC2nH2AA36jfA=;
 b=bZZ4sM9FRUf8HOvGhkWNaUAofzcfu9wntAxw12vW0CQ+gjfzsAGIYA8XCpH21nPD+44gk
 SI/tXxHcIMQ2FX36SC0pZW/XRYo3LJqiIAwFj7HyQLDKpxI8u7iUxX3hCG7Gmn7bcGJzXed
 IIIARdWSE7qcpB/9leMk80m11C+Aolw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 644223D1A3C
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 14:15:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E76073D1A0E
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 14:14:41 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F384F201161
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 14:14:40 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3679f806223so3103816f8f.0
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1721045680; x=1721650480; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+UkuJUbT30rqMlMfnfIh8u1zI9dLPVEBF+QzhBOxya8=;
 b=K3I5iII3qn27wtbtryVduaO7kknoau/y/v1VQq/MrjRrzCLqy2WPA7iT3+sk2RkIO2
 QMWCkM9LfkmsDHR+N3f5gyIUZmxoYhZOoFfpx5nTf6YJU7YBPG4e0dYP+bg7TOxperPm
 6VmXw/4qLSY3Lm1L+IgcposTa7Al7QZxZx6fOkBk9aeNmP060/CIQlAEdHuq+jfs2hWB
 eAjnmluPLffGNU0eZO5Y92h3XvW/71sRgKLKMfv77NI5AexLRm1fjged2Kuho+rMatg1
 oOmuJJiFtA0W91Cg+3CgTzDw3jpNyyOe30i0b4Php3+Ym7voJd/4alnR23QDeUcoFuHh
 k3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721045680; x=1721650480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+UkuJUbT30rqMlMfnfIh8u1zI9dLPVEBF+QzhBOxya8=;
 b=mtmwN2O2euv/KQAabIDhvujbwEzrjWdYb4mFC83FLvokAyby6jEmXQsmsPRGQkGA4B
 7g7xW4NWGg+wqhQicYjL2ftk0NgWxkhoqHKYtFQFsZptykVgppORKg4CKmkFKGqHJ1Gy
 efPf2DZsaHzr1S3f/+XywFIogXlVfjf3PRkB9A/uZ8g0T0ovqTYu8bCccqiu9ogroJTM
 d3wcQs4S+TyEF1diblDNNz50GRVyi3BJ6EkRnuRer+m8NlnBtKw00oobMH7KeuBMioN0
 Gm6/l0meIPnWqQWuWUe9pTBPP20/s4gkOb9zT12abSG3nOGgq+yOdpaILUvP1SR9mNo7
 6Ydw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8l2jKTCsIvFBZwrwDtv+BhXUO01E/J1UmLMnXTpiU1utOAPpYm9IsM4TQ4n9xz/HhO63TD7GJsSw3QkzJhcQehrQ=
X-Gm-Message-State: AOJu0YwCvJUgU6bqfjxar+oKsNtgT1CthLaPywMrYGZ8a5I4wFkpzsxk
 TEEnHwcpi7Ey9+LSPj5j7HhgT9vdgKecX+5ZJwhRgombMOtq7fC7+K7CQT22XrFZzUAd7fCXiPO
 +OpE=
X-Google-Smtp-Source: AGHT+IEaqEm8Fv7ma2i3OSDEtd00tSlQ0z9t4gz3tNWTC+5KC8tbXhsfyC7gGN6fv/Kc/DUzZRFFpw==
X-Received: by 2002:adf:f1d0:0:b0:366:eadc:573f with SMTP id
 ffacd0b85a97d-367ff70cc15mr7939167f8f.27.1721045680069; 
 Mon, 15 Jul 2024 05:14:40 -0700 (PDT)
Received: from [192.168.178.49] ([178.20.93.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0b9a0f78sm40694865ad.0.2024.07.15.05.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 05:14:39 -0700 (PDT)
Message-ID: <f903dd6e-6d5a-48f0-825e-71e4f216b5aa@suse.com>
Date: Mon, 15 Jul 2024 14:14:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240516104227.25381-1-andrea.cervesato@suse.de>
 <Zov59BQ_7j-1080J@yuki> <e3f88888-2a5e-4515-9805-bc605e081f52@suse.com>
 <ZpURPV6wv26kpXOb@yuki>
Content-Language: en-US
In-Reply-To: <ZpURPV6wv26kpXOb@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/3] cachestat testing suite
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

On 7/15/24 14:08, Cyril Hrubis wrote:
> Hi!
>> And another thing....the kselftests only check for EBADF and now I
>> understand why: basically cachestat() seems to always pass but when file
>> descriptor is invalid....
> That smells like a kernel bug.
>
I had to go through the cachestat code and maybe i found the solution. I 
will send the tests soon.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
