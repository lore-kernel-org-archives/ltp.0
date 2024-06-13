Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A3AC27C4F
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 21:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718312517; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=f/MJSyIL2EJpgSKKpyp7/LDpJtKAdjCJPT6iEhTOKLw=;
 b=qJtOgjuGL8MwLUFMoS7FbmMUfDYMm/ZY+iAY1ffA84qdhAysArjwOl70LRu6Zaa6Vsnhz
 v2kLV2zYPKZ68gKSpvFqWceC/B82g1izSJ7hxOZvu5tt6UReA6oX7YYZZXRHIhi+leS0GAS
 hpXtKhdUGLKfj3m6+ZGiqwiVPFrqw7c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABCAD3D0C63
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 23:01:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68EA13D0C5A
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 23:01:06 +0200 (CEST)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BB7771A00438
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 23:01:05 +0200 (CEST)
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-6e4d1605a03so1400164a12.3
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 14:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718312464; x=1718917264; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=j6mpbqsQj4TDIMg3c1XJXVU2quuYMeVG+UUMI9pH1XQ=;
 b=JXgwj5+P/QfKQMkfLeI0P4rdc7P/HsSAq5jii7C3qL1CvF3JP2YdjtpUPHwg4xFtGv
 eHP7af6etfKctog+aYD+h+8jTUSXdb9Gk7ggmAay1Ikpq/lpQqxywl5S2FQbA1U8YXn0
 6kWDNZCSIvdTtaGIcOv2t94RmgkuuxiLl7Ps0Tb0rdHJSzsUIqX9bvo4JkQQm3QbkHG+
 V4ZMFRy6syUk+sxpp8C8o2voge14rjRKb4EMR9wRAZ8WjZ74qy1eUj9TR1xt2BTHvgKm
 /BKIfhqQmDP3E1lnm0jDPg0UGQkK6/4rRWpZr5oDbXcxHTOfdn+UeXeRWOyUitgFA5sl
 lvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718312464; x=1718917264;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j6mpbqsQj4TDIMg3c1XJXVU2quuYMeVG+UUMI9pH1XQ=;
 b=O9/Y/zvk/XlRfvp70qm67mOhF/bIyHAb/izUQStj640xlkrfsuS9i6LLRjIX65/J+s
 OiOXeTgE+kdImamNJrDzjOJh3huSflkv15hIVqNc5M92Vd6/XumDsP6PexdkA8oF34fJ
 IceJt/U8V5kD7ognmHYX9wwgj2Hv2SINF2n81iMliFcfbE+s7YkTekTQuZ0Ikbk+ZbUW
 zYohUCh13nNAZBKTYuhN7osInu1pNIRryjafVJ9K2D+/EsIqb67eU4TM+XKkXYMqBEO8
 WM6Rq3vlhokXtlqBBYONw0oLWjSZeVnBKKFPrC0j/mU0Hmybz9MvEguPSXuvfHw999po
 SAyg==
X-Gm-Message-State: AOJu0YwqV55Vibr4NETHwWfUyNN586t+CeAYR2hfTtn1Jonz/IlX0iAi
 og16uRlO7q+f50Yrq6ChTnCmbbN8xYLHudKEVDwhBGhe94pM1xmC7ll/EBUVqhN6vsrtRx4+nAd
 q6hxElnDk2Tw2r4UaNSqG02ftP1r5prilVTB1g3y3cjTeruOe+iwmOEWNcxRL/Gwzf5Wq6Bzb1k
 KIcefoi/QBMuTVuVebetCy/ZKA2z4=
X-Google-Smtp-Source: AGHT+IGf6xMrRzS959QtvDEDIAwLioXT83+UfAQ4dfpeGqS2o3OgMhvNca5cC1jEaIlGYXt0uOz5RWcQEIk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:2446:0:b0:6be:96a4:1363 with SMTP id
 41be03b00d2f7-7019a78c7d5mr2029a12.10.1718312463886; Thu, 13 Jun 2024
 14:01:03 -0700 (PDT)
Date: Thu, 13 Jun 2024 21:00:58 +0000
In-Reply-To: <20240613210059.352767-1-edliaw@google.com>
Mime-Version: 1.0
References: <20240613210059.352767-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240613210059.352767-2-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] sched/starvation: Fix sched_setaffinity return
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

TST_EXP_POSITIVE to check the return value is incorrect because
sched_setaffinity returns 0 on success / -1 on failure.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/sched/cfs-scheduler/starvation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index eb9fd6ff5..1d0d5ff97 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -54,7 +54,8 @@ static void setup(void)
 
 	CPU_SET(0, &mask);
 
-	TST_EXP_POSITIVE(sched_setaffinity(0, sizeof(mask), &mask));
+	if (!sched_setaffinity(0, sizeof(mask), &mask))
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
 
 	if (tst_parse_long(str_loop, &loop, 1, LONG_MAX))
 		tst_brk(TBROK, "Invalid number of loop number '%s'", str_loop);
-- 
2.45.2.627.g7a2c4fd464-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
