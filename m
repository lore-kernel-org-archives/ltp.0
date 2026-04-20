Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E1DF588F9
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 16:35:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAB013E701E
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 18:34:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEDE23E2603
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 18:34:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0EDBC600435
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 18:34:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45CAC6A7DF;
 Mon, 20 Apr 2026 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776702878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rE1qYDVpkYFmab/OlipsxcqazD1xlEaIYBJniVGDH3Y=;
 b=xkn2/2asJTWoy4+PvE0VoAzWLQNLgVCCKSQzFvOBYo0tZzszRRgnfKY1+Pxh/0DZCKPV7Q
 G1yxen3AIrgMB68Id/zmEwvMJA/tbUyvSBJ+b9Jv7xJUrFrthL+bl2ODhaNwARx6GNMnsd
 YzsR7Vizov4ArZFGOe+P6+rxMeSgA2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776702878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rE1qYDVpkYFmab/OlipsxcqazD1xlEaIYBJniVGDH3Y=;
 b=hb/F6vH8OzxC1tCWJ3Mtf1VWjWzOe76MwW2A+7RMNTotdzIMVJflA45ZjIjmghCGKuyJUs
 U/AnBbgr6Z+R7BAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776702878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rE1qYDVpkYFmab/OlipsxcqazD1xlEaIYBJniVGDH3Y=;
 b=xkn2/2asJTWoy4+PvE0VoAzWLQNLgVCCKSQzFvOBYo0tZzszRRgnfKY1+Pxh/0DZCKPV7Q
 G1yxen3AIrgMB68Id/zmEwvMJA/tbUyvSBJ+b9Jv7xJUrFrthL+bl2ODhaNwARx6GNMnsd
 YzsR7Vizov4ArZFGOe+P6+rxMeSgA2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776702878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rE1qYDVpkYFmab/OlipsxcqazD1xlEaIYBJniVGDH3Y=;
 b=hb/F6vH8OzxC1tCWJ3Mtf1VWjWzOe76MwW2A+7RMNTotdzIMVJflA45ZjIjmghCGKuyJUs
 U/AnBbgr6Z+R7BAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E08593AE;
 Mon, 20 Apr 2026 16:34:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rlCHCZ5V5mkIZAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Mon, 20 Apr 2026 16:34:38 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>,
	ltp@lists.linux.it
Date: Mon, 20 Apr 2026 18:34:09 +0200
Message-ID: <20260420163433.44646-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lapi/io_uring: Add IORING_OP_READ/WRITE constants
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

Add fallback definitions for IORING_OP_READ and IORING_OP_WRITE.
These constants have been added in kernel v5.6 and older systems may
lack them, which results in LTP build failures.

Fixes: fcc4887e73 ("io_uring: Test IORING READ and WRITE operations")
Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 configure.ac            |  2 ++
 include/lapi/io_uring.h | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/configure.ac b/configure.ac
index 812f17d8b..4b789bfe3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -46,6 +46,8 @@ AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
 AC_CHECK_DECLS([NFTA_CHAIN_ID, NFTA_VERDICT_CHAIN_ID],,,[#include <linux/netfilter/nf_tables.h>])
 AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
 AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
+AC_CHECK_DECLS([IORING_OP_READ],,,[#include <linux/io_uring.h>])
+AC_CHECK_DECLS([IORING_OP_WRITE],,,[#include <linux/io_uring.h>])
 
 AC_CHECK_HEADERS_ONCE([ \
     aio.h \
diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
index c05517595..46168363d 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -253,6 +253,16 @@ struct io_uring_probe {
 	struct io_uring_probe_op ops[0];
 };
 
+#else /* IOSQE_FIXED_FILE */
+
+#ifndef HAVE_IORING_OP_READ
+#define IORING_OP_READ 22
+#endif
+
+#ifndef HAVE_IORING_OP_WRITE
+#define IORING_OP_WRITE 23
+#endif
+
 #endif /* IOSQE_FIXED_FILE */
 
 #ifndef IOSQE_IO_HADRLINK
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
