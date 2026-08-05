Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5F1C55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 15:16:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F8523E7617
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:16:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07D813CE30B
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CE10F1400E10
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E8567F21B;
 Wed,  5 Aug 2026 15:15:05 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DD11779F3;
 Wed,  5 Aug 2026 15:15:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CEG3HXdTc2qsGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 15:15:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 17:14:51 +0200
Message-ID: <20260805151451.648990-10-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805151451.648990-1-pvorel@suse.cz>
References: <20260805151451.648990-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 2E8567F21B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 9/9] [RFC] metaparse: Check {min, max}_kver validity
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

Check .max_kver and .min_kver validity. Exit generation with error when:
* .max_kver or .min_kver is invalid
* .min_kver > .max_kver

Suggested-by: Li Wang <li.wang@linux.dev>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v4.

 lib/tst_test.c       |  2 ++
 metadata/Makefile    |  6 ++++--
 metadata/metaparse.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 0d3714c709..11d233dcbd 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1496,6 +1496,8 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->max_kver)
 		check_max_kver(tst_test->max_kver, 1);
 
+	// TODO: Add runtime check tst_test->max_kver >= tst_test->min_kver.
+
 	if (tst_test->skip_in_lockdown && tst_lockdown_enabled() > 0)
 		tst_brk(TCONF, "Kernel is locked down, skipping test");
 
diff --git a/metadata/Makefile b/metadata/Makefile
index af194bcc94..9ee2441669 100644
--- a/metadata/Makefile
+++ b/metadata/Makefile
@@ -3,13 +3,15 @@
 
 top_srcdir		?= ..
 
-include $(top_srcdir)/include/mk/env_pre.mk
-include $(top_srcdir)/include/mk/functions.mk
+include $(top_srcdir)/include/mk/testcases.mk
 
 MAKE_TARGETS		:= ltp.json
 HOST_MAKE_TARGETS	:= metaparse metaparse-sh
 INSTALL_DIR		= metadata
 
+metaparse: HOST_CFLAGS		+= -I$(abs_srcdir)/../include -L$(abs_builddir)/../lib
+metaparse: HOST_LDLIBS		+= -lltp
+
 .PHONY: ltp.json
 
 ltp.json: metaparse metaparse-sh
diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index cb141c3831..07a452a5a1 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -6,6 +6,7 @@
 
 #define _GNU_SOURCE
 
+#include <assert.h>
 #include <search.h>
 #include <stdio.h>
 #include <string.h>
@@ -15,6 +16,7 @@
 #include <errno.h>
 
 #include "data_storage.h"
+#include "tst_kvercmp.h"
 
 #define INCLUDE_PATH_MAX 5
 #define GROUPS_TAG "@groups"
@@ -1372,6 +1374,37 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	/* Check max_kver >= min_kver */
+	struct data_node *max_kver = data_node_hash_get(res, "max_kver");
+	struct data_node *min_kver = data_node_hash_get(res, "min_kver");
+	int a1, a2, a3, b1, b2, b3;
+
+	if (min_kver) {
+		assert(min_kver->type == DATA_STRING);
+		if (tst_parse_kver(min_kver->string.val, &b1, &b2, &b3)) {
+			fprintf(stderr, "%s: wrong min_kver: '%s'\n",
+				argv[optind], min_kver->string.val);
+			return 1;
+		}
+	}
+
+	if (max_kver) {
+		assert(max_kver->type == DATA_STRING);
+		if (tst_parse_kver(max_kver->string.val, &a1, &a2, &a3)) {
+			fprintf(stderr, "%s: wrong max_kver: '%s'\n",
+					argv[optind], max_kver->string.val);
+			return 1;
+		}
+	}
+
+	if (min_kver && max_kver) {
+		if (tst_kver_cmp(a1, a2, a3, b1, b2, b3) < 0) {
+			fprintf(stderr, "%s: min_kver (%s) > max_kver (%s)\n",
+					argv[optind], min_kver->string.val, max_kver->string.val);
+			return 1;
+		}
+	}
+
 	/* Normalize types */
 	check_normalize_types(res, "", tst_test_typemap);
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
