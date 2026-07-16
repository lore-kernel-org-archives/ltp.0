Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAF5C4450A
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 12:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784206351; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=VLNMUYfZydvenKj98W2wHtxaJmK36Ii+mG8chV4KjWY3OTlJHkffMSdPRv3f5XaSs5H4b
 fO61Hu6IB5DZeXpV0NgPz1hNgey7M6n7Vo6atNlrec/vjjPCnTve43cV779j6oYVmdLHw60
 IfD49WQwtz6bxxMfou/ahLE1Lc/sVFs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B87F63E5649
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 14:52:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 804673D2269
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 14:52:11 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 002782000E6
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 14:52:10 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so12665555e9.2
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784206330; x=1784811130; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=C2zY0O6yTgwDfeH7xXqzpJfs10Jo3hnhBCVKWgyNiXmVrnFL8kORUjpd983RkaYGjW
 RGahlKEBgzqK4RUbQ0DKgKtskQCEpP4Exb6Z6upQLJL9v7x7JWbl4G55tirGOdmU3KLQ
 B0qaT9CiHuUHb3UlzjuYkxhXqbmtRuoIWRZL/S9OXQ5mt80XaL0QwghSv20qh0dTmneL
 Fkb/iJbcsZr7p3twQ5/XVkaVUDX7rYOVgksf2p9JY/4inKu7wNEQZmWhFcbmaykWE1C7
 aODsqnkBhYUDwj2n2NwoTIj/BGIbAW6gnqiF0qbTSF4Tif0kza4qcRXk7IA1x90VnxcX
 ilmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784206330; x=1784811130;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=MOCMGkk4xkD/q1JMOPSGh5tRBlgGv3JIhRBJsMOUhnesv2hzIKAs5RHWDvsEBiPIVN
 s2EgqH/odPeFg5lCtfT4Qhe4s51J72cAkeync27p1RZrVugX4ycSapdNjBhhwBLnCS7B
 awEpg1q+t3+Ejjdj8AqRYrjSdvcbeCP74kqKRw5qmyGms42cWLG3UpLtZPd2PG8bBa6M
 m6cwDDxzRjxloMqrWEb/SR1dLtgPC1LQjsVhTusSBVyXF/NXDS+ZOfQPyDnfrXcTYUwD
 XHeA81YtEZLl9JjNUq8RhdjtbFFtSCkjC5WMCLJk7stj9A7qNFZy4s4tJzg2zh/chHcK
 4x1w==
X-Gm-Message-State: AOJu0Yw0KZn048Ohj6lZcCGt5TQOJH2fwOQ+oh+XbGwkjxHPrcEyD/T2
 f7z8j3ekx28x9Go/0s6kyd9s5osGVjUwCLOIxPYwlWQn4W8YRZV2PFOW/p21zvWffkYGEFL4Q/4
 dP1eujbQ=
X-Gm-Gg: AfdE7cldKJTq+k4t9HPG40UYcpYQHQ5N0Hrf7H96Poi40jQHoAcypUBWrdMRSqI8RVP
 4l9kbPUy9FFX4L74LBOpKzbtclYLPa5e0TvLNe5g6MQCbZQFFprX1NagECOfP5u4OTdyO8FdvZV
 rJ7gQdi4e7ZlwahrB6RQUfP4psVPXDgYSLve+sFUZV2GatNC7Vg/0AUylRFHM51jRC6Zl+H1dq9
 S43EnHzgvq1Cx/M7IuAcambacuM/3B/jhL1nmC6NXIUvHXM9IJFRl7na0qrlmtA5GXujkGpElCP
 gs1gsYVdRa3FaI/wnzySakPYb6AU0x7tNiBI/TuhlbeT/L9meg2If0h5GFLyFwR6mTwxQROLNdC
 Kq8Ae8eBZb/fsleKWNqhZ2WcK/z9P9TPVNYRXnAJXlRH/ESFUYHBg+GzzDV7KyMu48n/H57nlIH
 ZEKT6tyUuud/IwNlrJooNEYQ==
X-Received: by 2002:a05:600c:b85:b0:493:c062:a533 with SMTP id
 5b1f17b1804b1-493f87efaa9mr247094335e9.17.1784206330265; 
 Thu, 16 Jul 2026 05:52:10 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541e9ee07sm59184255e9.15.2026.07.16.05.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:52:09 -0700 (PDT)
Message-ID: <6a58d3f9.09e844f7.1a9596.de99@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260714-cve-2026-46331-v5-0-bab4ac23c1f7@suse.com>
Date: Thu, 16 Jul 2026 12:52:08 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 0/4] Reproducer for cve-2026-46331
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
