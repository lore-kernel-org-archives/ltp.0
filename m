Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A7CC369DC
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 07:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745998188; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=xHP9MAcHdOcKaE+vceXrtMIJUzCnbbQI2mGMYBYTTRs=;
 b=LPCcF/FKHbo/NUvzNcv4fXMAUH8Q0g6Lb7xN3Bh7nKx3L4pYFUgeU54KvWor41t7OOa01
 CQsJ7q/JMvrMi2thPoOkwMaQUb6R3TXD+xE+sfhnMlBlLn3WBLUN4Wk5+lGK+/HSZLqeKhg
 cdqJjA2RTdNXnjhR/xcy0UGdYWeqVsI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A38E3CBC3E
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 09:29:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6B033CBB40
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 09:29:26 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E3248600629
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 09:29:24 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so7565514f8f.3
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745998164; x=1746602964; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uFHm8F+kUjVfMF7dRjBJuP6dkp6o85U44yL6wzwry38=;
 b=QyJWw6WZ2ET8ewHO5wTkPwKT3Rfjut9KSaZxvusMOx30v49OAFjK2R3rG5DG95g7L9
 LLB6+p1Uk11R+NwKaBXaidkhsxkuqsddY5uYOs8wbd50D3MAbZp5WjZdeo7Dhf6WQGpy
 6xAiCB7MkC+7ipIHiayyktsfGef+l8WRC0+meG8FuHXf5NMHkSs8uloCElPVSz0OpQx3
 MeCGcGRsD2bp62hhPT+aBpN14BdpgD4AwcGA8reWuFEPluyU89oFY/ig93qOxa/jC9ec
 mKDutBTc0C+0cFKTNpiXWNsiL80q5RpRQgq7zlQ1wljXwfP0sSoJvB0u5MOkpOnCEkGt
 QYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745998164; x=1746602964;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uFHm8F+kUjVfMF7dRjBJuP6dkp6o85U44yL6wzwry38=;
 b=bjflLQuNMT6dVng7ur2Ubod609py1r7SqmMQOIDWcV7yY/lIefM7sWg+EWREIg6ZTx
 5wrPMaLaEjI36rHZ1WoC9WJoFEBVobKMUtwKVwGlagylGCRzkk88VTZYM2E0lC3lJDwO
 IMuPr3I01D6Xt3No3v8btm9CHdcHb02TnbFO5hYUEE6dUqVJVOo4vyOPjOSEDM4EVi+q
 N39tJ8I4RIARsvm5co8A0U9CcRq/F4952woDxBvXFVcFsEa2J0ezIyT1Jc+Fdp8oCB6p
 48QFCiwm6av7ckNwc8+q807u9+vKFg36jrTaxlqD6erqO8cklR0Qtq4cOJD7G+pvUEbZ
 mP5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAne/4iGsJ499Fz/QKtsolDtRLZ1e9NkOCvcH0dxI6gqHB5lkLHJfitiw3r31yHBPz9mk=@lists.linux.it
X-Gm-Message-State: AOJu0YwJKL1LS9kapuBFIGf59mv9hutONN8bVeuBmRfzu7Fp+5ovl5DG
 hLsaGSwf763Ml8q503UTHrp9oWsWDEre21CzYEE1rRO6giAevsKLvHqsCEA3Eurcebg29/+Fq8O
 s
X-Gm-Gg: ASbGnculkq+3HdHPGsVlNyeojfNMJIhY1WRpEh00mOxbO6oHYESPqqcemoAhI5HQDSA
 FJmJ4SlhuTCFRp25r0xsZuvqwNlurf7DWVvrhKPh/yDjuWgTKdjmnSc9G8FGtffWeC3x+3DtNoQ
 C843e/uVTp13XKj4if2XwFpfjm7ClbWgvZLX8KI6nm/0bMBoOo8Jq7m3W5WRQgZRns+FNmfDt3h
 rBBEa5Abjc30QeYNod0ZpS8S42UJfmowvKBktfje/XefG9Xm4tHKMoPPki3edThRU3j4/r2Jrfm
 w7vxba1/HmeWNGB6pwuJS2Y8R0wLdAdEVTnGiGfI3Ocu1JPXS3rS0aWJlDmEpRIJknV0HZJA/k4
 24PiRRuQqPF5EUF75wTC5MbkKZnr/aj6b42XSl9Tn0MlBiWhjR6CKLIYrlTKP1ZDlR867HTUl+h
 WrEtc=
X-Google-Smtp-Source: AGHT+IHxLAWK96Zj/TbBvgNzgyj32dU+l5at0N+bott4D8awIHzZgtXpL+vD6vxj9sKG3mldun6TCg==
X-Received: by 2002:a05:6000:2401:b0:391:2bcc:11f2 with SMTP id
 ffacd0b85a97d-3a08f7525b3mr1710694f8f.1.1745998164386; 
 Wed, 30 Apr 2025 00:29:24 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da0dsm15851418f8f.88.2025.04.30.00.29.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 00:29:24 -0700 (PDT)
Message-ID: <725822be-fb0a-4e6c-9497-ef84dbec3412@suse.com>
Date: Wed, 30 Apr 2025 09:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jiaying.song.cn@windriver.com, ltp@lists.linux.it
References: <20250428073811.133441-1-jiaying.song.cn@windriver.com>
Content-Language: en-US
In-Reply-To: <20250428073811.133441-1-jiaying.song.cn@windriver.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/stime: Fix Time Overflow for 2038
 Problem on 32-bit Systems
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

I noticed that stime01 is equivalent to settimeofday01 when 
tst_variant=2. So I'm wondering if it makes sense to keep that variant, 
considering that it creates issues in 32bit systems. In my opinion, we 
should probably remove the usage of settimeofday inside stime01 and to 
keep settimeofday01 instead.

@Petr @Cyril WDYT?

Kind regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
