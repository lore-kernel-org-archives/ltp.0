Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A54DCDC165
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 11:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767700085; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=BPztn9bSrwq4LIk9dDq/CCrmMFitu/itbBvNJoR/Ey8=;
 b=PAk4JNf+CoYOBwNV0pFz0UM/TAORkIC8QoYIsko9mrvEDOCaXRqmkzZYBkU3bSWAsRqKb
 8zjurY7LHQ2bPZK5QWmVUoWJTr0kz0sdaGm9r2fM1PpnTLU6XJRNC2rtRdpkeGQcuQZsiE7
 zqnSawxeAvIRMJhs879NCu5vMvjQQNc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18DE83C1DC8
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 12:48:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 735DE3C0224
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 12:47:40 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 333101000487
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 12:47:40 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so401323f8f.3
 for <ltp@lists.linux.it>; Tue, 06 Jan 2026 03:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767700059; x=1768304859; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v09Swtn/TCu7iwVQKsl+pOSYbz0A9nQUAjpOO/MCIz8=;
 b=CpiycYJhPkqMff7vPSG9XVGlruvlvOlGFn0RPkAzisqxoMKfiZimT0B7q3pZbeYuiq
 oMM96GPKcEus8jp0kE/aoDHeTQZWuh+gu/rCEB9bSQRMGOcnqvsafnJ2EuVRFXwobpsv
 ag6ybxcpSeBCfb0qtjfFSZoY4tOAx+mPF1dfrFqAJPxoJesOsYy0iRFfctSSMuZhJgmG
 u9GKZIZK6RekJi3egZmOG49fmUSTJ4cHZwC/1Fipvz6Si0XTvdGGZgkaqIObMtQsdh4+
 yltXMUFutb6kfd8hnWTNDwkLt4gB5QBrSLlhy4n0uUikn0iAI+74EFjcWvqrz/bWAD9z
 YmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767700059; x=1768304859;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v09Swtn/TCu7iwVQKsl+pOSYbz0A9nQUAjpOO/MCIz8=;
 b=rcmWahi40Uj68QyymzomhXcsPPeY9xdirQVTtMcXyuXakRgKJi3j8X074wOdT6QXi5
 7AZQd4DN4x4aupZjlicn6v8WglraUYFOg0G3g7IWiLwvT1PQFrkAAS46FyZy7dPLI8o7
 CwiO6wcXorF1x4Fe5Y3j7Szlc5zxsVxbVBZ8+IwiEuJDi2Fn7xJtkd4aXdrl4lF6aYIG
 s+EwuWnSgQwTyKz6ULdUYfafkbW3n7Amxgzxd/fGStX6Ku7uOHwzbab1ELtj4n0hvTcU
 P58ezCt+gmNNW6yP1rKChrFtEoLxjCBk+xUJpJtshaFWd58Y9gXC0bsF89pv7RlFTmNB
 +/2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFG1WQbp5lHJOuqjBsatvDBcE6QXufAKW2GkVM7eUz0GUUcFbn4pSjM3unt8e71Aogl9U=@lists.linux.it
X-Gm-Message-State: AOJu0Yw90WH4PDojzRt59E2VgJPumlL88moai2yLcye7IKtsg731iuJy
 XTq5EW9bfYkK2ZgMrh3MMt5jMnr/zenZC0KAqbFMuF+lE1b22lHFyLhda767XHpQKcRlovWdVde
 l3RFIhIk=
X-Gm-Gg: AY/fxX6mFjcpInow14V9AmLsmD/g39SRVo14MlsYockTUMt1B75tioXenoeiMF7ztqo
 TEK8g/wS2fLqjrc7MEfBj/0JUP0whHXomiIIYYRWU54isya7oH1+/1KPTttWphN9hOxhm9yPBes
 m9QxZ3g/MM1aJMv3fhVQ6xH1nNsbUNDXpbqd78KnDthcN6WUVQ6sgMSs5R7aLhJZTPW1NV8c5IM
 5bxfWHGe/xfv9zQ6SQ8xjCGEnMDboTxue9P9hk+prIGqnc7rErArEOt6NReNeEBy/UFVd34WIAs
 v73pMFID4bc1Lr03mqx6IOOvHN8RjCUYPvDv0xJIz62L7+4cMXaEE1EkwDjuT3LbmrNoDrg6KsD
 ufw6gAyqW5ucYTi5P20pu3GrD/T2uwCG1uJSMF+xDDO/L62G5HpjpasuszECAj9shZROpde6s6R
 EH2vklNrHcSUoP
X-Google-Smtp-Source: AGHT+IEgzVgHTvpkMTIAyW6sHYdpU468Pt3q5zfvsxHBRdnKv2jyO41BztmEUWHrjwVzoDV9zKZKsw==
X-Received: by 2002:a05:6000:228a:b0:431:1d4:3a8f with SMTP id
 ffacd0b85a97d-432bca53d2fmr4166527f8f.47.1767700059368; 
 Tue, 06 Jan 2026 03:47:39 -0800 (PST)
Received: from localhost ([88.128.90.65]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e199bsm4069351f8f.16.2026.01.06.03.47.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 03:47:38 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 06 Jan 2026 12:47:37 +0100
Message-Id: <DFHHDFTQAVZH.XD071ZDDP29V@suse.com>
To: "lufei" <lufei@uniontech.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251022014518.14549-1-lufei@uniontech.com>
In-Reply-To: <20251022014518.14549-1-lufei@uniontech.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite sigrelse01.c with new APIs
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

Sorry for the late reply.

Before starting a review, can we ask you why this test needs to be
refactored? It's always good to refactoring old tests, but this one in
particular is testing a feature that has been deprecated since
POSIX.1-2008 (~2016) and replaced by sigaction. We usually give low
priority to these patches in this case.

Thanks :)

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
