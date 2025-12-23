Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F274FE6B26B
	for <ltp@archiver.kernel.org>; Tue, 23 Dec 2025 02:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766455838; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=1aeBGAecCZfD1lyv2oU0bqTRiOrxby1ngtWT4vZlqog=;
 b=PBJ29kC+qljEIx/E/kiNeeQ7Cuci7Qdvc4/B4Ax8rCi1Uu0oE/TCkyxmWdIJsb7p3dTGs
 9nTni6VJpMu4SymDn1t0qE8Pr+jJcbExBiN+WRqHCnZjkzMTuXSMmwF4sg1G7PZBEuVUayV
 Fbb1lbtVMaqu4zWztleUXCWZI/xzeaQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 946753D073B
	for <ltp@archiver.kernel.org>; Tue, 23 Dec 2025 03:10:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E38873D075F
 for <ltp@lists.linux.it>; Tue, 23 Dec 2025 03:08:46 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9202B20007D
 for <ltp@lists.linux.it>; Tue, 23 Dec 2025 03:08:46 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso44861835e9.3
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 18:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766455726; x=1767060526; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tszh1vQ5MOQUqW1oRBh860qm2p2gvRMJPV0RvPnwd/Y=;
 b=T4/FC5S3xjQSOYT2g0wcg98rHPurO9q1SGNA2MrsnIy/qAYXy6diUKhvaEbnLIJEaT
 m5zZPwqNO3nKDD0tIAAfXyZDrvKIw9Uc7adAuuq2YTHTIhhR6Qr706VODthcX1trKvrI
 DxH+OWTr0z2rAAy4s4imzzemlmHgOF2c8fgBILMk7f3M9PBHQ1AMHRpKB7pockU0vxoj
 Sx1CuLLcE9ueeHcqY27WC1Xy+iWMH0o9cg+dlp2okB9NitB0sVSp1+pW3cdWuHfjlbA6
 USeq2I3BDw8OxL2abnMl1rXAd4l17iAhwEHQqX7318PYGGnWUhXec0Y/Loc7JgEIpeJs
 Gafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766455726; x=1767060526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tszh1vQ5MOQUqW1oRBh860qm2p2gvRMJPV0RvPnwd/Y=;
 b=qVsGPxTH9TckTtbbDcQVp+yht4R21yANeUtF5UW2tiXDxqp/q5NDMYMU6DJtUzZZsB
 MbKTLbZr03aNq0nbKknFLUim4MsCRS6uTP/0l/mbf1XJnFtqTRy/NAOYBEd3EOR5Ymk/
 32lT+llcqK2Lay82HHSeVBsfumO3P3FkD09/Op0Om7BfEMiJKMh/5l1IDyZv2SjkQYwj
 +s7pFZZTng3XIYZluxRRftICD+xheC0i1fjWZl1rk3ijg8zjSx7vWH730qn2d7ItC8v2
 LWrYfmOSTbva9IVNg2eUrQXoKXykfWmhX70nPThBX9xQiw8bn0HI7VFANZnJYKKL+iHL
 6ozQ==
X-Gm-Message-State: AOJu0YzyFdtIJcT4NIqgeHSxnVCHuz0dK6vaEl6WvCaUAG8b6/rsCxX1
 Y+U+UOXzygKpg8rHrL5vfqbuqy3fW9Al66dBv+Q0Y/czi1tKMsqKCdA9f6iRfROLlCZ9NSTW4/X
 A1TQ=
X-Gm-Gg: AY/fxX660aUR28NIAsy+PtEqEj5S1aeEekWsy1/ID8ao12yTu2eaKleSPnuNUmyTj5u
 Fuw9GWBTyuafCxANorHYsysFxAG7e7Zxr/65vkDUCGQI/v2Jput876FpXy2lPRaHPp76CeE1DvL
 mjOqwjAqCC74Zkg74PP86vhSkihIq5jS15EqIWdIa/l1EmU40Ygeh9UxinxANPrlgLU8QcRADGS
 Q/L27xqO76oPrclJ5ONFZs3hPH9NSTa/Jsg28vj9OUqhLyaKKaRJJLC26xv40ur5ePmOUXVZnT0
 1+Bfmh+UfT5JdyclCohKUVfQIdu1EEjsxO8ZNEuq1bCPgnpYCKhnnzgSAa/+/UTJLjzWqOoD8DY
 v6naA7puKNj8T1PvuOgoA4EFyfWWFIecKN/kZpBxOysEI08Qd/wyAZJ4nGIAaPFWt4YAwv+YrSU
 M=
X-Google-Smtp-Source: AGHT+IGkx5VB365l0nbRh+6oGv1RJJRw9n/6tZz+Qttx6eRtlnv3RWyifu7nKF5axgBZlYR8cy/ETA==
X-Received: by 2002:a05:600c:c493:b0:471:131f:85b7 with SMTP id
 5b1f17b1804b1-47d19582bb0mr128497025e9.15.1766455725832; 
 Mon, 22 Dec 2025 18:08:45 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-47d193d4e91sm213457495e9.13.2025.12.22.18.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 18:08:45 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 23 Dec 2025 02:08:18 +0000
Message-ID: <20251223020836.9439-5-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223020836.9439-1-wegao@suse.com>
References: <20251110024805.31070-1-wegao@suse.com>
 <20251223020836.9439-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 4/4] shell_loader_cmd.sh: New test case check
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
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
