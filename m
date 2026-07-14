Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E0FC43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 03:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783998978; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=f0b4CvNdxDUg5WFUnOuG9TTIO14M90nTXvSnb9Jy0U8=;
 b=lGJB/2CAFylXirTI5Jg9U6E+s7kovJ8B99mnCccV+BTnQwKB3RjCyGeyN2Hech5oraL06
 SRo5gm9d2N7TGeW1gFVhSmB/12MrW5DWy/IWkkXfTeHD+lG0RB60xFyHn30f/CySrl9i4tA
 /TQ52xc9ag2wwx77NSAvEPU5EQCVUb8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46D063E5E43
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 05:16:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 366E43C5E52
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 05:15:56 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 099DD600726
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 05:15:56 +0200 (CEST)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-37e0a189b0bso502562a91.1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 20:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shopee.com; s=shopee.com; t=1783998954; x=1784603754; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JwiMziRmQLA0HzJG/IVke1pFPBFHgMP8q7DwxujbLe4=;
 b=hTaZ5LsF7M5NJuqiRpZFD580X2qrWwJ25oYHEiRXp4M2Mqtt3Dl9EAmV8hMIVUNhi9
 VRWl6F77tdTdCYm+7W4cncsiu8xeEmWxHg3pQ8XdzROeoUjrYWJQsfQeA9rmm5pJDhhP
 PAyhRkFmr0SAw1XNbR2hPl8sBsy7oRwUkJ5G8ZnGKKCcw7dVYttZfmuEMjZaZpHP3ebH
 diy6IRbQJryJGgwLsYMP6hZK5YBy4PoH2kg9LG0PzVZ/XT4H3zsnwoYASqxwa5tK2hoN
 t31IaalKr+vFNqo3v7L6PQujdQMOPxEpANMxdZyZJJGShvD1BCMoOTzjpWRTnM0iiRSO
 xbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783998954; x=1784603754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JwiMziRmQLA0HzJG/IVke1pFPBFHgMP8q7DwxujbLe4=;
 b=tPa7cqsrTzYlpfopRLuduPhtoX6P1wemkVoudsTdUeLbqeBe2yYDTA0wfOr7Tnp9zV
 73AJQC44r+yuOd90bJPWDzLsAC0OH3hY1tZqkpylywDg/lkxphGUcKh7tkf0w+bl0aYn
 c5uFxVtsKHwu+6U3VUxJ+8Aa1R4K0rQs2PQjbIMAQdNDjVMJE2kfvIAfpzQKdzOf446R
 LEXJg7K/FjUhhh44QP+qKAWbhgHktLQDcYsB3REul/bY5u42fn0qMZZ+U6sqP8QjQQTp
 As3DhCvJt7JdJeGMZCJFt0iWNAdY8z+E9eqltPiQitGAmmS5GSG0erqiRFtCM6P2zJJ2
 odWw==
X-Gm-Message-State: AOJu0Yz9k4h+OdWB4hgSfvzWzbtt3FZfvlEcqMpEgm0SFtkXcbhFtyJV
 lC0LFTECc6MAy0ZyBGQ0HY6ribNX/w5clTt3wsja8FDYmP66aubaNgzws1Xy/L9Ku/YVNjGxlUq
 BJwBhWf0p4bx7trdfxrM+RtnTfdVRgbrZg1SUEaptMmJigyWYxbLaSGgB75EBMyxWFYQHxa7Qzb
 qoYNQjmHpb6RSee5olCvS8EJJurcTD2WZA0ZGjWSk=
X-Gm-Gg: AfdE7cmK/F00tXft/+fNw7FlGUUwMHxSnKaHoKP0MizH4v+/P2mVo0Qe8bS1yKwddLA
 JaUTFBUJ3+ztPAQLKZSAezlf9Icel9KAv6UqvQvsnEnngYYV9wzxa0kDH3m/7DcOZatbLR+pPmI
 /YuV26CJAbTt9AhYnpyfT0XPgU9PWnpYNK45aO9/9fm/COG6VxwtmXkysxi886E/9GV2poQYr2j
 CEW0h8R3JqdP12YVAl6O7DFaErCePbgS19yw0u16MwhygoF4vw4ufINj+/bjHvr+LY52i5ldyuq
 C5Qgb6jR6nH1lVwB1vAN/0YcT6uGwXZfPSWMyzq/z/TlbhzM+W1hrc6+JgAepGc0GYvbJQHfHWf
 +xwMgrS87eU7UcOGIfeLiVKdVYFJBpm2/8CA93hcrIwKMQLfGHaVJ2BTfYjZI+tUWF900BQNdsO
 Z8mLFJt93bNrOMk8P7ziPNNmBl+g9MgPPs07vGQBXM6ojNJI897P1aR7g0PptOLgVz
X-Received: by 2002:a17:90b:5906:b0:38e:6dd:a9ad with SMTP id
 98e67ed59e1d1-38e06ddab7emr4463970a91.0.1783998954163; 
 Mon, 13 Jul 2026 20:15:54 -0700 (PDT)
Received: from LPMV6FJ9FM.cn.corp.seagroup.com ([143.92.118.20])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e173084c9sm716633a91.13.2026.07.13.20.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 20:15:53 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 14 Jul 2026 11:15:45 +0800
Message-ID: <20260714031545.64932-1-mingyu.he@shopee.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] pty09: Cap RLIMIT_NOFILE-based slave PTY opens
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
From: Runli via ltp <ltp@lists.linux.it>
Reply-To: Runli <mingyu.he@shopee.com>
Cc: littleswimmingwhale@gmail.com, Runli <mingyu.he@shopee.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

pty09 derives the number of slave PTY opens from RLIMIT_NOFILE. When the
limit is very large, for example 1048576, the test tries to open nearly
one million slave PTYs on the same master. That makes the workload depend
on the caller's file descriptor limit instead of the PTY behavior being
tested, and can turn a working PTY open path into a timeout-driven TBROK.

The test only needs to verify that a slave pseudo-terminal can be opened
multiple times in parallel. Cap the number of slave opens at 4096 so the
test remains representative and deterministic even when RLIMIT_NOFILE is
set unusually high.

Fixes: 20aa13dbd8a68 ("Add pty09 test")
Signed-off-by: Runli <mingyu.he@shopee.com>
---
Changes in v2:
- Print the uncapped available count before applying the cap.
- Add a separate TINFO message when the open count is capped.

 testcases/kernel/pty/pty09.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/pty/pty09.c b/testcases/kernel/pty/pty09.c
index f3ade2381..80da475e9 100644
--- a/testcases/kernel/pty/pty09.c
+++ b/testcases/kernel/pty/pty09.c
@@ -14,6 +14,8 @@
 
 static int masterfd = -1;
 
+#define MAX_SLAVE_OPENS 4096
+
 static unsigned int count_avail_pid(void)
 {
 	DIR *dir;
@@ -34,6 +36,12 @@ static unsigned int count_avail_pid(void)
 
 	tst_res(TINFO, "Available number of pids: %u", max_pid_num);
 
+	if (max_pid_num > MAX_SLAVE_OPENS) {
+		max_pid_num = MAX_SLAVE_OPENS;
+		tst_res(TINFO, "Number of pids is too large, capped at: %u",
+			max_pid_num);
+	}
+
 	return max_pid_num;
 }
 
-- 
2.47.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
