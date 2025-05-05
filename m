Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7305BC3ABAA
	for <ltp@archiver.kernel.org>; Mon,  5 May 2025 15:12:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 905443CBF69
	for <ltp@archiver.kernel.org>; Mon,  5 May 2025 17:12:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E03CD3CB0F1
 for <ltp@lists.linux.it>; Mon,  5 May 2025 17:11:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A20EC200962
 for <ltp@lists.linux.it>; Mon,  5 May 2025 17:11:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 118B6211A0
 for <ltp@lists.linux.it>; Mon,  5 May 2025 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746457916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8CR9F38FlbT2LBnHEaZTVg2sdEWUHcv0TS5/9rcuq2w=;
 b=EpDL9I/juEVELBZSSbTROfO5/fpEeXEsiUnyjxJRigXqE9mi6L7xpT4EPGkLKgaRHTS/cy
 Krqvz8tMx0/IWV8dPf9ImTcPL9nAtBgHo/CwNpXITAYS2gT0kN5TzVZYMtJAoZ+RcaDXjZ
 vvDgCCS0DXg1/lJIdHlYPtLlTO9I3vY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746457916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8CR9F38FlbT2LBnHEaZTVg2sdEWUHcv0TS5/9rcuq2w=;
 b=QB/d80QHf/TDDoJFYIdsIEnsTLd82tfq5xgdrSZ0KI7jsODIiaaxVta4hy66tu5RI7RR3U
 mR41zf0CmBQkl5Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746457916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8CR9F38FlbT2LBnHEaZTVg2sdEWUHcv0TS5/9rcuq2w=;
 b=EpDL9I/juEVELBZSSbTROfO5/fpEeXEsiUnyjxJRigXqE9mi6L7xpT4EPGkLKgaRHTS/cy
 Krqvz8tMx0/IWV8dPf9ImTcPL9nAtBgHo/CwNpXITAYS2gT0kN5TzVZYMtJAoZ+RcaDXjZ
 vvDgCCS0DXg1/lJIdHlYPtLlTO9I3vY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746457916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8CR9F38FlbT2LBnHEaZTVg2sdEWUHcv0TS5/9rcuq2w=;
 b=QB/d80QHf/TDDoJFYIdsIEnsTLd82tfq5xgdrSZ0KI7jsODIiaaxVta4hy66tu5RI7RR3U
 mR41zf0CmBQkl5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1C901372E
 for <ltp@lists.linux.it>; Mon,  5 May 2025 15:11:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M1YGOjvVGGg5WAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 05 May 2025 15:11:55 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  5 May 2025 17:12:35 +0200
Message-ID: <20250505151235.12898-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] metaparse: ignore macros in tst_test structure parsing
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

All we need to do is to drop all lines starting with '#'.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
This is needed on the top of:

http://patchwork.ozlabs.org/project/ltp/patch/20250429135542.19680-1-chrubis@suse.cz/

In order to produce a proper metadata JSON.

 metadata/metaparse.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 2b96149dc..9723a92c2 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -25,7 +25,7 @@ static char *includepath;
 
 #define WARN(str) fprintf(stderr, "WARNING: " str "\n")
 
-static void oneline_comment(FILE *f)
+static void remove_to_newline(FILE *f)
 {
 	int c;
 
@@ -126,7 +126,7 @@ static void maybe_comment(FILE *f, struct data_node *doc)
 
 	switch (c) {
 	case '/':
-		oneline_comment(f);
+		remove_to_newline(f);
 	break;
 	case '*':
 		maybe_doc_comment(f, doc);
@@ -571,6 +571,11 @@ static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *n
 		if (!strcmp(token, "}"))
 			return 0;
 
+		if (!strcmp(token, "#")) {
+			remove_to_newline(f);
+			continue;
+		}
+
 		switch (state) {
 		case 0:
 			id = strdup(token);
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
