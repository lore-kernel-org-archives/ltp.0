Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D22CCD4F54
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 10:38:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECD1D3CB6D1
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 12:38:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12AB63C71E0
 for <ltp@lists.linux.it>; Wed, 27 May 2026 12:38:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 708C41400DB5
 for <ltp@lists.linux.it>; Wed, 27 May 2026 12:38:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43C076B064
 for <ltp@lists.linux.it>; Wed, 27 May 2026 10:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779878287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8pSXU8y5UUrhrP+Fwb7G6btpdtWmcUYHBXc1RJj9K0k=;
 b=ODpJgoxgHZRZ8hzn6kenx8B0fBAQbGuP7LzBiK/8FUJymRkmGVv13GKGYqxsp7fR9SdZk0
 VFWz27oPVov7OwnvrBHrhSm9Tci3tisy8qJIpLdvah7rFYON6T25qTxmQQYDHtSW0fyORG
 9yrDaX5MfDAOlpC87zXf8wqVlCh73R0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779878287;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8pSXU8y5UUrhrP+Fwb7G6btpdtWmcUYHBXc1RJj9K0k=;
 b=rBohYV6/3DFIHESrhRKecptr+4oLmwS6y9GPGZ0UsaM8USF/KJufgSApMi76uTu13U3Q1E
 esXV2SKVZTY+dzCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779878287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8pSXU8y5UUrhrP+Fwb7G6btpdtWmcUYHBXc1RJj9K0k=;
 b=ODpJgoxgHZRZ8hzn6kenx8B0fBAQbGuP7LzBiK/8FUJymRkmGVv13GKGYqxsp7fR9SdZk0
 VFWz27oPVov7OwnvrBHrhSm9Tci3tisy8qJIpLdvah7rFYON6T25qTxmQQYDHtSW0fyORG
 9yrDaX5MfDAOlpC87zXf8wqVlCh73R0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779878287;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8pSXU8y5UUrhrP+Fwb7G6btpdtWmcUYHBXc1RJj9K0k=;
 b=rBohYV6/3DFIHESrhRKecptr+4oLmwS6y9GPGZ0UsaM8USF/KJufgSApMi76uTu13U3Q1E
 esXV2SKVZTY+dzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B29D5A7B0
 for <ltp@lists.linux.it>; Wed, 27 May 2026 10:38:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IDxhCY/JFmr5dQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 27 May 2026 10:38:07 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 May 2026 12:37:56 +0200
Message-ID: <20260527103756.448843-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/madvise06: Fix sporadic not enough RAM TCONFs
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

On systems with <= 2GB RAM the test produced sporadic TCONFs. That is
because even if the test setup does sync() and drops caches the system
starts fauting in pages immediatelly after caches were dropped. It may
easily happen that system may fault in a few hundred of MBs of memory
betwen the write to drop_caches and the time sysinfo() syscall returns.

The correct fix is to use the MemAvailable metric from /proc/meminfo
that includes both free memory and caches and is more realistic estimate
of how much memory can be consumed by a test. We even have helper
functions in the test library so we simply make use of them.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index a9df913fc..969b24984 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -39,7 +39,6 @@
 #include <errno.h>
 #include <stdio.h>
 #include <sys/mount.h>
-#include <sys/sysinfo.h>
 #include "tst_test.h"
 
 #define CHUNK_SZ (400*1024*1024L)
@@ -90,22 +89,24 @@ static void meminfo_diag(const char *point)
 
 static void setup(void)
 {
-	struct sysinfo sys_buf_start;
-
 	pg_sz = getpagesize();
 
 	tst_res(TINFO, "dropping caches");
 	sync();
 	SAFE_FILE_PRINTF(drop_caches_fname, "3");
 
-	sysinfo(&sys_buf_start);
-	if (sys_buf_start.freeram < 2 * CHUNK_SZ) {
-		tst_brk(TCONF, "System RAM is too small (%li bytes needed)",
-			2 * CHUNK_SZ);
+	long long avail_mem = tst_available_mem();
+	long long avail_swap = tst_available_swap();
+	long long chunk_kb = 2 * CHUNK_SZ / 1024;
+
+	if (avail_mem < chunk_kb) {
+		tst_brk(TCONF, "System RAM is too small %llikB (%llikB needed)",
+			avail_mem, chunk_kb);
 	}
-	if (sys_buf_start.freeswap < 2 * CHUNK_SZ) {
-		tst_brk(TCONF, "System swap is too small (%li bytes needed)",
-			2 * CHUNK_SZ);
+
+	if (avail_swap < chunk_kb) {
+		tst_brk(TCONF, "System swap is too small %llikB (%llikB needed)",
+			avail_swap, chunk_kb);
 	}
 
 	check_path("/proc/self/oom_score_adj");
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
