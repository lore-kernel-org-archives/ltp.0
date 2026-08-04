Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C5DC55184
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 12:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785845500; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=LLHF5LLecEVgxHtwI6+rr+SSGUB6u+11mvmuGJCdmC0=;
 b=F1MfnFlqLVeTwmoWDJJcA6xZN68H5En+PkEKKfOeL8+YsDoAYWjkbfKOQ7w+9PSNcNHW0
 dOhloGDfcUNUiZ4A6rKvO801W0WppiaeDYHm6gA6rN3ut8lKKhaeTDvs7JrK8mdFRDkCpaq
 YluP214derRchReH+RCjHj08+SE3cUY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65E013E717E
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 14:11:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08D0B3E7168
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 14:11:20 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 288311400156
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 14:11:19 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47fe377a217so1218594f8f.1
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785845478; x=1786450278; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=By6tkq5FK6BnsZlJZNq6ippZklzYmGucoUlxikUO5IE=;
 b=GOEeGkBLxTAac/94pndb0ckb8wy6BtG3KJapH7VZvREgXAsiaA4wbpVY51k1Q19gQk
 sQ79GpvkL/6D3Ilh9I0v63Y4rGVAHNs6oLB04ui/2ov6T2YOgG66PTRYlBUmMAdUyPwA
 NFfYSaofPNkhkF7AP7MHVD7V050al+FvM0BLV/OHTIBNDrKcGMerYrl6F/scEpaNVEry
 c1WcaqnbYm7zlWcX51oOCEbAroZm1ilOTiAsttELWfRHde3QIHfXxvbVjCnnJhWol0QX
 gWDfqwUjHDXqEU2TtY0WckxDkmaU1mYJUQuYtujD7R26DyEfJFrG5qXJo+A0CBcQLLWY
 L0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785845478; x=1786450278;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=By6tkq5FK6BnsZlJZNq6ippZklzYmGucoUlxikUO5IE=;
 b=JZuM2POzzoElbO3206TuD1bCD1r2g4NxOJXSSqqJI1vbge3t2OCOb6XHXEAGdUn/jo
 cdDz34eKRbegzovIgCBDqmPtzTmrOEomPFA9/b5YXWIsFrRs3OP5J68LVh1X3K8sUSm2
 XPHhm1w2xvgD5MqQqgTqWnpNU16krAWiBiZ3HECCXyi5ZnVEfEjxKEvEmhLsUK7exEey
 9xAkGCWV/5z0bLZ/Fue8cbRne3JDEUgZHnzDZ4ZCdikcDzZgWkmcYT3cW/ArkzmoQauE
 uCTNMG5K57KoRVGEiOQuBZ8VW0ry7nF360IrMYg7jCGwPhKbn9+wAmc0qcnPvOTBeyQD
 A3Zg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUZFto6fX4qYFFefXZ/jDh0FU0hTjHqxVcKorCVwxKlVuyamr7Q8XLtKDFF7KBRrizrug=@lists.linux.it
X-Gm-Message-State: AOJu0YwckDatvOQZTcpeA4W5IWK1ojPHMac/LJT9g1QOVEwAZgrzejmu
 yz/CHBE46O5fopA3ZKvkzk3PogwOEmoqmGBce0NYRF921jlx6XNjSK8ERwsKEYxLXHM=
X-Gm-Gg: AR+sD13jRIv/w65yfHHpXv8XLnpnOJluzf4WEHKn7werjWCalDFexQLlf1r28LZr4QX
 THl8D6Xx4SpExhKn91RjX3COB2IoZebAm+OZdGxXMHbOaokgqCwHreQoD0EL3tY4tzVmxFq431D
 MUipfATvT4lM8R6oX0A8EySjXVppkQJcjxII5Hsu1Ow52U6x6cSNXth6CmFnDU3lJUVq7BMHLjW
 tzqBKUmEia+Gwd/y5ifn1RVBGO4M8YsRG/7GGfIDy/fXtvOGHX6OZG+4+dC9vQsC4jsj5nJgbcK
 yDSxHMjgadhxblaHF9dpG28fTxrhVtlzjNi9HYkrgZRwtUClXhbj96QIDMWOoCaWxLmZyQhcmTU
 QcU+MkOYD8ppxR4+X9zANauA7Dl80o7RrxnAJ5DuGVqLkzQM8CnQhBwQxkUGKenSk2xMD1ucouX
 +9cT7vXRnTvzfEXiAaNodFhfgua5om5MGbU/xcRKmTErwjOwbK2LE1BzouBXt7OXRU/ue2Z712H
 MoP9kv3t8rcnFehzGXPVc5pOLyaOXb/w73W5tKG6S6VgtGHq2vs86tmQZgNWm19E4N/qOTtWC9y
 +97JRjRz++O8mojz8lioSMwAXr/2XsQY8DHtcA==
X-Received: by 2002:a5d:59c8:0:b0:47f:9404:5185 with SMTP id
 ffacd0b85a97d-47fd72c78ebmr34730737f8f.24.1785845478422; 
 Tue, 04 Aug 2026 05:11:18 -0700 (PDT)
Received: from p200300ef2f11090032755c67e6ad8da4.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458adc9sm45671047f8f.27.2026.08.04.05.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 05:11:18 -0700 (PDT)
Message-ID: <6a71d6e6.b251136a.ad181.4a5b@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <anHU21C6px2vFMyD@yuki.lan>
Date: Tue, 04 Aug 2026 12:11:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] metadata: add linter for JSON file
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

> I want both, this single file should be part of make check-foo

what the -t should do? at the moment lint.py already supports stdin

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
