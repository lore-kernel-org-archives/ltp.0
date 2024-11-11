Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED1AD2E9DD
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731325790; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=1itSPIft2jQpo2qyUjaPbdvj8zx060Cj4eJPY2TRcj8=;
 b=ZzyY6KH3zNhn7+HtzeXHo/WCLcH540T749oSHZg+QzWrL3XXURhj3gyVDvoqyXmQ2dSFe
 eXmq0spIXO5rSEApWpjSlOBQRZl5RepLOFOsF5Zu1K3DOQE0J/MMPaUIfIiAP9dyqCi4CrA
 KY7AeAX1A58qnYJbKAqmp4Ui69mQC4I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86AE93D53F3
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 12:49:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D22DA3CAC79
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 12:49:29 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D87771BD3548
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 12:49:28 +0100 (CET)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539f84907caso4859154e87.3
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 03:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731325768; x=1731930568; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GByO6p+yZtDi3WXDCwcYK64VpTeXpsLN7ihA+hKnxF8=;
 b=QS/esOQR5FdCniIEPFf4rOLkxdYK9e0+jXo4oTWzRX16t7ve83rwBWD0YfgUT1zKVp
 PhfSG/mFvspdS68GBhzb+2OHfowsoAr589h0GoBny7oWaKHhjHbwHZDqZ25CoiaF/ZYN
 iQrzoFrYn3r+kbYDC9Sv6WubCigPKKSCJW7ZrFzDvk95/7i4XpB5g6nw0dm2ErBL478v
 fa7LYMALtVPDR4CII6fJq9VuASEzLtAgHLWuGk9WMV5ED7Omq5088dil133slS/BsOft
 0XZrHUMh3ZLOP9b9aLP0ETF7AYYnZLuto7oXYxxa3RRIg07wfXifwPizoL2nTU66aEH9
 k0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731325768; x=1731930568;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GByO6p+yZtDi3WXDCwcYK64VpTeXpsLN7ihA+hKnxF8=;
 b=ZZNShppFSvsSNjv1XAuYV0dwudypdToZQNbh4E7W2S9ywsHkqUiNbj9n2GxiQka+RB
 UGCgqzYAPfFumOHv2aEzaOTrUuS+HcQ56IiugqFF8geLWO4jGveDtfDQpT5e1NddEPGP
 PtNWQzmSV4/YJoneiVkQnaiTL3sUn9K304e77tyRDFINCwwBlyYhPA9+q5/boTbwZmKG
 YGibdRMlgkRXqXSG1Kxb7bsO+dB3Is9DR88pSjClXrQP9I71pC18L+Z0Px/voHFrOoyz
 KVd+bJdLwf/mBNORCJFZlZtdAEmXG4eEoJXwXGCd0vlTgcVgh7GdKbIncPx4A89NQc++
 aNeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNzI8oinpNpVpGePs3IYdtJ+q7GWPTSXY44mxghctaTaY5dq9Z/4Tzf0DtXGP7QbSe0eU=@lists.linux.it
X-Gm-Message-State: AOJu0YxOJSpo+K1Vp5c7PUE2AHaBlf4Ns3OmmnfFY4UWzy0zp8Wd6L4y
 B0g9ZYFJ2JyYD6uOusaF58o1mU73MFFAs7exzrgEKezXPa62BQ7T4sUXzVJ7sf9TA6gSQ4wzS9c
 /ZKI=
X-Google-Smtp-Source: AGHT+IFEH5tIKfJImMIXKeLNCcZazAPBMuHuuJHa/P80D2/KCm8Gdpj22zuI7yB/XKUr+4rAoybIQA==
X-Received: by 2002:a05:6512:3e29:b0:539:df2f:e115 with SMTP id
 2adb3069b0e04-53d862c5dcfmr5942449e87.23.1731325768112; 
 Mon, 11 Nov 2024 03:49:28 -0800 (PST)
Received: from [10.232.133.32] ([88.128.90.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05c202asm177506895e9.30.2024.11.11.03.49.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 03:49:27 -0800 (PST)
Message-ID: <8734e4d9-d600-4596-9b91-0795dfb4a018@suse.com>
Date: Mon, 11 Nov 2024 12:49:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <Zy4z-VvTyGScU5tQ@yuki.lan>
 <52C460ED-16D1-44BA-8273-2DB44C2F5C60@suse.com> <ZzHt55N90DAc7CVv@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZzHt55N90DAc7CVv@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] Fallback landlock network support
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UHVzaGVkLCB0aGFua3MhCgpBbmRyZWEKCk9uIDExLzExLzI0IDEyOjQzLCBDeXJpbCBIcnViaXMg
d3JvdGU6Cj4gSGkhCj4+IHlvdSBjYW7igJl0IGJlY2F1c2UgdGhleSBhcmUgYWx3YXlzIGRlZmlu
ZWQuIFRoZXkgY2FuIGJlIDAgb3IgMS4gQ2hlY2sgY29uZmlnLmgKPiBVZmYsIGl0IHNlZW1zIHRo
YXQgaW5kZWVkIHRoZSBBQ19DSEVDS19ERUNMUygpIGJlaGF2ZXMgZGlmZmVyZW50bHkgdGhhbgo+
IHJlc3Qgb2YgdGhlIGNoZWNrcyB0aGF0IGVpdGhlciBkZWZpbmVzIHRoZSBtYWNybyBvciBub3Qu
IEkgZGlkbid0Cj4gZXhwZWN0ZWQgdGhhdC4KPgo+IEFueXdheXMgdGhlIHBhdGNoc2V0IGlzIGZp
bmUgdGhlbi4KPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
