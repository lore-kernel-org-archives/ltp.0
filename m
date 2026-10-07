Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B22ACA5FF1
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 14:01:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA0B23E7429
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 16:01:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35A203E2E0F
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 16:00:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4A5062009E8
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 16:00:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3B96321BC7;
 Wed,  7 Oct 2026 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791381650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yoropilRFm45iZq4vFJdxahTZ5ZZfFNKVo4v6RBd9qU=;
 b=EySKos+C3lASOfO/pzbJMmuznIFkdPs+9hZAtqCx//O8pCWt+ZR4dItU/vBA0UFzxqp4tB
 C4RBj0tuzQGoQDEuKbn24ZTs+XSaqs73eA/+PU5eueJ7kzytLHH96xL97nDKtQ9lilA6YJ
 dBy34hMAlVun6x/xkB1qkImpPlx1j9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791381650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yoropilRFm45iZq4vFJdxahTZ5ZZfFNKVo4v6RBd9qU=;
 b=9/WASeGz4HTyQXz/r78Je9ruPNbGYfuQKq4e7V7CaGQtZIL11cp7el9qpoZAheLdBIEBrS
 kgBGBllxDnUXoICQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=p5YiORCE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BrwIu5xX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791381649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yoropilRFm45iZq4vFJdxahTZ5ZZfFNKVo4v6RBd9qU=;
 b=p5YiORCETtly4YfS654Rluto347t0Z+ZpHevWYqJ/r7taoybYpccV8M0YVElalJ/sSD9cr
 wN29lOmSYQETYo2wRvTwHZq8aV//+3wdwkA+DtkhUtjdLORfZHpDbG14w9dRdFPOdz6ODr
 Q2cZsbsd8JRt+bGTSwr3L/oZ3bx8mto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791381649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yoropilRFm45iZq4vFJdxahTZ5ZZfFNKVo4v6RBd9qU=;
 b=BrwIu5xXc8jPbLL31PrKQ0mQUd9QebcLJ/vUjd58JB2jaDBHwhUUfcBmVRyq7j5Pf5MLYh
 nxtn6cSw/PNi9FAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF8D7139AF;
 Wed,  7 Oct 2026 14:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cP34H5BQxmqSLgAAD6G6ig:T2
 (envelope-from <andrea.cervesato@suse.de>); Wed, 07 Oct 2026 14:00:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 07 Oct 2026 16:00:45 +0200
MIME-Version: 1.0
Message-Id: <20261007-fix_leftovers-v1-1-63a1e7acd0e6@suse.com>
References: <20261007-fix_leftovers-v1-0-63a1e7acd0e6@suse.com>
In-Reply-To: <20261007-fix_leftovers-v1-0-63a1e7acd0e6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791381648; l=3811;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=KctJ5te0oOpTft6Zh8NL+gfkbcKOw7RV4Gt5k8ZeckQ=;
 b=hQ/v3ijjzSwqU5GfTNmdj4UOfhD/8T9U+dRcjEdMXlyQNYXYlLX6fef2M2qXEywIPTdlyMCg6
 +/d/nRsarsRDosvlRmy90xljUR3HZb2ITHCrvyQ+M1ATkQLKnTK13T7
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3B96321BC7
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] ltp-aiodio: Remove unused common_sparse.h
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

The common_sparse.h header has been unused since aiodio_sparse and
dio_sparse were refactored to the new LTP API. Remove it.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/io/ltp-aiodio/common_sparse.h | 129 -------------------------
 1 file changed, 129 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/common_sparse.h b/testcases/kernel/io/ltp-aiodio/common_sparse.h
deleted file mode 100644
index 3819e00a6..000000000
--- a/testcases/kernel/io/ltp-aiodio/common_sparse.h
+++ /dev/null
@@ -1,129 +0,0 @@
-/*
- * Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-#ifndef LTP_AIODIO_COMMON_SPARSE
-#define LTP_AIODIO_COMMON_SPARSE
-
-#include "common_checkzero.h"
-
-/*
- * This code tries to create dirty free blocks on
- * the HDD so there is a chance that blocks to be allocated
- * for a file are filled with something else than zeroes.
- *
- * The usefulness of this is IMHO questionable.
- */
-static void dirty_freeblocks(int size)
-{
-	int fd;
-	void *p;
-	int pg;
-	char *filename = "dirty_freeblocks";
-
-	pg = getpagesize();
-	size = ((size + pg - 1) / pg) * pg;
-
-	fd = open(filename, O_CREAT|O_RDWR|O_EXCL, 0600);
-
-	if (fd < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "failed to open '%s'", filename);
-
-	SAFE_FTRUNCATE(cleanup, fd, size);
-
-	p = SAFE_MMAP(cleanup, NULL, size, PROT_WRITE|PROT_READ, MAP_SHARED|MAP_FILE, fd, 0);
-
-	memset(p, 0xaa, size);
-	msync(p, size, MS_SYNC);
-	munmap(p, size);
-	close(fd);
-	unlink(filename);
-}
-
-/*
- * Scale value by kilo, mega, or giga.
- */
-long long scale_by_kmg(long long value, char scale)
-{
-	switch (scale) {
-	case 'g':
-	case 'G':
-		value *= 1024;
-	case 'm':
-	case 'M':
-		value *= 1024;
-	case 'k':
-	case 'K':
-		value *= 1024;
-		break;
-	case '\0':
-		break;
-	default:
-		usage();
-		break;
-	}
-	return value;
-}
-
-/*
- * Make sure we read only zeroes,
- * either there is a hole in the file,
- * or zeroes were actually written by parent.
- */
-static void read_sparse(char *filename, int filesize)
-{
-	int fd;
-	int  i, j, r;
-	char buf[4096];
-
-	fd = open(filename, O_RDONLY);
-	if (fd == -1) {
-		if (debug)
-			fprintf(stderr, "Child %i failed to open '%s'\n",
-			        getpid(), filename);
-		exit(10);
-	}
-
-	if (debug)
-		fprintf(stderr, "Child %i has opened '%s' for reading\n",
-		        getpid(), filename);
-
-	for (i = 0; i < 100000000; i++) {
-		off_t offset = 0;
-		char *badbuf;
-
-		if (debug)
-			fprintf(stderr, "Child %i loop %i\n", getpid(), i);
-
-		lseek(fd, SEEK_SET, 0);
-		for (j = 0; j < filesize+1; j += sizeof(buf)) {
-			r = read(fd, buf, sizeof(buf));
-			if (r > 0) {
-				if ((badbuf = check_zero(buf, r))) {
-					fprintf(stderr, "non-zero read at offset %u\n",
-						(unsigned int)(offset + badbuf - buf));
-					exit(10);
-				}
-			}
-			offset += r;
-		}
-	}
-
-	exit(0);
-}
-
-#endif /* LTP_AIODIO_COMMON_SPARSE */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
