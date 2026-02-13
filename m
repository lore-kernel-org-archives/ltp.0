Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4F2EDF172
	for <ltp@archiver.kernel.org>; Fri, 13 Feb 2026 14:52:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B8763CF914
	for <ltp@archiver.kernel.org>; Fri, 13 Feb 2026 15:52:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9005A3CE774
 for <ltp@lists.linux.it>; Fri, 13 Feb 2026 15:52:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CE650600E3E
 for <ltp@lists.linux.it>; Fri, 13 Feb 2026 15:52:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18EA03E74B
 for <ltp@lists.linux.it>; Fri, 13 Feb 2026 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770994321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Qk5lIKzZWkweO2pHYuIiVAWTAYIc97XJwI4eAnIDZW8=;
 b=r2ppAqQj05tegi88jLoJc2IkHkRq4KSB9yf98XmlTz9oHscuCnJd/flayjHOosv5lyjdwq
 GFSZeQDZoyf/nK6CY1nyFe37XJcsvhTNM2CUH9qfq8Wv4co+4lh8H+kKP6lcPTYch1WPRw
 +VN9Hk3uAANWBW/aLS3yASW37CWtTY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770994321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Qk5lIKzZWkweO2pHYuIiVAWTAYIc97XJwI4eAnIDZW8=;
 b=AoTNED7UemTnQgjaPTihZhXAt9B/b2/QOB9FWdkIksSUbrTWMduQ42NCYJm8MmWXxFndZO
 KZ8fk90U1S6DHjBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r2ppAqQj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AoTNED7U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770994321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Qk5lIKzZWkweO2pHYuIiVAWTAYIc97XJwI4eAnIDZW8=;
 b=r2ppAqQj05tegi88jLoJc2IkHkRq4KSB9yf98XmlTz9oHscuCnJd/flayjHOosv5lyjdwq
 GFSZeQDZoyf/nK6CY1nyFe37XJcsvhTNM2CUH9qfq8Wv4co+4lh8H+kKP6lcPTYch1WPRw
 +VN9Hk3uAANWBW/aLS3yASW37CWtTY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770994321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Qk5lIKzZWkweO2pHYuIiVAWTAYIc97XJwI4eAnIDZW8=;
 b=AoTNED7UemTnQgjaPTihZhXAt9B/b2/QOB9FWdkIksSUbrTWMduQ42NCYJm8MmWXxFndZO
 KZ8fk90U1S6DHjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06CF73EA62
 for <ltp@lists.linux.it>; Fri, 13 Feb 2026 14:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BieEAZE6j2lVYQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 13 Feb 2026 14:52:01 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Feb 2026 15:51:54 +0100
Message-ID: <20260213145200.23935-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 18EA03E74B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] readahead02: Always allow at least 100ms for cache to
 fill
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

The current wait algorithm for filling the cache after readahead()
will never retry if the cache doesn't start filling within 15ms.
Rewrite the wait loop to always allow at least 100ms for the cache
to fill and exit early only if cache increased by at least half
of the expected amount. This fixes random test failures if the interval
between cache increases is longer than 5ms.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/readahead/readahead02.c   | 45 +++++++++----------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 8dbcec2e7..5f7ab076b 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -38,8 +38,8 @@ static char testfile[PATH_MAX] = "testfile";
 #define DROP_CACHES_FNAME "/proc/sys/vm/drop_caches"
 #define PROC_IO_FNAME "/proc/self/io"
 #define DEFAULT_FILESIZE (64 * 1024 * 1024)
-#define INITIAL_SHORT_SLEEP_US 10000
 #define SHORT_SLEEP_US 5000
+#define MIN_SLEEP_LIMIT 20
 
 static size_t testfile_size = DEFAULT_FILESIZE;
 static char *opt_fsizestr;
@@ -193,12 +193,20 @@ static int read_testfile(struct tcase *tc, int do_readahead,
 	long read_bytes_start;
 	unsigned char *p, tmp;
 	off_t offset = 0;
-	unsigned long cached_prev = 0, cached_cur = 0;
+	size_t cached_prev;
+	ssize_t cache_diff;
 
 	fd = SAFE_OPEN(fname, O_RDONLY);
 
 	if (do_readahead) {
 		do {
+			cached_prev = get_file_cached_bytes(fname, fsize);
+			tst_res(TDEBUG, "Per-file cached: %lu kB",
+				cached_prev / 1024);
+
+			if (cached_prev >= fsize)
+				break;
+
 			TEST(tc->readahead(fd, offset, fsize - offset));
 			if (TST_RET != 0) {
 				SAFE_CLOSE(fd);
@@ -207,40 +215,27 @@ static int read_testfile(struct tcase *tc, int do_readahead,
 
 			i++;
 			offset += readahead_length;
-			/* Wait a bit so that the readahead() has chance to start. */
-			usleep(INITIAL_SHORT_SLEEP_US);
 			/*
 			 * We assume that the worst case I/O speed is around
-			 * 5MB/s which is roughly 5 bytes per 1 us, which gives
+			 * 5MB/s which is roughly 5 bytes per 1 us and we
+			 * allow additional 25ms for seeks, which gives
 			 * us upper bound for retries that is
-			 * readahead_size/(5 * SHORT_SLEEP_US).
+			 * 5 + readahead_size/(5 * SHORT_SLEEP_US).
 			 *
-			 * We also monitor the cache size increases before and
-			 * after the sleep. With the same assumption about the
-			 * speed we are supposed to read at least 5 *
-			 * SHORT_SLEEP_US bytes during that time. That amound
-			 * is genreally quite close a page size so that we just
-			 * assume that we sould continue as long as the cache
-			 * increases.
-			 *
-			 * Of course all of this is inprecise on multitasking
-			 * OS however even on a system where there are several
-			 * processes figthing for I/O this loop will wait as
-			 * long a cache is increasing which will gives us high
-			 * chance of waiting for the readahead to happen.
+			 * We also monitor the cache size and exit the wait
+			 * loop early if it increases by at least 50%
+			 * of the read ahead size.
 			 */
-			cached_cur = get_file_cached_bytes(fname, fsize);
 			int retries = readahead_length / (5 * SHORT_SLEEP_US);
 
-			tst_res(TDEBUG, "Per-file cached: %lu kB", cached_cur / 1024);
+			retries = MAX(retries + 5, MIN_SLEEP_LIMIT);
 
 			do {
 				usleep(SHORT_SLEEP_US);
+				cache_diff = get_file_cached_bytes(fname,
+					fsize) - cached_prev;
 
-				cached_prev = cached_cur;
-				cached_cur = get_file_cached_bytes(fname, fsize);
-
-				if (cached_cur <= cached_prev)
+				if (cache_diff >= readahead_length / 2)
 					break;
 			} while (retries-- > 0);
 
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
