Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CDEC54EBE
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 10:10:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1CA03CC938
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 11:09:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B58623CB4BA
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 11:09:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6167C10007DE
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 11:09:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 318DA60717;
 Mon, 16 Jan 2023 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1673863788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OToPyl4kl5LNSuSKZ1kMRFTPqAyUH/e2cGcT4ny3NMQ=;
 b=KPWC2qdppyxKKZIgeVQaLO5e7hdomm7SEAna1VWxFUrpq5cOh8L0jQjm2NWgVz4/9/ri5k
 hehyAX6z3OnInL+gLXeyYUgH1buah66kbbUpEmrLKJciaOdHmrWG3xdP8Jw+9h4oE0B9R6
 HxC1TPK2P4QeSVVpzY4/jfRd7G8JB48=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FFF9138FE;
 Mon, 16 Jan 2023 10:09:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id x04VGmsixWNeRwAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 16 Jan 2023 10:09:47 +0000
To: ltp@lists.linux.it
Date: Mon, 16 Jan 2023 02:41:01 -0500
Message-Id: <20230116074101.1264-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] readahead02.c: Use fsync instead of sync
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Use fsync on test file instead of sync should faster than syncing
whole system.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../kernel/syscalls/readahead/readahead02.c     | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 7acf4bb18..e04046bc3 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -99,6 +99,17 @@ static void drop_caches(void)
 	SAFE_FILE_PRINTF(DROP_CACHES_FNAME, "1");
 }
 
+static void sync_drop_caches(void)
+{
+	int fd;
+
+	fd  = SAFE_OPEN(testfile, O_RDONLY);
+	if (fsync(fd) == -1)
+		tst_brk(TBROK | TERRNO, "fsync()");
+	SAFE_CLOSE(fd);
+	drop_caches();
+}
+
 static unsigned long get_bytes_read(void)
 {
 	unsigned long ret;
@@ -233,8 +244,7 @@ static void test_readahead(unsigned int n)
 	read_testfile(tc, 0, testfile, testfile_size, &read_bytes, &usec,
 		      &cached);
 	cached_high = get_cached_size();
-	sync();
-	drop_caches();
+	sync_drop_caches();
 	cached_low = get_cached_size();
 	cached_max = MAX(cached_max, cached_high - cached_low);
 
@@ -246,8 +256,7 @@ static void test_readahead(unsigned int n)
 	else
 		cached = 0;
 
-	sync();
-	drop_caches();
+	sync_drop_caches();
 	cached_low = get_cached_size();
 	tst_res(TINFO, "read_testfile(1)");
 	ret = read_testfile(tc, 1, testfile, testfile_size, &read_bytes_ra,
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
