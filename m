Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BE1FF885A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 07:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777362194; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=h4H0U9PDKFYXw9fAQ97RGv0l44yRe8Etd1G9/MwFb7s=;
 b=qP6uq1b09s1IRwNZXu27z+ww3X9P1hPAd0bWsABO2jkzXO99VhMjTV1NBw/EgGiyZhTKN
 bZ9MJlKviRdCwZpACTot5jvb8t9lpSMio+rp2qn+0z1mmOHCMkhYcFQbiddX5FfwDqZH6Jv
 ErQUfVudLBRBs9tzzRPDAbwceI/GMsQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 744D93E2541
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:43:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81ED93C682F
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:42:52 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 18B912009A1
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:42:52 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so65214935e9.1
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777362171; x=1777966971; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zGUSpwShA3h6xkJiewWFDrThn1rqqHaLghZVlDFL8Fg=;
 b=Phs+51dPdmvzSGoTeidACs+pxET0cM6ivkTg5I1IY4raaQxzR8TOMKlC8y8lnxMbQr
 uIgZQIWDejqKNKYgXoK0GP5Way+N2cq52XLxHZx+dzp3lyfUxO5nLj3c9n5ou4fCGe/H
 hJ5p+SZ0uKkq02aYh1HAfYbUUlXtSOTdLpQ4zEzKdcPGct6y2fDoHp/k8XVEYH7ZUkZ6
 TnbsorxVCOJBUrGPFokZ3EGcIg1Cm4RCotCLVTxwc7bYBmu54om3V3uL4dBuT+uSSSth
 B7ZBWDpwcPHqIt+sObkiJYMu5eby0yERb7eHEdoeZHboeM6c6nfX7UhrIoGh6/u5in5G
 EhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777362171; x=1777966971;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGUSpwShA3h6xkJiewWFDrThn1rqqHaLghZVlDFL8Fg=;
 b=g4sF9QtAsl+pWGlBYyZSCfQDnYGp7bwCVXjq1PBhEaAWbgG6U0xx85uqtCuHAIYX6b
 PTIRbo8bqCY4yu+MNHomn40Xarp3FYodO8kmXfwEvG86wvui8Hzw3ralfMN0MWiww+9F
 8bMufr6S/r5n9ZFmsR6KHIbboN2mSXKNasOfK2+/i1rk3GGYu9Fr+OVX8TZVp5+0NAU/
 0046LN48rHtiN/Z5g5tDD3x4Aa9bv2WjrFhSwpisTFbD5bgGHzoeBfmgp/PW7PXm1iTK
 LTveTrgahRojbZiv4izJ9hFm8Kl8wNkVxyEIAtoVU8hnKSzQ8Myn6btJYRAuac/GKUR5
 z4Qw==
X-Gm-Message-State: AOJu0YzosUUt9HWGQ+G9DCQebpC+DvYfxNsInPF16wlOOxZw3dDrF1rr
 ew+F5jlmRJc+RYO4xzqIFS/bVTpXvFpZMB5Q8aT1ZFUnxgbxezQS+7zjzR5+b1qqmE0lwkz3/MD
 CNSNcbTU=
X-Gm-Gg: AeBDiev9piGyWqnagP8ywJ0UCvKtLwhJxi0vVIpK61RX0fzQcuJz+s1e3IMWvgv7Xs1
 xXLwodCPnhFTGGFvnG6NJpLYY/7U/B7hTTPwlkW9RDkqJ56nmMvT4IRb7AHswYVVMIz0KIL5rQe
 tYrlAZQxH0vBRP0VXWU0NVGB5JJHkGwdv49VIZwms4ZKPj/xNgCTJ2AKhSBmF0k/CIMS+0RPZSp
 2Hd+kMmHLYivwatYVXK+qH/jZ1ffGFTmC6PLwxmtHGt1Qba0EIqyj/hMS4xgYnNuJVSd704W29Q
 UeAzODe3tm5N15tdicENW3ZAlIQa18mNXX9TVzWoSHFwri6P0gJLSnXld41PjKf+DyO5SfWaH6M
 cN6jkNfmEhrsACiVt5WKaMPgxxxdZzmZrBRr7lok4wkFSRdEsQz1IHVLb55fgRC1EVALMi/2KUa
 Ejba/TUOcqnYeKSmB9Hz/eA2z59cbDYzV8TZgCBDCKDVyir8Rmo39A
X-Received: by 2002:a05:600c:4f0b:b0:48a:55d8:7882 with SMTP id
 5b1f17b1804b1-48a77ae6477mr26841335e9.9.1777362171416; 
 Tue, 28 Apr 2026 00:42:51 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463f5b50ccsm3743685f8f.24.2026.04.28.00.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:42:50 -0700 (PDT)
Message-ID: <69f064fa.5d0a0220.14ff24.d474@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260423120309.18049-1-chrubis@suse.cz>
Date: Tue, 28 Apr 2026 07:42:48 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/8] Add more epoll tests
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

The patch-set is generally ok, but there are multiple issues on
the Copyright part. Please take a look at that because sometimes
it shows Linux Test Project copyright and sometimes Cyril Hrubis
copyright.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
