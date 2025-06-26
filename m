Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFC3C7EE30
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 12:36:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE6D53CCBE1
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 14:36:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7232A3CCBB2
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:35:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E824C600830
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:34:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D72E21196;
 Thu, 26 Jun 2025 12:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750941289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fFtUuqpII28/KFU49bhlgcrAqNg3nOYKmBkVxcZ4S/g=;
 b=io0pZI2nwK8ugVh5Nbgp3cwEU/7IbWC2tsTWCukVAq7O8yerU97Yop5BEeiYE6miScQWdm
 Kj5N8ZZI7RjKYjVWLrrLyPEMgz3J73OYzJ8rRlQPfuMc7+NGRefyP7xuoOncwCIp3xpAoJ
 sKNMfOBtdyiaVodjzH+Bmda/mwlByZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750941289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fFtUuqpII28/KFU49bhlgcrAqNg3nOYKmBkVxcZ4S/g=;
 b=4bRMznAgY09pyemkucbSjJVWtxfQ9XFfOKFElgsnNqz8rC6xbQvsWl2jMKVlI8LSFCkUci
 p4gUYWYHDW09uDDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750941289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fFtUuqpII28/KFU49bhlgcrAqNg3nOYKmBkVxcZ4S/g=;
 b=io0pZI2nwK8ugVh5Nbgp3cwEU/7IbWC2tsTWCukVAq7O8yerU97Yop5BEeiYE6miScQWdm
 Kj5N8ZZI7RjKYjVWLrrLyPEMgz3J73OYzJ8rRlQPfuMc7+NGRefyP7xuoOncwCIp3xpAoJ
 sKNMfOBtdyiaVodjzH+Bmda/mwlByZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750941289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fFtUuqpII28/KFU49bhlgcrAqNg3nOYKmBkVxcZ4S/g=;
 b=4bRMznAgY09pyemkucbSjJVWtxfQ9XFfOKFElgsnNqz8rC6xbQvsWl2jMKVlI8LSFCkUci
 p4gUYWYHDW09uDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EABD013A96;
 Thu, 26 Jun 2025 12:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oOeGN2g+XWhJCQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 26 Jun 2025 12:34:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 26 Jun 2025 14:34:39 +0200
MIME-Version: 1.0
Message-Id: <20250626-ioctl_pidfd_suite-v1-2-165b9abf0296@suse.com>
References: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
In-Reply-To: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750941288; l=1972;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=kffUFJvtq3bcniX8SA72VImzGo3js005VkVYwk6FiEU=;
 b=8UoiMNbkbY2djGU72wnKmWeNMlCW3ueX4dPehWedqRomMPm8YMXMIHoJjYM/OO6ELZ7WCG8aI
 aheR0jnGIm6AuvvuIRIN4J8p9cnrrvU3a6INpqfK5Dc78jzUcmHDxZQ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/6] Fallback PIDFD_GET_INFO related definitions
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
 configure.ac         |  2 ++
 include/lapi/pidfd.h | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/configure.ac b/configure.ac
index 69c5be7362a0e9f2fdaf3e6bd01f92f6f4880108..7132c00df97870e234fd5b8c9fcaf1beb263cf06 100644
--- a/configure.ac
+++ b/configure.ac
@@ -259,6 +259,8 @@ AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
 AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
 AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
 
+AC_CHECK_TYPES([struct pidfd_info],,,[#include <uapi/linux/pidfd.h>])
+
 # Tools knobs
 
 # Bash
diff --git a/include/lapi/pidfd.h b/include/lapi/pidfd.h
index 9ca8e5aa23626646ebb2f18880abd5e52298bfc6..55a44d5840c01bda7b31237c5c0d54ebba8155c5 100644
--- a/include/lapi/pidfd.h
+++ b/include/lapi/pidfd.h
@@ -8,16 +8,53 @@
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
 #define PIDFD_NONBLOCK O_NONBLOCK
 #endif
 
+#ifndef PIDFS_IOCTL_MAGIC
+#define PIDFS_IOCTL_MAGIC	0xFF
+#endif
+
+#ifndef PIDFD_GET_INFO
+#define PIDFD_GET_INFO		_IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
+#endif
+
+#ifndef PIDFD_INFO_EXIT
+#define PIDFD_INFO_EXIT		(1UL << 3)
+#endif
+
 static inline void pidfd_send_signal_supported(void)
 {
 	/* allow the tests to fail early */

-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
