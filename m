Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CE5E77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:03:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F51E3ED628
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 20:03:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 359283ED622
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:55 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 493D364C2BB
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26CA721166;
 Wed, 18 Dec 2024 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ziHxd6gVwh718GjwfmIoVcfeiNbb3AqZ6pOOP4qxduU=;
 b=iAEm3wUlZ/GvYpJPuZqbSwDyIdAFLqaL8EMk4MjvX2yR00vZdrpQPHmJomiQkh/h2L1BIW
 vSj0k5LbggPQc+48lcOLIKQLduYPZM/z6bO+aUNaOo6ppYDo83RLJzfzpeU5LFkPvce9CW
 r8VSnMGZ79+mHopxQxhKyCYavN1rC24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ziHxd6gVwh718GjwfmIoVcfeiNbb3AqZ6pOOP4qxduU=;
 b=66br4xkOFr7J8ilgR5ckK3JYFCn8WCUHXiBQDGljwuM5GPNUaTqlAuS/ITaLl4kRhWVDFM
 Rren48CsONUQVOCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ziHxd6gVwh718GjwfmIoVcfeiNbb3AqZ6pOOP4qxduU=;
 b=iAEm3wUlZ/GvYpJPuZqbSwDyIdAFLqaL8EMk4MjvX2yR00vZdrpQPHmJomiQkh/h2L1BIW
 vSj0k5LbggPQc+48lcOLIKQLduYPZM/z6bO+aUNaOo6ppYDo83RLJzfzpeU5LFkPvce9CW
 r8VSnMGZ79+mHopxQxhKyCYavN1rC24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ziHxd6gVwh718GjwfmIoVcfeiNbb3AqZ6pOOP4qxduU=;
 b=66br4xkOFr7J8ilgR5ckK3JYFCn8WCUHXiBQDGljwuM5GPNUaTqlAuS/ITaLl4kRhWVDFM
 Rren48CsONUQVOCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E626132EA;
 Wed, 18 Dec 2024 19:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tulAAuUbY2fxdQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 19:00:53 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 20:00:28 +0100
Message-ID: <20241218190029.15015-9-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218190029.15015-1-chrubis@suse.cz>
References: <20241218190029.15015-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 8/9] metadata: metaparse: Add a few pre-defined macros
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

This is used mostly for stripping macro prefixes such as:

...
    "save_restore": [
      [
       "/proc/sys/user/max_user_namespaces",
       null,
-      "TST_SR_SKIP"
+      "SKIP"
      ],
...
-   "needs_cgroup_ver": "TST_CG_V2",
+   "needs_cgroup_ver": "2",
...

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/metaparse.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 29c03e5c3..fa30be727 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -760,6 +760,51 @@ static void parse_include_macros(FILE *f, int level)
 	close_include(inc);
 }
 
+/* pre-defined macros that makes the output cleaner. */
+static const struct macro {
+	char *from;
+	char *to;
+} internal_macros[] = {
+	{"TST_CG_V2", "2"},
+	{"TST_CG_V1", "1"},
+	{"TST_KB", "1024"},
+	{"TST_MB", "1048576"},
+	{"TST_GB", "1073741824"},
+	{"TST_SR_TBROK", "TBROK"},
+	{"TST_SR_TCONF", "TCONF"},
+	{"TST_SR_SKIP", "SKIP"},
+	{"TST_SR_TBROK_MISSING", "TBROK_MISSING"},
+	{"TST_SR_TCONF_MISSING", "TCONF_MISSING"},
+	{"TST_SR_SKIP_MISSING", "SKIP_MISSING"},
+	{"TST_SR_TBROK_RO", "TBROK_RO"},
+	{"TST_SR_TCONF_RO", "TCONF_RO"},
+	{"TST_SR_SKIP_RO", "SKIP_RO"},
+	{}
+};
+
+static void load_internal_macros(void)
+{
+	unsigned int i;
+
+	if (verbose)
+		fprintf(stderr, "PREDEFINED MACROS\n");
+
+	for (i = 0; internal_macros[i].from; i++) {
+		ENTRY e = {
+			.key = internal_macros[i].from,
+			.data = internal_macros[i].to,
+		};
+
+		if (verbose)
+			fprintf(stderr, " MACRO %s=%s\n", e.key, (char*)e.data);
+
+		hsearch(e, ENTER);
+	}
+
+	if (verbose)
+		fprintf(stderr, "END PREDEFINED MACROS\n");
+}
+
 static struct data_node *parse_file(const char *fname)
 {
 	int state = 0, found = 0;
@@ -777,6 +822,8 @@ static struct data_node *parse_file(const char *fname)
 	struct data_node *res = data_node_hash();
 	struct data_node *doc = data_node_array();
 
+	load_internal_macros();
+
 	while ((token = next_token(f, doc))) {
 		if (state < 6 && !strcmp(tokens[state], token)) {
 			state++;
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
