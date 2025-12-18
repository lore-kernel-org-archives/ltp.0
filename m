Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBF2D6ACF5
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 12:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766061612; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=CLzOgfoyyHmAq/lToUGOficscMhMoLa9FeDNzw89Vmg=;
 b=cqWAYYiLd4p/eBQbaWokSGfyXcuyFft7t6BoGmw69NKWsgqFmFfTCROoK4DlUzytnVe6/
 yTIiazh0w3hfRTuptXSEqbaxnvlXFTdO73XPU3k++S1oAoy4QOXbYVkRmrUaW45RJfom1eu
 yTpuorF5rOlvcgnxKY5/S4o7TA11BpQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B6EB3CFA8A
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 13:40:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0F783CBEC7
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 13:39:48 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3640C1400F2B
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 13:39:47 +0100 (CET)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so137330766b.2
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 04:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766061586; x=1766666386; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KL8kiT/GYI+SqCKoMg5rZNjZubuxjWLioDH11xNSE08=;
 b=I1j81/c6qkFuiJO0Ou9+DaV8GpqeH+Lt/bSx9bpc59+kgmyKidhlPKOOB+/Iughw26
 dkp63OXOCGTTxcQ/pcSY0y+a0JbCaH3gem7mjWMSG1kjUgr3b/YRH9qo5urOIr0xxprq
 960XtPWjNQexQoGpiROqRokkN57gzCL9jlFlhzcYpRs8QLRjdtanRj9ByHPRI9yZ/12X
 xUktqJqr9nfeUf6g5UgyodGtfZEDZPVWqSWFlW6Yc2gKN7UyIA9qWCwsi9VY/jkl0vkW
 Lx3Ek63q5pZd9pr5F3sKy46Pafc3+BJwgQNAnlph50Y0q1C5E7L5icuX5WqHUqVNQNvZ
 rAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766061586; x=1766666386;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KL8kiT/GYI+SqCKoMg5rZNjZubuxjWLioDH11xNSE08=;
 b=ZybF4W2Lv75lqI3fpDJ35MCK1J2dpyzArYfW3cuh7jvYHYk9r5p+QJ/8ywXm7swxfV
 KAdVF/LcwHu2wzZ0FNCC6BRRnbhi2WKQ7OEp94EUDaW1DJdg6xze+Vz5weMBVRGtDrAm
 cEl9shz58Uwz6pTp29MPLWhjfZ45JLlwiRwCq8aVs5KzjH0RY+UrUojdZ64jdNfK45/2
 NetUyE9vPJJGHsLgtgTwVTUir/JbfqI2FgyyCB95IpX8zFMeyH3Y0vL8oXUykgWmwmo5
 I/QqVW62sfmSR4nZNR1au9prX5kcdTeWEtM5vWIYMuZG2c0xN1w9GnLVUVrVIweA6cYk
 FHYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5c3c8UAj23HgVXKnDIU7jIc8nazpBhPhJLhZnQYgcFy7gjVh0q4gjhRk4xsDjfeT0pqk=@lists.linux.it
X-Gm-Message-State: AOJu0Yyee18DtBWVT00vM1GlkCxogQ1thKLN67ShcZx6fsSiG7ai6HDi
 xdB+AN0pzcLDmqchLtx9J4LvZwJNECIk6CuSRNzeGYqePzWyr89cKzkIYMyMUKZBzZs=
X-Gm-Gg: AY/fxX6qPxUbcLLMqBSaTr9CoGKcLiG8H52BVVKirHFb+w1rKx5suNsFlcQsGR8KUuA
 uWGwoYFbt/9eALdde/gWwi7MBoon1M1V6P/aQqsfexEaWNm/CXko63ZK4VPN3Yh27AjVT5lxPat
 cOO/aPGUAb11ET26AG964wKKmo8X9WDy9QTE/RwClwFAbMA4zliYnguVYvBlkhBnLIhLNg5Zh0S
 go4F45mS6C+bKPEvcoECIa7RGS017PTm3DRrCemWi9sPCOEformWB5HKftCG0eolAAGg2pVw8hY
 zYKvGbLB3oZXmUunoNLEMrxc15JWIlC8aePukpwgsV6YqzQsPjx8/dk9oq1a1+Rz+pa/+tLeJZV
 GyjMYB7ivoJTXy1q9HGo4nhkatMxvag4luuJoCneHdgrHh96tNaAYNWIv04PgTv+NeYTuXXKakr
 IAVkmyfskBftLhSOopjQHWr5E9TQ==
X-Google-Smtp-Source: AGHT+IG1/O4XE5OSFJPsaizqM9rFceVInEdR0C6TPP8vwpEmzwah9cv5/OcLgpAj+mciATsLWxngjg==
X-Received: by 2002:a17:907:d94:b0:b79:cb08:30e with SMTP id
 a640c23a62f3a-b7d23a9c78dmr2285631366b.58.1766061586382; 
 Thu, 18 Dec 2025 04:39:46 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b80230d3779sm222362866b.20.2025.12.18.04.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 04:39:46 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 13:39:45 +0100
Message-Id: <DF1CKZZ341NH.2FBK1TT6JU5Y6@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20250225114418.2940134-1-pvorel@suse.cz>
In-Reply-To: <20250225114418.2940134-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] tst_test: Add $LTP_SINGLE_ITERATION to
 limit variant
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

I was re-checking this implementation and it looks a bit different than
what I was expecting. I probably misunderstood the first version.

I was wondering if it's possible to select a specific variant inside
the variants list, but this patch seems to start from the one we select
until the end.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
