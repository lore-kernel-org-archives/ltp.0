Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188B1C5AD49
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 10:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748947987; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=laKP2/rMX2GJmV5Es+zRZamSapPvfokTMtUVCeHcsjQ=;
 b=R3OknspHD9/s/HPRi0hYkp1Q5RqpXokaqMs7XKu0jtej4sGOQDiX03852VasQP4dguhyp
 buSp2TyBAAxTfJeggxOpPtUl5Ohg5FKeh2SNl0NO5dbsjGqqX3xpurzqtsUYR95shndWh1n
 vHj/kmQuaeyJCVqXBS9wWd1R+/1DHm0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 105503C9F92
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 12:53:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61C8F3C9E90
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 12:52:44 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6427720074B
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 12:52:44 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a35c894313so4915327f8f.2
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 03:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748947964; x=1749552764; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qQhKqsigHBrH6hD1XTBDo5NmDt/JHXdTOE6pZESIJEA=;
 b=d/IKxhbvs+h0t8K2zsKoweH21A1KmHbm8B+ndHh1WIV33E7kLP/yTKHTlyVri97aVY
 R6vqMI+ugJ6dQzx8IOC12Cw+CpNf9IWTikwx9mYJQPMLV23NQNP4uksK0IYMgiJHJWBW
 HHCfcxmQpgn/SdhxgB3aTCo2SNRwvxBPrMS3XOM0f3dOyhm9ovGOrumjf1nvPt+rSoT9
 9eKLscpnDItCAlNNLOMb+joXDVVH6LgaUMImzr1W+hTa8JGkF4id5x5AZzT7IKheA1Tp
 IkJ8r9HoinV5uCvBVmgcGUflzCGOHmQtRNetTpYhTGcLl3uVJzoWhDH+pEh1pS624fPU
 kh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748947964; x=1749552764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qQhKqsigHBrH6hD1XTBDo5NmDt/JHXdTOE6pZESIJEA=;
 b=JcwxUTcWHwe+oRMaj2YapYg0Z6dLkQ0lJacL+ynZM4ARZ4aEVM3P0lKDjo895ivYoy
 BaZKFyAWrmpXt36uNr0OHKFa2OvOzQTqFIiYudBg6hRnhfQu2ctcPFLWGDJBu6kTvG70
 tkJXBQ/SzkEejjgdyCtoe6NjvbTVnRHgymoQn8Ph6Fi42FzD2C1VEkRsgSMmr2HSV7JP
 WQTqK5wZAPy/K9/f/h2bGtclEZgAVzz1+xB3rPrsfuczWoMUrx8GR8meHAtBAfxI8yzW
 e/24IivAR499I7JPXZoPf6nsNF1E+IBkn27XgrkgEuMpL7yMOWhKRjekk3AzjkjumrEi
 GXdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz/KY8LchD4RElYx/mpwoLKFVeQBNHdntDmI2fjBG5Ap+Rwv3HXzc1eC8acJGWb3E0Oc4=@lists.linux.it
X-Gm-Message-State: AOJu0YwzIjiLAmCAdxgJrwcT1/BQ9W8GGX1m8VYP5TiJIC5UO2QGEvMh
 cI9/f+tDQNq82H21dYWMEWeiEXJo0JGGHYjfuszb0gN8cIoq+nYYjOx8Eh/FzXMW2Yfgf+6j03l
 n6CzQ
X-Gm-Gg: ASbGncvzZGKhKv9Do2CweseigpmhOKyq4z6G0rIOmOPW9k2SInrV2RF/cG3PeY3XiOl
 KVCJ+kQDLewtJYDA+U+f1qmd/Vi3t9lSo++LbiQyxN9kBFBzeRSHnyEp16iPFZtUdmzPNSjRcd1
 8bWXspEoJJVnFjDF1QoqdsK0ZSjGdQUg99dufBzcnVPZ99zn1Wft4EvplPs1wR9oqd8yuo90bKV
 omqIxXrEUVDzCEFZDFzk0EA2y9aqv86LsUu861oS45GCIcuKx3cwvgOTav0WrE43yCuPZtNiPmv
 uBDvPUh4Fmc3sBaC1Dk3uD0HQst2BoAc66wikG0tOShu6yXDM2Ia+ISedzxRQw==
X-Google-Smtp-Source: AGHT+IEaawHCNTOZgAKeWHjtrE3RX+xDqBId00hca+jqHFNY3Sqdm1IhKhThmg5uX1zu06C2nstJ/A==
X-Received: by 2002:a05:6000:420a:b0:3a4:dd16:b287 with SMTP id
 ffacd0b85a97d-3a4fe178e98mr7761661f8f.19.1748947963652; 
 Tue, 03 Jun 2025 03:52:43 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-235c99ea09esm10289275ad.226.2025.06.03.03.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 03:52:43 -0700 (PDT)
Message-ID: <eb3f93cf-e2eb-48c3-b468-efb920c15221@suse.com>
Date: Tue, 3 Jun 2025 12:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250602-lsm-v5-0-5c0dd01df3c4@suse.com>
Content-Language: en-US
In-Reply-To: <20250602-lsm-v5-0-5c0dd01df3c4@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 0/7] LSM testing suite
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

Merged thanks!

- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
