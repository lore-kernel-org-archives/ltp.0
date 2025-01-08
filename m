Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E74AE77188
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736326241; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=92sF07rQmyAG8XNfPc91hJaq4Fxo/4tenc2M6Hqtgis=;
 b=Hk6sinWgnWmdttfPNSyKefRE1/YBUfo8gDPP6Iqy/4Ph42e0XdMq8lTJEtOAKtyNRSQJE
 pZo6WmEJndQdvKL6a+bMEIHvyCL7tk+dLbAfKEYbPEZIWLT8/u0QjXpSe0Dte9BuD3eugts
 VTbLR33Mvgzvo2FdjTRQG3kGc7EjJKU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DDF33C1AE1
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 09:50:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5ADEB3C1997
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 09:50:20 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 98C591A09AF8
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 09:50:19 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436249df846so113829525e9.3
 for <ltp@lists.linux.it>; Wed, 08 Jan 2025 00:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736326219; x=1736931019; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZzP+H0Ny4SH+Jvs/Gvh4WcQm07h/gl9a1NCGLcDfkd8=;
 b=S7n0KjXvc2PyWbFt1k45xQEJN5Oh3VtCdVR6FrwnmfzVSglvLyzM8uwypjgcpYddap
 82KJwX/YUToJyIxGTORrCNMrrNxagtkV276rLtiNPie0Pec+XXFFz0cdPzqxfH6kBmHc
 xo9wqQ7kMNhGevuLcLbqh4okZcpdGdeYhLS4wrmKg8KOHZvG7gTrKr2rsDE1FJZeYSBM
 4zAW+ETQluRLpSxCqxo99HsAQQhxY+enJIowIrUqygqC643wAZxbPJs0cUS/bODkp/NO
 zVZJo6KNpP0Det7E+v8kHYrSMkmjERKR9hu4Gb2VlX8OXfMoSV5uS2Zpkl4B13j6/b9L
 LXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736326219; x=1736931019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZzP+H0Ny4SH+Jvs/Gvh4WcQm07h/gl9a1NCGLcDfkd8=;
 b=nEdMV6CMSQ8UQT695kNbAl0GC5sSpYjkwcXSKWZ0xmwdkyG6loCYqahHt24mWoHw83
 oGjTs89XmdTtc2ibFIC3jm1OQ/TAH+N49BVxXkPRffSmNxSJMBwevWVCzZBtYX6ybx5N
 prpmEz83czJmTfZGRhOYPQYShAilg9Ucf+V3rWTaqXcYbVq8Wtjevq+l5pmfCLgV5Ar3
 OGvBZiOeT4C+aZnMX7fXmAHDjEPlreiMfWWbAgUonbKD735m43XffD9548nd0ceV82r0
 x8aNDsRj//W4WeUo2ogA0Naf6lbVoYDRHjJ89XCJsqrtmOn0hZzJelRiBcAuptRx4HS/
 fenw==
X-Gm-Message-State: AOJu0YziCjH/hWPGe4DXIt505lUtlINfk5DE8fnEn2IT18vwKm+jHB6u
 wIqFc0G5WtFXBJoROv2os44/0RPyMoL8OAoh7DpllprrwPqoMKrYiQCH4/fjT34=
X-Gm-Gg: ASbGncstZqHFTRbsrqD6o8GszbIlXj0A6+ZXHJu7P/4ZEKFTV6LrOfD9sZGOH3+Urtg
 ZU616KCr/5v/7+BJt5XmHx19DmYd/UrNszaujj1ew52fPjffwQTnRoPDS1qjZf5QE90CSqgsZoQ
 84oKfHeRHoWEn0d4NSkLkhiwJP/gwC3f0t9xLOSS7O50KVkAOl+Fdyx5xOXWGGpqC1dnG1fO1xw
 /dkMqORl+AkmWmKKxTa/NilCNAGp8tzpGe2Uq9HkQeun/en8Sc3s9qIDlv0YxShWj2D30h0yRIU
 bl5NFxNNrCGEb0AyB6OuR3fKZwubSF8vzd2P8iMXVOjw/wpfPcm3kkLKpufd5O236i1yGynH+42
 TMKhcbhnak4Rigom3/jA=
X-Google-Smtp-Source: AGHT+IFPWluwBvAH/AWFUx8Swvhqi3Z/dq1JMEpPdgLllbdtaTEUsZ5tJcy99RGxj9tt8ftsUZ1XTw==
X-Received: by 2002:a5d:6d0d:0:b0:385:f1df:2502 with SMTP id
 ffacd0b85a97d-38a87308abemr1310868f8f.36.1736326218984; 
 Wed, 08 Jan 2025 00:50:18 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e03210sm13287205e9.34.2025.01.08.00.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 00:50:18 -0800 (PST)
Message-ID: <966d9130-f5a6-45cd-9617-9ce177cd6fae@suse.com>
Date: Wed, 8 Jan 2025 09:50:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
 <20241112-lsm-v1-7-e293a8d99cf6@suse.com> <20241218190334.GB75387@pevik>
Content-Language: en-US
In-Reply-To: <20241218190334.GB75387@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 7/7] Add lsm_set_self_attr01 test
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

Hi Petr,

On 12/18/24 20:03, Petr Vorel wrote:
> Hi Andrea,
>
>> Verify that lsm_set_self_attr syscall is raising errors when invalid
>> data is provided.
> As I wrote at 2nd patch [1], booting with lsm= breaks all but
> lsm_list_modules0[12].c. E.g. in this patch:
>
> # ./lsm_set_self_attr01
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_test.c:1893: TINFO: LTP version: 20240930-146-gccd20cd77
> tst_test.c:1897: TINFO: Tested kernel: 6.10.0-rc7-3.g92abc10-default #1 SMP PREEMPT_DYNAMIC Wed Jul 10 14:15:11 UTC 2024 (92abc10) x86_64
> tst_test.c:1728: TINFO: Timeout per run is 0h 00m 30s
> lsm_common.h:51: TINFO: selinux is running
> lsm_common.h:51: TINFO: apparmor is running
> lsm_common.h:51: TINFO: smack is running
> lsm_set_self_attr01.c:110: TBROK: Can't read LSM current attribute
>
> FYI lsm= bot parameter causes setup (at least on Tumbleweed kernel config):
> $ cat /sys/kernel/security/lsm
> lockdown,capability,ima,evm
Are you sure about it? In the logs I clearly see that selinux, apparmor 
and smack are running. The way this is checked is exactly by looking at 
the string coming from /sys/kernel/security/lsm
>
> Kind regards,
> Petr
>
> [2] https://lore.kernel.org/ltp/20241218185508.GA77804@pevik/
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
