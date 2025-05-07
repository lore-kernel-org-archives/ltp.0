Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60686C3ABBF
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 15:46:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECADD3CC000
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 17:46:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACBAD3C02B9
 for <ltp@lists.linux.it>; Wed,  7 May 2025 17:45:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D48541A004E6
 for <ltp@lists.linux.it>; Wed,  7 May 2025 17:45:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE3B31F395
 for <ltp@lists.linux.it>; Wed,  7 May 2025 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746632745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aaZlgJGQJQcAkDFi9HHv9sspLlEZt8/WE573E2MbHJg=;
 b=r1CYpTTH6XWkcPaDhbbgtUylIY8LX3/C0jVibk5VWWQVVdw9nhgJy6rB84MrhobZmSibYZ
 fMWyuVpHwcf1AYPqPTxOkSLMd2sD8XiYpvawBVOZDgZ4+Jx/SMsF8QZKsiuQmpZoYvZyON
 Zrd1k1M6aRi4ko/edFiwbZmdqMomT34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746632745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aaZlgJGQJQcAkDFi9HHv9sspLlEZt8/WE573E2MbHJg=;
 b=9Pq4yxQaE21BYR0bzqQKz7uvZoAgpe8emaxe7u+4pce0ELNAjjnCR3o5bU0i44fbWCFGQ/
 etpeNMY8lrB3RxBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r1CYpTTH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9Pq4yxQa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746632745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aaZlgJGQJQcAkDFi9HHv9sspLlEZt8/WE573E2MbHJg=;
 b=r1CYpTTH6XWkcPaDhbbgtUylIY8LX3/C0jVibk5VWWQVVdw9nhgJy6rB84MrhobZmSibYZ
 fMWyuVpHwcf1AYPqPTxOkSLMd2sD8XiYpvawBVOZDgZ4+Jx/SMsF8QZKsiuQmpZoYvZyON
 Zrd1k1M6aRi4ko/edFiwbZmdqMomT34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746632745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aaZlgJGQJQcAkDFi9HHv9sspLlEZt8/WE573E2MbHJg=;
 b=9Pq4yxQaE21BYR0bzqQKz7uvZoAgpe8emaxe7u+4pce0ELNAjjnCR3o5bU0i44fbWCFGQ/
 etpeNMY8lrB3RxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A404413882
 for <ltp@lists.linux.it>; Wed,  7 May 2025 15:45:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id w8OiJymAG2iabQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 07 May 2025 15:45:45 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 May 2025 17:45:41 +0200
Message-ID: <20250507154543.22309-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AE3B31F395
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.cz:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_TRACE(0.00)[suse.cz:+]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_NONE(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim, suse.cz:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mmap_24-1: Change vm.max_map_count if needed
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

If vm.max_map_count system parameter is too high, mmap24-1 may get
killed by OOM. Set the parameter to a reasonable low value so that
mmap() quickly fails as expected.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../conformance/interfaces/mmap/24-1.c        | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
index 6cc8349e1..91677d289 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
@@ -31,12 +31,40 @@
 #include <stdint.h>
 #include "posixtest.h"
 
+#define MAX_MAP_COUNT_PATH "/proc/sys/vm/max_map_count"
+#define MAP_COUNT_LIMIT 65530
+
+void proc_write_val(const char *path, size_t val)
+{
+	FILE *procfile;
+
+	procfile = fopen(path, "r+");
+
+	if (!procfile)
+		return;
+
+	fprintf(procfile, "%zu", val);
+	fclose(procfile);
+}
+
 int main(void)
 {
 	char tmpfname[256];
 	void *pa;
-	size_t len;
+	size_t len, max_map_count = 0;
 	int fd;
+	FILE *procfile;
+
+	/* Change vm.max_map_count to avoid OOM */
+	procfile = fopen(MAX_MAP_COUNT_PATH, "r+");
+
+	if (procfile) {
+		fscanf(procfile, "%zu", &max_map_count);
+		fclose(procfile);
+	}
+
+	if (max_map_count > MAP_COUNT_LIMIT)
+		proc_write_val(MAX_MAP_COUNT_PATH, MAP_COUNT_LIMIT);
 
 	/* Size of the shared memory object */
 	size_t shm_size = 1024;
@@ -78,5 +106,10 @@ int main(void)
 
 	close(fd);
 	printf("Test FAILED: Did not get ENOMEM as expected\n");
+
+	/* Restore original vm.max_map_count */
+	if (max_map_count > MAP_COUNT_LIMIT)
+		proc_write_val(MAX_MAP_COUNT_PATH, max_map_count);
+
 	return PTS_FAIL;
 }
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
