Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BFCFB3CE5
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 09:09:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 691D23DD9D3
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 11:09:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 091833DD9D3
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 11:09:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BF9CA1A00987
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 11:09:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E8065BD60;
 Mon, 30 Mar 2026 09:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774861741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LQs596xnSgbdRJ76CO4xdbnCzyiyYnS8zs83zVeotTs=;
 b=FFmdHirKTSDuEy8J5EDo9rfxB1nPOs1otLyz8SXS8RaZt3WzpR0Dzcq5XjBBGdW8yZCL5V
 kx+iXdwIBE+HQeIwXEDqupZSFXIqUd3ooclLB2T5FVrM6TGjhW82ohcOBU4QeqV+B2VNZu
 V0ncLmPG2SnSwdgq8GmxhjfFB6G8i5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774861741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LQs596xnSgbdRJ76CO4xdbnCzyiyYnS8zs83zVeotTs=;
 b=ncCSRgFCHl8lNs4CN/9IeEBp29JaN8X1OD+KPIxvQsQ4Xg1WMDPW7EkhJ2DRGESmp1Y01Y
 iueUKi5WQQwZG1Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FFmdHirK;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ncCSRgFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774861741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LQs596xnSgbdRJ76CO4xdbnCzyiyYnS8zs83zVeotTs=;
 b=FFmdHirKTSDuEy8J5EDo9rfxB1nPOs1otLyz8SXS8RaZt3WzpR0Dzcq5XjBBGdW8yZCL5V
 kx+iXdwIBE+HQeIwXEDqupZSFXIqUd3ooclLB2T5FVrM6TGjhW82ohcOBU4QeqV+B2VNZu
 V0ncLmPG2SnSwdgq8GmxhjfFB6G8i5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774861741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LQs596xnSgbdRJ76CO4xdbnCzyiyYnS8zs83zVeotTs=;
 b=ncCSRgFCHl8lNs4CN/9IeEBp29JaN8X1OD+KPIxvQsQ4Xg1WMDPW7EkhJ2DRGESmp1Y01Y
 iueUKi5WQQwZG1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD9E64A0A2;
 Mon, 30 Mar 2026 09:09:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EAdPNaw9ymnvDAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 30 Mar 2026 09:09:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 30 Mar 2026 11:08:41 +0200
Message-ID: <20260330090844.79598-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWELVE(0.00)[15];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:mid]
X-Rspamd-Queue-Id: 4E8065BD60
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] power_management: remove unsupported tests
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
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

after the removal there will be 3 tests in runtest/power_management_tests:
runpwtests0[346].sh [1] [2] [3] (besides recent Piotr's patch).
@power management folks: you're move than welcome to review usefulness
of these tests.

These are very simple ones, they touch just sysfs. IMHO still relevant,
if we keep them it should be cleaned and rewritten to use LTP API
(ideally C API).

Changes v1->v2:
Use 2 years old Cyril's patch [2] which removes even more tests
(runpwtests_exclusive0*.sh). Follow it with new patch removing unused tools.
My commit can be squashed, but maybe it's easier to review when separated.

Link to v1: [5].

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/4688c20c01eece869b59e05ca3dd68c43e0d6af7/testcases/kernel/power_management/runpwtests03.sh
[2] https://github.com/linux-test-project/ltp/blob/4688c20c01eece869b59e05ca3dd68c43e0d6af7/testcases/kernel/power_management/runpwtests04.sh
[3] https://github.com/linux-test-project/ltp/blob/4688c20c01eece869b59e05ca3dd68c43e0d6af7/testcases/kernel/power_management/runpwtests06.sh
[4] https://patchwork.ozlabs.org/project/ltp/patch/20240916113308.16749-1-chrubis@suse.cz/
[5] https://patchwork.ozlabs.org/project/ltp/patch/20260318132639.18818-3-pvorel@suse.cz/

Cyril Hrubis (1):
  Remove now unsupported power management tests

Petr Vorel (1):
  power_management: Remove unused tools

 runtest/power_management_tests                |   3 -
 runtest/power_management_tests_exclusive      |   6 -
 testcases/kernel/power_management/.gitignore  |   1 -
 testcases/kernel/power_management/Makefile    |   2 +-
 testcases/kernel/power_management/README      |  29 -
 .../kernel/power_management/lib/Makefile      |  25 -
 .../power_management/lib/pm_sched_mc.py       | 835 ------------------
 .../power_management/pm_cpu_consolidation.py  | 143 ---
 .../power_management/pm_get_sched_values.c    |  36 -
 .../kernel/power_management/pm_ilb_test.py    |  57 --
 .../kernel/power_management/pm_include.sh     | 311 +------
 .../power_management/pm_sched_domain.py       |  54 --
 .../kernel/power_management/runpwtests01.sh   |  71 --
 .../kernel/power_management/runpwtests02.sh   |  68 --
 .../kernel/power_management/runpwtests03.sh   |  10 +
 .../kernel/power_management/runpwtests05.sh   |  76 --
 .../kernel/power_management/runpwtests06.sh   |  31 +
 .../runpwtests_exclusive01.sh                 |  97 --
 .../runpwtests_exclusive02.sh                 |  68 --
 .../runpwtests_exclusive03.sh                 |  95 --
 .../runpwtests_exclusive04.sh                 |  58 --
 .../runpwtests_exclusive05.sh                 |  97 --
 22 files changed, 43 insertions(+), 2130 deletions(-)
 delete mode 100644 runtest/power_management_tests_exclusive
 delete mode 100644 testcases/kernel/power_management/.gitignore
 delete mode 100644 testcases/kernel/power_management/lib/Makefile
 delete mode 100755 testcases/kernel/power_management/lib/pm_sched_mc.py
 delete mode 100755 testcases/kernel/power_management/pm_cpu_consolidation.py
 delete mode 100644 testcases/kernel/power_management/pm_get_sched_values.c
 delete mode 100755 testcases/kernel/power_management/pm_ilb_test.py
 delete mode 100755 testcases/kernel/power_management/pm_sched_domain.py
 delete mode 100755 testcases/kernel/power_management/runpwtests01.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests02.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests05.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests_exclusive01.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests_exclusive02.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests_exclusive03.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests_exclusive04.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests_exclusive05.sh

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
