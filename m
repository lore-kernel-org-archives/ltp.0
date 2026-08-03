Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091BCC55182
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 12:27:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29B5F3E4B7F
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 14:27:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 684BA3E4A6D
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 14:27:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8CB74600797
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 14:27:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 56C8A3F6A;
 Mon,  3 Aug 2026 12:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785760019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+L1jZTsXncTOktzFsyw9OopPo1SlDEUbrBOPYql/JM=;
 b=BtNbcy1aqhGbWB341eqysVr8aoJfDYNjVkv6jFBBXaVx8aURU4zmWnJEuyzkt9jZ2unvQL
 h69nA076Rq86SPUmZ5/wbMTuJdKNcdV51823ca2dDMjNSFtcos/OiuNfIYAMuTP71kd6zl
 LvRGgVzceYKXtj0Lpj0D3dLoOJClbKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785760019;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+L1jZTsXncTOktzFsyw9OopPo1SlDEUbrBOPYql/JM=;
 b=i3A8L3ksYwxZS/XR9oB9Zu6SwvYTs3m7IcOEId/wNfKk4vtJ7gtrLs5RRyREd2iuS8zJvG
 VYgDbufx9Kym6WDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KP55tWqL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DBzV1pSQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785760015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+L1jZTsXncTOktzFsyw9OopPo1SlDEUbrBOPYql/JM=;
 b=KP55tWqLVoIwNSGQ8A4YoAXlYzUI7b5g5VqEkMzCxGC2eYa3NpwZWe5Q8ZkiFJgF8U0xGe
 hqYKNfJBhrmeXgkUWeXZiWEtfoz5pzZr20qF5u8lk5UoulUilJ+U+Y29sO9Dpyzxn840YV
 sWnN76YFGFjT219jkyzzKhRIbGmz9/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785760015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+L1jZTsXncTOktzFsyw9OopPo1SlDEUbrBOPYql/JM=;
 b=DBzV1pSQ7REbeBVP+fseXL7hdWZswvFXk+dhA340dNofYmWZxGGWWGTPLc9JGn66FTTUoO
 5Y8ckufOWByTEDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 397C1779D3;
 Mon,  3 Aug 2026 12:26:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id APCKDA+JcGoiSgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 03 Aug 2026 12:26:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 03 Aug 2026 14:26:49 +0200
MIME-Version: 1.0
Message-Id: <20260803-cve-ghostlock-v3-1-cde83fa429b7@suse.com>
References: <20260803-cve-ghostlock-v3-0-cde83fa429b7@suse.com>
In-Reply-To: <20260803-cve-ghostlock-v3-0-cde83fa429b7@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785760015; l=1830;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=M4tskMX6xl36GfvtSiuHMzFy3JZ4z5nkTzOUG0Dcs98=;
 b=99h4AOBMFMKu/gX/bqw6kaJccqCxhNUWrF4EuUaZzWdtZET2k3miHMmrZO0yAPIHwvFqji1EN
 AjGmkKam6BeDsNrNEtPTfOofiwvIWUrZ9A6YzjUMIORHR+G87gg/SJI
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 56C8A3F6A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] lapi/prctl: add more fallback definitions
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
index 19fc5e1b8f5f5f94bd797ff2ba4275c29c20cb6c..052b83e048f43b132c59ba393e439a32e2f251d2 100644
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
index 8d3ef5c32ef5e2ee7742cc418b4ec40bee8cd661..278401bb733a823e03b144007d0530335b3f70f7 100644
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
