Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D83B106F30F
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 09:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774518074; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=nGxibC0x+pAsVlnD88sbtPOJi7jHTRS3PNr+CED+yWQ=;
 b=oRkMUcMSVAD1FOB24//8ZRllN+DCXLCL6goBhBT2fiRVLwPwR4JELrpzXkA/pPsF0GSBU
 0FB2OQO9/NE27ChFCA59vZIwgxKZNGdrN6BRXggXUrOJV7WIaLESKfTJOh3RoRq5e0E8juY
 qDEabGCOh8vEqy95lkj1kfJpDAqmpao=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 780F03E2AB8
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 10:41:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10CF03E1F8A
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 10:40:50 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7782710007BB
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 10:40:50 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so6888735e9.0
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774518050; x=1775122850; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xbf0mA+3EJbuV5L6RDGY9Ac/f629giCehHuph/1H++U=;
 b=elCFNP79i6hEBfZgQjw17HdYj10nIsKv0jhAqauR5snnXc4Txm1Q1hlhryk4YehZAa
 4YRNEO5vKSCDFmHTF4klIgyCPAQWwKalZK0TCMQzIBrT4JVmUxA7M48T6QtwOdIjnA2c
 x7PcEdG2OeO5lrdBBgKQJqoQXMH98cTX7jYzpVG37kuTXDfqFE4WFCtuJZ2Km0b2CfKA
 jjWoVtHb8GcAaWG4paoI9tsdYH5+fNeK/b6Va6LRE2UQBZEmz/1/yNsXxAOpTt1dVw7w
 Pfm3kmwfOaXjk6TjFKj9z9rsiUHzlc1R7suIWd2bHa5YcRnkXZOrIoSAQUce8pejPF7t
 WhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774518050; x=1775122850;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbf0mA+3EJbuV5L6RDGY9Ac/f629giCehHuph/1H++U=;
 b=OOJEF16PHAUz4SMRyVYB+fTOUT+5el/CDQrEDh8rpGQT+iJ+Hpk9SfQA0GMF5TK38Q
 DlYN56ERem+0OqNf/Faoyv4Idw5qPBgHWgYo3uKRLuBkK32PMLiMieRlu34IkXEvCDdn
 EhCJcEIwy3z95I5QbDRrJBbm4en8zGDn7/Bx9zYM4DbYr1RPuQvjThXJaUZx1+x2t51b
 O6qWkB3r+p2pscH/5N1UPgQwwymdIBeqweZqWt7tVLKEphBOBVws/pNnyuStg9P8ct1J
 lFPRRryP3tWNa96zEnVJuzVCSrANDHd4Pq9bgOA1o/uLyy84J5tvGZQZVTVOlm8afMHx
 xMMg==
X-Gm-Message-State: AOJu0Yyc0ErUbwjFR8GdhK+8WkA1NWKkO1ZEP3Oy36KoKqauAWjoAbdH
 RAVNCjp5vu8j+GTa3mRTPIjyaWskauyTzdpOjkv/ol6OLoggudCVhBb1jKZNh0qVOt70FoxCgTp
 Ptbh2xjk1jw==
X-Gm-Gg: ATEYQzwrA+7v72kJfBn1ai8h+Pv32FlQIQaSRGwHIHy67IalTAEMcVYf5rMJuUHh6X0
 cyRjES91J8qS7FQGoL+L3XxfC3LTKXNEdZDkdmo6Ar+B26ACvFVmx1QqVTfUYd2+dljH6DjOC47
 gEVV/U37nd5QLuoMHB262ZE2YmdvyK59flfb/qr+9bSKSwqV+XPhVqaRWPIi4AbjlOdh/VfAOQn
 A+MZEYj1JqMrGqHdb3ltEGjS/Q4+WwIrQQ0KV/F34KCdUgmc1TzZuEoGVOacE+em8a8Gh9Hn058
 rY5vAstZu9HUHE2R92K1OoG4qnBscGr5oZrcbFqnM/A7QMg8vi6YFttuU6lsXxg0uRZf3EdQRYT
 eWPjwchNwWfDMW79kz8mGBLTOCeFId0csQCd9VP6IaJ5/sbEwI8bewIPPQI7gm9pXQtsb0ol276
 a6nbUQNMYTuuSVJmqBcez9gqzb5nlORra+JXbNtjyoxt7fvPge9BRlG4uv7ARQnFod2hI4rrUZN
 xT68gCz0tWph5U4y6apCFNmU4a5PavPR54=
X-Received: by 2002:a05:600c:8b88:b0:485:3ff1:d5c5 with SMTP id
 5b1f17b1804b1-48715fc321fmr100211175e9.7.1774518049755; 
 Thu, 26 Mar 2026 02:40:49 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c8ca60sm17608805e9.7.2026.03.26.02.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:40:49 -0700 (PDT)
Message-ID: <69c4ff21.050a0220.3574c5.1d14@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260326012908.6885-1-wegao@suse.com>
Date: Thu, 26 Mar 2026 09:40:48 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] fanotify22.c: handle multiple asynchronous
 error events
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
Cc: Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>,
 ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

The overall approach with poll/read loop and consolidate_events() looks
good. A few issues below.

> +		char *current_pos = event_buf + read_len;
> +		int ret = read(fd_notify, current_pos, BUF_SIZE - read_len);

read() returns ssize_t, not int. Should be:

		ssize_t ret = read(fd_notify, current_pos, BUF_SIZE - read_len);

Also, both read_len and BUF_SIZE are effectively unsigned here. If
read_len ever reaches or exceeds BUF_SIZE, the subtraction wraps to a
huge value and read() will write past event_buf. A defensive check
before the read would be safer:

		if (read_len >= BUF_SIZE)
			tst_brk(TBROK, "Event buffer full");

> +		if (ret < 0) {
> +			tst_res(TFAIL, "%s: read failed: %s", tcase->name, strerror(errno));
> +			goto out;
> +		}

Two things here:

1) Use TERRNO instead of manual strerror(errno):

		tst_res(... | TERRNO, "%s: read failed", tcase->name);

2) A read() failure after poll() confirmed data availability is a test
   infrastructure problem, not a test logic failure. This should be
   TBROK, not TFAIL:

		tst_brk(TBROK | TERRNO, "%s: read failed", tcase->name);

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
