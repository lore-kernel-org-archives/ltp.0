Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63CCC35FF3
	for <ltp@archiver.kernel.org>; Mon, 17 Mar 2025 14:07:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 448BC3CAB39
	for <ltp@archiver.kernel.org>; Mon, 17 Mar 2025 15:07:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 545643C0E9E
 for <ltp@lists.linux.it>; Mon, 17 Mar 2025 15:06:57 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 757211000463
 for <ltp@lists.linux.it>; Mon, 17 Mar 2025 15:06:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A4BC32125A;
 Mon, 17 Mar 2025 14:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742220414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kZX+ehS2AQAIHwMN6PSEDfgyz3ZT/vZHf1UYHcEeZzM=;
 b=0qW3+o7oRbEwEwBZ3eB3puFOsWePQPfDOg4/XI/UAtwYARYO/M+ozcnbiOXI31bChqHII/
 JYuASYR4n22A3Yc54tCkfg5DTtD+2uS/8havgiSPOQdkLMbTfCBkLKnrKU9IPzgvQMGmkv
 LRoNXkaF+ZSpjFO65ip4PpOuf5VlE38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742220414;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kZX+ehS2AQAIHwMN6PSEDfgyz3ZT/vZHf1UYHcEeZzM=;
 b=l3rbxy/VSja361ybzsBoh9o679R/gtv7rZv0/hXHmpumE8YoJ8ZovnmvUMLpuBpwP3zQ+G
 jJPLi5VRMAtivPDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742220414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kZX+ehS2AQAIHwMN6PSEDfgyz3ZT/vZHf1UYHcEeZzM=;
 b=0qW3+o7oRbEwEwBZ3eB3puFOsWePQPfDOg4/XI/UAtwYARYO/M+ozcnbiOXI31bChqHII/
 JYuASYR4n22A3Yc54tCkfg5DTtD+2uS/8havgiSPOQdkLMbTfCBkLKnrKU9IPzgvQMGmkv
 LRoNXkaF+ZSpjFO65ip4PpOuf5VlE38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742220414;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kZX+ehS2AQAIHwMN6PSEDfgyz3ZT/vZHf1UYHcEeZzM=;
 b=l3rbxy/VSja361ybzsBoh9o679R/gtv7rZv0/hXHmpumE8YoJ8ZovnmvUMLpuBpwP3zQ+G
 jJPLi5VRMAtivPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E4A4132CF;
 Mon, 17 Mar 2025 14:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aNAcFn4s2Gc4aAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Mar 2025 14:06:54 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 17 Mar 2025 15:06:51 +0100
Message-ID: <20250317140651.305762-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] m4: Remove (custom) check for <linux/random.h>
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

Header support is normally done with AC_CHECK_HEADERS_ONCE builtin.
<linux/random.h> was added in kernel git from the beginning (2.6.12)
no need to check for it.

getrandom() syscall is supported since kernel 3.17 (check for its
support, which was relevant at the time is done by tst_syscall()).

NOTE: whole check is done for getrandom() libc wrapper support (used in
include/lapi/getrandom.h), which was added in glibc 2.25, musl 1.1.20
and uclibc-ng v1.0.2 (but until v1.0.50 required _GNU_SOURCE).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Tested:
https://github.com/pevik/ltp/actions/runs/13901359040

 configure.ac             |  1 -
 include/lapi/getrandom.h |  2 +-
 m4/ltp-linuxrandom.m4    | 19 -------------------
 3 files changed, 1 insertion(+), 21 deletions(-)
 delete mode 100644 m4/ltp-linuxrandom.m4

diff --git a/configure.ac b/configure.ac
index 0f2b6f3329..6582ba8b0f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -376,7 +376,6 @@ LTP_CHECK_FORTIFY_SOURCE
 LTP_CHECK_KERNEL_DEVEL
 LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_LIBMNL
-LTP_CHECK_LINUXRANDOM
 LTP_CHECK_SELINUX
 LTP_CHECK_SYNC_ADD_AND_FETCH
 LTP_CHECK_SYSCALL_EVENTFD
diff --git a/include/lapi/getrandom.h b/include/lapi/getrandom.h
index 706ef9b8ff..8d5b90ee93 100644
--- a/include/lapi/getrandom.h
+++ b/include/lapi/getrandom.h
@@ -10,7 +10,7 @@
 
 #ifdef HAVE_SYS_RANDOM_H
 # include <sys/random.h>
-#elif HAVE_LINUX_RANDOM_H
+#else
 # include <linux/random.h>
 #endif
 
diff --git a/m4/ltp-linuxrandom.m4 b/m4/ltp-linuxrandom.m4
deleted file mode 100644
index 4f6b9d1355..0000000000
--- a/m4/ltp-linuxrandom.m4
+++ /dev/null
@@ -1,19 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) Linux Test Project, 2015
-
-AC_DEFUN([LTP_CHECK_LINUXRANDOM],[
-	AC_MSG_CHECKING([for linux/random.h])
-	AC_COMPILE_IFELSE([AC_LANG_SOURCE([
-
-#include <linux/random.h>
-int main(void) {
-	return 0;
-}])],[has_linux_random_h="yes"])
-
-if test "x$has_linux_random_h" = xyes; then
-	AC_DEFINE(HAVE_LINUX_RANDOM_H,1,[Define to 1 if having a valid linux/random.h])
-	AC_MSG_RESULT(yes)
-else
-	AC_MSG_RESULT(no)
-fi
-])
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
