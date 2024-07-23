Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5DDC3DA49
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721747879; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=5F88YHl7+KwxsXZz70w/RNyTc1t0CIteIe21czZuoEU=;
 b=akJWCePzSnJ0ZOLqHg3pgtUhTcgcx4Cv+O1yFMPCOoi8LccsMC04wjMgsG8HET1asMQRD
 fPZ6ZSkobUeAWzFHa8pgssh/mY7zWe1lP02FOhpbUZUnCRAdNVPBW4Zd1riPbItYNftTvPI
 r4wPJkZdOBExTiJBmKCTWWfDR/y4rQw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 150C43D1BFA
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 17:17:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 731683D1BEE
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 17:17:37 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B31361A00F5A
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 17:17:36 +0200 (CEST)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0468so76507541fa.0
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1721747856; x=1722352656; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fH4h+lXcp/lVrklr1OnojksddnIIQnGbi6JhyevSS/4=;
 b=ecA5V+mwF3/0/2c/5Y9lNMCWaeH+0jnEPghfsVpHIMC6IqMCbNPHS53ZvsK8ySRkiT
 XJSVyhDmmO0wdq5oYqeI8Wac8VnEahSS+aeyzIkjikh4NySenXi7YWxKAt+hHUmDDg6v
 nFd8YeiBYs4JJscWrwXJGObCdOlEnncItp+/ePGRJZlnMpCP1SKVXxUrFXHPo8OYNr0E
 5pUZXjfwOvk42j5T1XTZy7eMMazSc0zHXWaEdNW5DJmbNr8h+MTsZcYB11z0x+6wM6gC
 HOLRlQWugCoFCvdjABrXO4JD6Ib40XELeoEqtTgZlbdKCMFOfxNHK+5NgtbDH3WEpYBH
 0Reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721747856; x=1722352656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fH4h+lXcp/lVrklr1OnojksddnIIQnGbi6JhyevSS/4=;
 b=QyQWi8UJo8l16AgEbKbTJ/P9ltURqHsUHKqJaw4YnMj9yH2L8Pu9HAZNADpgog3Lr1
 VEyJ0v/m7fuBk8qEf0hqJargsFsUGRrvhVejoLAqxpJhi/8BSMqSxlvD8Y/U8h9LbJcm
 3oo2Sd0qbUpK0W2Hy+4K6rJWtz2kdfjo5+1GuMI+v1M4DJIPv8YpywyhLOjre3mOtbzB
 u854WnKPrT7pCctmHvnFmAIG+6O1N1HNtlS1QU3zQiUhaB1Ugu3zd0Zw7XM3a7ynPU01
 exzeDtFbu88uN2ntZrJwHEEd/tvLlAm6SNKkiFfdV7P1tlwqwJXJ7+74wRumMgFswcZA
 pyBg==
X-Gm-Message-State: AOJu0YypYsdA0e6vjvzA1WXxuMA9eMixt/kKfuyr6UAgIVh6e7qKyMmn
 nKoSJCoXmq7WB/iVSZY22cOdK5nGXsOmO8WgppXu7TAklJNSZxpUhWln80GtIov6zW0gzldBwkh
 T+GU=
X-Google-Smtp-Source: AGHT+IFW3uqhT+ttFQeycMawZRv3WERU1y9Dor4gSNZ6NdtY1H3RfU5NnO2D3q88HPn5hTldZXZQJQ==
X-Received: by 2002:a2e:240f:0:b0:2f0:2833:efaa with SMTP id
 38308e7fff4ca-2f02b74725fmr1480701fa.25.1721747855110; 
 Tue, 23 Jul 2024 08:17:35 -0700 (PDT)
Received: from [10.232.133.77] ([88.128.88.131])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c2f8c10sm7717958a12.76.2024.07.23.08.17.34
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 08:17:34 -0700 (PDT)
Message-ID: <205c3123-be3b-41e5-adf3-3458bee9ec89@suse.com>
Date: Tue, 23 Jul 2024 17:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240712134412.30853-1-chrubis@suse.cz>
 <20240717082547.GA584952@pevik> <20240717083116.GA587967@pevik>
 <20240722130651.GA857641@pevik> <Zp5aPZZikKndIqgi@yuki>
Content-Language: en-US
In-Reply-To: <Zp5aPZZikKndIqgi@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add tst_tmpdir_path() and tst_tmpdir_mkpath()
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

On 7/22/24 15:10, Cyril Hrubis wrote:
> Hi!
>> merged with tiny documentation format fixes we discussed.
> Thanks a lot.
>
I had a strange SEGFAULT when .needs_tmpdir is not defined. Are you sure 
the feature is correctly working in that case? TCONF should be expected 
in that case.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
