Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A375ED232E3
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 06:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767939557; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=VhvweKkDK5oAZVkCYM80dqPLfYMKIvqAtU37KbSMXlQ=;
 b=E7AZuN4gqNzFxwMvIGuRFF1MekwsAF0b+WeGkq9IdSM1t/AjiNDkmsvnpVczQeesbhggI
 zBFKk2y9QsYmOIAXDuYvtRSLuDy0TlMlfHnzB4nlt1obKRG/xDSsMHelk95WuCIwoOasHTc
 LhZ5WTH8H3Pwt8Z8tXgCCi5tLFSStiU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D43D3C7048
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 07:19:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CAD43C6943
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 07:17:25 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3513B1A00792
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 07:17:25 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so27046175e9.2
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 22:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767939444; x=1768544244; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3OPFiK8YQkwsyE8I6rxRYnuLyX9FpbCXUZywaVkbVY=;
 b=XH5rP6EGQSWQ40MqRJMUvo7+SBIySkQBfzvSi4BXc9xq22mQp6AG/DGCAEtoZ9Ahdi
 Qh2PgFaxT6Pgi58lwsi6ZhBK82xhlJ4/06eiAk5njFrCr9BM/+jE5+zo7YMw7iU4vd4M
 UbO/P5tfAiNapjLRjEbxCPdI+hGzqlixEsgbGVSMpF3b0B6J67X/bhRJaSlZUdYpT236
 46Gc36q3rUjxzNpzRukNG23gqzY4Xli/FZaZqUrSV3uIOrcMr4NFmfUjPZ7qGG7QI/RK
 4teC6DPfzUsgYhBxW2zuXMxPx6uTpOZMeZTKbjd/3tRfLiPY0lAjVY9EUaGyXMdL2NhO
 dx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767939444; x=1768544244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z3OPFiK8YQkwsyE8I6rxRYnuLyX9FpbCXUZywaVkbVY=;
 b=sxNCvUCusqvtfeV+R731p4XMpEdrEKRW7N7DWrxHZLkpEN0czT0WnVpM8U5Xu1SD3D
 GEciwCAcL3Zn1ACSNtZYfGKKpUr98Ua4ypyr4HuBx4gm7I4c4ETwQxvh/kx+xrWowLcD
 hLY5liDR4FCFzMG7zTEyCZMHg2bq1ZM76W388SIiR+ksqfnwRvrHA8osK5OhzwFBNPKV
 YoCP2+/A0bdar1jbBblTeYmKt+hnJQZXo/W0A2pPWCkm8HK/MwfqtoTczxjQkBmbkd1k
 y8ts58CJbntYCiC0hrVlX5cYSKrtmzAYr60Pa9nBxrpCkf87ngGQOxTzT43pCW8rnwHX
 SuQA==
X-Gm-Message-State: AOJu0YzgQaNe3aMvoeHG4dXFmQhbqTNvmIv6pmktXRMSxaU66I+V8lWP
 g8ApFSw1TjRjU0Y0eRjCi4i07IAu97Nxgkj/qYC4O+LirEt2d9688/8teiJ8675Cl7XfOPJL1jS
 bOUg=
X-Gm-Gg: AY/fxX7a5xc6eNXueMfQM8gcmkTB/xmADkRzUkRe3K54ABYuno0QhbS4y68Ls5RucZs
 mURxXKMyQh6lqRQI84jvCNCjMxydYpJF+6GEt26UtZ+512anAdflaUOhLzzg5UWNuJcIAGppaTd
 0PDwx50WKIDKhlExLvf5gUn5Y9do9QnC+e732V9u0VeGDse9IGM4tuDd5mQEQKAbhOYanqKRu5d
 N8d9BL/nvt9XIhUB29A/0Nnu9fXFNvqHck/G+vrL6OpZJD7y06lhT0y4UpeNKOFT4rlDQfOHfnY
 yo+wX1AUbiV/Nmw+A59Zz3A8URl4nqdKGH46A1/MbO9I+aeIYkw96D1i7Eg/xN9x/h7rP6VNkCI
 A0NHI3Ij2zkDwYKer19Zu4blIwTw6eIbfbEWPv3fq/k/bu6bOul1Z6zVUeBOnyysAdNmzTnsKz7
 U=
X-Google-Smtp-Source: AGHT+IGIojN1VCOSiXEK7T6KHfk0FjphsZR4Vsp3lvEo1PUP36IlRQPLP1wTVBHyxB76qICTUPlGrw==
X-Received: by 2002:a05:600c:82c3:b0:475:de68:3c30 with SMTP id
 5b1f17b1804b1-47d84b21466mr110629045e9.16.1767939444426; 
 Thu, 08 Jan 2026 22:17:24 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-47d7f68f686sm189336995e9.3.2026.01.08.22.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:17:24 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri,  9 Jan 2026 06:16:33 +0000
Message-ID: <20260109061716.20258-5-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109061716.20258-1-wegao@suse.com>
References: <20251223020836.9439-1-wegao@suse.com>
 <20260109061716.20258-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 4/4] shell_loader_cmd.sh: New test case check
 needs_cmds
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

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/run_tests.sh              |  1 +
 testcases/lib/tests/shell_loader_cmd.sh | 28 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100755 testcases/lib/tests/shell_loader_cmd.sh

diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
index 5c309bbeb..24ac81a44 100755
--- a/testcases/lib/run_tests.sh
+++ b/testcases/lib/run_tests.sh
@@ -6,6 +6,7 @@ shell_loader.sh
 shell_loader_all_filesystems.sh
 shell_loader_c_child.sh
 shell_loader_filesystems.sh
+shell_loader_cmd.sh
 shell_loader_kconfigs.sh
 shell_loader_supported_archs.sh
 shell_loader_tcnt.sh
diff --git a/testcases/lib/tests/shell_loader_cmd.sh b/testcases/lib/tests/shell_loader_cmd.sh
new file mode 100755
index 000000000..4e8e61eb6
--- /dev/null
+++ b/testcases/lib/tests/shell_loader_cmd.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2025 Wei Gao <wegao@suse.cz>
+#
+# ---
+# env
+# {
+#  "needs_cmds": [
+#   {
+#    "cmd": "ls",
+#    "optional": 1
+#   },
+#   {
+#    "cmd": "mkfs.ext4 >= 1.0.0",
+#    "optional": 1
+#   }
+#  ]
+# }
+# ---
+
+. tst_loader.sh
+
+tst_test()
+{
+	tst_res TPASS "We are running with needs_cmds"
+}
+
+. tst_run.sh
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
