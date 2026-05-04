Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CADDFF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777894422; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=BsMqTU1tHkGKmtgB1R0+k0LzVVNQey8v/rNVafd2B+WS+Bd4w7mPBUXFPEOl/OgSMxoaW
 1piEbbIaAw03K/0EeTl5Qwa28CMQk7rYMcUvqttT+yjTIBTGTft53oqnwIuOUzTXkwgUyc6
 RVgu61ah3AcBsgD9UiZIU3ja83IqWIg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09DF63E61FF
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 13:33:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0A2D3E1902
 for <ltp@lists.linux.it>; Mon,  4 May 2026 13:33:18 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1AF141400277
 for <ltp@lists.linux.it>; Mon,  4 May 2026 13:33:18 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so59185245e9.0
 for <ltp@lists.linux.it>; Mon, 04 May 2026 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777894397; x=1778499197; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Zhw1nbEoCCbMhnl+uUSQ3xjNWyWVXKxHsqppnIEgVFJTJB5kgyO6IevWa4eG77jYgx
 rY7TknToavm8FmP013rMBoHJs5cewUf8TiOrlyd2Uf9ujtc6let4Kg9l1WJqrm0AZuFA
 owYk0P0dQYpNIv5YbLwohE2mXgaPcc1TmL4W3n7RGMhQjWT91KKskzXbbDVZG+5l4LUQ
 a2WTVkdrtK42ZlXt3n24GibEmU6xdp24sbxqNJ7qcD0NSW0nxQ/WuFjQ14jFTYHLzR2k
 JmxyyAMPBB52xwL/ps8QDB/abg/ZWEXleBl3HgFJxKn3u8yvHk4uS4fTj/NHHylPv/Ld
 5zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777894397; x=1778499197;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=VDky6kdweBMXRO9E+zv4FUBtJSvYubmzGMd1Xg1FjTJ3NbnfiGDGkwE6tivyCcaG/G
 luwYPAXnEAC/MahavDcI2kCWK290RiWFrgUNHxm0/uJ4buepYo82O3SyAmYfAqxX6qqx
 /30DcoMCDNy5+fXigt9D7oU+kSvpTaO0DE3KfkU8kejd11jyf1gW0Rk3TcmjxFBcLmqI
 Mrq41iL/go7056VHqr5ZJHFMQ5FmMp6BN0X9QXuQQwMnSV674WmQayA1oXX8roFDFpBk
 1bz9k7yL8MlgC4hO0pnc0gOaTBUy3GvmmQRsP/Dqu7+Dw3wwqdlO00zjLfLnXaRIT0I5
 ViZA==
X-Gm-Message-State: AOJu0YwS6z7byyJ+sScWErFFMfbPEJO+TskY0+y6gQnN501jEkZr7szd
 gFGO6363dA4L+Cj909pWirfcIxjm0unO2//j69lV0ORBqhN/390R/gJWYjn6h0Wrzb4=
X-Gm-Gg: AeBDieuoLAjaEHkTKhnf25UK1LBwRJDwO4DtrlGi0U44CxyJoL3ur4O4WOwUmr07OwH
 2hTyw7d40+QHNaRN0C2LESh7cC1h4nO+8RqpICMi2iJtOVPsMgU4XUIMF9hcjfm1StHZHtG5G67
 wZp/njVCLd+0QiaBmuONGdQtekAQlZYOE/Mk3G1fmNaGVK59Ufc296Z+nB3scy1SBt9ClwHFNj5
 GjgIMjNzYUBVl3ZaPTqOXG4SX8+F51EpNOJh+/AhfOdAd/5Jq3RbmvrwHcTeIw87ak17o5iN53A
 7NGnKqVh1U1fxgdY+2n5InmrzlZrDUueygj7ey1JF9vr4Vi5rXyzBlJDA/4WgrWHb3s5SVrEjiy
 i+qdE7FHKCEONcJIqTcpGlyghxm2idCGxkmVKBe2yJpEA8wIWwNrqQ4KlMcLmtTDJzGcODShBQh
 PGwdIdBF5JeE2q3gI1f138HZ7T83cs9CQCryD3bq3hbx7pA3Zvtl8x
X-Received: by 2002:a05:600c:a30a:b0:489:1cda:bbb7 with SMTP id
 5b1f17b1804b1-48a986737f4mr111049025e9.25.1777894397083; 
 Mon, 04 May 2026 04:33:17 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f28sm541780625e9.13.2026.05.04.04.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 04:33:16 -0700 (PDT)
Message-ID: <69f883fc.050a0220.2e0e40.78fc@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260504-safe_splice-v3-0-e5acf4c9193b@suse.com>
Date: Mon, 04 May 2026 11:33:16 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] Introduce SAFE_SPLICE()
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
