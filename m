Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A975AC021A0
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 13:17:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 165D73C9A17
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 14:17:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 047013C9A09
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 14:16:16 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 409E46184BB
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 14:16:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EAFEA1FDEA
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739366174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=guk+fD+zqcwT8AxkHi0vLWemYeoBbkKuXiQoQsqCQ58=;
 b=IMKPKgfs4WW25fWBAtPfUVeurPK4zg+kV8F6xcdKqoyaBeQT+dI8PpeNAxE0brqalD5fYG
 ZzZMkwdtGaXaodubdwtxEW/+tNV8R3hjDc0knp2qSDyqLxSEqXvoSrdBldRTP3SdQQ+3w/
 A5uHSHwX/mpSI/8UbmZ7IfcodNwh+Ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739366174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=guk+fD+zqcwT8AxkHi0vLWemYeoBbkKuXiQoQsqCQ58=;
 b=Cug7eN0BkwFMiaVzfaMsyi2a6iAyQ7klJpG2GlwM8EED36Z9nOJqtupxNXp47FJ+xymKwV
 Iv2he3IkxRK5gjBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vbotLucX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SEqwyGiW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739366173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=guk+fD+zqcwT8AxkHi0vLWemYeoBbkKuXiQoQsqCQ58=;
 b=vbotLucXBYP5QEQzi5Qx1iW7EyV7IbbpB/1Cu8Fn2I1TX57tH1CzjaK0vnBgs/BYxrSekX
 j+s9CTlmdlFEnlsq2xwavb+GRR3xlNbw4dM+/6s5F6nmJCSFoxx6FYl5MOOnNlK0Ffnhhg
 A0M3+PiFKwDIpHgpDp6+y7LDGXxCJ3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739366173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=guk+fD+zqcwT8AxkHi0vLWemYeoBbkKuXiQoQsqCQ58=;
 b=SEqwyGiWhNbtx0y5H+5sxwSDCMnr4ZDFDFDEVifWeZm4BiIoS3mez6w3fQy2sE8mu8eTkQ
 GK5LTEkiJapfcECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D64D713AEF
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 13:16:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tktuMx2frGcTGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 13:16:13 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 12 Feb 2025 14:16:17 +0100
Message-ID: <20250212131618.6810-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250212131618.6810-1-chrubis@suse.cz>
References: <20250212131618.6810-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: EAFEA1FDEA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:mid, suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] metaparse: Add shell test parser
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/.gitignore     |   1 +
 metadata/Makefile       |   4 +-
 metadata/metaparse-sh.c | 127 ++++++++++++++++++++++++++++++++++++++++
 metadata/parse.sh       |  13 ++++
 4 files changed, 143 insertions(+), 2 deletions(-)
 create mode 100644 metadata/metaparse-sh.c

diff --git a/metadata/.gitignore b/metadata/.gitignore
index 07d2fd6ff..bb6399e5c 100644
--- a/metadata/.gitignore
+++ b/metadata/.gitignore
@@ -1,2 +1,3 @@
 metaparse
+metaparse-sh
 ltp.json
diff --git a/metadata/Makefile b/metadata/Makefile
index 522af4270..641657318 100644
--- a/metadata/Makefile
+++ b/metadata/Makefile
@@ -7,12 +7,12 @@ include $(top_srcdir)/include/mk/env_pre.mk
 include $(top_srcdir)/include/mk/functions.mk
 
 MAKE_TARGETS		:= ltp.json
-HOST_MAKE_TARGETS	:= metaparse
+HOST_MAKE_TARGETS	:= metaparse metaparse-sh
 INSTALL_DIR		= metadata
 
 .PHONY: ltp.json
 
-ltp.json: metaparse
+ltp.json: metaparse metaparse-sh
 	$(abs_srcdir)/parse.sh > ltp.json
 ifeq ($(WITH_METADATA),yes)
 	mkdir -p $(abs_top_builddir)/docparse
diff --git a/metadata/metaparse-sh.c b/metadata/metaparse-sh.c
new file mode 100644
index 000000000..9eb38f583
--- /dev/null
+++ b/metadata/metaparse-sh.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <libgen.h>
+
+#include "data_storage.h"
+
+static int started;
+
+static void json_start(char *path)
+{
+	if (started)
+		return;
+
+	started = 1;
+
+	printf("   \"%s\": {\n", basename(path));
+}
+
+static void json_finish(const char *path)
+{
+	if (!started)
+		return;
+
+	printf("   \"fname\": \"%s\"\n", path);
+	printf("  }");
+}
+
+enum state {
+	NONE,
+	START,
+	DOC_FIRST,
+	DOC,
+	ENV_START,
+	ENV_FIRST,
+	ENV
+};
+
+static void parse_shell(char *path)
+{
+	char line[4096];
+	FILE *f = fopen(path, "r");
+	enum state state = NONE;
+
+	while (fgets(line, sizeof(line), f)) {
+		/* Strip newline */
+		line[strlen(line)-1] = 0;
+
+		switch (state) {
+		case NONE:
+			if (!strcmp(line, "# ---"))
+				state = START;
+		break;
+		case START:
+			if (!strcmp(line, "# doc")) {
+				json_start(path);
+				state = DOC_FIRST;
+				printf("   \"doc\": [\n");
+			} else if (!strcmp(line, "# env")) {
+				json_start(path);
+				state = ENV_START;
+			} else {
+				state = NONE;
+			}
+		break;
+		case DOC:
+		case DOC_FIRST:
+			if (!strcmp(line, "# ---")) {
+				state = NONE;
+				printf("\n   ],\n");
+				continue;
+			}
+
+			if (state == DOC_FIRST)
+				state = DOC;
+			else
+				printf(",\n");
+
+			data_fprintf_esc(stdout, 4, line+2);
+		break;
+		case ENV_START:
+			if (!strcmp(line, "# {")) {
+				state = ENV_FIRST;
+			} else {
+				fprintf(stderr,
+				        "%s: Invalid line in JSON block '%s'",
+					path, line);
+			}
+		break;
+		case ENV:
+		case ENV_FIRST:
+			if (!strcmp(line, "# }")) {
+				state = NONE;
+				printf(",\n");
+				continue;
+			}
+
+
+			if (state == ENV_FIRST)
+				state = ENV;
+			else
+				printf("\n");
+
+			line[0] = ' ';
+			line[1] = ' ';
+
+			printf("%s", line);
+		break;
+		}
+	}
+
+	json_finish(path);
+}
+
+int main(int argc, char *argv[])
+{
+	int i;
+
+	for (i = 1; i < argc; i++)
+		parse_shell(argv[i]);
+
+	return 0;
+}
diff --git a/metadata/parse.sh b/metadata/parse.sh
index 7db2e2415..45776e4d0 100755
--- a/metadata/parse.sh
+++ b/metadata/parse.sh
@@ -42,6 +42,19 @@ EOF
 	fi
 done
 
+for test in `find testcases/ -not -path "testcases/lib/*" -name '*.sh'|sort`; do
+	a=$($top_builddir/metadata/metaparse-sh "$test")
+	if [ -n "$a" ]; then
+		if [ -z "$first" ]; then
+			echo ','
+		fi
+		first=
+		cat <<EOF
+$a
+EOF
+	fi
+done
+
 echo
 echo ' }'
 echo '}'
-- 
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
