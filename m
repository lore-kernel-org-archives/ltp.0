Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5960CCFA05
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 00:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762475564; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=QT8O9p15207XdG/g/kdtLoc0LvMEzqkVVYf7gptdCyU=;
 b=NyRxPfBj2WWxoel5vLRa+kA8xycwnIqzJOrHLRD7ryWV6LeJ5htCuCpFyrNxiROXy1fvt
 s2L8nc/hB+F4g1vZcJXarJpd/RtAKTQCEEVXKI3wzwO2Y1g1mb0fgy5JXaErywhd37SZsSi
 u/nA6UGMAIGPnzMob6vNDNq/3S302Uc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 605A43CA11F
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 01:32:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98A323CED4B
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 01:30:55 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 31DCD600C7D
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 01:30:55 +0100 (CET)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-63b9da57cecso372837a12.0
 for <ltp@lists.linux.it>; Thu, 06 Nov 2025 16:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762475454; x=1763080254; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OE6xQDUFfD8cUzG9PXyOkaVCeoBojK2qzrXdtnA6xQ=;
 b=FQiRBTmZV+xzZc5jacyLRg9GR3YFIK27uJO0Fm6x0+d/LSp52CIzHOaadSNHA71IOl
 vQKnVGGvd8c31g0/P9LhkalVdbueS2oKa50dowGpny8Pi6Qs3o7T8wMSZ1fbzd8GDeFW
 JLrkI3smw5xnZAOf9Z37jPYn3Jp+vZZCS3QALoNEckkYYUYNppPm+b1hr5uoT6kAnGXk
 J/vABP9CRDYTtVDgXfokp3lH3kphwGuUfjUPyL8cEzPBztxEVv+R0geJohpGM3AXMFpw
 2rJkGmjMr5WBt+n2id7lRTS0rBhyUVmpDooiG8jNXOig5T8UH/15/1YKas856QioIBpi
 6fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762475454; x=1763080254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7OE6xQDUFfD8cUzG9PXyOkaVCeoBojK2qzrXdtnA6xQ=;
 b=vQOxW0/CXd0fs0+GFc+JlS9byj9I+TMBU/nBxX1w1NqduSmvkniNzQF+ikoOm8o5Iv
 SV/r9eEklROMyQrhIdVkzQm9juU+FbtsoKkdTn8rO+bkYlNIJD+MnT71GemAC0mZxbxD
 xWvAQNUlmplS2W4iF/F3T+oGssDawGkAIOACo2aJWO9uqCJR1TUBi03o0A5WXJ3K/7P6
 BKKp1IR/zT99qkK6GPQWV9yoaSmvy/3/bRi0+um7sX3P59WiJo5tHaLdZRzPgxaEKWRF
 BBZivQ8UOqJqT/mgJsv7TB9ei5GWbO62Kb7sUFXuvnJm2UoSWCFM2x/H3mZAenFa2UAv
 rShw==
X-Gm-Message-State: AOJu0YyMo/Oo3/jrRFyyki52o9qDJ5Vch38+2EKMTatTVGOw7t9mo8sg
 aPoJR5xaZ8oHK/oy5Q7Sckf7KayvH57r6KOcjs1MeChpIJ/T8vhXuMYG6gIVE+oOH8yIz/KljOs
 c0TA=
X-Gm-Gg: ASbGncvRMv18oH/RU5StYU9Ew07oOaDThlSIUt5lTKTREYFS2Oo+8yMSZGsEpavPbmL
 N7TBIYVofxwVQm4ylO4aF0GZEBVdOwl212kE/y650O+5KzqsD+7FwFc5HCTlTR9y5ij6EzDdi7Q
 un7mjcFMYfChnhZDyO0CPkPuzoqKK4duARy7CVJA9M8LuOpbFQbfXxIbobFNmQ8UvVt5DoDUTku
 37w+uIf1IFZoSe9x3agawNMu+HsjPZ0++9mzN5MMgeBUSNEaWTdhEUy8ShrOftvECOD5JBpvd9v
 Ipyjuw7WNgoe5/r4gcc4ucaAQxWl7fowbNS2S5FG2Qhf8fEL0zl5cAkpPvVLZVswJAkkzVgJg4i
 vXRIcACxE27yixCWqJPOiwJWsHbamN5esiuld0z8VcBQ/jLgTWxtwanQTYSKcMP1N
X-Google-Smtp-Source: AGHT+IGzq1IfmQiykqFvUatFKxGDBfQZgYxbeLu+hDzV9IWdLxn4ld3OE+VuumpB3Z8TjtP9ZwPicQ==
X-Received: by 2002:a17:907:db02:b0:b72:598:2f32 with SMTP id
 a640c23a62f3a-b72c0d9fb88mr103585366b.42.1762475454353; 
 Thu, 06 Nov 2025 16:30:54 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf312240sm90370866b.18.2025.11.06.16.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 16:30:54 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri,  7 Nov 2025 00:30:27 +0000
Message-ID: <20251107003041.28929-5-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107003041.28929-1-wegao@suse.com>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251107003041.28929-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/4] shell_loader_cmd.sh: New test case check
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
 testcases/lib/tests/shell_loader_cmd.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)
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
index 000000000..a05562089
--- /dev/null
+++ b/testcases/lib/tests/shell_loader_cmd.sh
@@ -0,0 +1,24 @@
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
