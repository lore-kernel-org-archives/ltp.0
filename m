Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A88C624D0
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 02:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788317921; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=QXesxhTPlDZfJPyv0FTzhXwl6y3qVo9jKI+2D6aumBg=;
 b=COnL8KnfoCNSYQ49r6cJErFGSD7+LUCJkydMlTBB6U+CtQQfo+mkg1CSQtFD58OYMkIf/
 MXIBhbHxdru5xunKR8SjxMz1Sqjt43WXCguE6ta2wxcJfySq3JOlJ+6XovG1n/bTYv9dtM8
 HeCD1PFskSWuKV/7or1rtqCQLxaOCWU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28E363E998F
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 04:58:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 132A53DE96E
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 04:58:20 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B6AE4140021F
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 04:58:18 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48441a2ba14so531433f8f.1
 for <ltp@lists.linux.it>; Tue, 01 Sep 2026 19:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788317898; x=1788922698; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OR/9yj2TBgYpHq8dcxaXhaU7Y+GG6YIHDMM8dasGnk0=;
 b=Fh/jYnFMm2BNckshvDkAb2G2PAwhfdwJlPma/qzzNt/mBG0ERu3hCBBq+I7SXjzB+R
 G2OEOcJ600M3+hLv7jmYtLkduafG0yuhQORbKG7ICd/AEq0y5qV+U/mTAz0rbQyP0fNY
 uGoxU4KkwdyMN5XrMIHKMcHUYX5lBdc0swoYYfP+CgwkDUaVVvSrr/eU3+K1MaUlvnS2
 PMjsY7qi5fHeWobFug8LX4WykHEXO24RuxpFVw5PObMV/n4LDbJgUB1ElkBU89VVaLM8
 txALF5Du7sn0KTqiCji4adGVSaRw5PZGWH5/r3kBlGoChTXWbqyK2VNApmYK62Qr3JYH
 MLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788317898; x=1788922698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OR/9yj2TBgYpHq8dcxaXhaU7Y+GG6YIHDMM8dasGnk0=;
 b=gExEDkRlRT7k8jyC/CBns4KK0HcEwX6WJCrih70smPuqnJy7amUWoFMIZ1iggLv3or
 GVqQE1gQFauysMEeF5Z6biEyOzhHuvFKwKbeGp2J5LL37GIdcsN5HANKpISQAZsQBPvF
 6s3fL/MXsRSYMifDFTKIFhi4s0gOHACD2Zl8VfOZjc/xyxNPoD1fjfJczFPHVk7hhChK
 8rWpBxQqGb95YsfGeV3OrUrEZWFOZV+esG/5tYeZdrF7F2tGawnUJHYV2kJTPvdIN5WL
 KEfC0Su7ZYJAM7799cQOxfiMMDo8cLgk1yDWMLX7q1tGsqZOE0aM4Nw5ZG364unY0YsX
 1SYA==
X-Gm-Message-State: AFuF++nap+6z+r9Lg8u4cSnkiY8goPUGEgxVNYyIDS/jkLXaxSf8YOXp
 ti32z01k8Pt6fFwROh3KDFXmX45Bdmh7Uqq43LtoT5gaFOUobM98aaCdYZr/KL8NxRCwxu62b1b
 S8EY=
X-Gm-Gg: AYBFou1Jd52hpGuhqLcwnNOlCh2djVE3tyZONa0YaRNY0tbPAOgj5bFJaDtPp5eK1B3
 ykRKnxzqBJl9poou6aFeQ2SoPuUttl/8pFN5sSWJ4Ca4jtenXLh72QDsdF6bfNU2o5OuE7u8m/9
 RwizHSVdhAwWHKRLhhfjsukAOvtiln3w7uk+M6kvPGs6KWycC0y7aiBUvh/lq6ntvVuY+gInul8
 hN0Pi3SKQmlMiVQiEV52WAb2+bNEXJ35SpB9syv03qvjT8MDpVWMc5l/i2W1vdfR8K/OZS4n5Tt
 OY9BCz2aI1lKnUfYMFl8bc1qLRzFvmJC8tLuUZQBXqkzhNSS+qLEYwoe4dDEZ0b3ZBzrQ5svK3G
 K2OEpGCeLRp6VKIoaCI3KuQE8++vLXyYv+Ylcr524yAzfqLP7jwsLyByMfaPYBo1KhnG88qhorQ
 UTkBDJxDjjsjN9fAC+bx0nAhrdFe7l/bYECxJdzpDPkWojw/bcvXB1H3qqNKcIPFQqtpowc1LZg
 HPhbJLjwVDt5SyifnCyYBkCUFtqzGAmCgDndXpPlEU=
X-Received: by 2002:a05:6000:40c7:b0:482:e451:680c with SMTP id
 ffacd0b85a97d-48488df7900mr2461959f8f.8.1788317898109; 
 Tue, 01 Sep 2026 19:58:18 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-484492ce236sm3637125f8f.35.2026.09.01.19.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 19:58:17 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  2 Sep 2026 02:57:12 +0000
Message-ID: <20260902025816.3915-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825022926.9649-1-wegao@suse.com>
References: <20260825022926.9649-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mmapstress06: Use memory.high in cgroup v2 to
 start swapping early
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Set memory.high to slightly smaller than memory.max in cgroup v2 to
start swapping earlier. In cgroup v2, the asynchronous swap writeback
does not start until we are over the limit (memory.max). Setting
memory.high starts the reclaiming/swapping once memory.high is reached,
preventing the child process from hitting the memory.max limit and
getting killed by the OOM-killer.

Signed-off-by: Wei Gao <wegao@suse.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
---
v1->v2:
- Update solution base Cyril's suggestion

 lib/tst_cgroup.c                               | 1 +
 testcases/kernel/mem/mmapstress/mmapstress06.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 7c6ecd4d2..3ee9d32a4 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -180,6 +180,7 @@ static const struct cgroup_file memory_ctrl_files[] = {
 	{ "memory.events", NULL, CTRL_MEMORY },
 	{ "memory.low", NULL, CTRL_MEMORY },
 	{ "memory.min", NULL, CTRL_MEMORY },
+	{ "memory.high", "memory.soft_limit_in_bytes", CTRL_MEMORY },
 	{ "memory.max", "memory.limit_in_bytes", CTRL_MEMORY },
 	{ "memory.stat", "memory.stat", CTRL_MEMORY },
 	{ "memory.swappiness", "memory.swappiness", CTRL_MEMORY },
diff --git a/testcases/kernel/mem/mmapstress/mmapstress06.c b/testcases/kernel/mem/mmapstress/mmapstress06.c
index 4e6023399..7cc17fc75 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress06.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
@@ -37,10 +37,13 @@ static void run_test(void)
 	/* Set memory limit to force swapping of the mapping */
 	SAFE_CG_PRINTF(cg_child, "memory.max", "%lu", (unsigned long)mem_limit);
 
-	if (TST_CG_VER_IS_V1(cg_child, "memory"))
+	if (TST_CG_VER_IS_V1(cg_child, "memory")) {
 		SAFE_CG_PRINT(cg_child, "memory.swap.max", "-1");
-	else
+	} else {
 		SAFE_CG_PRINT(cg_child, "memory.swap.max", "max");
+		SAFE_CG_PRINTF(cg_child, "memory.high", "%lu",
+			       (unsigned long)(mem_limit - mem_limit / 8));
+	}
 
 	child_pid = SAFE_FORK();
 	if (!child_pid) {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
