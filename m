Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E06D6ACF5
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766060592; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=VjiwkhlwBW1LO7kyXkLKmSfYWrrWJSigrnjx1KCg/FQ=;
 b=gq6ne6Kv7f71zdGYzE+nks3x+QEEwfPaek3cyPM88KCJfZyiCzqZT8tax4bSb0q3BeWh3
 UvH2FRn2GKJhW5QBrPf3dlWhLMjKsGnx5ZtvI4ID3WlCgUX2ybTM2Q1GZHDWgmEd1hT8xmM
 OtkgWXtrEIjAdOlDamNe/92mz0YPntU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D0C63D047E
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 13:23:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A27E83CBEC7
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 13:22:49 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4AE5C1A006EA
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 13:22:48 +0100 (CET)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64b7318f1b0so496975a12.2
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 04:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766060567; x=1766665367; darn=lists.linux.it;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tuNA7NxBJTRiWZW6BE98lY2kaLc6RulDFBzd7cIDX/I=;
 b=GnigawWd22Ry63TVvmNJshWr7H/GUCZdWMqSIPitRQIbmvJ9Rgk1GzdA2NGhRyGHCR
 JGNX3Ic8c/6Zh4mkvGNaXDqoqBUhaNHR9Dd27KUhlptxH3BfMfCJxkO//ap8iKDQibeg
 A6WoWdPDt6KCysNt400VpKbUAMOV7+at/VEwVwPlRGMtRKniz1KVAAiDAXJWESCCNG/i
 NRMzj/T9ISH9XB7tUBvFf8QUEpiu6BIYLPxyHT1JJrB0EazEQUbtwYhrqombwLd8Sobf
 qvhNSzt+347t5BQOJCG55HI8YbGr7fDxlGh/de8gL3yA5XMVa3a8raIx7oILZ/JWpgzB
 7yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766060567; x=1766665367;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tuNA7NxBJTRiWZW6BE98lY2kaLc6RulDFBzd7cIDX/I=;
 b=GTk/wv/T1lgZ6ggcXXuO5G1cYA9F2pdH1z8PhCMeMTl/cg1G0H2uQRi4LtDNPWFBYV
 rV0v0GDROhKfZP2sRvYhu/yO3kuuecWXrqNG9nwjjw3BqTbrgcEBR+BIGIYenJ7aoRhv
 YCyq1Osy7QFu1BQW3zFuaDYzlvpYk4aHFMdf4GC1r8KApk1tCkTZmQ/lpGK26vjmWO4Q
 lnfWN3EY86c/q5cubBhmjuXxMYEKEpWAU5CYG4a84msfX2j6L7xnQpRFJHseUYOfWb7W
 9Unk2pHeCddi9B+zSjQVycmleuaNZlo7ZR5YYTPGIicBpd0MQQ9ZlCd8M+KBIvT4bqgT
 Jeuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdWQAAHy2oJkd8dKEfypck1SVV0EhsTB9IpMnPIE5bd0bokLbb5StDgScq+H3jcp2J/hI=@lists.linux.it
X-Gm-Message-State: AOJu0Yy9beMpYb2spdCVE7juuxyrwRqNQJ1prC26XztZwJ1JNCFfWk1t
 +CQ+oMpIhgz+ONSmrFljETkttdr2hWAtdXGI2rPdFVPtX5YXz2SJbvGuA4U0qK/CDWs=
X-Gm-Gg: AY/fxX6XREhY75KgI/+2BASi7Besa9GNHaYkDR7Ei9rSCq5arpS8xrnzvvAw984+WLc
 3e3y5nJkawWksZeQFniGD3MSNeWUmjzYo2U11XOCTxE6gPd+UfAifYkV3P4YIPDibSg3uTu3c6U
 jpj+FF/XZdCX4suGTm5uE0IZFaZS2xC2prKzDMo7vGl5Sc0Agrdmy16SWxxlh6jO9LBDha61k4o
 jqdT1peDmhffeWyiuxki5TqG9NhDe0Q7RwI90I0z0LQxvYH+oYN554hWDDYN2/LCwdjPC9e7fDz
 VW1jhLtSR5ygyqKWh4MSRcVy5E4cS+r4ZiiPwq1eoAJqUmq722iT8CdjUPbDYCGSdQIiFUSjT+g
 9iwFzZZi64FM0mpN5gQ/NOV7XQy9U9fWL4M0Zv+Et/80kH2hrTqkCGOiHgZjlIrBvE5+c+je2OL
 TDNyBR1p9mYqYTmG4=
X-Google-Smtp-Source: AGHT+IEV6y9+OQ4ELJ+U3xQvLjQJitd6hoKUO+tMVKN47XP6JTftIXSTpVzKkOFJxN7mXya1INaQyg==
X-Received: by 2002:a17:907:1c1f:b0:b70:df0d:e2e9 with SMTP id
 a640c23a62f3a-b7d23a3467cmr2117756366b.44.1766060567437; 
 Thu, 18 Dec 2025 04:22:47 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b585eddccsm2353798a12.14.2025.12.18.04.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 04:22:47 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 13:22:46 +0100
Message-Id: <DF1C7ZVSMFX1.K8PM75CT0PQC@suse.com>
To: "Petr Vorel" <petr.vorel@gmail.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251012194946.370905-1-petr.vorel@gmail.com>
 <20251012194946.370905-2-petr.vorel@gmail.com>
In-Reply-To: <20251012194946.370905-2-petr.vorel@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] m4: mprotect04: Replace
 __builtin___clear_cache with __clear_cache
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
Cc: Hui Min Mina Chou <minachou@andestech.com>, Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

I'm re-checking this patch, but I couldn't find many info about the real
implementation among many compilers. gcc seems to have it for a long
time, on clang is the default, so I guess we can merge __clear_cache
usage already.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
