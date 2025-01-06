Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BA2E77188
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 13:27:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E5CE3C4BD9
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 14:27:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7F703C4C16
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:26:28 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 526E21BCD10E
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:26:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4647421161;
 Mon,  6 Jan 2025 13:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736169987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WDv7KozbrcIJx8S+F4mHIsNj+zkKMh/Div0xyX+6hno=;
 b=bM7PZe+zJ4+G04mQm25KZ5bjMNKWraPr9u/E65P6JiGPpu7cLEQhVqJcEsz3rWiNaJhBVA
 OJ2AkGLV5hfaPp6gXlejjChi4gulI9uUsBA8HQephHsGujONzLA3o0W5IOD0FyIGGFQRsa
 eY5L1Q0CliXSgLRcX6Nv8x96Hn6MAqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736169987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WDv7KozbrcIJx8S+F4mHIsNj+zkKMh/Div0xyX+6hno=;
 b=L1i5+VqSuHzM/nmwwt09rO7r9vOWp+Vq2B8k1hGrWeyh7wPv1JocDxfgJJVwDlkj4XDc2X
 /qHOW6AJpNcKtTAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736169987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WDv7KozbrcIJx8S+F4mHIsNj+zkKMh/Div0xyX+6hno=;
 b=bM7PZe+zJ4+G04mQm25KZ5bjMNKWraPr9u/E65P6JiGPpu7cLEQhVqJcEsz3rWiNaJhBVA
 OJ2AkGLV5hfaPp6gXlejjChi4gulI9uUsBA8HQephHsGujONzLA3o0W5IOD0FyIGGFQRsa
 eY5L1Q0CliXSgLRcX6Nv8x96Hn6MAqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736169987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WDv7KozbrcIJx8S+F4mHIsNj+zkKMh/Div0xyX+6hno=;
 b=L1i5+VqSuHzM/nmwwt09rO7r9vOWp+Vq2B8k1hGrWeyh7wPv1JocDxfgJJVwDlkj4XDc2X
 /qHOW6AJpNcKtTAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 365F6139AB;
 Mon,  6 Jan 2025 13:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iJRFDAPae2fRKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 06 Jan 2025 13:26:27 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Jan 2025 14:26:05 +0100
Message-ID: <20250106132607.25627-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250106132607.25627-1-chrubis@suse.cz>
References: <20250106132607.25627-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/6] tst_run_shell: Better errors for metadata
 extractor
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

- Add filename and lineno to error messages

- Make sure that we are still in the comment part and TBROK if any of the
  block wasn't terminated properly

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_run_shell.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 54463c04d..8760ea43e 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -521,6 +521,7 @@ static void extract_metadata(void)
 	char line[4096];
 	char path[4096];
 	enum parser_state state = PAR_NONE;
+	unsigned int lineno = 1;
 
 	if (tst_get_path(shell_filename, path, sizeof(path)) == -1)
 		tst_brk(TBROK, "Failed to find %s in $PATH", shell_filename);
@@ -534,24 +535,40 @@ static void extract_metadata(void)
 				state = PAR_ESC;
 		break;
 		case PAR_ESC:
-			if (!strcmp(line, "# env\n"))
+			if (!strcmp(line, "# env\n")) {
 				state = PAR_ENV;
-			else if (!strcmp(line, "# doc\n"))
+			} else if (!strcmp(line, "# doc\n")) {
 				state = PAR_DOC;
-			else
-				tst_brk(TBROK, "Unknown comment block %s", line);
+			} else {
+				tst_brk(TBROK, "%s: %u: Unknown comment block %s",
+				        path, lineno, line);
+			}
 		break;
 		case PAR_ENV:
+			if (line[0] != '#') {
+				tst_brk(TBROK,
+					"%s: %u: Unexpected end of comment block!",
+					path, lineno);
+			}
+
 			if (!strcmp(line, "# ---\n"))
 				state = PAR_NONE;
 			else
 				metadata_append(line + 2);
 		break;
 		case PAR_DOC:
+			if (line[0] != '#') {
+				tst_brk(TBROK,
+					"%s: %u: Unexpected end of comment block!",
+					path, lineno);
+			}
+
 			if (!strcmp(line, "# ---\n"))
 				state = PAR_NONE;
 		break;
 		}
+
+		lineno++;
 	}
 
 	fclose(f);
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
