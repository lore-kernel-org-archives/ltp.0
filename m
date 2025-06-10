Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56321C5B552
	for <ltp@archiver.kernel.org>; Tue, 10 Jun 2025 10:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749550541; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6+980rx4QXyVerKY3jYGep+zfPMBFffimeErZz6UI1Q=;
 b=rdJqF11E83sFR+wioF9/DE0A8ZFeNQYlr6uWxbANEI7W9ThQhi08PpHf8WtfdVOhNQ2u4
 OlzGHfww05YtxHm/myi0i/v0c/e3kEnao99CrXNRJwN6ZFd1OKTdMm6vt9BcM6Z0ipnlbt0
 qemdzv8t71HO+T/vkmrPTcwTruJhxZQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 395403CAEB9
	for <ltp@archiver.kernel.org>; Tue, 10 Jun 2025 12:15:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E23113CAD37
 for <ltp@lists.linux.it>; Tue, 10 Jun 2025 12:15:19 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F15BC201747
 for <ltp@lists.linux.it>; Tue, 10 Jun 2025 12:15:18 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so46821685e9.3
 for <ltp@lists.linux.it>; Tue, 10 Jun 2025 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749550518; x=1750155318; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TOL+8XFqP7oQQLvxaNrFkMqy3/OWvIopaaHleQvb/E=;
 b=aCu/wk0QW0ipLuiLNsorw4+CxqJPLCU4JYSgi2wB+es4kFosRyP0lW4UIrhImR2cSx
 eNsf1BHqyGRolI+SR9OEgtlwS24DCqOzeh2iPfoZEn+2SFUTebJOP8SWkJr/7k3jtOYq
 qb4lzkKf4YoLHbcw1P4qJz8ucOr/RRjQdTxlmn0nxFbIvmDGYsiCkGaz4ZF5+KYJvRPY
 TVygTPMdZQ60fP//XI/2IWaxXokGBz5CsrnUFOBvfknBqNYDFYQui5BTAcJvOy5XEmTK
 aIO1BEb7gflNp051E6btpjc+kW8skHiwDmYbH9hBAKhUqJURjeWVPukOMllLN/HpNJpN
 ovww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749550518; x=1750155318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3TOL+8XFqP7oQQLvxaNrFkMqy3/OWvIopaaHleQvb/E=;
 b=H6Bd/BCcRaSwNI7N4/7dSnFqdRSSksPxQROmw+unsrOeakZKdmc0a68UU3tOAZMpdr
 9jK9M62LdMZUV2PSomEUilXQmxeq8HHiUCSN6CcUX5Xz9MMjxWYjbNdcp5SzrkboMLsx
 LLsYHlUkr2I55gB7nrWY8xpjotD2/Rkbf/KRUTE0NdD3xNGl5lkpAkQkRM67lLar0xjP
 ZlOUHDNTxMNfuheEPh/Ljee020xnOXuLuITQl+p+5zjZuCB2w1Dg144YUfb43bMYYfTj
 GgBcYIihbtu11isn/xAIHLMryGro7ihY7n/uCN5pKl2CWAFRlxbrNYm1IySRBbl6ghHq
 QQ1w==
X-Gm-Message-State: AOJu0Yz6bVVWzYbC1D8AC0Z064DbUpvL+2514qYEvTsbUCiy5xmCX6+2
 we/UsNZbVt9kbkmcLdmemHjJ050IgQppgqABkAEys6pUHSs9OHIp0InDLEjOHtzjrect1AflkQ4
 s2gQ=
X-Gm-Gg: ASbGncsoBC32Y8eVghmr0rlZKaTILuJJlilPF7EXxNJNwHnwEsnhVaRfISYlqCrR764
 zYqG42TOAmEFifvwXBURUAI27frGPr/srDcviDkJCZG6ZEQMtMFCkhLQZtf/C03cfHwnTbQS+y1
 NYNRLKyfO4bEgBSMea08JzupGI2MY2PUpRLpSiGKdwz486GouwvuaVs2xKEOoeJ+1bG2SOZGO92
 iG3/T/mviffo3Db/M4a0bdik1EejT6k+eHHLI7s5HXO1Fs/JJDeHrNT2gYVTUOn7+55KU/X4I32
 V5rlvrtMW2luLGMPtoGQRI46qaxKyXxGbAN1Wu+Sn2LfEIljul4=
X-Google-Smtp-Source: AGHT+IGYLRo3D1jvidbkRCjg9J4u7jKvMImAmZVQUK8MqlGp0OLhrO8cmpJZvQUf6gesNs4VFEo+3g==
X-Received: by 2002:a05:6000:288f:b0:3a4:ef00:a78c with SMTP id
 ffacd0b85a97d-3a531ceb99emr15404846f8f.55.1749550518058; 
 Tue, 10 Jun 2025 03:15:18 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7482af7ac79sm7356247b3a.53.2025.06.10.03.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 03:15:17 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 10 Jun 2025 18:14:16 -0400
