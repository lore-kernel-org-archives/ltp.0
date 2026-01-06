Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D45C47BE8
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 10:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767696575; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=KcvB1hGrpW4rp9m5V2rpiKKmF4zf8M5zF8PDrSKS6h0=;
 b=BElorUJjJgkFmwu2hb+obDzhUzL87tF3zMkY4IzfNPiCqOLEM4qejcTWFxnD59YTiu9oR
 WSOeGqFbXALEh+UthW1WYpsmzy38jXdbesbo3pQModWvJOdTcy83cVXKobk/In4Dc1Wae1p
 bpQQ/N8jbtJzpv44S7ZjZfWlnkTYbkk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A684F3C06D4
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 11:49:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C14293C0614
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 11:49:13 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4D933600043
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 11:49:13 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so5980705e9.3
 for <ltp@lists.linux.it>; Tue, 06 Jan 2026 02:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767696553; x=1768301353; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10CJUVlE+Wy+vMswNEXR7zBVIMcJzMSrRoEdmFbZecY=;
 b=d2zZ2dpEbq6KEDeQ2rLFwIWABm3Xgdv6uzeHZYQrWR7Sdgqe9aEgBFohmbaerjlgY1
 Wun6yEIliokREgXScn9/lTSk1m+7AxgR9Mr5hZFdLNGWEcbLYb08hz5vyN0Jt7Eaq2uS
 WhGS6+8PoFq4gCOnexhaAxC2A/ek/pMuQNASxLF3GBmKao14YCQvJ15IwdDWQaySORwd
 bli5zHTYJhQp67RBPjkBQZy9asOI0m8gOIXt3sQI/N7AxCREh16RWdLWDQ1fALY8FDt1
 U9h0zVlhiabGOm0gm1ctLI60m/Kgfrf0rhc8j2EsH7NSBAs09PxhrKPDQN9f3zu80w28
 SWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767696553; x=1768301353;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=10CJUVlE+Wy+vMswNEXR7zBVIMcJzMSrRoEdmFbZecY=;
 b=eDCyvkOxZ45Bje7DVzPjpfGQBKUmRE7UMeUfQE0sFxlEJEweS1g5rONzBe68iHaKBu
 nbVkmSOThBuSLBhNBL9TBVbyfEE/DGhzfAjzLjvP9pLgnz2EVTrOnxc1OFtIE+EJCbJL
 59I1nR8tvrzpnhRewQ9t2TTmBLjPoIT7ukdCxEtDVcqY8rZg3Wlz0Y8kbxw84YDza/BS
 8EaY4/TGqLqz6vodZHzE7t1pUaRd34ELqsvMqpzB+qck4dEM1+vxv8goM0BlzJ0hXS5d
 GIONshThVUVHkr3gX+c51UO2J9lLUwAhzPODovhSB9JQ6V1PZoI/XpLBE8vMQmHg70Uf
 bikQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPCrPmm3d1K/1Ys2tFKt3gmkjtRHfBKfTCZZGVZ0HFgynpkDCxgxeQUOu7mvykrA1xaV4=@lists.linux.it
X-Gm-Message-State: AOJu0YxUe8ACgvHTfQJGIFFO2Lpr1nEUcNGjxslepdtrHxhQGs+u2fHh
 zEh7TLm/TpEajC0sBpR/MyRtWXxbUv69aGV6g63kONyVEiEQB38fXPEgORpTp1ARmMHq3ohLnoH
 KYdR+Sy4=
X-Gm-Gg: AY/fxX6vLauFqOumEtKSM47tMqkao4IwBFYoFrWnVSrIuviouJojFgx3JoGs4bKI2Pq
 LMLWI/xOy7nalDUVimRAvvbyGTLPtYn8gr141tmQNI8bqmd3IRyG+K5t1cbi0RKlqoMsoP+0QrO
 sv+4/DGJI0Bi2rqZJmx0+gI4zG7q969fkrHl2pbiaPdAFH3J+yEbRsB1bDEPxUCPS/wpxSOTdZj
 WZ2vTYZhTTj3dd6tOJu+rycoIFlnXf7bLqSAL3F014b8iPlzOkhdJTFb9DoQO/gI8oK+/ktZDP0
 yxo5MdoLZXsarz8Y5/Klw12pf0bsyYZNoCyRUUZuLened9qCE0hOSCkVnSdc/xZxwuvKkaL3mwZ
 GSirJREoiBCiByCnCubycY8ANVK57PV/SMA3xD1oxXRZkErYPQ5eX54b10RBJ1HP8SEdvRenCIt
 cE8WXVSZeklzC/
X-Google-Smtp-Source: AGHT+IGPWpNcJZHVJV1aq81y0hYcLWkUKv0I+Jj53mvFiQ09G0GY2AIvxsQbiJTU8cGZvvyab7hHSA==
X-Received: by 2002:a05:600c:8485:b0:477:333a:f71f with SMTP id
 5b1f17b1804b1-47d7f09c9efmr31595765e9.17.1767696552720; 
 Tue, 06 Jan 2026 02:49:12 -0800 (PST)
Received: from localhost ([88.128.90.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fb657b3sm14393975e9.20.2026.01.06.02.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 02:49:12 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 06 Jan 2026 11:49:11 +0100
Message-Id: <DFHG4OY28ZPJ.3QDAR7P7FND1Q@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260105130359.647879-1-pvorel@suse.cz>
In-Reply-To: <20260105130359.647879-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] make check: b3: Use --strict when run
 checkpatch.pl
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

Also, please change the commit title, because it's b4, not b3.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
