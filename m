Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBA4CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 16:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778083406; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=Yn8xi1dIcpMzeKAsCkDhZsUaJCJUzNieuQQFU5YZhR2dKc/SHal68Db5y1MN0shQuYKs3
 zcBoadULtI6vx8DXt/bDV7jlEzq0Sd1KLXz719jZ4MG7q6UC8rAID/j/igu9sv95n+BqNzs
 vIbrZQS/K4Rn308kMi5acqVeaav4oBA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 298373E6AA8
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 18:03:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E9033CCB1A
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:03:01 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A973E200AF8
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:03:00 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso2473390f8f.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778083380; x=1778688180; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=MGxscpcBNKaZOJFn6vlR4xH+gHpOCeruUPjiwqeeDImf9d3LnVyAKDDgQfW2sdHIUB
 dzit62AirU5VOdAcd4Bt6JwKPveNl4T+QSMFESMa72TVturg79S9jbF1vmh8Fb/tYoUs
 xirfPSXIrF1ptSq/iZVIIkqwEd5AIhIkbwNITY/W9Jj4/cIXH52aj2YS0lZ8dKkehgT/
 7sAyEZabAGfEz/6Li3bmOtUspyuWBGId2HM2O9+5ZZSRHZ4ViQAea7tAigtFBkxASed/
 axpxCFAo+8AMkTlNOekDnK19MBB0aeKBB5lCVd+RDV7L49otWhziQI1LQCoZyzvTiAaT
 JR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083380; x=1778688180;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=awL+2tf08D5v/6aScKQ1JWMXVD8Jz0tX4xZAsiEqmoOiizb4oLiV0Iw9sKz0OyaU+/
 PG/7K29a3EWyZI5H7jRra6gFfKmC9del10Gblih2RlALrOYRF0nZtwqs03gSc/r9TiKI
 ykcqNE7UhCGWbeVgVK8Vr1DxQ+Nls12AYSMcbBwHSofcobl/Ki8Y/QwYHihgw8QdThwg
 NilGwz2VIv4J2UvGq/87+Jo9FjXDaG0jauSpzVZ2z97/WUxZ+e2pasrB3IDDWOFikQ4q
 EKUFvkkif8Yn3rfZu9PBdXF2+sxAVX+kTxreOHQa3WbVAzFVcf4jy7dV7LZKyHsh1msI
 P/7Q==
X-Gm-Message-State: AOJu0Yx+LFoJYE8E5K03HhG+BZE4M13/oZN3czof2FdCX6EXxgelnfGS
 m28Qf5WAggBys8uGIlNogMJ0agBmejazZi4KfsGmC9ifGF5XNCXP3V6PQWQHKmScCLs=
X-Gm-Gg: AeBDietshimLMJSAKj+3XWh3vHVl7gAGn0kmAX7PXlG6/6vvEkC8zyqp971H3wg9dem
 1cNuqnYwr6DjS7uEGR78XfnBQLxC52iPArVf/6jicCBvAE+NOs0d7BEjA0xS6Ve9MZ9GkYz/Ivw
 0qK5nge2AfGQkSXLSFKtLUPrQIJqvQiv9tMZsxTpTbR58wPiAJSKZJdl0nfspeDKNPijhespjhC
 IqvmUa39OH68+VvAGG+RYV1IjPey1llCiy4JX/gOJFsRQMlGIW14dJbYVFUajIzOVhNO+Q6P3iX
 O5KkXdhV/8laF288+X4Yx9KUniZlAgb1yu3LFAc6FOM4OHvQUyRUen5rw84g57pDMEfiJzt1R43
 alL+h3QsdQmQe2y2LhnK4+99copeCZzTO6Fz0FpUHv8HNofXFD+uLRuFG6ui2573LY8Pt/KGC9Y
 L81T0AhX3xo28YeOSuhxkSLImWaxaXTD0BlVkjjBk8QsbwBfj+jfmarg8ewLMdDgvd9NobxwEJP
 o6YcP+vIuchbT9hzMsr7YJ/mrHXJM7G9WiJm2Rj9GOvxA==
X-Received: by 2002:a05:600c:c4a3:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-48e51f258damr66160305e9.9.1778083379967; 
 Wed, 06 May 2026 09:02:59 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fb19csm53580525e9.11.2026.05.06.09.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 09:02:59 -0700 (PDT)
Message-ID: <69fb6633.050a0220.1afec7.2a7a@mx.google.com>
To: "Sayali Patil" <sayalip@linux.ibm.com>
In-Reply-To: <91e8e5a0259ba981e530d099eb053395d8991177.1777377311.git.sayalip@linux.ibm.com>
Date: Wed, 06 May 2026 16:02:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugetlb/hugeshmat05: use size_t for hugepage
 allocation sizes
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Pavithra
 Prakash <pavrampu@linux.ibm.com>, ltp@lists.linux.it
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
