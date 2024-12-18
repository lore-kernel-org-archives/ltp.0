Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96772E77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:02:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32BAB3ED62C
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 20:02:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC6713ED626
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:54 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F354635838
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 996FD1F397;
 Wed, 18 Dec 2024 19:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2GrVlQAYJkzgKoMydHXI9AgVusmXG899sCk8sMWbPA=;
 b=joWbIdeJLLWiiO+z3J8lf5zvasjwrLnvixy5pGjS6s5fxcdPwgPOOpGtAuLGDLqtLK2dgr
 VdjGjPBoLtVt/NOo+NbT4SKWeXdVgJtjbJlJqbID/JHdXvaHniIs/5JvzvENvWY+VFru9j
 Ar+f9ZMOhF1FhWHdLaPK7221iWgIQu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548452;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2GrVlQAYJkzgKoMydHXI9AgVusmXG899sCk8sMWbPA=;
 b=3eZsSiZd+Y4aSvhgzzPfNTW2XB7DMpfY216qDtlMvqP5bd2wXygrotLLy8EgJyd9wATGNV
 WvHKTQUb2nQgg+Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2GrVlQAYJkzgKoMydHXI9AgVusmXG899sCk8sMWbPA=;
 b=joWbIdeJLLWiiO+z3J8lf5zvasjwrLnvixy5pGjS6s5fxcdPwgPOOpGtAuLGDLqtLK2dgr
 VdjGjPBoLtVt/NOo+NbT4SKWeXdVgJtjbJlJqbID/JHdXvaHniIs/5JvzvENvWY+VFru9j
 Ar+f9ZMOhF1FhWHdLaPK7221iWgIQu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548452;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2GrVlQAYJkzgKoMydHXI9AgVusmXG899sCk8sMWbPA=;
 b=3eZsSiZd+Y4aSvhgzzPfNTW2XB7DMpfY216qDtlMvqP5bd2wXygrotLLy8EgJyd9wATGNV
 WvHKTQUb2nQgg+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83ACD132EA;
 Wed, 18 Dec 2024 19:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id okTWHuQbY2fudQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 19:00:52 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 20:00:27 +0100
Message-ID: <20241218190029.15015-8-chrubis@suse.cz>
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
Subject: [LTP] [PATCH 7/9] metadata: metaparse: Ignore ',
 ' in array inside parenthesis
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

This fixes the TST_CAP() macros:

    "caps": [
-     "TST_CAP("TST_CAP_DROP",
-     "CAP_NET_RAW")"
+     "TST_CAP(TST_CAP_DROP,CAP_NET_RAW)"
     ],

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/metaparse.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index f133a65d6..29c03e5c3 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -372,6 +372,7 @@ static int parse_array(FILE *f, struct data_node *node)
 {
 	char *token;
 	char *entry = NULL;
+	int parent_cnt = 0;
 
 	for (;;) {
 		if (!(token = next_token(f, NULL)))
@@ -402,7 +403,7 @@ static int parse_array(FILE *f, struct data_node *node)
 			return 0;
 		}
 
-		if (!strcmp(token, ",")) {
+		if (!strcmp(token, ",") && parent_cnt <= 0) {
 			finalize_array_entry(&entry, node);
 			continue;
 		}
@@ -412,6 +413,12 @@ static int parse_array(FILE *f, struct data_node *node)
 			continue;
 		}
 
+		if (!strcmp(token, "("))
+			parent_cnt++;
+
+		if (!strcmp(token, ")"))
+			parent_cnt--;
+
 		try_apply_macro(&token);
 		str_append(&entry, token);
 	}
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
