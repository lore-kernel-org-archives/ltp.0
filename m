Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1943E77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:01:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D1AA3ED626
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 20:01:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF4193ED624
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:52 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1F5D6635838
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D336021157;
 Wed, 18 Dec 2024 19:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFlWfrreKkDQK06hzpn40oh8YsrJdJmoAddSlfg7XXk=;
 b=K8t+x6lLbwhRzOvTI9/WfrlFss9y7eOfD5B3PK+qVntJ3mX1pWrILfWKfyATK9le13UVOB
 oOT/K6jKE3LXhb+GYzTq7eIm3ZTMvyLGsfCuaU7/FkLPqq73XWJZyxeb/r3j5vXQ47t37T
 wgbAS3IZYvcDhkq0MfHEADVpF6FLtTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFlWfrreKkDQK06hzpn40oh8YsrJdJmoAddSlfg7XXk=;
 b=A1piFUw2xvd9b4EIjk9Oke7kvULqTzZ0coboWRSqTHBxReZczb51rlJsBRR55nVml2Y2Jw
 /fKG3JJgA24c6wDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFlWfrreKkDQK06hzpn40oh8YsrJdJmoAddSlfg7XXk=;
 b=K8t+x6lLbwhRzOvTI9/WfrlFss9y7eOfD5B3PK+qVntJ3mX1pWrILfWKfyATK9le13UVOB
 oOT/K6jKE3LXhb+GYzTq7eIm3ZTMvyLGsfCuaU7/FkLPqq73XWJZyxeb/r3j5vXQ47t37T
 wgbAS3IZYvcDhkq0MfHEADVpF6FLtTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFlWfrreKkDQK06hzpn40oh8YsrJdJmoAddSlfg7XXk=;
 b=A1piFUw2xvd9b4EIjk9Oke7kvULqTzZ0coboWRSqTHBxReZczb51rlJsBRR55nVml2Y2Jw
 /fKG3JJgA24c6wDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8C9B132EA;
 Wed, 18 Dec 2024 19:00:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /U/2K+IbY2fldQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 19:00:50 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 20:00:23 +0100
Message-ID: <20241218190029.15015-4-chrubis@suse.cz>
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
Subject: [LTP] [PATCH 3/9] metadata: metaparse: Apply macros in arrays.
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

This fixes many cases mostly paths in save_restore:

...
-      "INTEGER_PROCFILE",
+      "/proc/sys/fs/pipe-max-size",
...
    "needs_drivers": [
-     "HW_MODULE"
+     "hwpoison_inject"
     ],
...
    "save_restore": [
      [
-      "CORE_PATTERN",
+      "/proc/sys/kernel/core_pattern",
...

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/metaparse.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 486475780..969293cfc 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -317,9 +317,28 @@ static void close_include(FILE *inc)
 	fclose(inc);
 }
 
+static void try_apply_macro(char **res)
+{
+	ENTRY macro = {
+		.key = *res,
+	};
+
+	ENTRY *ret;
+
+	ret = hsearch(macro, FIND);
+
+	if (!ret)
+		return;
+
+	if (verbose)
+		fprintf(stderr, "APPLYING MACRO %s=%s\n", ret->key, (char*)ret->data);
+
+	*res = ret->data;
+}
+
 static int parse_array(FILE *f, struct data_node *node)
 {
-	const char *token;
+	char *token;
 
 	for (;;) {
 		if (!(token = next_token(f, NULL)))
@@ -346,6 +365,8 @@ static int parse_array(FILE *f, struct data_node *node)
 		if (!strcmp(token, "NULL"))
 			continue;
 
+		try_apply_macro(&token);
+
 		struct data_node *str = data_node_string(token);
 
 		data_node_array_add(node, str);
@@ -354,25 +375,6 @@ static int parse_array(FILE *f, struct data_node *node)
 	return 0;
 }
 
-static void try_apply_macro(char **res)
-{
-	ENTRY macro = {
-		.key = *res,
-	};
-
-	ENTRY *ret;
-
-	ret = hsearch(macro, FIND);
-
-	if (!ret)
-		return;
-
-	if (verbose)
-		fprintf(stderr, "APPLYING MACRO %s=%s\n", ret->key, (char*)ret->data);
-
-	*res = ret->data;
-}
-
 static int parse_get_array_len(FILE *f)
 {
 	const char *token;
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
