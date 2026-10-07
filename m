Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966BFCA5FFC
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 10:58:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8628D3C61C4
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 12:58:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D71943C61C4
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 12:57:49 +0200 (CEST)
Received: from mta0.migadu.com (out-237.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ed])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C9FAB1400C54
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 12:57:46 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=dW8diFthGBdi/LpLkjn+ADtJJyisHHLNr4+7F+dxqnk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791370665; v=1; x=1791975465;
 b=OGD6Yu2XMlWbyHdnUWC/zk8HRNqtekNR9Ae3Y6GSyuuQLKy6tW/0AuDTiJGb5iaOwBS1wfDa
 VCn14dw8x4eI970Ao8US94JsyFQuUAQ3McPzUqo/ColyoVP9Cid+s7GhmQYOmN5TZcRpToELceZ
 u2oWBtnR2qtU9/mAvOXsQBWI=
X-Envelope-To: ltp@lists.linux.it
Received: by mta10.migadu.com with ESMTPS id 2737bd704d6681d4;
 Wed, 07 Oct 2026 10:57:45 +0000
X-Mizu-Trace-ID: 2737bd704d6681d4
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Wed,  7 Oct 2026 18:57:27 +0800
Message-ID: <20261007105730.94492-1-li.wang@linux.dev>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] tst_kconfig: automatic module load/unload for
 CONFIG_*=m
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

Tests that depend on a config set to =m currently load the module
themselves, and may fail with misleading errors when it is missing,
e.g. bind() returning EADDRNOTAVAIL for AF_VSOCK without vsock_loopback.

This series makes tst_kconfig record the module for every
config_module_maps[] entry seen as =m, load them once the kernel
config check passes, and unload them at cleanup time.

Li Wang (3):
  tst_kconfig: load and unload kernel modules for CONFIG_*=m
  tst_kconfig: add module mappings for vsock/vsock_loopback
  testcases: drop manual tst_modprobe() now handled by tst_kconfig

 include/tst_kconfig.h                       | 28 ++++++++
 lib/tst_kconfig.c                           | 72 +++++++++++++++++++++
 lib/tst_test.c                              |  4 ++
 testcases/cve/cve-2025-21756.c              |  6 ++
 testcases/cve/cve-2026-46331.c              |  7 --
 testcases/cve/sctphantom.c                  |  3 -
 testcases/kernel/syscalls/keyctl/keyctl29.c |  3 -
 testcases/kernel/syscalls/keyctl/keyctl30.c |  3 -
 8 files changed, 110 insertions(+), 16 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
