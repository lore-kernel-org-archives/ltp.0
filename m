Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C08C8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 07:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751872720; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=QtKHycfHridm7HCwDkU80minwzNhwZ1lj6CaLQnVc9o=;
 b=ON0h/XaZvUsdyEmWRCr4hX8QkGFiYNbXEUGLc8Ypqja8IQe2QdziyyzbvnYWR7XCNjgWd
 vxngnaQ+0SnMRV+w+gtUJwrFFzn/+yDjFaVV4SCzGplv9bEIoMJ/UNGUu84w1l4b0RuB1nl
 P4zZDkJmw83346P6I8UJedOCQOlbNpE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FE2C3C6AE2
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 09:18:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18ED23C0F3E
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 09:18:17 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6933B1A00801
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 09:18:17 +0200 (CEST)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60c01b983b6so5071134a12.0
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751872697; x=1752477497; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MwoeSTJpY4ODDAS4aA0ss30O85XK3jU218ICr0rYzxc=;
 b=Hab2Y7QGalqPE2goa7n35/ptmbsjQKamPotE+CRJEZyZIH8Xf6WeLTeIpq8UEBPqzx
 gc7BmZiFiJUrqt01cvJ1AUwbiFTjse8W3+lYtYxNliunayZf+pvzoKoVobE7kQpaERiB
 M6nsW43QoG6y5+1AxtQo6qFC1e/82Rf4sp8s8MFgLSY35Y4z3RVPMWoZrQjSH8K61xOv
 cN4r70rKVF4YnBtUgz2yEhMmZOTgASEw6vklRuTw1UnAOemRpVh4jZyug4/Hk5D0lHro
 Qa342xCOP1oOYE7G4qRHcFQ5HJaTDbmou+JjE5+7vWHtIFpjSh3AnHnTArDBlMCEQ4/u
 xsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751872697; x=1752477497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MwoeSTJpY4ODDAS4aA0ss30O85XK3jU218ICr0rYzxc=;
 b=S8IqrtnB+O9scBSKN43Q6EuujK9zKzURIlVC5fH3aXbzUMtFLShd9kZnbaacLEZSk9
 xIIuc4D8obt3w+rhCLiV0NEIU0nm8i7MFWmgle+gMYrB7M2o+qxTu+uONklS6/3PTa9N
 iaXYsGaq0oQg4jbD1ScUuZRoFVYTKz5ALQBA33f3GG0JHH2558mnrTSyggnWyh9CNkyB
 vLt63UsA4+dPtlYyu6t5eJBKr26Yc/j4DQlx1IsHthoOyVrJrKmzKHhIS60vYe+jzSdX
 WFTHraCHF+7vg4c53bKa73NImNsBhSPjXqGfVkciCOrab8VOJApBhlrYTeVC3J8rB7mr
 gEvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXqjnXEtDrGHovHDbBPMcwak6qFx/cYh8d2DIjNfbQXfq8WrvrYbGaTgdmXURSLsZfJ1M=@lists.linux.it
X-Gm-Message-State: AOJu0YxQqFIcbn1fkUwMBmiQAzIfD2V6bcRSbFscLBQxuhgW7zwZNX8z
 iFUS/HR0nz20VJV8F/K/mUL3wBLeKhJfJyoG+8ovWqgZ3DQTJ+CXk8hyTf4sx9hNBRQ=
X-Gm-Gg: ASbGnctKYVnAx0pdT0nQU1zLV18couOWpgel+Er1BCpOB48NCMR1woGuV7A5omryP9d
 Sk5BGjP+rjEMBBdB4hsZHTIoQDtGwgJDQUXa9WdxT6/wmpe89MR6jAbmziXSiSqeN96PbkiTw82
 UMESczKlpDic3yDA/ljUygpDiUUvobySz2J432UgAPSPN7bNMNor2s1aIUNMxvMu99KHqUiYzko
 XRfMCWTBbBHmFNk7J2qZVHhWa7LGasOjeb1P82H1g+Zm+5J3F3iYXYzRiS4fEtk9b459EgEPC6F
 xFumpP4DaRHeQzwiHnQC/IgaU5KeA6ei4s4xzPJ4WWstx/h8yS+ac89IkjV3ZTl0sJoFHJDQ
X-Google-Smtp-Source: AGHT+IEQMjMy0bRrQB3o3WJAzd0XGSaPcW4MYh+TVosUKQL4tq6O5llnFQpUKI9A5ej8A8CgZB9raw==
X-Received: by 2002:a05:6402:358c:b0:602:a0:1f2c with SMTP id
 4fb4d7f45d1cf-60fd00846b6mr8614734a12.9.1751872696832; 
 Mon, 07 Jul 2025 00:18:16 -0700 (PDT)
Received: from [192.168.0.108] ([83.1.218.186])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fcb1f89d0sm5069572a12.63.2025.07.07.00.18.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 00:18:16 -0700 (PDT)
Message-ID: <853fc709-b1df-4d3f-a5d9-e11390c35368@suse.com>
Date: Mon, 7 Jul 2025 09:18:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250704-new-munmap04-v2-1-436c80df9646@suse.com>
Content-Language: en-US
In-Reply-To: <20250704-new-munmap04-v2-1-436c80df9646@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls: munmap: Add munmap04 to check ENOMEM
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

please take a look at the CI because we need some fallback definitions.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
