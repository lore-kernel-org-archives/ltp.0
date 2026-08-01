Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1E2C55172
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 10:34:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 765DD3C332C
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 12:34:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13A2C3EA69D
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 12:34:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E2C5410005F8
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 12:34:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C75843C3;
 Sat,  1 Aug 2026 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785580457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txH5yjVJDUsLG57anBkIQRG4aGbHttDfotnBbflPAss=;
 b=UWK4mdU/P9PhjhABkTvcJe/Z0PbivLYndAyfGaAauxLNo3R5Xx1q6YorS7LkoiYW3YQdbN
 5AceydU14ctU9VvqLs3VTQ76D3RWBsLrq5Kv8r7dFKuhFpM/1NcnmyIGw24Mr+pJf1PWuP
 +0HNWc+UsPe2exA9cjHrkGOePKxbH5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785580457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txH5yjVJDUsLG57anBkIQRG4aGbHttDfotnBbflPAss=;
 b=4EvF/zhXKfyu2IPizvl/C551lx9g09/1Jh5w8sPNbV1eRzL0zH0JwQ8DiSYaPc7ktg4REP
 zvKUWDB2Alaw6+BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ovoqtCdN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HDVPBjIc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785580453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txH5yjVJDUsLG57anBkIQRG4aGbHttDfotnBbflPAss=;
 b=ovoqtCdNfT/1+11ls+V0l9slr5S9XsK1yYXERCEuGFmYRkLnq+/ovl30l2soHTtB+U50fe
 U2cQt7k057g5VjhWO1+Kz5dKHhJVT74QYLkXV58LDLuMo1ARyx+lSe1U5SJ5GznQvRxlEt
 ZujZBH7SjRcV3SGaH3X2y9PiR6rwRCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785580453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txH5yjVJDUsLG57anBkIQRG4aGbHttDfotnBbflPAss=;
 b=HDVPBjIcPWk5uD+NYWEEWVox9t+g/IEsww3jzl1MeMv/48epLp5v3SpRT3ZkSlJvnkNUbc
 LijHsSFXN4ZLthAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DB09779C0;
 Sat,  1 Aug 2026 10:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uP2iAaXLbWrxXwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Sat, 01 Aug 2026 10:34:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Sat, 01 Aug 2026 12:34:12 +0200
MIME-Version: 1.0
Message-Id: <20260801-cve-ghostlock-v1-1-178f698f9702@suse.com>
References: <20260801-cve-ghostlock-v1-0-178f698f9702@suse.com>
In-Reply-To: <20260801-cve-ghostlock-v1-0-178f698f9702@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785580452; l=1806;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=pcj8b0MWoVf2PS56FuZ4LqIEbbMLi5/wwTPbbeQEr14=;
 b=JtdV518Oy6GNbsN4vAuSxWs6doCxe6e0wiwvje7xb1jbyVvzLMZf1q39s47fsQx3AUvZ2ZwaS
 oCjqnZVYu18CGNquCbTZBk+xlF7jUnXUR4Vxe6arweJElDUwyzpthss
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2C75843C3
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,suse.de:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lapi/prctl: add more fallback definitions
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
index 19fc5e1b8f5f5f94bd797ff2ba4275c29c20cb6c..e698c2b890547ccd32872526daeba13477a7edba 100644
--- a/configure.ac
+++ b/configure.ac
@@ -286,6 +286,8 @@ AC_CHECK_TYPES([struct fsxattr],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct logical_block_metadata_cap],,,[#include <linux/fs.h>])
 
+AC_CHECK_TYPES([struct prctl_mm_map],,,[#include <linux/prctl.h>])
+
 AC_CHECK_TYPES([struct sockaddr_vm],,,[
 #include <sys/socket.h>
 #include <linux/vm_sockets.h>
diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
index 8d3ef5c32ef5e2ee7742cc418b4ec40bee8cd661..96c3396779b3baf01ce05b56d9226fe04cba15c6 100644
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
+#ifndef HAVE_STRUCT_PRCTL_MM_MAP
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
