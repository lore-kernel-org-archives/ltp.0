Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70868C27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718814543; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=P3LYPeA2PBm63ZI6SuGbkG6PscLaRSTBjgS7zUdCPS8=;
 b=nEb/Sv6ZmY009v5A6Q7gGQb+OKaoTUKRQF8rAbNPcOM5ZFeboQPLDT8atJUKOygO8Ih7S
 Jbq9RHO//RJRicr0EI6LzpQUTaklbZpt8tx+nXR6gQl6e+kZ2KQ4H1aVt8aa0elwn+BkKJi
 TZ8LT/RxZYiOz3bVkRIk8ZBEMAtA1h8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E89C83D0DD6
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 18:29:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 130303D081B
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 18:28:14 +0200 (CEST)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A880314098D3
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 18:28:13 +0200 (CEST)
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2c2dfbff88cso17217a91.2
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718814492; x=1719419292; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=RJb1ZWagckoOz9UhcjLsTz5b9JU0HY0YqbonVprVfYM=;
 b=gPrJ+uqQ0Fo+8CQQTBv9oGLOzWFyW1BwTSzV5lDyXaXFQ2eP0MIVAXKYxTp2sj65x9
 Muk04oAVb/lN6giS6SAh5NshFs/PzDTaumptKywo11FsojKItn4dYgIzEGhxO3ylrW4d
 zEnqXMMkpgsCnqEWUS71w5VtygkXj2ZY3tykp8ifyVJfbhlyrCnWgFn8OLrBjZQo/NQN
 reS7Xznwey11SJ5o7yTRT/u9P69ZIXBwXuQZUvfNe2IhMITD2FW9wuOSp7lc5uE1lvuJ
 BApdW4pxNLvvdr1mVKjmygsQK9VpbdQLogWHQ5AGWuRzuEFC7wutZjyKQ6tQ1WbdD1h0
 9VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718814492; x=1719419292;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RJb1ZWagckoOz9UhcjLsTz5b9JU0HY0YqbonVprVfYM=;
 b=ghxmbnl9mtSDjwrqfRdpnh2h8ZaAQf0oxOWI7Z8JD6HDemY/Mxzo0koGPaUXha5Nv3
 7thRlS9QOrbXYcq/Q9XpTlaXQcbCIvS7uCAlgijyH6qipyZjZW6/o1Z4sVdfyrBNWapE
 6xxkPbPgA/mSFTbC4XmbGDOBCdASiMWVf7KSEzspEXiXYFbUwqvFOP18Fc9B8ofYPyZa
 DecZ7Xrbz5hPFHQE+S4k0KfeA9K5b+V0IVhiXu2ftRp74l+Cfd8pZsncKzwHFXX/RZIp
 A0/CmbIvBlq/pkZYfIT9CXFFRczmNdKxL9XYmB4mHkw/ubJJD4/hzZp6qMkgptIxFdhG
 cXYQ==
X-Gm-Message-State: AOJu0YzNj8LZonI6OLxKWKu3y5+VL1YsRxBYgm8pirK74dXVmXxx8uXJ
 pLC2TKTb5IpYMnvQq6DAKLD+jB5PNc3kwwazJVp83ibdL5F5wd1Z7rPuk9hO2jWO0wlM89tp7cf
 NUE7eQqw8fXehHXxnsZ74SIr+tTZfE86yriDx8aaFPDb5CrRJqOnPrpSClO+/mn3s6TTR2mjD1i
 tdQm0tRjHGGc2v+gTYw92li23u4Ps=
X-Google-Smtp-Source: AGHT+IHNyMLux0DytyQHTOrG2uPRt3EdVob1wDmjXlBJeScbylfLh6dUcRqcG40FPQXr+ADJaHx3U88ssFQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:1091:b0:2c7:3a76:f6de with SMTP id
 98e67ed59e1d1-2c7b4e4b167mr18513a91.0.1718814491814; Wed, 19 Jun 2024
 09:28:11 -0700 (PDT)
Date: Wed, 19 Jun 2024 16:28:06 +0000
In-Reply-To: <20240619162807.2725018-1-edliaw@google.com>
Mime-Version: 1.0
References: <20240619162807.2725018-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240619162807.2725018-2-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] sched/starvation: Fix sched_setaffinity return
 check
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Edward Liaw via ltp <ltp@lists.linux.it>

TST_EXP_POSITIVE to check the return value is incorrect because
sched_setaffinity returns 0 on success / -1 on failure.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/sched/cfs-scheduler/starvation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index eb9fd6ff5..c845af849 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -54,7 +54,8 @@ static void setup(void)
 
 	CPU_SET(0, &mask);
 
-	TST_EXP_POSITIVE(sched_setaffinity(0, sizeof(mask), &mask));
+	if (sched_setaffinity(0, sizeof(mask), &mask) < 0)
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
 
 	if (tst_parse_long(str_loop, &loop, 1, LONG_MAX))
 		tst_brk(TBROK, "Invalid number of loop number '%s'", str_loop);
-- 
2.45.2.627.g7a2c4fd464-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
