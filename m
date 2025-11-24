Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29FECFD313
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 13:13:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 547083C84F1
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 14:13:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D778B3C83EC
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 14:12:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2947710007FB
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 14:12:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 391B92232C;
 Mon, 24 Nov 2025 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763989962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l90gX7oZ02jkc4IFJLYCSYpajfE4GgRV5ohZBQyn4js=;
 b=Sbh5bSN+099Rx57q1DhldEZ1OzHSa/Dp1zbcex1x9lzWiuFHoll4rk8bflOeYn919+qElt
 0H/iNNy9+lJO5ls2x/KZxZXUgc1307RrcHVuzczCF7mZluBxWNWfoNYrGTLlbPx6iQ00bu
 XwrinnRLK4K9tPycenyCLSZM/GIRxRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763989962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l90gX7oZ02jkc4IFJLYCSYpajfE4GgRV5ohZBQyn4js=;
 b=jonJC7Ys9PZM97Urb5BgPupr6ZHMRftDFCKCqobzVQwrtJHDjUQi0eywZ7ZVxzUALgTq/p
 ExoiAON+oVrEmCBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763989962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l90gX7oZ02jkc4IFJLYCSYpajfE4GgRV5ohZBQyn4js=;
 b=Sbh5bSN+099Rx57q1DhldEZ1OzHSa/Dp1zbcex1x9lzWiuFHoll4rk8bflOeYn919+qElt
 0H/iNNy9+lJO5ls2x/KZxZXUgc1307RrcHVuzczCF7mZluBxWNWfoNYrGTLlbPx6iQ00bu
 XwrinnRLK4K9tPycenyCLSZM/GIRxRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763989962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l90gX7oZ02jkc4IFJLYCSYpajfE4GgRV5ohZBQyn4js=;
 b=jonJC7Ys9PZM97Urb5BgPupr6ZHMRftDFCKCqobzVQwrtJHDjUQi0eywZ7ZVxzUALgTq/p
 ExoiAON+oVrEmCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29AC83EA61;
 Mon, 24 Nov 2025 13:12:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KRiFCMpZJGn1RAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 24 Nov 2025 13:12:42 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 24 Nov 2025 14:13:35 +0100
Message-ID: <20251124131335.5009-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FREEMAIL_CC(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/readahead02: Wait for the readahead()
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
Cc: Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test did request readahead on a file and then immediatelly tried to
access the data and measure if readahead saved I/O or not. The problem
is that we need to wait a bit for the readahead to happen, especially on
hardware with slower I/O speeds. So the test now waits a bit for the
readahead to start and the loops for a while, with a short usleeps,
until retires are reached or until page cache stops to grow.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/readahead/readahead02.c   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index f007db187..e0f56e989 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -39,6 +39,8 @@ static char testfile[PATH_MAX] = "testfile";
 #define MEMINFO_FNAME "/proc/meminfo"
 #define PROC_IO_FNAME "/proc/self/io"
 #define DEFAULT_FILESIZE (64 * 1024 * 1024)
+#define INITIAL_SHORT_SLEEP_US 10000
+#define SHORT_SLEEP_US 5000
 
 static size_t testfile_size = DEFAULT_FILESIZE;
 static char *opt_fsizestr;
@@ -173,8 +175,47 @@ static int read_testfile(struct tcase *tc, int do_readahead,
 
 			i++;
 			offset += readahead_length;
+			/* Wait a bit so that the readahead() has chance to start. */
+			usleep(INITIAL_SHORT_SLEEP_US);
+			/*
+			 * We assume that the worst case I/O speed is around
+			 * 5MB/s which is roughly 5 bytes per 1 us, which gives
+			 * us upper bound for retries that is
+			 * readahead_size/(5 * SHORT_SLEEP_US).
+			 *
+			 * We also monitor the cache size increases before and
+			 * after the sleep. With the same assumption about the
+			 * speed we are supposed to read at least 5 *
+			 * SHORT_SLEEP_US bytes during that time. That amound
+			 * is genreally quite close a page size so that we just
+			 * assume that we sould continue as long as the cache
+			 * increases.
+			 *
+			 * Of course all of this is inprecise on multitasking
+			 * OS however even on a system where there are several
+			 * processes figthing for I/O this loop will wait as
+			 * long a cache is increasing which will gives us high
+			 * chance of waiting for the readahead to happen.
+			 */
+			unsigned long cached_prev, cached_cur = get_cached_size();
+			int retries = readahead_length / (5 * SHORT_SLEEP_US);
+
+			tst_res(TDEBUG, "Readahead cached %lu", cached_cur);
+
+			do {
+				usleep(SHORT_SLEEP_US);
+
+				cached_prev = cached_cur;
+				cached_cur = get_cached_size();
+
+				if (cached_cur <= cached_prev)
+					break;
+			} while (retries-- > 0);
+
 		} while ((size_t)offset < fsize);
+
 		tst_res(TINFO, "readahead calls made: %zu", i);
+
 		*cached = get_cached_size();
 
 		/* offset of file shouldn't change after readahead */
-- 
2.51.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
