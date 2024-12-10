Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1C2E77182
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 22:58:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A718A3E9426
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 23:58:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C4D63E9426
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 23:58:00 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1C899141670B
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 23:57:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 711301F390;
 Tue, 10 Dec 2024 22:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733871479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuAiJwIysoqTckUo83rog62Dr8wGaOPnXfvszf6eRZw=;
 b=Tti/zOZ+97x7Q3ahlmyzUXLops9KJRk+6xfpEp71ST8Dazvmjjr71pOUWkXrs1oFUZzAEt
 RRinif5in8ULfppqTGGDrY+fRvWWRXiKjIM0gZddvkMQEPkA1DdAR0IWCOU2O/sL56hFRR
 HmrYBNoNLRAYDcYAF3PUV2ut0pIrIo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733871479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuAiJwIysoqTckUo83rog62Dr8wGaOPnXfvszf6eRZw=;
 b=8cU0ESKiTZHUD4TjwnWvBR2K39Pv6VwUbxCpwwLabbJ/X9MMrpEmBx+P3H/YalMRgTY46z
 KtDuaxoIATTj93AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733871479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuAiJwIysoqTckUo83rog62Dr8wGaOPnXfvszf6eRZw=;
 b=Tti/zOZ+97x7Q3ahlmyzUXLops9KJRk+6xfpEp71ST8Dazvmjjr71pOUWkXrs1oFUZzAEt
 RRinif5in8ULfppqTGGDrY+fRvWWRXiKjIM0gZddvkMQEPkA1DdAR0IWCOU2O/sL56hFRR
 HmrYBNoNLRAYDcYAF3PUV2ut0pIrIo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733871479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuAiJwIysoqTckUo83rog62Dr8wGaOPnXfvszf6eRZw=;
 b=8cU0ESKiTZHUD4TjwnWvBR2K39Pv6VwUbxCpwwLabbJ/X9MMrpEmBx+P3H/YalMRgTY46z
 KtDuaxoIATTj93AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 417D413A3D;
 Tue, 10 Dec 2024 22:57:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cN0CD3fHWGd9KQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Dec 2024 22:57:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 10 Dec 2024 23:57:47 +0100
Message-ID: <20241210225753.381770-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210225753.381770-1-pvorel@suse.cz>
References: <20241210225753.381770-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/7] ci: Run docker as privileged to enable loop
 device
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This allows to enable more shell tests.

Remaining shell tests would require to allow other exit code than 0
(TPASS) or 32 (TCONF). Also script do not expect combination more results flags
(e.g. TPASS and TWARN), it complains "Error: unknown failure, exit code: ..."
To fix this would would require to check exit code.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2.

 .github/workflows/ci-docker-build.yml |  2 +-
 lib/newlib_tests/runtest.sh           | 51 +++++++++++++++++++++------
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
index 0445a35384..cb1ddd70fe 100644
--- a/.github/workflows/ci-docker-build.yml
+++ b/.github/workflows/ci-docker-build.yml
@@ -114,7 +114,7 @@ jobs:
     container:
       image: ${{ matrix.container }}
       env: ${{ matrix.env }}
-      options: --security-opt seccomp=unconfined
+      options: --privileged
 
     steps:
     - name: Show OS
diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 8f2a497b19..68f8af7606 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -1,14 +1,45 @@
 #!/bin/sh
-# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
-
-LTP_C_API_TESTS="${LTP_C_API_TESTS:-test05 test07 test09 test15 test_runtime01
-tst_needs_cmds01 tst_needs_cmds02 tst_needs_cmds03 tst_needs_cmds06
-tst_needs_cmds07 tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus
-tst_fuzzy_sync03 test_zero_hugepage.sh test_kconfig.sh test_kconfig03
-test_children_cleanup.sh}"
-
-LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh
-shell/tst_check_kconfig0[1-5].sh shell/tst_errexit.sh shell/net/*.sh}"
+# Copyright (c) 2021-2024 Petr Vorel <pvorel@suse.cz>
+
+# TODO "unknown failure, exit code": test_assert test08 tst_cgroup01 tst_cgroup02 tst_res_flags variant
+# TODO TFAIL: tst_fuzzy_sync01 tst_fuzzy_sync02 test_macros0[1-6] test23 test26
+# TODO TBROK: test_exec_child test_kconfig01 test_kconfig02 tst_needs_cmds04 tst_needs_cmds05 test_runtime02 test01 test02 test03 test04 test06 test11 test13 test22 test25 tst_safe_fileops
+# TODO TWARN: test_guarded_buf test14 tst_capability01 tst_print_result
+LTP_C_API_TESTS="${LTP_C_API_TESTS:-
+test_children_cleanup.sh
+test_kconfig.sh
+test_kconfig03
+test_parse_filesize
+test_runtime01
+test_timer
+test_zero_hugepage.sh
+test0[579]
+test1[59]
+test2[04]
+tst_bool_expr
+tst_capability02
+tst_device
+tst_expiration_timer
+tst_fuzzy_sync03
+tst_needs_cmds0[1-36-8]
+tst_res_hexd
+tst_safe_sscanf
+tst_strstatus}"
+
+# TODO "unknown failure, exit code": shell/tst_res_flags.sh shell/timeout03.sh
+# TODO TBROK: shell/test_timeout.sh (sometimes) shell/timeout04.sh
+LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-
+shell/timeout0[1-2].sh
+shell/tst_all_filesystems.sh
+shell/tst_all_filesystems_skip.sh
+shell/tst_errexit.sh
+shell/tst_format_device.sh
+shell/tst_check_driver.sh
+shell/tst_check_kconfig0[1-5].sh
+shell/tst_mount_device.sh
+shell/tst_mount_device_tmpfs.sh
+shell/tst_skip_filesystems.sh
+shell/net/*.sh}"
 
 cd $(dirname $0)
 PATH="$PWD/../../testcases/lib/:$PATH"
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
