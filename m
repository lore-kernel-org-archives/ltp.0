Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A394CC83F1A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:17:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44C973CCDC4
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 16:17:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5B233CCDAE
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1137A1400195
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B790421843;
 Wed, 23 Jul 2025 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cV3vMv7TaUmbFeMlPi+EVB51dq1ZJaFJVYvASqf4XqA=;
 b=vHCgnwRX9SE7jQbESrMJlRlMfd7plf5lYnubhc/nRmzoU7zCsksMNgaPncnBdh5uCrwcLD
 5EvmSUBSvUx8Sl6AUSPvYUJgL+3zpR6KWCsWW5sDQLvpBGufJFP9gnhQBO0xH/na2hhqSc
 /smCkKwBGfo7fvuVq1J1bHDToBn1VqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cV3vMv7TaUmbFeMlPi+EVB51dq1ZJaFJVYvASqf4XqA=;
 b=9ObPcdNxZEx64JUNDXnRBEyk+2xbcnG4IphajizpqsJmfULPoyD4wCBUCV7+4c12K+0Rny
 F0W02ySAvE/mWoDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="WYjU/ZFF";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xky6aZYn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cV3vMv7TaUmbFeMlPi+EVB51dq1ZJaFJVYvASqf4XqA=;
 b=WYjU/ZFF5cq6UQhhT9VD1kdrcytyWAhOcGiL/FZBjKZmr1munuywPPKdGT0MOUWuVl/LCT
 HxHKAs5HEHIQjlk+OQiBsFkQ1HaeRqpX5wwL2bAYHVf4V9TugKN8tT6d+JkVZ3glBxfH7e
 qhMHZH6gv51zBiu/iOSo/dfXxbNHnTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cV3vMv7TaUmbFeMlPi+EVB51dq1ZJaFJVYvASqf4XqA=;
 b=xky6aZYn9ApflfG3JfZZeUPaOzdsPneE//967QPjffAIuG2DK/I9+FyVdU5oFcbBS4lCit
 xPynRCr+/bfkHsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9129713AF2;
 Wed, 23 Jul 2025 14:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wIGrIaTugGj2LwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 23 Jul 2025 14:16:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 23 Jul 2025 16:15:16 +0200
MIME-Version: 1.0
Message-Id: <20250723-ioctl_pidfd_suite-v4-2-9309eacb1d8c@suse.com>
References: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
In-Reply-To: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753280164; l=2023;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=L31l0e/crlW32I+NTWxgWsL/M1MH6fXKth5vAN9jco8=;
 b=/jUlkOPLphvFjVWw9iF20ZUmuHchC8jIo1VPPeapHdWG8j99uUTFhyMhkNMM6UHyVRH+0FhKo
 NQzFjFy1nx1C1IW0RLRA4M+++adzhANYAHVTTiHkJrQZoJPAA0wwTrU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: B790421843
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,configure.ac:url,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/8] Fallback PIDFD_GET_INFO related definitions
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac         |  2 ++
 include/lapi/pidfd.h | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index cf37c58be9ebcdc5cf78c17afb00ffb91d55304a..8ec37639c140088065390887426b1adaacd15395 100644
--- a/configure.ac
+++ b/configure.ac
@@ -261,6 +261,8 @@ AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
 AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
 AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
 
+AC_CHECK_TYPES([struct pidfd_info],,,[#include <sys/pidfd.h>])
+
 # Tools knobs
 
 # Bash
diff --git a/include/lapi/pidfd.h b/include/lapi/pidfd.h
index 9ca8e5aa23626646ebb2f18880abd5e52298bfc6..a3205032cf7d702fd8a014456933f8495f5984e2 100644
--- a/include/lapi/pidfd.h
+++ b/include/lapi/pidfd.h
@@ -8,14 +8,51 @@
 #define LAPI_PIDFD_H__
 
 #include <fcntl.h>
+#include <stdint.h>
+#include <sys/ioctl.h>
+
 #ifdef HAVE_SYS_PIDFD_H
 # include <sys/pidfd.h>
 #endif
+
 #include "config.h"
 #include "lapi/syscalls.h"
 
+#ifndef HAVE_STRUCT_PIDFD_INFO
+struct pidfd_info {
+	uint64_t mask;
+	uint64_t cgroupid;
+	uint32_t pid;
+	uint32_t tgid;
+	uint32_t ppid;
+	uint32_t ruid;
+	uint32_t rgid;
+	uint32_t euid;
+	uint32_t egid;
+	uint32_t suid;
+	uint32_t sgid;
+	uint32_t fsuid;
+	uint32_t fsgid;
+	int32_t exit_code;
+	uint32_t coredump_mask;
+	uint32_t __spare1;
+};
+#endif
+
 #ifndef PIDFD_NONBLOCK
-#define PIDFD_NONBLOCK O_NONBLOCK
+# define PIDFD_NONBLOCK O_NONBLOCK
+#endif
+
+#ifndef PIDFS_IOCTL_MAGIC
+# define PIDFS_IOCTL_MAGIC	0xFF
+#endif
+
+#ifndef PIDFD_GET_INFO
+# define PIDFD_GET_INFO		_IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
+#endif
+
+#ifndef PIDFD_INFO_EXIT
+# define PIDFD_INFO_EXIT	(1UL << 3)
 #endif
 
 static inline void pidfd_send_signal_supported(void)

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
