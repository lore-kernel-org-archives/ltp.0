Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A21DD35690
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 09:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769591610; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=RZhYZvkXO9JkiBREJfgZOsuG5Z/8ZuSvQyIHSYqN/l0=;
 b=mhKpstDQ6Y+BmnxRKbtQcxnPoVx8IhaivyWeiADLJXPwvM+8zDmKHVg/znXwFw8whXzHX
 J6JVTf7mU1CRiFJ1EmtAMJ2M2OOQqUBVMB7YxPy+J4oUUDluG6g9FkyGOedaE57wKXiLMBZ
 pCfORr7pE0B0v3ZoNGkQuJCAkrfFQ8g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE6DE3CAE57
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 10:13:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DBD63CAB8E
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 10:13:04 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EF6601A0099C
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 10:13:03 +0100 (CET)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b883787268fso1030505566b.3
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 01:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769591583; x=1770196383; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efu4hvABevJqFsYb0mYwMDPDt8yWBiywpFh3DWazL7s=;
 b=T0ESlOBDtH3ziwqcDWwmGK5nXt5ywmBnbbsgB/6SF8+C4PuM2kSQdp5VpbtdvUoh9U
 ZmzTDUNCNqfbqk/MEuIaVJNG4jrwzuMUmRyrQlRHNaca6Ulo9UmHPDBymK1/uOyC8YdY
 TI27uxIV4+Zlm7SXf2kpl7IrCTBYpCdrIYZ3pcw1u4NVLX+KNa1S5nkcNgOEp1J2w5Up
 z1Y8sDcGdDMwpbSoBTkejp8bZtAGKeS0sk9Epow+0KBXzy6tCd4fw3ScN281riDj/rNg
 Dgy0YwUKxK0KhMFy3qKiwEe5K2THPlp9ZX0hUN64y4KTADZA9VSAcHi5e42Eb14rmn5s
 zoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769591583; x=1770196383;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=efu4hvABevJqFsYb0mYwMDPDt8yWBiywpFh3DWazL7s=;
 b=KPP+4v/6GUEt4/anPy0jUzT9hymr09xX2tWp20oSV17tbri0mpBnqoc6Wxl6J5g46T
 KifjhpU+CAUV7F40mD/d2Cwxa5RN4qIg7t/JcvhizL/no2wRjJCR9+89W5czz6Nd8RZh
 5qIPKzgLK3538TzcNG3JyfjXyXdP46vKLj/h03l7NfCyz+ZRmYeDdbEYycMmRBLHdRub
 O3tck+5HPkwrVKnKUnv0Q/9cXAGhJu9wJKBE1gM5jl2Z5AcRjxPrRjR9yA0UJoiI6phT
 Ibezjxkrzjl+HvmKdLoGiNkLp2qVe35JcrAS2naG7ovLyoJNpyTkiKU5sKam5gjHGZfp
 hKLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1ZHqgYqdH5HLKukkZey9fddOEkuSeQ57Bv3aDtO7a8sVMXlMyoOyXTW2pxoR5nzp9LZM=@lists.linux.it
X-Gm-Message-State: AOJu0YxvbBsXx2Zs4/qhhNtSSs2kELRcenqMOj7doQ+Fg+y2BqVEufR2
 AOnVtDkS1iv0fNodJ+wkWj/2a5cPdkCHRcAmuo6Ix/OVwz5iVh+hnbor9zh3uQ8ZwvPalIRsmGI
 5zQemnlE=
X-Gm-Gg: AZuq6aLjvsExDc2j7w2Hge9e7Jnaxa18EVk7ZuOYhK/QMoTzzFYcvsXslow9X98w4od
 OaFWg//uE1QemxKfuUqNLbrRnLqoOF0Jck5AnotjpO2SZaHLd5bXU1S9EPQZcmLpyinOON2N6wo
 SUZHgQ9G3oCkr8FnS7Jfq73s095B3gfZivwW4pC55OjdhVQEtFxAum99Ms+J9OWDp2pyweGcfd6
 3fqjSbmPjACCxzyGacQeXvSyBz6UaTvWMq6Zryae89oFrrEswtjrKlm6E2Kv4iu/7hZdSd5Q3Rp
 Q75j+2wQz/Bxi6Ee/9jotp/gyUK3qkba/ijlRLUmC1EK2W2/DQENxycCfj+3wgfQgUAdo/HCYtl
 R/7sqcJ8cvIGALMHFHOlilxvrxTKxV6lcKA9yWcrqtgm5AW4uxEnz8DQ7bDuMHAAZ2k4GyxgJyc
 7GWZdGPNLH97p6WT1NRu8NVqiHrkaQaE5HWDt4kdtd9RWYb0j9Fe2YxooHLal5jIpj3wtb3g+LT
 cEpxesINtQ6oLSZVw==
X-Received: by 2002:a17:907:720b:b0:b8a:f946:f7c8 with SMTP id
 a640c23a62f3a-b8dab1b52a7mr324777766b.17.1769591583161; 
 Wed, 28 Jan 2026 01:13:03 -0800 (PST)
Received: from localhost
 (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de.
 [2003:ef:2f16:4900:1c62:6999:955e:52c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbf1baa42sm101679066b.46.2026.01.28.01.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 01:13:02 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 28 Jan 2026 10:13:01 +0100
Message-Id: <DG03V1ZOO5Z5.2R0ON903EMW93@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <aWjZX0fsrTJMqq49@yuki.lan>
In-Reply-To: <aWjZX0fsrTJMqq49@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preprations
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Thu Jan 15, 2026 at 1:11 PM CET, Cyril Hrubis wrote:
> Hi!
> It's about we start to prepare for the January release. We have roughly
> a week for getting in all patches that should go in. So if there is
> anything that should be reviewed please point it out ASAP.
>
> As for me I'm going to (hopefully) finalize the ground rules patch and
> send another version today.

There's one more thing to do and it's to push a new version of kirk a
minor fix. LTP should update it accordingly.

I didn't see any issue with kirk so far, so we should do this now before
the release, WDYT?

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