Message-ID: <20250610221435.1680891-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605142943.229010-1-wegao@suse.com>
References: <20250605142943.229010-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] tst_cgroup.c: Skip cases which testing cgroup v2
 with CONFIG_RT_GROUP_SCHED=y
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
Cc: mkoutny@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RT_GROUP scheduling is cgroup v1 feature as of now. So we need skip test cases
for cgroup v2 with CONFIG_RT_GROUP_SCHED=y.

Skip cases list:
sched_rr_get_interval01
sched_rr_get_interval02
sched_rr_get_interval03
sched_setparam02
sched_getscheduler01

Fixes: https://github.com/linux-test-project/ltp/issues/1245
Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_cgroup.h                                  |  2 ++
 lib/tst_cgroup.c                                      | 11 +++++++++++
 .../sched_getscheduler/sched_getscheduler01.c         |  2 ++
 .../sched_rr_get_interval/sched_rr_get_interval01.c   |  2 ++
 .../sched_rr_get_interval/sched_rr_get_interval02.c   |  2 ++
 .../sched_rr_get_interval/sched_rr_get_interval03.c   |  2 ++
 .../kernel/syscalls/sched_setparam/sched_setparam02.c |  2 ++
 7 files changed, 23 insertions(+)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index d2b5224a0..0f0f44ec3 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -256,4 +256,6 @@ int safe_cg_occursin(const char *file, const int lineno,
 
 int tst_cg_memory_recursiveprot(struct tst_cg_group *cg);
 
+void tst_check_rt_group_sched_support(void);
+
 #endif /* TST_CGROUP_H */
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 36602402d..4ebdf701f 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -16,6 +16,7 @@
 #include "lapi/fcntl.h"
 #include "lapi/mount.h"
 #include "tst_safe_file_at.h"
+#include "tst_kconfig.h"
 
 struct cgroup_root;
 
@@ -1531,3 +1532,13 @@ int tst_cg_memory_recursiveprot(struct tst_cg_group *cg)
 		return cg->dirs_by_ctrl[0]->dir_root->memory_recursiveprot;
 	return 0;
 }
+
+void tst_check_rt_group_sched_support(void)
+{
+	static const char * const kconf[] = {"CONFIG_RT_GROUP_SCHED=y", NULL};
+
+	if ((access("/sys/fs/cgroup/cgroup.controllers", F_OK) == 0) && !tst_kconfig_check(kconf)) {
+		tst_brk(TCONF, "CONFIG_RT_GROUP_SCHED not support on cgroupv2");
+	}
+
+}
diff --git a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
index 7edb59481..58bbede9a 100644
--- a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
+++ b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
@@ -39,6 +39,8 @@ static void run(unsigned int n)
 	struct test_cases_t *tc = &tcases[n];
 	struct sched_param p = { .sched_priority = tc->priority };
 
+	tst_check_rt_group_sched_support();
+
 	TST_EXP_PASS_SILENT(tv->sched_setscheduler(0, tc->policy, &p));
 
 	if (!TST_PASS)
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index b4d75bdcc..6dbf5af89 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -43,6 +43,8 @@ static void setup(void)
 
 	tp.type = tv->ts_type;
 
+	tst_check_rt_group_sched_support();
+
 	if ((sys_sched_setscheduler(0, SCHED_RR, &p)) == -1)
 		tst_res(TFAIL | TERRNO, "sched_setscheduler() failed");
 
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
index 789e5ff10..3f6f34bbc 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
@@ -36,6 +36,8 @@ static void setup(void)
 
 	tp.type = tv->ts_type;
 
+	tst_check_rt_group_sched_support();
+
 	if ((sys_sched_setscheduler(0, SCHED_FIFO, &p)) == -1)
 		tst_res(TFAIL | TERRNO, "sched_setscheduler() failed");
 }
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index 5e2f4ed7e..d4b7a6f22 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -59,6 +59,8 @@ static void setup(void)
 	bad_addr = tst_get_bad_addr(NULL);
 	tp.type = tv->ts_type;
 
+	tst_check_rt_group_sched_support();
+
 	if ((sys_sched_setscheduler(0, SCHED_RR, &p)) == -1)
 		tst_res(TFAIL | TERRNO, "sched_setscheduler() failed");
 
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
index d71e2c6d6..99277baf6 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
@@ -36,6 +36,8 @@ static void run(unsigned int n)
 	struct sched_variant *tv = &sched_variants[tst_variant];
 	struct sched_param p = { .sched_priority = tc->param };
 
+	tst_check_rt_group_sched_support();
+
 	TST_EXP_PASS_SILENT(tv->sched_setscheduler(0, tc->policy, &p));
 
 	p.sched_priority = tc->priority;
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
