Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBBDC3DA4A
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 12:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723118675; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=uA5es+Tt2TIszuXeNhAz0r8llgd5XhWKSp3nN08YkAk=;
 b=Jup7msctDCPtJBk3MM8gDg2vnQBNvWbVIfhyJluxq6/DVf6+l8XP0JlwMLqDjJJU6Ppm5
 jdXInUybZpdzoP9kGjP6IGd4v9JMu27amnF0P3fv/OvZisrldS8hoG8ZG2B2M43+uPvD65q
 z45dlGvao4TWMCy4g3UXZQkhSvQ2p7E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 765F33D20AA
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 14:04:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 374DD3D1CA3
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 14:04:13 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 244B3204B66
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 14:04:13 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6135eso1313201a12.0
 for <ltp@lists.linux.it>; Thu, 08 Aug 2024 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1723118652; x=1723723452; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2NOtcFTJYciQgyKfHZsnDcBvr/+WqAxhy31+p5ijsN4=;
 b=FQjRVOjAQLDxFELYRKga6O16ZWQKdpGq7CDOUD/JELG58wMzHTPlskeFXTM9ol7vDZ
 u3LWKyY4blQAlRweJKGk7llYRBVnksSUvi3Aa5eedNpdRZ049NBqVPMa2kHA+OFmiFfP
 UCj7rnhscHrel3GnH3a29xhICyzJxCJzlCK+K4crzvCP3x0zBgxuK0QEo2paV1V378S4
 SRXo/XQREOLvoIZNpBhu8dWkSb8oIyfVK4WwkiwS/6egxPaxGLOo+bNekS56uydxkNgz
 XcQhuZ2mHHSk4r2l6juk/If9zqIEY3f7sa5VOVQGm6HTOqdEL5V3mNKM5SbMeEoOJRtS
 aJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723118652; x=1723723452;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2NOtcFTJYciQgyKfHZsnDcBvr/+WqAxhy31+p5ijsN4=;
 b=TG3AxVROVdE789L+dSpF+i+o0B/aTqUWLPK1ydDEUthYcfEyXyMEaLHoFUCewkXLax
 1FDZ7PIfoXuPfCL7cOisri3B2L33MimlN4NAfKdk1nbeVCn0wNOLteEX1Ct3NA7jQPuM
 ZfCS6nkx58dxd+P97A0XyGzwyjCumXrfNSU2zY17/q8ZK/mQbeS0OtVprDpc6UIxQm/K
 ixFSV3SU4GhuGbasmmXLAdyG54b7ognmdNLs/KY4CjUvlDb76OURTFkb4JhaSE16sU5K
 UaY+3a5BpJ0GcZ57wzH9zXR9QINZ9N0W3xYrJNNvPItIDWvcoOJsi4b6AEV8IJEPg9qH
 odVw==
X-Gm-Message-State: AOJu0YyeAHQKCQXxitM9GW/b6ROJCFS5cIA+BOq91Up1ZHQq+4h4aHAG
 QsjNR/F6MLKxZLShZwl5ir8bIfWvkPTj9ckPk1kIh6ADH9fqVoRrbeMZZHc9SFo=
X-Google-Smtp-Source: AGHT+IErH3YBRfMMELlkjgybkSmybuTFPc21yQAcutJTUVxKagl8ji5ozUonp+sQbtNFRh329wJgJw==
X-Received: by 2002:a17:907:d14:b0:a7d:2772:6d5f with SMTP id
 a640c23a62f3a-a8091f8660dmr149537866b.23.1723118651859; 
 Thu, 08 Aug 2024 05:04:11 -0700 (PDT)
Received: from [10.232.133.106] ([88.128.88.142])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e842bfsm736749566b.181.2024.08.08.05.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 05:04:11 -0700 (PDT)
Message-ID: <a1093e17-fcaa-44ba-b561-2989df9210ff@suse.com>
Date: Thu, 8 Aug 2024 14:04:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240801-landlock-v5-0-663d7383b335@suse.com>
 <20240801-landlock-v5-3-663d7383b335@suse.com>
 <20240808095824.GC327665@pevik>
Content-Language: en-US
In-Reply-To: <20240808095824.GC327665@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/6] Disable kernel version check in landlock
 tests
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
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

I send 1 more patch to fix all tests removing CONFIG_SECURITY_LANDLOCK=y

Regards,
Andrea

On 8/8/24 11:58, Petr Vorel wrote:
> Hi Andrea,
>
>> The reason why we remove kernel version check is that we use
>> verify_landlock_is_enabled() function in order to check if landlock is
>> present in the system. This is really helpful when landlock support has
>> been backported into old kernels.
> Great, I'm glad you removed it from all landlock tests. It really did not make
> sense to guard correct version with 3 guards (kernel version, kernel config and
> ABI). Could you please remove also CONFIG_SECURITY_LANDLOCK=y, because you
> check EOPNOTSUPP in verify_landlock_is_enabled().
>
> Anyway, feel free to merge these first 3 patches (ideally remove also
> CONFIG_SECURITY_LANDLOCK=y before merge).
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
