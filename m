Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E719FF8864
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777449581; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=tDaMA3614K8MP4sUjhagzlrDWxagUf3yO3V8wl7qWAE=;
 b=S458KBCHNvxydUOAnQp0eb1tG+CA9QiNf4qm7UN4DKh1IBkQtE60CXDW6wQHhHm7lB+Pd
 30wDBgIUm8S6h5mDoYfDTs+jqBd7lQm4bqkhaKgLsyTXa2QG0NO1w9DQqnE9rSHQxTCLc1p
 CvTfpTpCGsJBStdxZhWJGMmzmstZipI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD3583CA104
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:59:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BDD83C8CBD
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:59:18 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AED4C1400DB9
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:59:17 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso65967315e9.3
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777449557; x=1778054357; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=S6N788w6xzRpzC49Ja+pNfIqt4wYUX0s59qMBZ2vdZw=;
 b=PmU5dpXFKDX4gJCOzHfwUh5Q2zfVyFEsWJuXkO+kjFdqqWW8RMN2/KRGHfsz+JQM7Z
 BIX2k4qHCJvdbI1DFKr3pn8O/LVlSU04OR01sEGr9Ozt4gsFz4mz2skuN3x1ffyxo3gI
 QFXUEqHazblco1UXVV2zEt+RGJ3+PSbTpwBTmkmvvozmOrHcQ93ckyXhP3w8j15/RFHD
 pQQoWVdBFg1f4Mc6nv6UtS6NS2EGTExqcCBE/yzYHzw4EBWFU6R1+YxbPvIWkcVL3KgK
 oRuzLZoYQ/x9DcJueaFVvInOccRrOdFoQ6AfzEmxZjYwIvtH6vY02yRgmp20rOmNUyrP
 t6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777449557; x=1778054357;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6N788w6xzRpzC49Ja+pNfIqt4wYUX0s59qMBZ2vdZw=;
 b=O4Ko8pzpRQyCC+6IDO46t1OLJtdtPPB9JQs68TwIUdrNwnc4WFc7unoOrDcDD24lGL
 vfwuo9cj/icDBBCfTGWPAVPY3mDkQW5JqX3750mVfFjts1V1/YaU9+4u43rzcDLTCWhP
 zMaHNFj1V+EBNVmPvD79MR5FsDpW3nydAJ07UvWP4tYZyX08yzpgJE9YGIAxcYIZQheF
 wtpdtPyvYOM8YwkqE8qojn0QjXuTQVaZM17xHBC5jbDCk+bhqz9w5QfxnjZvvAzQU91z
 KYc3xkT1eLhGQvocy+Bob1SidUPpoVDctNskzCdwb5tGII+8u0xXh0ZEcrEQhEOtBine
 /Ifg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qCqAZMfoUD9IrEQK2m4Vq1gK2bu9HKxPoyrvbkJxD4crf1rdu7EEfa+5Un5fkv6bWBNM=@lists.linux.it
X-Gm-Message-State: AOJu0Yx7IzChpFTQxQly41S3vWZMvDCL5YRN7MkAUEIee3m2vr4EhvVR
 XRvjSglNVtO5M/nYI2vypnMH6THh0K6BjEeDQxsv5i8/XG5sANigSQisi56wK1Zw9+c=
X-Gm-Gg: AeBDievO68xBk/93dhLBk10TGCdnHh9D+uqAqBFLUtGxeqp7qVD3RKmOAZFo8zfJjNl
 rk7jswsbd5WN+U0IVChnSgJauAWBze/PMCm16ncmDJ2ajgtIB3IMj70Gptko1RjbY1w5/dPKlSB
 /U8Nkg2kremvRXB9PgigDSlTE7AyO0x4rXkfHUwQ/6r1ybU4JscOATYXGk64A51QTFi8KgERGDU
 w3QdR+cYB6sUXb0dYGguFZxUU656S4aVRQZVIqW4IAKHvtkt61OFYE3sahcLEV/cJjqzD08t2YM
 lXEmzxLZtV+NVbx4NFYxyWLxSSDm5PDCdTk3seS8fUrw7Y2zrcgCYhrtO1DBOUxI0ytgGiEB1B3
 8wQ2Vi/ZMjg4/N7a4Yn6Mz2wspoHd0616nzR4P+Cg8TztpNs7aautBWTHLzRA0y1W6Ru8naiIvk
 +4cfh5fa6PyAm0tPKB2A0B3UTWLM1aqHv68EaQCzra4RxK3hHmGpEkLI64ztWydO2drl+f77r7V
 r/9dMG25pa+2786aEcUD3oggaXdaeA7UTtR3DfNvl8R4yKoF3wpBk1aJUYyicd2WFHy5M1//93h
 1f1Up7MhXe4j
X-Received: by 2002:a05:600c:1d1a:b0:489:fec9:a17e with SMTP id
 5b1f17b1804b1-48a77af1953mr97156815e9.12.1777449557086; 
 Wed, 29 Apr 2026 00:59:17 -0700 (PDT)
Received: from p200300ef2f4fc90003f4f7286cdeff7d.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e60b0sm3917130f8f.31.2026.04.29.00.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 00:59:16 -0700 (PDT)
Message-ID: <69f1ba54.df0a0220.24022a.9d3c@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260429075347.GB968839@pevik>
Date: Wed, 29 Apr 2026 07:59:16 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] clock_settime: use POSIX runtime detection for
 CLOCK_MONOTONIC
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Function with this warning could be in include/clock.h as well, because that
> will be needed for nanosleep tests. But you can postpone it to nanosleep
> changes.

I can do it here, no problem.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
