Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD19F8A174
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:24:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 665F83E2DE7
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 15:24:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29AC33E2926
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:24:25 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5E62B200AED
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:24:25 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso4139379b3a.1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776345864; x=1776950664; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3uE4mlNMGIvIopK84JTJWviefhU6TLm5wlqAsg5Mmw=;
 b=K5vk8TdAXyOIaPw6taNfZfFqZGC4OyMYngVvgxk3g7IMK/mCi/xFshGMpVBIEP1L6/
 ALxHsHUDICRk30J0GXoSHw3gGNlSWRVSjFkTAquQzHZxiUYAQIR63GLUBymD51+i7w3H
 kggV7O4b+bvyMbAq42XFucDbQaqxBQUlOUqnzC+zBOarl2lhkvqvFcJIDXKs23khoqrp
 z2rG7qigI3ELEwJZXSxbqUuDnA+nmwBRzpGu1aieE+qYQPOsAAp2PzCFp1ybdD/NEeTP
 y9gfirHazEkf5ix3REQVfhGy8suOapew6+C0kLq4jlxfmxoDD552bhWZRbqeTFndCZDb
 XNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776345864; x=1776950664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R3uE4mlNMGIvIopK84JTJWviefhU6TLm5wlqAsg5Mmw=;
 b=pOKbvCoa+HiuISTjH4YRribckZPkybiXWLKcIoLjTZFvXEvlwt3BWtLNzntUzdkh3d
 R6ywZwqxfaCQddRLlsneQ9ubQwNDqlZAXjpmLTbcOtJkZeISP5hqqrY4klNHlg2VQwNA
 uvVtJMLbjsAfDbCqs6GKEBa2Be8rm8MaQ5b0eMSEI2MGWZfu0EwC3HeAs9tf8vCbWURn
 kXPhhTXukkn1BjyhoATA4B1HDlX+99zAOVS6fkXLRE5/1f5r4UOydKCN2EAjnFo8QkXB
 96yl4rRhu7is8ZqAa8s6myw4vYQ3CqEtKgQeWK0wLUfjlbmC6zQimLmHTcPka9KSZpBM
 CBiQ==
X-Gm-Message-State: AOJu0Yz3rIrFWaK5LWCLbvdSsFvY1Ltf/V4zH3NJoG2e4dcQiK/qdgcG
 nWPwg3KXBb0ssyIv31GeRvp/TULlKXzmMX1SaAIhYSWCotGJMV/5ZZaDPURgi61kvaHo
X-Gm-Gg: AeBDievjufavEKNaxEvQVShdBUFAZQ91lZ0jW5t3ueiNxIx6iidq2UEjGWNTG4rxOjj
 27kK/9kwL2ZDkJWIUWdRraGVlN8xuxAhSh/xAJhuxOYP8qU/ifYDv97wqCNvAmT0svz6igkDvps
 OCz3Jl09iNKlE+w0WnnCNi6JELyn7BucmN6qg7BkHXhZc1BbVs9ADZl1OZctxgZ9BFweE4bkp+6
 ph2y3RoN8XYJ3Kq8lIVVA4QYMcDTDmJHRMrK8bwOo9cOgYPflAUOnvrIC9ti/DC0QQL4ivW65go
 yytE4lVC4ym5dYzBsrXPUGiTCl5Hzu0YdEaWBvz7B8xTksNTol6U9cwWkAv1BrDjWkz7u+3XSps
 p39z2+REH6tMznSglEtJONZTuflShKIMljgSKT2fzVOeU4RFPehmXI2bCQCGZZ7WG0zappvv3TY
 gACT+0fQioQedM6GaM1Mner6BtIh2yRgMwN/n/Q60QCFH6tshlJDK6Bss=
X-Received: by 2002:a05:6a00:1896:b0:81f:4566:ccde with SMTP id
 d2e1a72fcca58-82f0c16a5a3mr26104088b3a.20.1776345863628; 
 Thu, 16 Apr 2026 06:24:23 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f6747541bsm5420443b3a.59.2026.04.16.06.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 06:24:22 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Thu, 16 Apr 2026 22:23:58 +0900
Message-ID: <20260416132400.3046-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69df73a0.050a0220.11c737.98a8@mx.google.com>
References: <69df73a0.050a0220.11c737.98a8@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] read: verify read size and data correctness
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

Thanks for the review.

While looking into this further, I realized that strengthening read01.c
in this way would make it overlap with read04.c.
Would you prefer me to:

- keep read01.c as a minimal success test, or
- update read01.c and drop read04.c as redundant?

The main distinction seems to be full read vs short read at EOF,
so I wanted to confirm your preference before sending the
next revision.

Thanks,
Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
