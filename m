Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADEBEFB7F9
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 08:15:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 977A83D0F77
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 09:15:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A8503C2C22
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:14:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A55D11000447
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:14:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5259E5BCD5;
 Tue, 24 Feb 2026 08:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771920886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LbfdYJPvLYJSiJfxr2xLrCK1gQk6hKKPfCtxlHtxP84=;
 b=lasYYJppLG4NBTQY1BHi6vs/+RQFCBiygIqnB8BZYaYTwWZf9JmmrjRABhkpcLBzISZsAi
 upi1SjI3f3T6gPaC13unlTKE0EsUhCzwUhqinzOXXe4r2gp4wfoHrfdHORjy40w0/tcMau
 TBZJsuidAgT+r3YF6bt5y7WR6H+zdeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771920886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LbfdYJPvLYJSiJfxr2xLrCK1gQk6hKKPfCtxlHtxP84=;
 b=jL/RB6YiudtMHgJn/G3HHP8oiDi34UZ3duLGHx8SRyYNMfwm9LdiFXyaT5v5nLQyl8vZ8F
 k1m+K2a2F19wA8AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771920886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LbfdYJPvLYJSiJfxr2xLrCK1gQk6hKKPfCtxlHtxP84=;
 b=lasYYJppLG4NBTQY1BHi6vs/+RQFCBiygIqnB8BZYaYTwWZf9JmmrjRABhkpcLBzISZsAi
 upi1SjI3f3T6gPaC13unlTKE0EsUhCzwUhqinzOXXe4r2gp4wfoHrfdHORjy40w0/tcMau
 TBZJsuidAgT+r3YF6bt5y7WR6H+zdeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771920886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LbfdYJPvLYJSiJfxr2xLrCK1gQk6hKKPfCtxlHtxP84=;
 b=jL/RB6YiudtMHgJn/G3HHP8oiDi34UZ3duLGHx8SRyYNMfwm9LdiFXyaT5v5nLQyl8vZ8F
 k1m+K2a2F19wA8AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BD3C3EA68;
 Tue, 24 Feb 2026 08:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QhveCPZdnWlMNQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 24 Feb 2026 08:14:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 24 Feb 2026 09:14:45 +0100
MIME-Version: 1.0
Message-Id: <20260224-remove_runltp-v1-1-7baa79b65acd@suse.com>
X-B4-Tracking: v=1; b=H4sIAPRdnWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyMT3aLU3Pyy1Pii0ryckgLd1ERzI5OkNENTg5QkJaCegqLUtMwKsHn
 RsbW1AJ8O4IZfAAAA
X-Change-ID: 20260224-remove_runltp-ea724bf150db
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771920886; l=3722;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=FEuYvGVtHoL8dKG+XO9a79o0PcNIFnpjaiDfnZZdlmM=;
 b=dB5coSHOpThR0/hQr8dDSfdhshm0sWFr62IlFUo/0SsZln7r2m++6k3s+QEWPiMSI4D1uu9fj
 gfiKnHCFZyYB8tvj3VnxEiv6iuxBn28W0ozG3cCqj0nk4Ohm9/RbXpv
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Remove runltp leftovers
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Delete `runltp` script and `scenario_groups` folder.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runltp                   | 11 -----------
 scenario_groups/Makefile | 38 --------------------------------------
 scenario_groups/default  | 28 ----------------------------
 scenario_groups/network  | 20 --------------------
 4 files changed, 97 deletions(-)

diff --git a/runltp b/runltp
deleted file mode 100755
index 62b9367faae04d9787bc0b1f6b641c2db19b0137..0000000000000000000000000000000000000000
--- a/runltp
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2026
-
-cat >&2 << EOF
-runltp was removed from LTP use kirk instead
-https://github.com/linux-test-project/kirk
-https://kirk.readthedocs.io/
-EOF
-
-exit 1
diff --git a/scenario_groups/Makefile b/scenario_groups/Makefile
deleted file mode 100644
index fcbc9270829e2e496ef8bcc0fb69e558a0bb81ed..0000000000000000000000000000000000000000
--- a/scenario_groups/Makefile
+++ /dev/null
@@ -1,38 +0,0 @@
-#
-#    scenario-groups Makefile.
-#
-#    Copyright (C) 2010, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, November 2010
-#
-
-top_srcdir		?= ..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_DIR		:= scenario_groups
-
-# Don't copy over the Makefile
-UNWANTED_FILES		:= Makefile
-
-INSTALL_MODE		:= 00644
-
-INSTALL_TARGETS		:= $(filter-out $(UNWANTED_FILES),$(notdir $(patsubst $(abs_srcdir)/%,%,$(sort $(wildcard $(abs_srcdir)/*)))))
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/scenario_groups/default b/scenario_groups/default
deleted file mode 100644
index 0e76b2bee11c937e878ddf77c94f695129d98dbf..0000000000000000000000000000000000000000
--- a/scenario_groups/default
+++ /dev/null
@@ -1,28 +0,0 @@
-syscalls
-fs
-fs_perms_simple
-dio
-mm
-ipc
-irq
-sched
-math
-nptl
-pty
-containers
-fs_bind
-controllers
-fcntl-locktests
-power_management_tests
-hugetlb
-commands
-hyperthreading
-can
-cpuhotplug
-net.ipv6_lib
-input
-cve
-crypto
-kernel_misc
-uevent
-watchqueue
diff --git a/scenario_groups/network b/scenario_groups/network
deleted file mode 100644
index 974b9fc58317912d194334af28278fa9a22eef65..0000000000000000000000000000000000000000
--- a/scenario_groups/network
+++ /dev/null
@@ -1,20 +0,0 @@
-can
-net.features
-net.ipv6
-net.ipv6_lib
-net.tcp_cmds
-net.multicast
-net.nfs
-net.rpc_tests
-net.tirpc_tests
-net.sctp
-net_stress.appl
-net_stress.broken_ip
-net_stress.interface
-net_stress.ipsec_dccp
-net_stress.ipsec_icmp
-net_stress.ipsec_sctp
-net_stress.ipsec_tcp
-net_stress.ipsec_udp
-net_stress.multicast
-net_stress.route

---
base-commit: f062b34785db121c841f2faed8233b0943cdff27
change-id: 20260224-remove_runltp-ea724bf150db

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
