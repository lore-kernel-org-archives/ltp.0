Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1A5C55175
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 08:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785744949; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=lK5QlcNuAjeVfbddsGklNo6BS+yTmOnC0NZgoUo03qQ=;
 b=Zj/QbnW9UUxvx35dC7WyIJUwQRWAozNBnSzdQYZAu78XupjIoROmgJFclGBHF03EUxnQw
 sANKNJkz1+DJYtGUu9CjAV4fNLPvYd4vObQLpPrz7/2ENuAbI4tqHy7NOfYsblb9sCaq9ay
 91y78DZ1H8f63N6pVpO3jVgsoOe9wu0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 638D53C244F
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 10:15:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BB213C244F
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 10:15:28 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 391431A004C9
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 10:15:28 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso11350565e9.0
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 01:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785744927; x=1786349727; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LKOm52sj770rclD+TU51i8ed3n32ppwS7ur9xg+ihPA=;
 b=XKwxl/lGZP4vKvch24YKgFUPQfb3PEMFS6GtP3tD3e3k7+1t4NYDi3aCsa0lrrbp/R
 zLvoSTFxd41nMPtdVJahCjL9Ypaysb8dQgnp4Mkai5CfDwJ3cw6s8Jp/rvlRUvT/vs4v
 OmFxMDQ0OWOErewbgHjySSM9nB1bvdFKQ/4TeuheRf0reBji/afdw1WZBwEizoMewBMI
 qkJv0XGzsLiP0j+6Na+eJIResOAfwHmIA4UIqSHe7GToAAiD3QHfXiZQAAirrxlj7heB
 3w+g3e16k2xC+vYm83vC1c3agsratRvUCAFI7BN62U9HfoddaW8JhlbPXOHZnPhlAzDp
 OIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785744927; x=1786349727;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LKOm52sj770rclD+TU51i8ed3n32ppwS7ur9xg+ihPA=;
 b=QiUa9tQi+/Swp67kX2yH7QQ/+r5D9JfzPsF7sz/qRAi8zx0ef0RxUUpjskbaPx8ihc
 Qm3stCfCDlWRT0MzOR2yRp+qpuBe7PwQ1vv8tk5lB3GLFDsQXlAcC2U8JKQb/i2Gv1FU
 Tvg8f7nclqO1zgc0O9T5UQVYvKckqglZClLnk80qVxmdYMeTcsyLwehI7fJtT6l+JGao
 Lym4irqd6GXHlDTj+GMXmOD8ibGVe5k5Ont4obaLal1Oyvzkky60Wx8cxVff8eCg9v8f
 tmH5VVP83LiOIlyLpLEBlRxA6AT0iiaHVie+ZXponnwBd1zPnCQi9Q4uXi98jVq3i7Ac
 n69w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrq3sep61UObaPPapMfv0WP7HrBc6XDJyKx/+GqHW4OVBlHJ8EPwz48EWyZUQbml+ZWyT0=@lists.linux.it
X-Gm-Message-State: AOJu0YzTOgqlCA/WSK2oBY5epuUSqPZlGjSq2Vh9bQ0gaYtDYarohIYl
 smek7rSHy5B49TrfJwflaHC9dFQ6aGDhWqFaI+meZjsiNpWqSnNR+fzVtiOvg+S26Zk=
X-Gm-Gg: AR+sD12K9KojG+L90ubutqoC4jEKoear3/PttBbqusSpnA2739NLpnG5Q9HMyDtAL13
 7DlP7zRW4upAgvmPk0sNj2V0YiPEcXtO1mEu5HDyfLR9Eh+Y5ZiN9T/QvP8bfJ7fiz8nJyBgmLJ
 N3zvhHWMDTcogIXBlfyQTgmoSmPpnsDrwY5PLRZ1uALYdM+P8waiz6SVv4FDJcUewQoEBt1uzfQ
 5G1lIvRxFJXox5i+31rzgwuPdpqTRRrvCCk6I4TxdOx4hk7Cvjg+92kgFkKa1cGZwcFyg839EEV
 MIBSLlgnsKPF1EmSsYG3xMhG3h0XbwFVSes1/5z6l/AeORzETHXNXoEvxqFeilDR3r69VHnwWEF
 5sb5LA5CX7ZKqRPSVuPSuDMFaEnn6pD0SKlnWSLBsNJLRSyMqLbQs0oGPcnKenh4qPUmJz1V5FR
 2nylUOvdPSuV5AFlnNYGdr/SmIbwydxSSE8DThUPeh0ktZ9fd1zHLOedxZqKHOGS/I4vlxLX5vD
 D00ZQ5fp2GrK7F7f6Tzc01V0wASz7M2/482Tyo4yrNSdUF2qjNsIwc9W6fXGp7CIMusb7c=
X-Received: by 2002:a05:600c:8b13:b0:498:8e6:d464 with SMTP id
 5b1f17b1804b1-4980c65cd2fmr204211095e9.14.1785744926950; 
 Mon, 03 Aug 2026 01:15:26 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b5b4a2sm243731495e9.1.2026.08.03.01.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 01:15:26 -0700 (PDT)
Message-ID: <6a704e1e.da15fda7.2878a9.2f0c@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <anBNIz29I4YdG2Ii@yuki.lan>
Date: Mon, 03 Aug 2026 08:15:25 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lapi/prctl: add more fallback definitions
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

> You are checking linux/prctl.h but include sys/prctl.h in lapi/prctl.h
> which breaks compilation on all targets in CI.

yeah, I sent a new version that will fix it + 32bit run

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
