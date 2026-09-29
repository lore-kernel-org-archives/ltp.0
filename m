Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE437CA5FA5
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790693026; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=mwX36Q7rcY1u+s4eIRXiueu3xsJ9Uohp7/C2C7lWtxM=;
 b=oU0791Uxc0Q4ApjFvjSY0Qtrpb9G2sOj/Zsad5r57liGO4OKRVZRlgwg0GeQB4+PpjvW8
 ngcUEh5Y46VW9SA8WAID2Fn/pTTettbQxTU+T6I6pnkqV/7b02g/0bAUTHgS99Md7Ojtikw
 x5VlP8SWqSjmB1D1A4AJBwmP/MTs0Mo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3551B3E5873
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 16:43:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F40AF3E20C0
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:43:25 +0200 (CEST)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1A9671400217
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:43:24 +0200 (CEST)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6351831so2515858f8f.1
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790693004; x=1791297804; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Lk1j3s65tEuCvQX5/LHHgABouUKIeNtBE8bmhD6f1WA=;
 b=J8csgOLVsQYYkLQfDAc7QA/6ky9gXqFwO7Ep3c9IuaEZVk1zqMObZzBIe21lV0bMck
 V9hwjK/gyEQ1eAWn+Fq7gKmIxzm4TBanpFYBzBk6mG55nDoDgmI3wUiazkMsSOcUYjjE
 UTMj9fBOEToNrfmEy4kqW4SD9Yxt5llFH0+PFl2b1N89B2FdtrSAm91nJGJLfJFHc65a
 1ijC7PdwtXH49OBEnyiswSRz7uue5KhyNnr3OzfPRqml72CaSqLpugDUNmatopI32Uba
 7StQJSUI7Qob/xcVj9q45kFtb9frgH2ZZJnXBoV3tO6wkVO0zWDzORBg9FNfXXTBZ37J
 14Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790693004; x=1791297804;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lk1j3s65tEuCvQX5/LHHgABouUKIeNtBE8bmhD6f1WA=;
 b=PP9bBgm5etsNbtt4vBFWmsG4NbuECdNuxS4tA72phA0Ethn/aCocD5isxQWfNhwhkA
 4P9LFQu4nepl7/A02ReA5bzkW9U4HrjuZTZKcJNCwtAJbLy8euV0kvBF0H4zi/Br01ev
 796x+0xnbFuCEg9t/5MOQpdTClBZ78hvR6Deaq4L8xsrkqFrArFs/nejKJz9tRPl4hPa
 BdHT4TBT9/a+5mlq6ZO9+0IMM5hAEWNl/w2NZYeHPSh1lkeIxep3QR3x9yZx/dj2zXpQ
 OPahddNWg+kvmSDMfbsHEiCe4VbmVTnnuADsfN43DaLVolS7shj+G/h3ILNyDATFYCzJ
 q48A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz63xNv5f4ivgxH23WfJ+64mhnU/7OgSUUeldxItCAHbIuhJWk9lnZVmt+du04hI0FiQ1M=@lists.linux.it
X-Gm-Message-State: AFq9FYLKddBKpzr2LuEGjH8YqhVt0XZVhrJEw4Axpii+zBZoXTvzAJ/n
 Ns4bc3wA7bElpBL9+7K+m1fOtuxXjRAhLyMPdzxbBGyZGECsOOkarJ9NAieSXz4IRGxCcYRFceQ
 uYcrf
X-Gm-Gg: AYBFou1z0hMTtUuQyIERFHkBi7v6IsaFbKLbveOTmY7bED8zJSkuO3IUEDjqVE/6O5U
 /qAbmn+HwIotEni/25VQgqqUWMK8NnwNVSiOasoC9zAoX2w2dJYoPdQVfRKvdmgX4xlbmKoMBMS
 F+V41W2n+GxPkLYMt4jBOZULy6IaQIPiuxmKQPQtRl/BUQvtpLjjuQMXRU1lF10Xpk0IAWRRIIr
 nOpXHPDck+ukBqwDVDH/DifZB274yKsxP8YsbRi/1rQzZ059NXaSPbyOJe5ncopd26ZdbTCPalC
 OgQreqmZB1S+MFlIbaR5hnUw0w+oZz//apfdE5gLudqkil1YKZb4L+4ovrYXvMoICpR8sVLYgL7
 8oc65AsZy/GCDPIkVUYMsjv3vivZydM7qBPu+mqF+fNxrPEMz6e+yOTXUWvXVho/KCeP6JelHI5
 8YIAb3Fhmw9YUeYKJnxvKMc75mOVwixg+RTRBU4lcSDSrumBACe33GvU85Sck3ABlqN/q7jql08
 jHJ4EYkuTswl9nTy8A/zNXzZnsBbmKdOZ7rKIHppKlx8Rdh
X-Received: by 2002:a05:6000:2284:b0:488:89ad:56c0 with SMTP id
 ffacd0b85a97d-48889ad576amr17577574f8f.11.1790693004267; 
 Tue, 29 Sep 2026 07:43:24 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508b13fsm4067074f8f.27.2026.09.29.07.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:43:24 -0700 (PDT)
Message-ID: <6abbce8c.aec4f0e4.fd74d.fe52@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <arvN7MPnBolwnT3z@yuki.lan>
Date: Tue, 29 Sep 2026 14:43:23 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] epoll_ctl06: Fix BPF map on old kernels
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Should't this be guarded with kernel version? I.e. only enabled for
> kernels older than 5.8?

At the beginning i did that, but then i thought that probably there are
kernels backporting this feature. i.e. REHL

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
