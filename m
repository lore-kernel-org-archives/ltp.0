Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56B4CCFA1A
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 02:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762742983; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=51MxOHFPQMIggKZAXA/NeMymS9i6p8m+Edv8jhgrTz0=;
 b=ZU0CHC6rusI3lNE20ba/17E6G4xQckcMd2iABAjVGM1Ehs9IwEZdVd+U1wDgasZf1Mee1
 b6jKSLHjXzUXANp1xGYdDyrmy+fJh93P5tdRN4snSGPkXdgPJd0CwyGS9EKMyq1QTrSW3Wn
 klQQrb8yZRFYO8FODL39fiGUdkLXVnY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 128053CF55A
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 03:49:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 354AE3CF553
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 03:48:16 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CDE8A2002BA
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 03:48:15 +0100 (CET)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-64074f01a6eso4616086a12.2
 for <ltp@lists.linux.it>; Sun, 09 Nov 2025 18:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762742895; x=1763347695; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xo3y0vAoUjG5+Qu4Cq8WtsL+vEQ8PrW1DluMpvtjk9Q=;
 b=LfGcIn0x5BYVygtafh0lTEwS0277wpPXX40SQFSuUJf+3UQpv0qoKBOr7p6CgVPdxe
 jCgynny4xXXlNpirrlROorPhMeh1fVTf2T2ytfjVHs2Z3zkpG87MdZNSj59MK8JgmVFj
 RDpNODBuxStKBtChsmw7TEePPEZw/XwTZMn4KfFcw2UxjIoadnz7fUhvri7WxNlDggsK
 utKUSisnOY8v3F8y5TU4aMs0YzUNzIAvDpKHeSxrXmO95BN/4ELpxkq+KrUcXoADkVtO
 UgWclBmza6tkeAgWlciVI52HJGNAX9LvR49x5Mk8shIFKNoAFzDRcKs3cgSVz6vIbQea
 g5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762742895; x=1763347695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xo3y0vAoUjG5+Qu4Cq8WtsL+vEQ8PrW1DluMpvtjk9Q=;
 b=BqV/lyMqNp8zioyOQrJB/VwgDtZ8HYFV1TA8bd/f9bDMw0tCu3szKlT7xLcMi3TsAu
 x8VtY/VovFNZS6iZKkA4snZbpdfjMNlBVTr9oGv+FIYI4K6Cjy3r54PpTZ99x8WV0XFH
 VXuOcA589PeqsftndG4kUQFmzP/tUgN9ReEdX/fioYwJfXYOg3Lqddh7ftVD9tk3jmV8
 wquXAl9Xu8Q0pKUQpxRbSPx/u37JzKhgbkD/oWboU8kiUBNlmtVKt786m5Y9ZjVO97fW
 zBJOW1A/BSR+kLGRvGIqhSF6Iueo6q5RzzEobjBRzVosTZ4mBnJm+OVEWE3yz/czZJOe
 gcRQ==
X-Gm-Message-State: AOJu0YyInJmIr2wpQ/IWrs5Y4NolXGFjkdemaba7ex0i+0P4zLEYr5nF
 iz9kXUgQPGDmvHquHLYxL3nOxDQ4rjYHeykl1RNkIuaAUghgssjKe5DQ0ZF1AJNstxdjiewrn9i
 mHX0=
X-Gm-Gg: ASbGnct0l/zV9l5RB+hIRD0qUyfrQpp2Z2F3QS+1ZdQ1tvd9b1KuL3mtBt6q3b9hhhS
 ktE7vTaB/jPqvoLvr8GkZJE3wGKDJ7QeJUC1OkQ9D9YXrjyRsILTZyiYZWydnv7Fy960Zg6+OdI
 ve6c8u8T0dkEOl7iIwXKtP5Od8ADuvoDDB6ErWcNu9x24XdYXKqPCEzp7PdNZm2Xk92gYGfGtEk
 EQgVsMJ1R9AsdyCO38cQE+NB5O2taaNsKXsIxhJDcLYuQXC9tfUTRFq6MetyvsRD4GjFsHKaF0P
 H3XFEOuCAO/nr0ExDoc7MMRHA7JGrI1YPF2hdTjbpxIdXS0DIuLA/dg+hWurRZLc2h2gmwxP+L5
 85zCnkrEEu2k6aJh4kvB17XO/W4oRx1ybJgLz/QUa8txHub/h4K3dDNTAwRsWvm1TvFuPIg+eDC
 A=
X-Google-Smtp-Source: AGHT+IEE2z3tP+keWASkwxTd3f8ywyXCZtntOWgyXGrXrHjnG4M3Az1DUOfcCoiykbEI3zUYu1eknw==
X-Received: by 2002:a17:906:730e:b0:b70:b7f8:868f with SMTP id
 a640c23a62f3a-b72e036bbebmr708394066b.27.1762742895050; 
 Sun, 09 Nov 2025 18:48:15 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf31286esm955701566b.21.2025.11.09.18.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 18:48:14 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 10 Nov 2025 02:47:55 +0000
Message-ID: <20251110024805.31070-4-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110024805.31070-1-wegao@suse.com>
References: <20251107003041.28929-1-wegao@suse.com>
 <20251110024805.31070-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/3] shell_loader_cmd.sh: New test case check
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
