Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3E8C79F9E
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 06:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788763260; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Z6B1ARxKj8reYcVFfil1FP3O3YuCH6J8lZvJlJLggKI=;
 b=EJV91IEFPFlMMqqoUOdwxz9Iw9DRugL8vqkjviEo5UfIQzPtf7k7vWvYKT/AjN3NXwPDi
 Ou6iEVaBddW3eY2GyeupDoo8GMJ9RpP3y3X+6BiFqUqv+vFCusMkv/cYlK8p+YFY1UttoK3
 wFngU7firCW/FrpolMJ/0oe1E5DX3JY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 761A93C56F4
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 08:41:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57E853C56F4
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 08:40:39 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 42990600209
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 08:40:39 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso30661585e9.0
 for <ltp@lists.linux.it>; Sun, 06 Sep 2026 23:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788763239; x=1789368039; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Vb0c5qq1PXGyCNRVErNFOm8uokPOMUuL/XhxMc+nNK4=;
 b=SwyJiFUBs4je8zCGMF3khXp4J1AWVlmws/T+MdNyQgbJpmQulnS+3ghqg4O/v9HtaR
 pjtQnTboQbS1A8uMXqL/5fFSNwSstE5J2n0vheXLxQGXBgp397DDAWYidiTyzPqX78kv
 TX4UbLv17P0euqerDb1kZZPiCZzmyaWORnqYh3xIsi4PbMeUgs8Ttkov0o/HDEfgk59x
 FItGN0r0q05xmZ/6HzLlSMJl+D3vbL+qSSoqGaGzKW1B9L+N6YyVj1R543vUCLSK9O+C
 753A6sBH2HBPxaSxAy2oFhp/BXbi2m/XTlrP14wPuoeX2FZKp4ZTBbQIjWmm2tO+WjYK
 qBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763239; x=1789368039;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vb0c5qq1PXGyCNRVErNFOm8uokPOMUuL/XhxMc+nNK4=;
 b=dSuu913ISCeuMVOUO8NeoUbGqJN1Vkdt5dfZ3EQA3guG8TymdJHOjxGrmoQUG3UZMe
 B08tiFsB9MD/vR9IIz6QVh4dDukKFp/aqEGILvcN8oJJ/4ir4Eyb/aGh4wYjpFpw3trb
 DYcF8K4UZZqA3KZ+hc44ZF/bBtaRyCIwtB0yXMf8P4TWHTeTbO60C8J7Pkh4gI/YovwT
 xCKKzPjJQP6qmkahuGZ4VzYF1+ArA8kPvHx6w9UjK3eSn8/jvd80c0COangLDZb6mpAB
 gBTLQL1BP/sw0tag7KQZzHWpo+MsQ42c2baoh4lVbSdD9P9qsMj5UB6LA9CudFSALEj2
 TVnA==
X-Gm-Message-State: AFuF++le1FbKrZZv6oO4x/ktuZ0i7vOsvCwtDMtOX3m4ovd8KpBwZVs8
 S0N+wcqRhoYETXN0YzQoeAOL/JSBm0G/LScIDaM1TfVgiIX3Y9iiJeKZGUKsSYnc4P2fcjfLqZY
 aRhNnGWzUMw==
X-Gm-Gg: AYBFou0yQFzPSqrKU0wMgrlp67qxqxuAaf1uNheH4SoJRUJt1M/aNXV+I3J0XjOjXiD
 KVVXw4GebcdNQOv4/V/Q7IZ09HWnT36bnKC2Pw7w/AezrTFcju28d8Y9nX1JFfZXtUWkFQu7Grc
 +upUNLLcI6dQ/vVDJigusj004HoSgQnKGjRESJjBalSKe6LGh4/rlQrWuW40p1LWd8LYzpjWOhP
 UbPlyRF9wa1G056CO1nv96gCvWGKiyMluR78VKA6WCm5D9qqO+y+sc8sntl+svG0kbevr0kzadG
 /LXSFTI/Rnkx6OHP5EKA9OhLk93RUboJpclFofXUvTpwUuWsYo3eKHdTvBProDAqxHUDHkzZ/94
 PlSIB08enogQo9s7gUjzjAgqsgP3rSvZTSbT0JYIqlFxcUvJfDi4QFPUQ+ovLGOV4kpT9nlEjCj
 DAzqLbfIDXMSRg603UoxdBD70pBi9fyamXQbe3HAQIuiawS4R2aP/Wy0JGDecR0QkNwE50gInBH
 TxtCSp9vU1IsTruDmhu44Cf7XO8PHlvfG3kkGKlcICUt0CkWNXA3NmMF3tAFkdVvxdpKkNXV63Z
 Swh7Mw==
X-Received: by 2002:a05:600c:1d07:b0:49c:f13e:e4d with SMTP id
 5b1f17b1804b1-49cf86f4fe4mr188510145e9.10.1788763238607; 
 Sun, 06 Sep 2026 23:40:38 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfd3f8192sm246735915e9.3.2026.09.06.23.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:40:38 -0700 (PDT)
Message-ID: <6a9e5c66.5d733ffd.75e90.a101@mx.google.com>
To: "Michael Menasherov" <mmenashe@redhat.com>
In-Reply-To: <20260906135650.52112-1-mmenashe@redhat.com>
Date: Mon, 07 Sep 2026 06:40:37 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] read_all: Fix buffer too small for long paths
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

>  #define QUEUE_SIZE 16384
> -#define BUFFER_SIZE 1024
> +#define BUFFER_SIZE 4096

better to use PATH_MAX here and make sure that when we create a path,
PATH_MAX is always preserved as the maximum size of the strings.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
