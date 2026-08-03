Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C172C55175
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 08:10:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D52C3E2860
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 10:10:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 329D33D064D
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 10:10:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DD0FF10006CF
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 10:10:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26E627EF53;
 Mon,  3 Aug 2026 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785744610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMvWtgQfhM1damDXfj4QtwEG/gfWV+jh545q24g75VQ=;
 b=ibUHtMuDColPHlLL2OqmLAr5w5TZh+BWb2vCTqPOBKXcYmbIEihEznJ74Rce4EoG4j3KT7
 GqzcZSF2zwYJ1xObea4dd8oTe6icW3zbYL2QwRi7xKlSacz9bdq63mebt0mFVJEYnXgSmT
 +qznhJ/VWyfEv8kCeC4HskTtJjVJu80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785744610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMvWtgQfhM1damDXfj4QtwEG/gfWV+jh545q24g75VQ=;
 b=wjafsXwKkFF7FBoryqR7zcyi9a3v7UvW+39fyWbQntra61OoMjDhuf3Ad4IeMQ2Z+aoOnw
 tmzkZXr8bBNbgMDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785744606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMvWtgQfhM1damDXfj4QtwEG/gfWV+jh545q24g75VQ=;
 b=mZKV1bYje7nTjjS/TDouHRJM4E+u/nsD/e4dIH6YCC10hiLcWCIz7ZKdiXrBLUMnD9lJMu
 c5UGBx8nUDtEls2W4dIu7+o7nHaXlYLsuwMQgAUDNJCBKsTOGxOywAN49+ZlX+//Kp8EzF
 gxchxnPV9utWf0vQxRtlzxDMLm1nm/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785744606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMvWtgQfhM1damDXfj4QtwEG/gfWV+jh545q24g75VQ=;
 b=IL8szoTxsVcpOkowkZn3PKv6YH0BqQDo+oli8zd8qhEBK0/EJqeA02se/DVDbKMziqbf+E
 vrSnRSnfsPQfURBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05B04779E7;
 Mon,  3 Aug 2026 08:10:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UIwzO91McGpJTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 03 Aug 2026 08:10:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 03 Aug 2026 10:10:04 +0200
MIME-Version: 1.0
Message-Id: <20260803-cve-ghostlock-v2-1-b60588853140@suse.com>
References: <20260803-cve-ghostlock-v2-0-b60588853140@suse.com>
In-Reply-To: <20260803-cve-ghostlock-v2-0-b60588853140@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785744605; l=1842;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=fLgHauXXtEA66koQXqhE7W/d86TByaJKewK19xtPGUo=;
 b=3VK1CY/MRr/iz+ZFvAISWEq7gAcJWom/cnHSP+D6FN5F3RiRVaFdonXWx/PFOjZGDToq7VOaL
 MT6xGR0iL+BDp2ghKNoB/pPwvfowGqJ/Y5+OiPin7q0KQ8oka7AHUvi
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] lapi/prctl: add more fallback definitions
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
index 8d3ef5c32ef5e2ee7742cc418b4ec40bee8cd661..a681aab499271b618d2e61fb79faf0055b6718dd 100644
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
+#if !defined(HAVE_STRUCT_PRCTL_MM_MAP) && !defined(PR_SET_MM_MAP_SIZE)
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
