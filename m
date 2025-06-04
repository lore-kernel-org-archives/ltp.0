Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70215C5B549
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749047830; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=3L9RcF6nzr6wudHvdqskcHbhH/v3ahK42QSObQyvvOY=;
 b=Kg3YmHx0Elk+5VNGqMzkpJHr5yLmCPoXaHu+2fVmSN5urk5D7euys7TtDMBQMK+oL6FRb
 wRgcyCo7HfE+/heYK8YLhNbOQ0Sy7RN7T+/Gb0bPe4uVcye7f4Npcg20e7xlis8s7efPgb/
 kH18a8+s4vOpIQk8c3EqgpiX2yT87n4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D930B3CA131
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 16:37:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C9703C91D9
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 16:36:49 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 471512005FE
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 16:36:48 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a366843fa6so3714245f8f.1
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749047807; x=1749652607; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kwiU9hDxSo5sq7MlxbVhw5eRLsl/syX0EfVbsXk1D6Q=;
 b=B7emzZ+i9t57jr8wS4C3Tp5ikGZCaS2k6SQKa5zoqgPHkgXfkOZnlRxKrHvHWQKEbS
 BlkGOA5Ft5xcoEByXvQ1qAIIGKcuapzoN2i/3pVl624Poyf1TSu2gXMNtD+uQNQcuG8D
 /Cnbw9CivKQ2CY1IXTtjz92inVOtJFR017HdHqjdddmOnKrGLFyHfHKy0fOyMsdm6hCy
 i8ytWkMLCwS7IpdlkMHBTmc4VNJxDaqvWQ/RykiHTBe7B/QyvDFY8g25gAZvNASWcBl4
 BWVefFX9P6Qz5m5SMbKQ66PgzwLtKvyfafdtejyLzAjxmpL9PZbwyvOox7Y/piZzFan7
 5mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749047807; x=1749652607;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kwiU9hDxSo5sq7MlxbVhw5eRLsl/syX0EfVbsXk1D6Q=;
 b=JQQKj3+Y7MY+8G/bQeQKC0tSQM9Hr0ZhoTslC5U9yUHUr4jwXa4Gxt04X14zFH4JwG
 Sn3q/lWlKXwCDP79rnrxC1RmD74u1TJ/+x1Y7SfRPxaJS7cNJAzaJcsldtYRt3+rXhog
 Ruhzc41bXSFHrWaqrZbe37idVDeV+fCjmNhfVKUhWrNgaUd1tEIrA8jC+RNfHm7Qc/D2
 1OqHRSyZ+nLI+QK5mJ6/hQsM8mccWw9BzehEVnjp6lMqZlcrRorq3gYFFeWOSw6Zx1tX
 0yGVQ0ZpMcE+dSRPn678F4nHnXoLVVFo2681mu9ijEMw37jQHqBKwqlB+I491MH1B/hH
 W28g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7FsNVVqLAbPha0pmp5IQ1FdDK6BcnrW8LqpD90FQgNFGo7rRV++9bPpQkqPxa5JR3JrE=@lists.linux.it
X-Gm-Message-State: AOJu0YzoZ6PTnNO+S0ZQKOA2ZPl54L69/N2RiLtUoaqNoV2wJoMIzzel
 NZrONQwe5TQc7aYOewt3xqNVkbe6uUD9vQ8XSS0WB3TAY/6Ui2Vbszf7+CAuDKyF+ZMhqHvdIAz
 tTtmP
X-Gm-Gg: ASbGncvfkZSshLIy7HQ5Wz0//p7rdadtRcoPHs8iKuDoOIZZ5oMLqDx9s5jjPA/mtKu
 pRVbCWEByUsKKBY/zj8KsOVtYYHXXZrSBEKPNDmpSdsyuwO/Y6H62uSVO2uobjy7Oj/MV2GlP7z
 +vwq4DbbloATAlCsNprcSfULYSMBHyCkpXSRlhgYYsa32By3LTG2qoVqCi68nwlsrnJK2jzsryn
 SS6HpY3rKKzMAjBJWhRj8dwGPCUEO2TOjNAFaHlxAo5wE912PIXw90HJ0MTN3/sJc7Dqfg4Q7dR
 kiP3G+nPhXQytPDbYplySiL12wkjFnnLj/BWt09EneUl0wdeBPa2U/Xi2PxELbJSqnj88rc/nbQ
 BJ1Z9/V9KTewOvSDD+O+sB0so6MLLVvDtgJ6K+v/ftI+L0MnnS/yDFuZ+iMJ2FLE+2po9kCrqAj
 wqkR+3Yegy6/EAEQ==
X-Google-Smtp-Source: AGHT+IFu4ZZ8LNtzgYXEZ4RVZ+CuxXRp+30YC77bciJa3dzRGHUYmIbXQs4QFP1b0iRXY4bp4RyRIA==
X-Received: by 2002:a05:6000:40c7:b0:3a4:eb0c:4087 with SMTP id
 ffacd0b85a97d-3a51d93450emr2434527f8f.25.1749047807577; 
 Wed, 04 Jun 2025 07:36:47 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb0654sm201268685e9.21.2025.06.04.07.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 07:36:47 -0700 (PDT)
Message-ID: <07d8ce3b-d1e1-40ae-b3ab-2b3db7ff9f35@suse.com>
Date: Wed, 4 Jun 2025 16:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250425-conversions-mknod-v4-0-222e0d2e7ef1@suse.com>
Content-Language: en-US
In-Reply-To: <20250425-conversions-mknod-v4-0-222e0d2e7ef1@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/8] syscalls/mknod: Refactor all tests
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

All patches look good to me. we should be able to merge them.

@Petr WDYT?


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
