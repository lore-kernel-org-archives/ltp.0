Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52C1FF8860
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 15:02:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC1E53E2D8D
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 17:02:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E624F3D0EE9
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 17:01:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 40F37200918
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 17:01:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 021C85BCFC
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 15:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777302112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gv4oqdGEtJGwyYJDQujQhIoJObWcNC0TwooXb4i9vwY=;
 b=KAls1YSAK2Lx0Mni2W6u6tgUEej+LCJdTY6kmJ//MpkYH3HRB0n9HQAXMjq7ttJiRKvCwD
 2Ri2qTo78qiRUvRE1QrvU/XOoXbbAK48p0lzNsvIbuH1x0J3ctM7dNbOHX7AqA0AbCZPK6
 NAz6w109578OqhnrsYPC9vgiTixWKqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777302112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gv4oqdGEtJGwyYJDQujQhIoJObWcNC0TwooXb4i9vwY=;
 b=x8tzdWQW4o1VAzJeaQBU/V6Ffx6ltmWSb0pg6QEVyuFZjZ9fijb2oA3UWcJ3WuEMe8BpBn
 s9u4rkhzl2mUCVDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TXoUtJ0w;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FWdfUaUE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777302109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gv4oqdGEtJGwyYJDQujQhIoJObWcNC0TwooXb4i9vwY=;
 b=TXoUtJ0w38mIGmCwkF9mwWcpnuRJPOOdNoUpSs1zIJcYRnEhVVIsV24IkuRjJ8dHbwJ2rR
 j0aLIm3X0HlsTvcOnRJvCHPVK0q+J2fRW+K6LKvk3GjcFp7AtCsno+sTEhLaV3Hn45FnB9
 0toUdF2veI/F2USn5J3WfiDn+Zf2dGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777302109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gv4oqdGEtJGwyYJDQujQhIoJObWcNC0TwooXb4i9vwY=;
 b=FWdfUaUE0ki6dhX3e4Dx8CjIZnP1CbIOzpVJRaH94IJ8VwNmUEyBz87KS3D9GthFvpBB6m
 Bs5GEblOEjgLAcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1E28593B0
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 15:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AmnXNlx672lLOAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 15:01:48 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 Apr 2026 17:01:35 +0200
Message-ID: <20260427150139.31685-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 021C85BCFC
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lapi/io_uring: Add IORING_OP_READ/WRITE constants
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

Changes since v1:
- Fixed preprocessor conditions in io_uring.h

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
index c05517595..2026863a2 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -253,6 +253,16 @@ struct io_uring_probe {
 	struct io_uring_probe_op ops[0];
 };
 
+#else /* IOSQE_FIXED_FILE */
+
+#if !HAVE_DECL_IORING_OP_READ
+#define IORING_OP_READ 22
+#endif
+
+#if !HAVE_DECL_IORING_OP_WRITE
+#define IORING_OP_WRITE 23
+#endif
+
 #endif /* IOSQE_FIXED_FILE */
 
 #ifndef IOSQE_IO_HADRLINK
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
