Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796B1C4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 12:43:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 101F23CFD6B
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 14:43:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D99C3CF511
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 14:42:26 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 078FE1A0C24F
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 14:42:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F1EE221A09;
 Fri, 19 Apr 2024 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713530545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=A+F6U9jtG7momZBR7aimDpuDWn+B72YXuUfKhugqlew=;
 b=jOWi22YcZPCC25O+6H89ixoiUtzRM4V+CkwIEW88zi6oCXkjaAHl1sfGljxiSMDbnG0Xha
 Dc4J0oUO9urw8r4xUxFJfpayFJWbkjurpgAocyzD1AT+1t2cUvuJAQxdC5GDqXooK7NToT
 WTKn5Zb24V/2nXrsKxwqSAmx7VPee+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713530545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=A+F6U9jtG7momZBR7aimDpuDWn+B72YXuUfKhugqlew=;
 b=lRFz9EHXnXvWey1quqBYd3PbY51GGn0iKMZ47Yo1LZOkxJWjVabBQrlz+3lP//iJPSkOjO
 XlXyC1MlJbq2QBBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713530544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=A+F6U9jtG7momZBR7aimDpuDWn+B72YXuUfKhugqlew=;
 b=g9ap0GBp/XCvtwplaotkPPXHIUGC6vZrNuZMOXWtcQvvi/N/1FK60djDYkxPpHXeszfgJU
 EU4bTrTumv9CDKGFy5PJPMx689vcZV6nAebpTB3bfWz7CixYeqR/ToxScniQSb1n1LbjKj
 ONbHKHL2OqRni3pJVTxTETajQVJowFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713530544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=A+F6U9jtG7momZBR7aimDpuDWn+B72YXuUfKhugqlew=;
 b=CLQDCkgB0788ghcD7SMoWuFGgxAYvGh5W9955ODj80/2QVYWGUPhHzeeotaymt02tHcyOj
 JGdKSESyJnhfDpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FEF313687;
 Fri, 19 Apr 2024 12:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5wx/C7BmImZNRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Apr 2024 12:42:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 19 Apr 2024 14:42:19 +0200
Message-ID: <20240419124221.207445-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] doc: Bump minimal supported kernel to 4.4
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

and remove RHEL-7.9 Maipo from the list.

kernel 3.10 was supported by CentOS 7 build, which was removed in
360927080. AFAIK all distros which use 3.10 kernel (or kernel < 4.4)
by SUSE/RHEL/whatever distro are using older LTP (including RHEL-7.9
Maipoi). Thus we should not claim we are build testing 3.10.

4.4 is kept because is still used for old SLES 12-SP3 (4.4 based).

This update is safe for upstream stable releases (the oldest stable
kernel is 4.19).

Update also old docs to prevent users / search engines got confused.

Fixes: 360927080 ("doc/support: Update the oldest tested distros")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

NOTE: if we ack this, we could remove various checks for 3.x kernels:

$ git grep 'kvercmp(3'
testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c:                       tkeys[i].good = tst_kvercmp(3, 15, 0) < 0;
testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c:               if (hier != 0 && tst_kvercmp(3, 15, 0) < 0)
testcases/kernel/syscalls/fallocate/fallocate04.c:      if (tst_kvercmp(3, 15, 0) < 0) {
testcases/kernel/syscalls/recv/recv01.c:                        if ((tst_kvercmp(3, 17, 0) < 0)
testcases/kernel/syscalls/recvfrom/recvfrom01.c:                        if ((tst_kvercmp(3, 17, 0) < 0)
testcases/kernel/syscalls/recvmsg/recvmsg01.c:  if ((tst_kvercmp(3, 17, 0) < 0)
testcases/kernel/syscalls/renameat2/renameat201.c:      if ((tst_kvercmp(3, 15, 0)) < 0) {
testcases/kernel/syscalls/renameat2/renameat202.c:      if ((tst_kvercmp(3, 15, 0)) < 0) {
testcases/kernel/syscalls/sched_getattr/sched_getattr01.c:      if ((tst_kvercmp(3, 14, 0)) < 0)
testcases/kernel/syscalls/sched_getattr/sched_getattr02.c:      if ((tst_kvercmp(3, 14, 0)) < 0)
testcases/kernel/syscalls/sched_setattr/sched_setattr01.c:      if ((tst_kvercmp(3, 14, 0)) < 0)
testcases/network/netstress/netstress.c:        if (busy_poll >= 0 && tst_kvercmp(3, 11, 0) < 0)

$ git grep TST_MIN_KVER=.3
testcases/kernel/controllers/cpuset/cpuset_regression_test.sh:TST_MIN_KVER="3.18"
testcases/network/busy_poll/busy_poll_lib.sh:TST_MIN_KVER="3.11"
testcases/network/tcp_cc/dctcp01.sh:TST_MIN_KVER="3.18"
testcases/network/tcp_fastopen/tcp_fastopen_run.sh:TST_MIN_KVER="3.7"

Kind regards,
Petr

 .../Supported-kernel,-libc,-toolchain-versions.asciidoc   | 2 +-
 doc/users/supported_systems.rst                           | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/doc/old/Supported-kernel,-libc,-toolchain-versions.asciidoc b/doc/old/Supported-kernel,-libc,-toolchain-versions.asciidoc
index 511b9e14b..252b7a4be 100644
--- a/doc/old/Supported-kernel,-libc,-toolchain-versions.asciidoc
+++ b/doc/old/Supported-kernel,-libc,-toolchain-versions.asciidoc
@@ -54,7 +54,7 @@ distribution you may as well reconsider you life choices.
 1.3 Minimal supported kernel version
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Minimal supported kernel version is 3.10.
+Minimal supported kernel version is 4.4.
 
 1.4 Supported libc
 ~~~~~~~~~~~~~~~~~~
diff --git a/doc/users/supported_systems.rst b/doc/users/supported_systems.rst
index 6220a96e0..82774c2ef 100644
--- a/doc/users/supported_systems.rst
+++ b/doc/users/supported_systems.rst
@@ -6,7 +6,7 @@ Supported systems
 Kernel version
 --------------
 
-Minimal supported kernel version is **3.10**.
+Minimal supported kernel version is **4.4**.
 
 Oldest tested distributions
 ---------------------------
@@ -38,12 +38,6 @@ Oldest tested distributions
       - 10.2.1
       - 11.0.1
 
-    * - RHEL-7.9 Maipo
-      - 3.10
-      - 4.8.5
-      - 2.17
-      - \-
-
 Older distributions are not officially supported, which means that it
 may or may not work. It all depends on your luck. It should be possible
 to compile latest LTP even on slightly older distributions than we
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
