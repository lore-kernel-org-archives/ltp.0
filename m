Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5D7C02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 16:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6319B3C2A78
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 17:45:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA5D53C0229
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:30 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2EBCE100CD83
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A1092116D
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2eFo03h34/GBYcHZKTlIWDcaD+hiyF76gAzF+OlP18=;
 b=0UU/3OaJYycq75By+JiiP/4hovr2XnZvv4oStFMWfVFimZQtesuyGD421cpC6HCbG9DGX8
 pQQGRUHxCoQFnR3zP7ga7xmMiA5Jxg6tZGurIhnju49cCeBXIYfO6xiMZVp79xswpMrjG/
 md3WttllDt4jxFRr91kcc278Mzs6oRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2eFo03h34/GBYcHZKTlIWDcaD+hiyF76gAzF+OlP18=;
 b=ZtSYC+v2MlpSE8ZZM53nLFGzH+vg7+Mwj0P2rhlaROa4urNHqZQ8s6MI91xiCYL8/clJnZ
 Nd1BqNovAGW4JqDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="0UU/3OaJ";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZtSYC+v2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2eFo03h34/GBYcHZKTlIWDcaD+hiyF76gAzF+OlP18=;
 b=0UU/3OaJYycq75By+JiiP/4hovr2XnZvv4oStFMWfVFimZQtesuyGD421cpC6HCbG9DGX8
 pQQGRUHxCoQFnR3zP7ga7xmMiA5Jxg6tZGurIhnju49cCeBXIYfO6xiMZVp79xswpMrjG/
 md3WttllDt4jxFRr91kcc278Mzs6oRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2eFo03h34/GBYcHZKTlIWDcaD+hiyF76gAzF+OlP18=;
 b=ZtSYC+v2MlpSE8ZZM53nLFGzH+vg7+Mwj0P2rhlaROa4urNHqZQ8s6MI91xiCYL8/clJnZ
 Nd1BqNovAGW4JqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F7D713991
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iFzSFu3Oj2erPQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Jan 2025 17:44:22 +0100
Message-ID: <20250121164426.27977-9-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250121164426.27977-1-mdoucha@suse.cz>
References: <20250121164426.27977-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6A1092116D
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 08/10] lib: Add helper function for reading boolean
 sysconf files
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_sys_conf.h |  2 ++
 lib/tst_sys_conf.c     | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/tst_sys_conf.h b/include/tst_sys_conf.h
index 4c85767be..6bbf39672 100644
--- a/include/tst_sys_conf.h
+++ b/include/tst_sys_conf.h
@@ -28,4 +28,6 @@ int tst_sys_conf_save(const struct tst_path_val *conf);
 void tst_sys_conf_restore(int verbose);
 void tst_sys_conf_dump(void);
 
+int tst_read_bool_sys_param(const char *filename);
+
 #endif
diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
index c0981dcb1..91203ea9e 100644
--- a/lib/tst_sys_conf.c
+++ b/lib/tst_sys_conf.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <string.h>
+#include <ctype.h>
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
@@ -145,3 +146,37 @@ void tst_sys_conf_restore(int verbose)
 	}
 }
 
+int tst_read_bool_sys_param(const char *filename)
+{
+	char buf[PATH_MAX];
+	int i, fd, ret;
+
+	fd = open(filename, O_RDONLY);
+
+	if (fd < 0)
+		return -1;
+
+	ret = read(fd, buf, PATH_MAX - 1);
+	SAFE_CLOSE(fd);
+
+	if (ret < 1)
+		return -1;
+
+	buf[ret] = '\0';
+
+	for (i = 0; buf[i] && !isspace(buf[i]); i++)
+		;
+
+	buf[i] = '\0';
+
+	if (isdigit(buf[0])) {
+		tst_parse_int(buf, &ret, INT_MIN, INT_MAX);
+		return ret;
+	}
+
+	if (!strcasecmp(buf, "N"))
+		return 0;
+
+	/* Assume that any other value than 0 or N means the param is enabled */
+	return 1;
+}
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
