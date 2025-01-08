Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BAEE77188
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736342050; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=aS5/bh76MYnHsog2F5TGteVejeE7TGBoU0BC2mPJoz4=;
 b=Z9GJhuD07JSshraolU66GF/5Y+Qvj9WWmjZACzo9RD/EWl0dxRyRuOAIvSlPaD3rFJhy6
 z0ieWG0926DLV8FH0zXi7QU9gpNj/0kxZneZ4/TiR3Ow7FyzdbS+mFz2mECfMIoXBNURClt
 OdI4LlepAAcqbS76oyMimIJhBCwyacU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 750CA3C1BC7
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 14:14:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40DDF3C1863
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 14:13:50 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 90BBC27BE12
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 14:13:49 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so115556455e9.2
 for <ltp@lists.linux.it>; Wed, 08 Jan 2025 05:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736342029; x=1736946829; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=206h9QE9NFYTWB/btQBl1thJs/q3lTnPh8bELJiEq6I=;
 b=etg4JSitQmFA1l0Kdx24xN9FeRUsM9ulEd0yOcAR9daMbgZkEeBYOrQLJI2ShwuoCZ
 YqfVEJ18dL/d2yupoeQ34JnfnE6i8oY6z1blnHfa3NC0XO3nhJvdi1atr46oTtoGCk2Q
 l9mz1HFZJdHnfTWapUIvjdu5XmPS/1aXVe82KdaO/QzFwLbkpX1NlLaP7yF3mQDh2GKz
 noX/DYQXyEyjmPmZ/DlNhkRASAcRzhx+MvWODPA94p+D9/xNIl6cXUmzafOTjprPJ+Ub
 xuA3vSr0uLK2hNBq5EJ8mqMcGvF0DSJzT0VGTWSQdZKUr/1zzegNShVhoESpzcvWs7Mi
 j0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736342029; x=1736946829;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=206h9QE9NFYTWB/btQBl1thJs/q3lTnPh8bELJiEq6I=;
 b=pZuMBl9aOUX85vb35YXxfBRH8RVdeGI0NcJ7AOjJj7V3pnS/hP4/JY1e9VzX9y0Q8m
 ceqKT1fhKAbt7yd48CtzZXs9DVpfkn6gewXcSL1gi3S4fXGIHH/iYQwmmM551UoIBo6U
 idY7YJGS7D9BE0DJ25b1BlTEyKj9aQgTTVC4ewZ0BKF/Vi4K+auDCmblV2m7mWKZ5iEG
 WopHJJTohy5k7vbGw9RNDVxVNAgZSiMgty7lP1j28pyPl9T2M8iCsLEmDB3U5DxXlX30
 vB67zOGoDuCaUkjucjUHyXCsAdKK7RukBWDFZGjP2q8SeSoBg5/wEiVOxW68Vft7tP/f
 JHag==
X-Gm-Message-State: AOJu0YwEz4eVByTHzaQ82nKFddDnl/tOCV4/V+boWsb3PVwP+zghmSd6
 otzCdjkN6mBsXZbC4n1Mcj1aYZqRo+ThnUVR/NUZ7s9ErBKK95OC92jDjkj5Vu8=
X-Gm-Gg: ASbGncu6QRCIDrp/PjrH1l2YhtUxNYMpWHnYJFZ81BDXSYb3GsCRLpNBqlwKP/0YKw1
 FRW/yhEZ7G1ABg1D1I1MrdJbs+QxcC1qV57/PoCQfamFps80x/PFWU0qqV61Gcu/6vtv0alnMaf
 tcH21MUt4DJt8TfoYNoqfHsWoD/Pagm0dsAgUoIu5LI5/ZeUXhgUgEOQBmmUvs8OHgrKKjGeOaF
 a+AjSRQtjG94jVCENSC8IplMZkrMJqjeOCWgA5gSp7wm3f/7eeOP874CZvgOnfArAk3/UkOlGu6
 wDyjh12AYJLiPjRVEx2HXgbR+8xPnx8nNy0kV8yCgALUyROqdH1KZ7lRI3dznN69vHzPPrW8PVy
 7OiHwHbhEQjQj1Cy8yKI=
X-Google-Smtp-Source: AGHT+IEq7pjG21aPrSvgz5SX+FxbRc9Cm/tJb+/+dh+7exRTzZfgOMNzYSpu0TbD41PUI+fni7ZrLA==
X-Received: by 2002:a05:600c:1e17:b0:434:9d62:aa23 with SMTP id
 5b1f17b1804b1-436e26dda97mr23714515e9.20.1736342028988; 
 Wed, 08 Jan 2025 05:13:48 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2ddd113sm20951045e9.25.2025.01.08.05.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 05:13:48 -0800 (PST)
Message-ID: <82caf392-de0d-417e-92e6-09bb6fce59f2@suse.com>
Date: Wed, 8 Jan 2025 14:13:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
 <20241112-lsm-v1-3-e293a8d99cf6@suse.com> <Z352WrLF5bP-DgA2@rei>
Content-Language: en-US
In-Reply-To: <Z352WrLF5bP-DgA2@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/7] Add lsm_get_self_attr02 test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On 1/8/25 13:58, Cyril Hrubis wrote:
> Shouldn't we just look at the /sys/kernel/security/lsm file and if it
> exists and it's not empty there is a lsm on the system and the syscall
> will not fail in that case?

Unfortunately not, selinux, apparmor and smack are the only ones which 
are supported by LSM_ATTR_CURRENT.
https://docs.kernel.org/userspace-api/lsm.html

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
