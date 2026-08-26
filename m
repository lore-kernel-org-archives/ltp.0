Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07722C5DF97
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 12:41:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F07083CE321
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 14:41:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CADCC3C6F71
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 14:41:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0A2C51000A27
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 14:41:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 396E41F851;
 Wed, 26 Aug 2026 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787748062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/tvDFCNGxQ0K7Ky1Ld8OEqNIXi1O2KbN4J4W4mHAv8=;
 b=WgtvLvXXZ78Vf78zpQ1QQ9KEDDA4s+IK1lwKmXveJigilTS/mu5CesTggo3Fx1QqG7UE49
 3TrLGhUvcIn1pp0ubbj6/sgVgAhJD3e3dv3ma8VHIl14NWK5cnrJLJjEoVJXLjDIV4taWH
 zsAYXHuGKmnRZliWIQnLcAbGsa0phHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787748062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/tvDFCNGxQ0K7Ky1Ld8OEqNIXi1O2KbN4J4W4mHAv8=;
 b=BzEpdARQBuAHHTkNfXomFCLqPEiZDzOMA3CeT+0lxTETdkQAEl6dGlx3O0WoaiQE9P1wgO
 JNI6YH+tN+AARGCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EffYtvMB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tIWlqcHO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787748058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/tvDFCNGxQ0K7Ky1Ld8OEqNIXi1O2KbN4J4W4mHAv8=;
 b=EffYtvMB5LvlHnMLo9JIByyRUzb8WsqyQJdKdTrZ2c8zafeIgNh7HdFk1TNC9TCn+HHBFs
 b5My0Ax91yt7y7Vf4gKX/8QBU4MXkb0CJTVHQ3MKmdYHmSMmnszt6JShVkoGJL8Cz8/Clo
 T+9lDCjkX8SqqS47ZU+qPGONpZnwuEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787748058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/tvDFCNGxQ0K7Ky1Ld8OEqNIXi1O2KbN4J4W4mHAv8=;
 b=tIWlqcHObCTJbODdvxLxDfWQ1wpMZ2YFm7yX3P0Wgvm9I1ORM1hPs8DDxSqV5PNjjtDpwh
 ZDrZkx2qYLLjoVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C6B61361C;
 Wed, 26 Aug 2026 12:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yK50BdrejmpuNwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 26 Aug 2026 12:40:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 26 Aug 2026 14:40:57 +0200
MIME-Version: 1.0
Message-Id: <20260826-cve-ghostlock-v4-1-52ec94d6635f@suse.com>
References: <20260826-cve-ghostlock-v4-0-52ec94d6635f@suse.com>
In-Reply-To: <20260826-cve-ghostlock-v4-0-52ec94d6635f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787748057; l=1706;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=e2wKi8ihjilihYofM7sd1LymMOKtygNDIIkc9ws5WYs=;
 b=FMvVslo5e1rtji++z0giGMaZh1lxgeb3dYjdTre1L1RNZvQLiwhtTGmm3T8dlRUxehT72jHSD
 JuksyDfQIDDDxhOmKiHUqY/68IoOLu634wRFhUZKc67WqpVpnjK6LFl
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 396E41F851
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] lapi/prctl: add more fallback definitions
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

Add the following fallback definitions:

- PR_SET_MM
- PR_SET_MM_MAP
- PR_SET_MM_MAP_SIZE
- struct prctl_mm_map

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac         |  2 ++
 include/lapi/prctl.h | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/configure.ac b/configure.ac
index 19fc5e1b8..052b83e04 100644
--- a/configure.ac
+++ b/configure.ac
@@ -286,6 +286,8 @@ AC_CHECK_TYPES([struct fsxattr],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct logical_block_metadata_cap],,,[#include <linux/fs.h>])
 
+AC_CHECK_TYPES([struct prctl_mm_map],,,[#include <sys/prctl.h>])
+
 AC_CHECK_TYPES([struct sockaddr_vm],,,[
 #include <sys/socket.h>
 #include <linux/vm_sockets.h>
diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
index 8d3ef5c32..278401bb7 100644
--- a/include/lapi/prctl.h
+++ b/include/lapi/prctl.h
@@ -7,6 +7,7 @@
 #ifndef LAPI_PRCTL_H__
 #define LAPI_PRCTL_H__
 
+#include <stdint.h>
 #include <sys/prctl.h>
 
 #ifndef PR_SET_NAME
@@ -59,4 +60,28 @@
 # define PR_SET_SPECULATION_CTRL 53
 #endif
 
+#ifndef PR_SET_MM
+# define PR_SET_MM		35
+#endif
+#ifndef PR_SET_MM_MAP
+# define PR_SET_MM_MAP	14
+#endif
+#ifndef PR_SET_MM_MAP_SIZE
+# define PR_SET_MM_MAP_SIZE	15
+#endif
+
+#if !(HAVE_STRUCT_PRCTL_MM_MAP) && !defined(PR_SET_MM_MAP)
+struct prctl_mm_map {
+	uint64_t start_code, end_code;
+	uint64_t start_data, end_data;
+	uint64_t start_brk, brk;
+	uint64_t start_stack;
+	uint64_t arg_start, arg_end;
+	uint64_t env_start, env_end;
+	uint64_t *auxv;
+	uint32_t auxv_size;
+	uint32_t exe_fd;
+};
+#endif
+
 #endif /* LAPI_PRCTL_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
