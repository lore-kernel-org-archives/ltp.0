Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377C9FF8870
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 07:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777361155; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=ifRIKVWqiA0j/4Q/JLqDrALmctJNyJ77Q4vaXtKQvsu0hwCh2KKzl33N9lfNWVqCG39ea
 /LBuGm1WmenownGBSll9pi9MWhujN0RU9iqUmjUWeKu06jOxHBNBZ3SDBOpovsO7FEEH8ev
 NcN92G+KWI5S3RqQoqzYAwcH7EHSjsw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E99B73E2532
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:25:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4943F3C66CA
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:25:31 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E34EB100098D
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:25:30 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so136075535e9.2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777361130; x=1777965930; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=FqTo+pgP/N2HsGTCGPn9JXcSaVa+JV6r+f7y2md7P4bdJTvAJ1pTg0r+m4caZYhxaf
 pTpTOh3dRbNavStMWsfoG0u/ykEnpT2Xt7kl93NrwICLNFQIP4qot1WQ1eXKZpoMy5K8
 FLz42yQddleBTEHwMpv+6Xydj94754fiyHWlOJGWkmJ3GEPlcv3juLJ1OYJ9kn/hY/MR
 8OqG0ZOm7DGI+wvLlPbnoOJs2Vv9+015b5STUJ2c8Q4hxIXEc3mGajoj+svR4/EaofyP
 hvXy/ahNGV+EIkotA6KU3pnX37agL+d1kxWovsWhQGLtTL9e763GnoTx2DRZ9scTzwOM
 P5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361130; x=1777965930;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=mdDpTczd64ozv8duinCm8fEvpf2tAVHJAOq5SCU2RaAFoyajqKkVXozMMsXfrglrVy
 4wWVzqPJl8RSQ4ELnatUYxMOMDDPUoJ5mDAXVxcYmaoj8K5en9Xr26SfhXep1wHYl9lL
 GRh0Gp1frEXwUsWPf6yKynhXAwCMtoap9OaY2BYceZBI82e4m6e3i5AwoKv7K7CNOOTA
 Lxg9hkqy1rrl/hqtI0eF+axM0MRZox3nRmTE1aQ0qDmKPzyqkHE0qJ93jGdtTiO/PN2Z
 XhWPaVgWcfZP6WsxZEEp+iuXAZcceKStbMGBUMgh5O8mC5MOQcUolii/kkuTZdRo2DyU
 GM2A==
X-Gm-Message-State: AOJu0YyZE4/0CKU3dW8YHa9OWmLBeS3bTZjuf0dvSxV98VOs49voS8+X
 uJlpLkqckFiMJGL3I1tS59ScYGdeQFezESWq+xMP74VSxPUBu/qoDi+aUyWhGgPs/TfxieVM/oO
 81fnufhQ=
X-Gm-Gg: AeBDiesCxtIa8gmdqzF+ZnkZQ8a8un2qIz5lo6/9/9/IgTXn1kyny5yNacCBuztLb00
 v1roUohyiT+YURCb+lAx4MPpz61zCgC3QWANGKqR+HnldPGKHRjpVNS6fEDToOpCFEe2Ejuh8GS
 Ey+2KRUKXdTUdtqIBureD4SVt0q9eSENWLX8obSKec176ak5AQEZsgpK32Wz3pIl55i4HRsf0C2
 DS/C0/MUzic7nzB1QOCNWj/RFEH86JMuWTiaP0K5Luz9Cr/gz7h6epvFmkc3fZcEmATzMEWwl3D
 QHrRGDjSrMolk6xpL6cx0sTUA8sMCDCn0xgKiXozAzKxTO+EiB0iORGBF4FxgjjFeZ8iXZOsEtY
 nzeUyyGrKpglC6YbJfVoyCptXMWZtlewMa3wpx8MenfCrlBZH3zYKdja/v5MyyCblNhac0IDnGM
 C93LQlXGxIhA/o0/SZMb4VuGKyRW5M4I6oJVg/xrL8T8MUvb4cosmT
X-Received: by 2002:a05:600c:1382:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a77b216bamr27865315e9.27.1777361130200; 
 Tue, 28 Apr 2026 00:25:30 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773efe04sm38899225e9.12.2026.04.28.00.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:25:29 -0700 (PDT)
Message-ID: <69f060e9.050a0220.2aa67b.3aa3@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260423120309.18049-2-chrubis@suse.cz>
Date: Tue, 28 Apr 2026 07:25:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/8] syscalls: Add epoll_create03
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
