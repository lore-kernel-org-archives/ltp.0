Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA7DC10DCE
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 21:28:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DAE73CF045
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 22:28:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BEA23CD687
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 22:27:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A764D603A29
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 22:27:47 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CEC7F1FD75;
 Thu,  7 Dec 2023 21:27:46 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 40D0813907;
 Thu,  7 Dec 2023 21:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id +LUhCNI4cmXtHQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Dec 2023 21:27:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  7 Dec 2023 22:27:38 +0100
Message-ID: <20231207212739.302374-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207212739.302374-1-pvorel@suse.cz>
References: <20231207212739.302374-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [12.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(1.20)[suse.cz];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(4.60)[~all:c];
 NEURAL_HAM_SHORT(-0.20)[-0.984]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: CEC7F1FD75
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] fsx-linux: Reduce log output with TDBUG
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

Log output is very verbose thus silent with changing most verbose
TINFO messages to TDBUG. Given how many times the test tries it's a
significant time spent for printing output. This change also helps to
run on slower SUT without need to set LTP_TIMEOUT_MUL environment
variable.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/fs/fsx-linux/fsx-linux.c | 33 ++++++++---------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index 112c21f85..5b099c8a0 100644
--- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
+++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
@@ -98,8 +98,7 @@ static void update_file_size(struct file_pos_t const *pos)
 {
 	if (pos->offset + pos->size > file_size) {
 		file_size = pos->offset + pos->size;
-
-		tst_res(TINFO, "File size changed: %llu", file_size);
+		tst_res(TDBUG, "File size changed: %llu", file_size);
 	}
 }
 
@@ -114,8 +113,7 @@ static int memory_compare(
 	for (long long i = 0; i < size; i++) {
 		diff = a[i] - b[i];
 		if (diff) {
-			tst_res(TINFO,
-				"File memory differs at offset=%llu ('%c' != '%c')",
+			tst_res(TDBUG, "File memory differs at offset=%llu ('%c' != '%c')",
 				offset + i, a[i], b[i]);
 			break;
 		}
@@ -135,10 +133,8 @@ static int op_read(void)
 
 	op_file_position(file_size, op_read_align, &pos);
 
-	tst_res(TINFO,
-		"Reading at offset=%llu, size=%llu",
-		pos.offset,
-		pos.size);
+	tst_res(TDBUG, "Reading at offset=%llu, size=%llu",
+		pos.offset, pos.size);
 
 	memset(temp_buff, 0, file_max_size);
 
@@ -176,10 +172,8 @@ static int op_write(void)
 		temp_buff[i] = data;
 	}
 
-	tst_res(TINFO,
-		"Writing at offset=%llu, size=%llu",
-		pos.offset,
-		pos.size);
+	tst_res(TDBUG, "Writing at offset=%llu, size=%llu",
+		pos.offset, pos.size);
 
 	SAFE_LSEEK(file_desc, (off_t)pos.offset, SEEK_SET);
 	SAFE_WRITE(SAFE_WRITE_ALL, file_desc, temp_buff, pos.size);
@@ -194,10 +188,9 @@ static int op_truncate(void)
 	struct file_pos_t pos;
 
 	op_file_position(file_max_size, op_trunc_align, &pos);
-
 	file_size = pos.offset + pos.size;
 
-	tst_res(TINFO, "Truncating to %llu", file_size);
+	tst_res(TDBUG, "Truncating to %llu", file_size);
 
 	SAFE_FTRUNCATE(file_desc, file_size);
 	memset(file_buff + file_size, 0, file_max_size - file_size);
@@ -218,10 +211,8 @@ static int op_map_read(void)
 	op_file_position(file_size, op_read_align, &pos);
 	op_align_pages(&pos);
 
-	tst_res(TINFO,
-		"Map reading at offset=%llu, size=%llu",
-		pos.offset,
-		pos.size);
+	tst_res(TDBUG, "Map reading at offset=%llu, size=%llu",
+		pos.offset, pos.size);
 
 	addr = SAFE_MMAP(
 		0, pos.size,
@@ -261,10 +252,8 @@ static int op_map_write(void)
 	if (file_size < pos.offset + pos.size)
 		SAFE_FTRUNCATE(file_desc, pos.offset + pos.size);
 
-	tst_res(TINFO,
-		"Map writing at offset=%llu, size=%llu",
-		pos.offset,
-		pos.size);
+	tst_res(TDBUG, "Map writing at offset=%llu, size=%llu",
+		pos.offset, pos.size);
 
 	for (long long i = 0; i < pos.size; i++)
 		file_buff[pos.offset + i] = random() % 10 + 'l';
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
