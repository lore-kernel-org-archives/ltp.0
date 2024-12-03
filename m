Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48B1E64AB6
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 15:16:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5976F3DE32C
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 16:16:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E31C3DE30D
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 16:15:30 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 34CD11A01945
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 16:15:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC5D71F445
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733238929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+20QhUhsb3ZU7AXZXiT0gGJWR3RbJ3B24SoIySBwJP8=;
 b=yPTrBmpBGn57gpBRXCBw7uw2RM9uflJMqDiTCH45/9TmtCn/zUOKLwY8v/c+PS6cyN+z1I
 89GjxcooOiFntyAcfpZgXtZvRA2pMQebQMvIANL5Sh8NgayXfSVcPl8Hg7ndI8yWiwkx/z
 JVotk+DyI1JWYVlJEkUHl2hF9PVmGek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733238929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+20QhUhsb3ZU7AXZXiT0gGJWR3RbJ3B24SoIySBwJP8=;
 b=Am6wAm73s1AainPwE9tNTpLF2jmAwHVSAMZAsxRhyvps8nWci5WigtdAZsynP+ELnbec1q
 IXRg2FXwsYOVLDAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733238928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+20QhUhsb3ZU7AXZXiT0gGJWR3RbJ3B24SoIySBwJP8=;
 b=L5336DezpbWcnVLR0S7sQRlhLW7ASdema9wszvz88XOe6meCwrj2A6bXgaCN0sLYGvL4rF
 jVBDBEBwb5S/Fi8eEfVjlt1N3fucE4BnleI1SkQwum42aLAqiZFMgi1TeNXh4v4rNVn7Iy
 I0RDc7RLVEZUfP861t9lsqiq9Lgf+Ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733238928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+20QhUhsb3ZU7AXZXiT0gGJWR3RbJ3B24SoIySBwJP8=;
 b=c6j6anQHTfaADjBQFq4of933jLQDVUxKU+6pPFgTZWLXP1YuO6EwG+ikFxV03LUwNSCQ/5
 5YPNY++3fTJBryBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6302139C2
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 15:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OhkKM5AgT2etQwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 03 Dec 2024 15:15:28 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Dec 2024 16:15:28 +0100
Message-ID: <20241203151530.16882-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203151530.16882-1-chrubis@suse.cz>
References: <20241203151530.16882-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] tst_run_shell: Better errors for metadata
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

- Make sure that we are stil in the comment part and TBROK if any of the
  block wasn't terminated properly

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/tst_run_shell.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 836e01f18..24172c877 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -506,6 +506,7 @@ static void extract_metadata(void)
 	char line[4096];
 	char path[4096];
 	enum parser_state state = PAR_NONE;
+	unsigned int lineno = 1;
 
 	if (tst_get_path(shell_filename, path, sizeof(path)) == -1)
 		tst_brk(TBROK, "Failed to find %s in $PATH", shell_filename);
@@ -519,24 +520,40 @@ static void extract_metadata(void)
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
