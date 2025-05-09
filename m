Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748C4C3ABBC
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 11:32:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2C8F3CC1E7
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 13:32:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D5953CC1A1
 for <ltp@lists.linux.it>; Fri,  9 May 2025 13:32:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A096A1400043
 for <ltp@lists.linux.it>; Fri,  9 May 2025 13:32:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 634EB210F9;
 Fri,  9 May 2025 11:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746790336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wr/LBPr89z2nKtPq3gxzF5L7+klMeSlKCWS85O5m1HY=;
 b=XMPW+7qubxWjz5vDZPEifISImX870MbyWw3BmmeentBHZ84jHfVcWcTHQd8jU69lTK6joh
 Zd9BHdzfm2nyUGuVN3h1qBzGYsL6mTn2uFGHbeeppF4vcvYtFbuIQf8a6AsP32ZZ+2XSVb
 gMqGz6rgB6iZ01bX9AJHQcSWtC28G60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746790336;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wr/LBPr89z2nKtPq3gxzF5L7+klMeSlKCWS85O5m1HY=;
 b=dJaNsWVm0hc+tMjuYNr7lpklW0kALatWbQBcIaHBDsp9shH2OMO4bsKYuFs+lFa9u65Mbe
 wPUcMr8KP5MQ5ECQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746790336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wr/LBPr89z2nKtPq3gxzF5L7+klMeSlKCWS85O5m1HY=;
 b=XMPW+7qubxWjz5vDZPEifISImX870MbyWw3BmmeentBHZ84jHfVcWcTHQd8jU69lTK6joh
 Zd9BHdzfm2nyUGuVN3h1qBzGYsL6mTn2uFGHbeeppF4vcvYtFbuIQf8a6AsP32ZZ+2XSVb
 gMqGz6rgB6iZ01bX9AJHQcSWtC28G60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746790336;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wr/LBPr89z2nKtPq3gxzF5L7+klMeSlKCWS85O5m1HY=;
 b=dJaNsWVm0hc+tMjuYNr7lpklW0kALatWbQBcIaHBDsp9shH2OMO4bsKYuFs+lFa9u65Mbe
 wPUcMr8KP5MQ5ECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 549B31399F;
 Fri,  9 May 2025 11:32:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s/9DFMDnHWg+FQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 09 May 2025 11:32:16 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  9 May 2025 13:32:04 +0200
Message-ID: <20250509113206.59574-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mmap_24-1: Change vm.max_map_count if needed
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---

Changes since v1:
- Print warning if procfile cannot be opened
- Use fopen(..., "r") instead of "r+" in main()

 .../conformance/interfaces/mmap/24-1.c        | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
index 6cc8349e1..49673d603 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
@@ -31,12 +31,42 @@
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
+	if (!procfile) {
+		printf("Warning: Could not open %s\n", path);
+		return;
+	}
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
+	procfile = fopen(MAX_MAP_COUNT_PATH, "r");
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
@@ -78,5 +108,10 @@ int main(void)
 
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
