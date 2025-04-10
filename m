Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAB9C3601E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 18:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744308863; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=B4+Z9K0juz52+v6Y7zIcoAuh55FldR6Z1vN8vFVaiUA=;
 b=oSUx+ZgrBXqQh2OKLOMnOJstcgMcFjR/N+zCNsBYgvbWs4bo4kx9wkSM4EGXwkJcEYGa6
 ExCqHMMvcDB2vlcjRmlgHXI+a1wSaA3SLDYZPX8/oeFT2yuU4ZhpA9h8OqgP2qDMXOE6t8v
 e48u91uAiYGs+OJHfrH2O8tGRrg8ZXs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA27A3CB540
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 20:14:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEF4C3CB528
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:14:00 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3EC89100040F
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:14:00 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac339f53df9so215203166b.1
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744308840; x=1744913640; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8br7PhybYhg+0VAwbSAhImwss3UZajPUknrPRQOlJkE=;
 b=PIf4coTCownAKovj61+WrHw54YtL99r6cQ22Pv1dVMBgCcfXTK14jmtC8YY2uF3dfi
 osXk9OVN17kJEscQBZk6Xdmj/+3u+dvrqmkvbVHU5zkhVB5Hol7akOkCEy53KzG5WtWp
 6H4EHirYzk75Po1utAhY4ijlQDGzHmSxTHA0QcU61pWGEXackEc0S32C0Jwg3NCuVC9m
 x/QE0gDOpP/cRTLHA9/3s47GHvVUw5TSWkFk2uOJRwrFoQQQR1fF60vVVUI1zqbz29Rg
 QuN/gWtjO5+0RPneAEtMiNIMZfdJkrI/Vf9YVTjsHilH8K9UoTfd7NYHi+0K01gvm9ir
 I8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744308840; x=1744913640;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8br7PhybYhg+0VAwbSAhImwss3UZajPUknrPRQOlJkE=;
 b=hVQKYAxXJLywR/UfxOZ8Rr2CFHdvWy27wPWF2ONPbdWZ5YQ0qE1jhQSTIr4FLjMvRX
 rz5fREYtxzOuyHXrXeyR0hrOXWs83naqtpZWRHle/LktPuQt7MWzB3EpyvwOxH0yaMlj
 oJluacuXCu7ACrmsCObjMHVmcxd0vb+qJ/Q8NMdJTvLpRg2ud7AGRYi0sIYAQzzjCcMk
 5ing5cYSIk7JPK6ICfH+LvneJG7YVFhW9uc5zQaKpidRS8bfJBNzICjbFO1s5YIN0/eB
 MmY5Um9z2vLD/rwTsCO+yoWB0qHkBA7ieDAkFG9JZwV5IpUB5ufe8S/euHdtq/6LlE1w
 4nvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOLPWyC8QqDcEXTOoGtdYzFT4FIrpWuUzq9bt2SSHgT8hn2XjEOnPsCn6TGxBt5DSS8pM=@lists.linux.it
X-Gm-Message-State: AOJu0YxLJzx8j3VFUjp7STV2AgdIEZ4vcSS3kQxX4mZflzOZwYhEXdw/
 fUxo5uSs4WMNW0u+gHuK4um9yvbEiesqp7SE+fhVtw2RzIx+IkRf9zY0wLCTfylqHAD5B3r8gus
 b
X-Gm-Gg: ASbGncvH7s5d3ia+Mmg+as2YTVDrnumKBS0526hXCuK0YTrkqzLTfd6Ok5YEzRKVimS
 4xTboKjpfjjE1C9NnYBU1uK76Le3oczirECCPZtukltXlckevHC3SI5AD4orbVuldsNpUbfUklr
 N6ew6+qhzMUsi2nclP9gI47JUIYcfnEgXuFzlkYeoUEFgUzmy4PSFO+0lcIodltHWrkviQSHvIf
 70nhcZUqiFbBrE3Fm2tsJ+9IotvvhsY7RRDYARWik/bkE8maaS9m29LKMcBXC9HI/PIegdpUBdx
 P6gyxhSmRzcDy9L8vUBcazstUblzzFx8JdBzsZ6xZEyyoxejj8Ijd2vcuvBY0Wg02V897Pg0RXw
 81A9yNkRhB7pdOawLU5vaImrqe9zm412T4x2LUL/djf2RUOVhDUFYhfD7n3Euxi0KiFRU5GwgBM
 vyoyw=
X-Google-Smtp-Source: AGHT+IHDWKPsgkCkFrCLJD9qpvb7f7y5m1pT1p3ba7dqpV0jiFXhaUoXQEQoIvJUsT21CRMhg9597A==
X-Received: by 2002:a17:907:60d1:b0:ac4:76d:6d2c with SMTP id
 a640c23a62f3a-acabd4cd993mr322170766b.40.1744308839619; 
 Thu, 10 Apr 2025 11:13:59 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ccd1a0sm310572866b.152.2025.04.10.11.13.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 11:13:59 -0700 (PDT)
Message-ID: <a1d43f8f-e2fa-4698-8155-3f6bcb64cbc4@suse.com>
Date: Thu, 10 Apr 2025 20:13:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250410-patchwork_ci-v1-0-def85825f46a@suse.com>
 <20250410-patchwork_ci-v1-4-def85825f46a@suse.com>
 <D935U2KQA85M.1Q8BM04DP9WHM@suse.com>
Content-Language: en-US
In-Reply-To: <D935U2KQA85M.1Q8BM04DP9WHM@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 4/4] ci: apply patchwork series in ci-docker-build
 workflow
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUmljYXJkbywKCk9uIDQvMTAvMjUgMjA6MTEsIFJpY2FyZG8gQi4gTWFybGnDqHJlIHdyb3Rl
Ogo+PiArICAgICAgICBQQVRDSFdPUktfVE9LRU46ICR7eyBzZWNyZXRzLlBBVENIV09SS19UT0tF
TiB9fQo+IEV2ZW4gd2l0aCB0aGUgYGlmOmAsIEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRv
IGNoZWNrIGlmCj4gJFBBVENIV09SS19UT0tFTiBpcyBudWxsIGluIHBhdGNod29yay1jaS5zaApH
b29kIGlkZWEuCgotIEFuZHJlYQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
