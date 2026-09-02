Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B138C61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 21:26:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1A183E93BD
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 23:26:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 324BC3E2D93
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 23:26:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8D7DB600472
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 23:26:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D53C21CDD;
 Wed,  2 Sep 2026 21:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788384355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/tvDFCNGxQ0K7Ky1Ld8OEqNIXi1O2KbN4J4W4mHAv8=;
 b=emlfjY8gAok+iDAGFZ5JQvauFMiS81UPgccqAX1sasv31aBsKb7NT4t91RNehAAKF8Dg+i
 aaccryp5jnMTMrQoBtYhTrzFW8RpXtdUtDKx8Iz0Shi4FEWsTQ5cz9G2ROusvNlVqfWdP4
 uy97cKMMiHgkzojgSEo+kX8wjLH+SLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788384355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/tvDFCNGxQ0K7Ky1Ld8OEqNIXi1O2KbN4J4W4mHAv8=;
 b=7sD+9SmvXGmntRTK5qMQnG0DriPiFTsrlVvDpv3RDmlSF3ZgJz5ObWLboEhZGjZWSAFZyV
 ZZJjIWm7ZcKfLiDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788384351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/tvDFCNGxQ0K7Ky1Ld8OEqNIXi1O2KbN4J4W4mHAv8=;
 b=REGqAvej6Y1CLpOpFzveBkbiqIWqs/BWVdTT1IaMvnyjcS3aOg8sl/lh16de2Q/ZKeeM1v
 SGydo8vVVc0S+lhcEJZQSLwdpNvi+ePUyFSw+ACfqdjaWepkk5z3lFkYQS2boRIHiZRFSy
 CWW+I86q0qfhSg+DD4UAmp8AcB5DbHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788384351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/tvDFCNGxQ0K7Ky1Ld8OEqNIXi1O2KbN4J4W4mHAv8=;
 b=17YoBWOHqF7AP+G6fJOOd7N664l3i8BZWVsfOBwPyt5uxrqkCg+YMxflCTXSf6iv86SjEK
 +83aRXjRFNRTQzAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B450013738;
 Wed,  2 Sep 2026 21:25:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EAZIKV6UmGpbMAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 21:25:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 23:25:49 +0200
MIME-Version: 1.0
Message-Id: <20260902-cve-ghostlock-v5-2-569b9eb37941@suse.com>
References: <20260902-cve-ghostlock-v5-0-569b9eb37941@suse.com>
In-Reply-To: <20260902-cve-ghostlock-v5-0-569b9eb37941@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788384350; l=1706;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=e2wKi8ihjilihYofM7sd1LymMOKtygNDIIkc9ws5WYs=;
 b=/PPYTi/WUkqMOoSlCqZoRF6HQScLjBJNFVbrpMhZ8yUPDVm3o97lp4PuBZGX6CEPcxc+kdcPL
 lf2gdo9WdKtBcmQeN231BI+ujsz8exLUTxHuJ/OvTtD1n6MZlYnrfI+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/3] lapi/prctl: add more fallback definitions
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
