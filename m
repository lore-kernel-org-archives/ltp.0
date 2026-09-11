Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B72C88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 13:16:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B605D3E9222
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:16:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA5FE3E9225
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:14:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 63B50600A3D
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:14:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 19A9921B48;
 Fri, 11 Sep 2026 13:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789132484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMm+elVlwtzcX9Zqv3d77AttyodTYkEC+5oj7ANn89E=;
 b=Ep7GGiGqwAcpUtrlmuAoqa0hF4V2q+wQQt58u8FOKM8DS90+PIBkcGyJVcCgm0J7pHRf8J
 Ou/0aiYOXPT/nHyoqJRNp2/MCUmnOBszbKhKsEZKWcAbAH7f8NB1Qvpl9cIHGzy+ushzuZ
 hcrqQNtVm4eHMFIEqCahC3MOpKo5Pa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789132484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMm+elVlwtzcX9Zqv3d77AttyodTYkEC+5oj7ANn89E=;
 b=X9udlPynoURbWUTV9AIm9z5n+NYmqE4duo/p84TolMTFkxcuPvz6yKl4+0PiBfxayWYZ34
 pSaxsvp+O5Du0bCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="MfnAa/7c";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oyJkVJ5z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789132480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMm+elVlwtzcX9Zqv3d77AttyodTYkEC+5oj7ANn89E=;
 b=MfnAa/7cKvwRWtZoQu4FSOludwhkSZI8RBHuZw2q8mGeiP4Kvwz9X0HT1WEsHAyYKdXKUw
 P4wQoAkNTzvkyitQqkTngaG5t6hhGyMmPISQbLs78Cb6UIspOC7CucCrggeHbx7TeXpVBA
 8JrYHpNQjb9zKN8iaj+oh26vYorBnjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789132480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMm+elVlwtzcX9Zqv3d77AttyodTYkEC+5oj7ANn89E=;
 b=oyJkVJ5zU7eDcrmOKOhJfRAyPkqjIMuklA9T2THj622FJIszXhunyT2l8YayUi/JX/XNBN
 i8SYlGSxXpAFdiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC27D137DE;
 Fri, 11 Sep 2026 13:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4HIiML3+o2qLLgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 13:14:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 15:14:37 +0200
MIME-Version: 1.0
Message-Id: <20260911-cve-ghostlock-v10-4-817cfb0187eb@suse.com>
References: <20260911-cve-ghostlock-v10-0-817cfb0187eb@suse.com>
In-Reply-To: <20260911-cve-ghostlock-v10-0-817cfb0187eb@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789132476; l=1682;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=E3uFhMd1rqVVNK8dJmYghnwyT36avpuAHWVF6uBxCZE=;
 b=400B1AXeBpJwiXVZGmKeWvSL21oUH/5tO/1mudY0u8/onT0iFCZ/lNODdzYkhzZEBK6yd5ZZv
 ue5U0Kic7LLAfojI8m4KDhSUk9U22qBL5z2e08+zMLcfGoTZ/wyzxwe
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 19A9921B48
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.com:mid, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 4/5] lapi/prctl: add more fallback definitions
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
- struct prctl_mm_map

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac         |  2 ++
 include/lapi/prctl.h | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/configure.ac b/configure.ac
index 8aa3ff539..18bfdb88c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -289,6 +289,8 @@ AC_CHECK_TYPES([struct fsxattr],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct logical_block_metadata_cap],,,[#include <linux/fs.h>])
 
+AC_CHECK_TYPES([struct prctl_mm_map],,,[#include <sys/prctl.h>])
+
 AC_CHECK_TYPES([struct sockaddr_vm],,,[
 #include <sys/socket.h>
 #include <linux/vm_sockets.h>
diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
index 8d3ef5c32..3394a8581 100644
--- a/include/lapi/prctl.h
+++ b/include/lapi/prctl.h
@@ -7,7 +7,9 @@
 #ifndef LAPI_PRCTL_H__
 #define LAPI_PRCTL_H__
 
+#include <stdint.h>
 #include <sys/prctl.h>
+#include "config.h"
 
 #ifndef PR_SET_NAME
 # define PR_SET_NAME 15
@@ -59,4 +61,26 @@
 # define PR_SET_SPECULATION_CTRL 53
 #endif
 
+#ifndef PR_SET_MM
+# define PR_SET_MM		35
+#endif
+
+#ifndef PR_SET_MM_MAP
+# define PR_SET_MM_MAP	14
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
