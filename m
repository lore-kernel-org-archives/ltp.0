Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBA4E77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:01:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE76D3ED62D
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 20:01:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A58263ED62E
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:43 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 116621425063
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 64DE61F397;
 Wed, 18 Dec 2024 19:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGN9ByE4vrXkuZzlBYcXA2+JaENDjt3VGwhd0yECVnc=;
 b=j/mplcr+9irRJGdYQkyQHn8PPrktoSjS8VRDNd3EXX7svmXGigN9gV1o0i46qd+DLF5m8k
 5MUt+sMU0rBG+PaEeV1qdXz8+/ISSLyJW25QaDNUdWi7JRWUYV9BoqTOFZNQZLzc2asCmn
 EP1qt+hdg547evub1icqLqE5yweJ1io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGN9ByE4vrXkuZzlBYcXA2+JaENDjt3VGwhd0yECVnc=;
 b=UBqnswRaP4d7WIVahovs2d8EQWZ5+Dl5kGRxTQtSxTQ0clu017fXDW3GRxeKcP/gLCjo+q
 cnjeJggdmY4ENpDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="j/mplcr+";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UBqnswRa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGN9ByE4vrXkuZzlBYcXA2+JaENDjt3VGwhd0yECVnc=;
 b=j/mplcr+9irRJGdYQkyQHn8PPrktoSjS8VRDNd3EXX7svmXGigN9gV1o0i46qd+DLF5m8k
 5MUt+sMU0rBG+PaEeV1qdXz8+/ISSLyJW25QaDNUdWi7JRWUYV9BoqTOFZNQZLzc2asCmn
 EP1qt+hdg547evub1icqLqE5yweJ1io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGN9ByE4vrXkuZzlBYcXA2+JaENDjt3VGwhd0yECVnc=;
 b=UBqnswRaP4d7WIVahovs2d8EQWZ5+Dl5kGRxTQtSxTQ0clu017fXDW3GRxeKcP/gLCjo+q
 cnjeJggdmY4ENpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48466132EA;
 Wed, 18 Dec 2024 19:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X7F0ENobY2fedQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 19:00:42 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 20:00:22 +0100
Message-ID: <20241218190029.15015-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218190029.15015-1-chrubis@suse.cz>
References: <20241218190029.15015-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 64DE61F397
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/9] metadata: metaparse: Implement recursive include
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

This is really needed in order to expand all relevant variables in the
tst_test structure. For example PATH_KSM is hidden in
kernel/include/ksm_helper.h which is included from
kernel/mem/include/mem.h which is included by ksm0*.c testcases.

We also have a list of headers to explicitly skip, that define many
macros that are not useful in tst_test structure expansion.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/metaparse.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index bf9559712..486475780 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -237,6 +237,20 @@ static FILE *open_file(const char *dir, const char *fname)
 	return f;
 }
 
+/**
+ * List of includes to be skipped.
+ *
+ * These define many macros or include many include files that are mostly
+ * useless to values expanded in tst_test structure. Or macros that shouldn't
+ * be expanded at all.
+ */
+static const char *skip_includes[] = {
+	"\"tst_test.h\"",
+	"\"config.h\"",
+	"\"tst_taint.h\"",
+	NULL
+};
+
 static FILE *open_include(FILE *f)
 {
 	char buf[256], *fname;
@@ -249,6 +263,20 @@ static FILE *open_include(FILE *f)
 	if (buf[0] != '"')
 		return NULL;
 
+	for (i = 0; skip_includes[i]; i++) {
+		if (!strcmp(skip_includes[i], buf)) {
+			if (verbose)
+				fprintf(stderr, "INCLUDE SKIP %s\n", buf);
+			return NULL;
+		}
+	}
+
+	if (!strncmp(buf, "\"lapi/", 6)) {
+		if (verbose)
+			fprintf(stderr, "INCLUDE SKIP %s\n", buf);
+		return NULL;
+	}
+
 	fname = buf + 1;
 
 	if (!buf[0])
@@ -641,12 +669,20 @@ static void parse_macro(FILE *f)
 	hsearch(e, ENTER);
 }
 
-static void parse_include_macros(FILE *f)
+static void parse_include_macros(FILE *f, int level)
 {
 	FILE *inc;
 	const char *token;
 	int hash = 0;
 
+	/**
+	 * Allow only three levels of include indirection.
+	 *
+	 * Should be more than enough (TM).
+	 */
+	if (level >= 3)
+		return;
+
 	inc = open_include(f);
 	if (!inc)
 		return;
@@ -662,6 +698,8 @@ static void parse_include_macros(FILE *f)
 
 		if (!strcmp(token, "define"))
 			parse_macro(inc);
+		else if (!strcmp(token, "include"))
+			parse_include_macros(inc, level+1);
 
 		hash = 0;
 	}
@@ -697,7 +735,7 @@ static struct data_node *parse_file(const char *fname)
 						parse_macro(f);
 
 					if (!strcmp(token, "include"))
-						parse_include_macros(f);
+						parse_include_macros(f, 0);
 				}
 			}
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
