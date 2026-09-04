Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F13C79F80
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 07:41:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1A053E9372
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:41:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D6A43E56C3
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:41:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 89642600F17
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:41:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D767122B03;
 Fri,  4 Sep 2026 07:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788507686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9YnzU1PA0qFArnqqPjZkh3Xr8Hu4NXMzbIrp19P4tI=;
 b=163pfne8smCoafF4TjtMlrYrd8N4Hs1upGOOEcYeeciTz+8dAK02cWrxFtT7w7vZtHLAhl
 bueJtlBr3i75Tdiis5bb8N8PJC4wHrAy6Z+1u6EYgWgadCYq14v/GVmKAkQCpobUTnaalH
 Pf1UMNmG9nQ7U0KONGoSG7LWIMQJLtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788507686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9YnzU1PA0qFArnqqPjZkh3Xr8Hu4NXMzbIrp19P4tI=;
 b=a3ANC2lci7Hsvk828F39RIcP6wfRIVmTcp+oQjCEpAVmgS2GaYbgN2RKSuDpnFmFSGMEvV
 cSF8x4LLfd1AzVAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788507681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9YnzU1PA0qFArnqqPjZkh3Xr8Hu4NXMzbIrp19P4tI=;
 b=N/Rcnwwnf36tHTRPg0zeNEP8D7B5021a5r+0mWSYNPEuGbIAc8o60XIT1cAhHm4W9v3FgA
 VPCBQQ/26s8lA5yGlphvcwjzbUESNL+k2t5ijVQnsTaiPvVTcHbhV2GRRyY2jTqUISFbFM
 J0svlT63gQcBFFYDV2Ex8HOQWJmBYOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788507681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9YnzU1PA0qFArnqqPjZkh3Xr8Hu4NXMzbIrp19P4tI=;
 b=xkZJ0eRfKyqGxPLS6j5mH2fWG4lQsB/5PFM6Jy8HJlsGz3+qtbse01qggKLrAgyrMr5JG1
 03psDQ2O6eAusdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7334713886;
 Fri,  4 Sep 2026 07:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eCWZGSF2mmoGHAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 07:41:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 09:41:22 +0200
MIME-Version: 1.0
Message-Id: <20260904-cve-ghostlock-v8-4-bd999083c7fb@suse.com>
References: <20260904-cve-ghostlock-v8-0-bd999083c7fb@suse.com>
In-Reply-To: <20260904-cve-ghostlock-v8-0-bd999083c7fb@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788507680; l=1637;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=MeXViqEL1agiMm4qvT/U9TEj2sh4cc4RtMVMFay2A4w=;
 b=yI49jnLV2UTERBUcW+9RsvM004yPUvRjUvO/hStGnWxhhKOTaTTTfMLmUBCzpqLEV873PXHBp
 A00MuTKir4GCFBpyLthbW/bCjQnUOkKo8MQuhVx3Eq/UsY07VrERbiA
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 4/5] lapi/prctl: add more fallback definitions
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac         |  2 ++
 include/lapi/prctl.h | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

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
