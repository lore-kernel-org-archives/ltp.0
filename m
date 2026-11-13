Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31999606A32D
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 04:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Z6BOPBoG;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=bWnGKyVw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794543120; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=NPPKbSK26lfKP7x1/R/cGtohKY+p3nksaigtEoPfpSs=;
 b=Z6BOPBoGdMAOCxoGCBxJTycfcm3prlP1KZoNVF3u5bNJWrPIBY0DeEVhh727gntlTkAiu
 hQxm+6eLSzGUvuDw+71RbYOVy8JVRly8Fmr0RrdhjoDTPZOexPPzVcwtD58DQBGzwRlI75e
 LKgK20ZICoqLjc88Z298z7LpARWt45o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9304F3EB501
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 05:12:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45D0B3E2E48
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 05:11:40 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AB280200AD7
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 05:11:39 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so194884f8f.0
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 20:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794543099; x=1795147899; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VECxucycoL/cADHhDCX/a2x77/7AX3LUxeQxxliUb00=;
 b=bWnGKyVwjy4yeCIHjmIseIP8qCRP28s9qqymrTgT+CQodU9lqbFZCelNNwocXjaADN
 5nhpZ+lh5aBCTqqG9p4KzMnuGbxBaTopPzN/2J+VDKDYjvUD0abX7M39tMTtQawQEo+S
 n/BvYD2+XkaFLD1rd2V55rT3/SXWb6O1hJ5bAG5k6++hqmpnQGBWNClNWrdualtXeAaC
 /berZeQRi6yaf7aRh+C5YOJGS2nnM/CKnB04T2x+q8xpt7JMaXKMY2o2YJIxVftSlx5O
 9LNeYzNuLN2fSqMVfTnXxFbqTN+UbFhsVSYmoZL+ral2dS1HRYZU3nE4GsEZgmi3ZqA4
 PeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794543099; x=1795147899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VECxucycoL/cADHhDCX/a2x77/7AX3LUxeQxxliUb00=;
 b=SBSGTzWw4mblEXgW/Cn39gQtLh1bKKP4b3ED9rkVrxdDEFtVP38OkXg8Zyn8D39XuM
 MrSTb2QxKDFLEFfldU9Vcls9PZGbp5ltSBWp3pHdenjys/grr6JUYIKNPcMGMIqMhMwO
 BwqvXifMf8MvPfNgtIzzluoHmL00gbVqgHaifxUsAYN7YpOJYCpUh7bYLryVoO5jbN4/
 r8Kel3o97CH3qpNppJUP3St4TqrJ5bnSZCEaFt+tmINkBA40IknaHtdETdonmV9WDRZ5
 xUYpOJq22e39OB21k206J+QGGZ5EMUhV1l0plUmaFzV7+D3+CyZssBryFQRb71RiaoLK
 EjYA==
X-Gm-Message-State: APuU4Z/5f8r0LZcpqFxZgrM5kgW2GVnAsQbKiKZjKYuhspMPfoCp5xLZ
 S38oQE5Dgwjcdv/w9JSpB9gd83bQa5fWkc30ifOfMmXK5Y2r7yRYx86xqU3yB0ZiVhAJtpAQQ6R
 69p8N+g==
X-Gm-Gg: AYBFou2Xjpqd4IO4Ym7peEtySyGdUNh2/7UWKvnw+AiVqnKoOg1FleHgOqK40f1/BUT
 WDdfLChv5izxj5IxgghEpWnok3PI8JK4wuzH90iezqSiObZR2y+7WYIP2uAOVQvCpJVRP7JwSfy
 hbMeVf1gyiv8tTZPq0bxacmp7UeDR2La0oxy7RtTnwz84ub+FU1QudBYWqw5qVYspEK3dtkoNa6
 JSJKVI0bRNazDyo057EZb0ubbFoN/l8PQUyLGgxPWm86ZnLHCE654/hDx0ZBwGq3sezyZ0Ql7Wi
 nsKHYW1Jd0F0I5+PKMmMGT0Zn7unrv1oYNCWyBgl7S9u3aAsXdiBhffYCqBzXR1Pepz4ttb+7AU
 S2z5xXCAV9MNKtwP1UfPUBqwnF/4hUYcHNkYGQ2MThpBtlMx+08V+Llt8vpgyWVlqIyg77DkuK7
 Xtako4wgz+T2ljgi85Ak1Z6roZLO4uWy1vUn0XL+/tHVm/1zDedNltIUB5MCZBzpyxNNei65ZO7
 sjM7g2ZeDQtkG5IdthaRUVbG/CVkH9c8BMdTKVWhO+ExxljKwxJ1nxbn+3eCNCdb5s8HdXbCVu2
 LLTUkNRWA5+rGxLSz3V5IJPp3Ko9w1RIT+/NsOZWJKdCVCWIXvZyCV/eIhrBgnDuL/oaPuMxVS3
 pNqtSbbuBK/DY9SJ5Pjycvrd4XwAofztAvw==
X-Received: by 2002:a05:6000:2c04:b0:491:3fdd:af42 with SMTP id
 ffacd0b85a97d-49c72c9c049mr2932733f8f.37.1794543099022; 
 Thu, 12 Nov 2026 20:11:39 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-49c608cf46dsm2724157f8f.43.2026.11.12.20.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 20:11:38 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri, 13 Nov 2026 04:11:29 +0000
Message-ID: <20261113041136.17102-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] memcontrol03,
 memcontrol04: Bind test process to a single CPU
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

v2->v3:
- Move bind_to_current_cpu into include/tst_cpu.h
- Update perf_event_open02/getrusage03 use tst_bind_to_current_cpu

Wei Gao (4):
  lib: Add tst_bind_to_current_cpu() helper
  perf_event_open02: Use tst_bind_to_current_cpu() helper
  getrusage03: Use tst_bind_to_current_cpu() helper
  memcontrol03, memcontrol04: Bind test process to a single CPU

 include/lapi/sched.h                          | 10 ++++++
 include/tst_cpu.h                             | 11 ++++++
 lib/tst_cpu.c                                 | 34 +++++++++++++++++++
 .../kernel/controllers/memcg/memcontrol03.c   |  2 ++
 .../kernel/controllers/memcg/memcontrol04.c   |  2 ++
 .../kernel/syscalls/getrusage/getrusage03.c   | 32 +----------------
 .../perf_event_open/perf_event_open02.c       | 22 +-----------
 7 files changed, 61 insertions(+), 52 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
