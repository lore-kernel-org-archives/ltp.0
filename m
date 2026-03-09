Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD9EF417EE
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 14:49:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D98943DD984
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 15:49:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DE543C198F
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 15:49:07 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 11BCB200912
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 15:49:07 +0100 (CET)
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2ae4e538abdso79539525ad.3
 for <ltp@lists.linux.it>; Mon, 09 Mar 2026 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773067745; x=1773672545; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHPBYp5AZpX/0AWfNq6WCaf9VPvtx1yxgsyKF0xcQ8Q=;
 b=EYnxypZEKsm+E7LUTlZmYUGPhM56Bn3jGk4fcAbJPGK732jDdAP0YFlqF6/BS5cYsJ
 BvRv4x5tpGTE/piD6ABSVNwEVjdslQnSbhnpjbeTueOse8TtSEWeVHA+ZLxGDEsygeDk
 x+l3+Xd2Tx7NQ4QR5fuwEzm8mNoKHMAPe1HdjoQnVvGgg6p3wDme6KjOy6oyPyWEXCXV
 bnVxdYkIZ5cUErxu1XiOOufHZNfb/rUjgG+ITJNHBApw6n6KUb9bKjyF9ReVBajp52EL
 5ppr+6DbtwKY8foAJ0Nd0t80XgBrWSM/48Z22Xj2GNAsDl3oIAaowl6Vc/1vDCDnyih9
 T3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067745; x=1773672545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HHPBYp5AZpX/0AWfNq6WCaf9VPvtx1yxgsyKF0xcQ8Q=;
 b=hbXxo2SD4GfX665z3OeXE3Ol1PZBBVfTPuhrT4bEDIogI66bDrUcYkXw/4wdTQlXV3
 vjEUAz6s1YAqhjeOZqTRjk30eU+UnCCwxk/7LoHUZMa24efBdWE5WKpzSTBtDCMz5Pgb
 URH8xoynPF4w2QCzd56vVJLFJCWArJZVgYERl0NTjyUvZHp52v9xp/O9MyHyusKFU8jY
 tnMQSipcZlhEMH9FxV1eiBG8wsR85MILrCijjTX8C6BJ/I1gM/Hf4TzGXMTQ7A9PwfZB
 acGo7zlnJty715ZoJ4NquRRbu3JcmPLvWbkp8THZSTgsQ4cOWWGreezJY9KxjLAo1Ufa
 k73Q==
X-Gm-Message-State: AOJu0YwpE4UmkicO9BwOZmJY/2ryClzr5sa5y1/gbpakut3Ef3MIOq2F
 5NGo7o1EpVFgRaQbqV4bIMER8wftrdOqJ31etofynVn38aBdAvMxlzW6ZsKmNj0=
X-Gm-Gg: ATEYQzwhkIuORqrzAUklkmU9vfbb3hmj1I4x+UMzZAgMxI1kC5SFxxy7xuzZI1VYpSx
 JrTsWZgbrRJOK/oHH6hzq9HNltuSvYeePY8CjLpA3so7pe4iyduSN1uELIJlhSTqthzp10PBbfn
 qb7pF6D4eXhz8WIcvzIt+a9jdWiV7DLEOxUQrlnPblQn/2C1+EFMxphNwm+QAOIscwPS5MPuJjN
 v2om2r8xdeUr7/hi4x6/powRB7icm0EO9m9jx2RhG90xKnWYlPdnbT917e371NHBitav3PJH8gO
 r4uIFr0uAAn2Tmy8vpn7QxS/EFoCuQBf/GyCWRGb4irgmK9Kp8rmRj+Qa8RHXykccZSSFnBjLgr
 EoGyG45TR6/Ndla0E+TECpRx8FAP5TPc6/xqAoJvXXUlb0oSiNYBEEdHTPxyvJUOHLA+PBCwNxN
 MGdiUjANiXNTe2qVGG4A==
X-Received: by 2002:a17:903:2283:b0:2ae:5223:59ac with SMTP id
 d9443c01a7336-2ae823849famr109551595ad.13.1773067745430; 
 Mon, 09 Mar 2026 07:49:05 -0700 (PDT)
Received: from JS.lan ([171.3.84.26]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83e57b1fsm157941465ad.12.2026.03.09.07.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:49:05 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz
Date: Mon,  9 Mar 2026 23:48:44 +0900
Message-ID: <20260309144858.717-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aaq6eVykSC-dSZHg@yuki.lan>
References: <aaq6eVykSC-dSZHg@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] inotify: clean up build and make check findings
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

That makes sense. I'll update the arrays as suggested.

Thanks,
Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
