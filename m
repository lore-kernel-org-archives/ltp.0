Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01756D74EC3
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 13:16:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 764E63CB844
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 14:16:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF0423C4C11
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 14:16:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2D666600D46
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 14:16:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7CB75BCD7;
 Fri, 23 Jan 2026 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769174177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V2EoSbhY11LT2MNuIlLDoZNVEK5t0ydLcMDb28blcrc=;
 b=NMKDYipK6lxMyoGPtnkxAYTNgc2PBGQf88ru6mCU5jFq0HOnBZK2YPNuqgggNffPf0XmQc
 1Mjl0ThL2JaVWmxZyl8muyvo5DJbPHpdukNUglBPGAsGfQH043piC6UyDqGEjaFr8d4ew8
 tMzAgcyO5/PWGYxwZ300DZoVb8FdDH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769174177;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V2EoSbhY11LT2MNuIlLDoZNVEK5t0ydLcMDb28blcrc=;
 b=9K9dGqjx0pmo+4/UOcQBYpHPEuQoA54+wAvJWTdoF0r63iEk3xDut+PR1IgnROclHr4SUc
 48TBYE69x2uvreDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NMKDYipK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9K9dGqjx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769174177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V2EoSbhY11LT2MNuIlLDoZNVEK5t0ydLcMDb28blcrc=;
 b=NMKDYipK6lxMyoGPtnkxAYTNgc2PBGQf88ru6mCU5jFq0HOnBZK2YPNuqgggNffPf0XmQc
 1Mjl0ThL2JaVWmxZyl8muyvo5DJbPHpdukNUglBPGAsGfQH043piC6UyDqGEjaFr8d4ew8
 tMzAgcyO5/PWGYxwZ300DZoVb8FdDH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769174177;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V2EoSbhY11LT2MNuIlLDoZNVEK5t0ydLcMDb28blcrc=;
 b=9K9dGqjx0pmo+4/UOcQBYpHPEuQoA54+wAvJWTdoF0r63iEk3xDut+PR1IgnROclHr4SUc
 48TBYE69x2uvreDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A265F136AA;
 Fri, 23 Jan 2026 13:16:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ocELJqF0c2lhXgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 23 Jan 2026 13:16:17 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 23 Jan 2026 14:16:15 +0100
MIME-Version: 1.0
Message-Id: <20260123-fix_dio_sparse_slow-v1-1-65bd0dc0d52f@suse.com>
X-B4-Tracking: v=1; b=H4sIAJ50c2kC/x2MQQqAIBAAvxJ7TjArrb4SIZFbLUSGCxWIf086D
 sxMBMZAyDAUEQLexOTPDFVZwLLP54aCXGZQUmlZqVqs9FpH3vI1B0bLh39Er9q+7Yw2zjSQyyt
 g1v7rOKX0AYunRpxlAAAA
X-Change-ID: 20260123-fix_dio_sparse_slow-925958767d74
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769174177; l=2341;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=XIKs2/iujtzIfwYpmRPx2D0X6Vsyb8hWbvcRKuOM4E4=;
 b=yU9+tIemnl+d7BbGCV10ulk91H1RajNIcGlrEq2zcrqysB571EcHqcADwrvK1kucsmnd4G86y
 N0AJHJswbM5CNROzn0Y7vrtEAzo5Z+JsGOXwpn6yryxbTuhBEhCB0yW
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: C7CB75BCD7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] io: fix really slow dio_sparse on certain systems
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

The reason why dio_sparse is happening to be slow on certain systems is
that, if data buffering is slow, we run more buffered read() for one
single dio write(). This slows down the whole test, because for each
read() we always need to move data from kernel space to user space.

Create a READ_BUFFER_SIZE variable inside the common.h header and use
it to define the write buffer size.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/io/ltp-aiodio/common.h     | 6 ++++--
 testcases/kernel/io/ltp-aiodio/dio_sparse.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
index 9a2d2716661651adf40c635ac516cc70068c9393..d3f05a3c1e75cd4baa629cbce1872729a0d641c6 100644
--- a/testcases/kernel/io/ltp-aiodio/common.h
+++ b/testcases/kernel/io/ltp-aiodio/common.h
@@ -9,6 +9,8 @@
 #include <stdlib.h>
 #include "tst_test.h"
 
+#define READ_BUFFER_SIZE 4096
+
 static inline char *check_zero(char *buf, int size)
 {
 	char *p;
@@ -57,7 +59,7 @@ static inline void io_append(const char *path, char pattern, int flags, size_t b
 
 static inline void io_read(const char *filename, int filesize, volatile int *run_child)
 {
-	char buff[4096];
+	char buff[READ_BUFFER_SIZE];
 	int fd;
 	int i;
 	int r;
@@ -102,7 +104,7 @@ exit:
 
 static inline void io_read_eof(const char *filename, volatile int *run_child)
 {
-	char buff[4096];
+	char buff[READ_BUFFER_SIZE];
 	int fd;
 	int r;
 
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index c87e5ab1aca7c8910f76ee87f86b561f548d4cdf..d858340bf9a707fb019e82c644da7f355ad0effd 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -32,7 +32,7 @@ static char *str_filesize;
 static char *str_offset;
 
 static int numchildren = 16;
-static long long writesize = 1024;
+static long long writesize = READ_BUFFER_SIZE;
 static long long filesize = 100 * 1024 * 1024;
 static long long offset = 0;
 static long long alignment;

---
base-commit: c47ab95d5fe077133e598ac7762387450a87cb2b
change-id: 20260123-fix_dio_sparse_slow-925958767d74

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
