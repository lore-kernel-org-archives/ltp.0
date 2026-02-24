Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E567FEFB81B
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 09:22:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 250EE3D0F7A
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 10:22:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8FB13D0F68
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 10:21:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 076FD200251
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 10:21:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 572133F13B;
 Tue, 24 Feb 2026 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771924907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+mEKzhS65bWwFDy8FuObaxWCAhiPYGGAgwk0jElz8Q0=;
 b=hnCWjyfcQepBeYEBLKHmx4GapDc1+GFeRawWntoYuFGVC/4w9z/fhe/oVdQ7HzLUePwfNV
 qAsPbi37/nTMxOEWrGBu/whU9r2L8xwvz6GeSj3dOLgcd0CSu7qA1ZhYi9ExjdefkyBg5d
 dFpEFKEiBMtwqeUoaFYsGaG17//LZ8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771924907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+mEKzhS65bWwFDy8FuObaxWCAhiPYGGAgwk0jElz8Q0=;
 b=o5Pc8qcycKsW4jB/SzK4+LmVCQz5FK4WzQySE6tMywisPhDrolXDiv/qvO5PpTX764y83+
 qE6nGpa1VwwbpnCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hnCWjyfc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o5Pc8qcy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771924907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+mEKzhS65bWwFDy8FuObaxWCAhiPYGGAgwk0jElz8Q0=;
 b=hnCWjyfcQepBeYEBLKHmx4GapDc1+GFeRawWntoYuFGVC/4w9z/fhe/oVdQ7HzLUePwfNV
 qAsPbi37/nTMxOEWrGBu/whU9r2L8xwvz6GeSj3dOLgcd0CSu7qA1ZhYi9ExjdefkyBg5d
 dFpEFKEiBMtwqeUoaFYsGaG17//LZ8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771924907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+mEKzhS65bWwFDy8FuObaxWCAhiPYGGAgwk0jElz8Q0=;
 b=o5Pc8qcycKsW4jB/SzK4+LmVCQz5FK4WzQySE6tMywisPhDrolXDiv/qvO5PpTX764y83+
 qE6nGpa1VwwbpnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BFD73EA68;
 Tue, 24 Feb 2026 09:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o/j3CKttnWkeeAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 24 Feb 2026 09:21:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 24 Feb 2026 10:21:45 +0100
MIME-Version: 1.0
Message-Id: <20260224-remove_runltp-v4-1-75483a655894@suse.com>
X-B4-Tracking: v=1; b=H4sIAKhtnWkC/33M0Q6CIBiG4VtpHEcTEIGOuo/WGshvsqU4UFZz3
 nvoUWvLw+/bnndGEYKDiM6HGQVILjrf51EeD6hudf8A7GzeiBa0KigtcYDOJ7iHqX+OAwYtaGk
 awgtrUDZDgMa9tt71lnfr4ujDe8snsr7/SolggoXRWihTcV3bS5winGrfoTWU6C6mGTdMyopqy
 Y0SP5jtYpYxZ1IZopXkFr7wsiwfl23KgCMBAAA=
X-Change-ID: 20260224-remove_runltp-ea724bf150db
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771924907; l=5306;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=BYS4x4IORooivzCQAe5V4julv/QHR5C4RICQO/3t09E=;
 b=ytAMUXUl8jg+VB372BZ5OjtOEjoXLuNa9sgIyAk+FBfyMSkkuoNmUBVDmwbGbX8QscuFpuZte
 ku4Klk+BwlwBiSFs8ocV6r9ODhLs77oqVAKx1V5CFRu8E3Vi70rWH3L
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 572133F13B
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Remove runltp `scenario_groups` leftovers
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- removed scenario_groups from documentation
- Link to v3: https://lore.kernel.org/r/20260224-remove_runltp-v3-1-5389b1a985de@suse.com

Changes in v3:
- remove scenario_groups from Makefile
- Link to v2: https://lore.kernel.org/r/20260224-remove_runltp-v2-1-f38862a85b97@suse.com

Changes in v2:
- forgot to keep runltp script
- Link to v1: https://lore.kernel.org/r/20260224-remove_runltp-v1-1-7baa79b65acd@suse.com
---
 Makefile                         |  4 ++--
 doc/developers/writing_tests.rst |  5 ++---
 scenario_groups/Makefile         | 38 --------------------------------------
 scenario_groups/default          | 28 ----------------------------
 scenario_groups/network          | 20 --------------------
 5 files changed, 4 insertions(+), 91 deletions(-)

diff --git a/Makefile b/Makefile
index d82366489c36b90ba665ee1030f9aebc528c25b8..2a7cf54caa4186b9a16402fefff778d6e0b2943d 100644
--- a/Makefile
+++ b/Makefile
@@ -45,8 +45,8 @@ COMMON_TARGETS		+= testcases tools metadata
 
 # Don't want to nuke the original files if we're installing in-build-tree.
 ifneq ($(BUILD_TREE_STATE),$(BUILD_TREE_SRCDIR_INSTALL))
-INSTALL_TARGETS		+= runtest scenario_groups testscripts
-CLEAN_TARGETS		+= include runtest scenario_groups testscripts
+INSTALL_TARGETS		+= runtest testscripts
+CLEAN_TARGETS		+= include runtest testscripts
 endif
 INSTALL_TARGETS		+= $(COMMON_TARGETS)
 CLEAN_TARGETS		+= $(COMMON_TARGETS) lib libs
diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index a7be78874d2c8609675c1d2f451c08a18011c653..992374f8bbee5ac5e1e5df623146c1824541b62c 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -256,9 +256,8 @@ Runtest Files
 ~~~~~~~~~~~~~
 
 The list of tests to be executed is stored in runtest files under the
-:master:`runtest` directory. The default set of runtest files to be executed is
-stored in :master:`scenario_groups/default`. When you add a test, you should add
-corresponding entries into some runtest file(s) as well.
+:master:`runtest` directory. When you add a test, you should add corresponding
+entries into some runtest file(s) as well.
 
 Each line of runtest file contains one test. The first item is the test name.
 All other items, separated by space will be executed as a command.
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
