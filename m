Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB31CD6E55
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780322191; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=X9JUxOKXfrhLDOzer+ND9NEgZ9Zwlt6CvlwyC5gAox4=;
 b=W6VPErG+D3tFuxaMeEyKYo2/CuHStXAjlmS7anZ0taIJCD99rycr8u3NxZE1jb841dQpy
 d1W5ac0XAJt/zjMtKiXGLH9JsaUcvGQ9cG/RVAvR2V2MhiwV2uy45V1yPx3WvGeOT3mmhlv
 itWsOCC796IxorzuU8agvcgErImTCsY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 476483E56DE
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 15:56:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 919403E1EA0
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:56:08 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 117A460094D
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:56:08 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490426d72f7so88982535e9.3
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780322167; x=1780926967; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JM7aK96VDihDy+3WSGhZDOr57E7sqjHz2PesTwcf3JU=;
 b=E+KdWNjnX84STIe2XP+APTEOBQTFSHSF6iESW4EalBjQvP8eRb/rQ1izn3cTAq2Mkd
 LYwHez3EGVaEoushyIC7y65HDR+SXGgfd/Ex48kFL7bEoePVPC75AX3B4cyahqil5yFF
 s+nlu/RbUOula710xjyma9LArjhr7+cnfe5ieeHxYAPkj9MwOb9R8MuoBpzZBDWXpd4j
 7DVY8WXIxEZyox1zW1udASPSDdbM1x6SVkrZI5zQJlqEIFDrMstpJDqLsIS9x36eXERM
 PFItQ2xpNh2ALDJzovBPSYnwbjMDhLKBI7sSFkXs6x92H2xcY0UUDPiWY+YXiHvSrtr5
 Z32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780322167; x=1780926967;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JM7aK96VDihDy+3WSGhZDOr57E7sqjHz2PesTwcf3JU=;
 b=ZBk4Yxk+YMIkIxzPX+yD5oKF7JNqcrDPedtH2+yBVaS/JERTbjpMg8TFQybvutw+j1
 VemM4NE3ieXxGw0fw23ffqunhW8H7B5uIEto8h1Re9O72hw7wiIavxKBee7FB68v2tRo
 9C5V0YKKuFEeJLRasbSplIdCgNla35JzBrMDnPBHZxaEKaLBCPdmsRA9r+FOJkR4Y/Jv
 wHa9yL/wjaImJEN+RTnWSqaySAImKOh/TOLV7w+Xc91HHM58pKc+gdXRkX8RKx61rCpR
 ay5hp0hrSLHC9X0HwT0FL2LHcNSpT3K9Q81m+d7npO3icPRU0yn0okwzl8wchrb2JABG
 Litw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+J6PNznDJBgiWHHY7Lfyp9I76nWaj+XNTlM1b678oI4pKaF4IozM6Q8AtCOVt9U1Nnu2M=@lists.linux.it
X-Gm-Message-State: AOJu0Yx3jCUTYszxMPONwlxH7tB47YKnMkftXW5AZo5aOMzmzLYnzeUd
 28RzYLKYeeqR9Tvu44i4nFwCGcyj5B1j2ulPdHIboPUcPWi0OvdisGRyGvizEkxHkD/JTQ7h5US
 yIVgxJV0=
X-Gm-Gg: Acq92OGkPy4qzIHl+WGVSgJRI2IQ5Clg91I1pEx7VDfVEbWzU/aypVP+yDamSmuVw0y
 MuspDRj9vVk+Z8o2mKArNjEvcjlFkGyQ9sm/8HPp3BbhbLC94LKnmxzD2GOdAzasHZDTvikeF8v
 MJRYe9irjCf9n8zLm5PoHZ+ZRg5MakSvH7j32N9CTbHuFeELz0I/IZ3PVp9G3GoHbhwMF140rCe
 3WE/kaNZvFHjR9O98bEFCP0fWH/1hDEbxf2C8zhuc/yNuGcH/kkngOw5ooHWlsWXCYLWt7DAw/R
 Q5afnYKd4TyCuOPvHAjig9C6mHusXx3cEtRYJ4QhZ/4STwmKHArkkY0/XAzID6cTwFiSnddas+5
 3ryOH0yUbjlq8qE6QL4yGXBhfI10XPYlVc26Kco11D32rk0JrkKGzNL1N0nL5ySapwabT8mF84c
 7M35D1NoaOC2Y0CL4y53duVD9VyY9/bRXk2rscC90kkYpgvjHSjOpkXwpmGuQ9mE/gF18cL5lpM
 e7eKhG9+8I=
X-Received: by 2002:a05:600c:a305:b0:490:7227:100 with SMTP id
 5b1f17b1804b1-490a2933b22mr159204395e9.18.1780322167359; 
 Mon, 01 Jun 2026 06:56:07 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909dff2a80sm292403535e9.3.2026.06.01.06.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 06:56:07 -0700 (PDT)
Message-ID: <6a1d8f77.0c2aff9d.3966d9.31c0@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260601134134.4295-1-linuxtestproject.agent@gmail.com>
Date: Mon, 01 Jun 2026 13:56:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc: Add missing API references to api_c_tests.rst
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

Sigh, I should have sent this one with the previous documentation
fix patch-set . I will do it in the next iteration.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
