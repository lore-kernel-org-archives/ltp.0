Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F9DD3EE64
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 13:21:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A85853CB5BA
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 14:21:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82A813CB707
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 14:20:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 502C4600BC5
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 14:20:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6BF935BCCD
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769087983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyaIcVu9sNyCpmRB4dwYc8nIxLF8Irs72WWT7Y6vDjY=;
 b=tqLnfv6KbkDuGZvGFujiXUfpyklTaE7znHelZtroAjM65xKJb5bjzFdQGbflnqYrNJo+xC
 tX2JTDAPmCz0OAc47kjChbGge7n2GkZCwZIh0vvoWJ6skwKCvEqb7hoQnkR24GtiPTJnT7
 4OuBO4ykO+IWKBzVIZ7H2AdMLCoSxtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769087983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyaIcVu9sNyCpmRB4dwYc8nIxLF8Irs72WWT7Y6vDjY=;
 b=flR0mkvy0iRkNrVIl7TC3fUnnyyyoBKarnQaQ4gdFswRtwOjYfl/IqdoqAG6QZsKEnUCOO
 WbTHRB+3mObJh8CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769087983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyaIcVu9sNyCpmRB4dwYc8nIxLF8Irs72WWT7Y6vDjY=;
 b=tqLnfv6KbkDuGZvGFujiXUfpyklTaE7znHelZtroAjM65xKJb5bjzFdQGbflnqYrNJo+xC
 tX2JTDAPmCz0OAc47kjChbGge7n2GkZCwZIh0vvoWJ6skwKCvEqb7hoQnkR24GtiPTJnT7
 4OuBO4ykO+IWKBzVIZ7H2AdMLCoSxtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769087983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyaIcVu9sNyCpmRB4dwYc8nIxLF8Irs72WWT7Y6vDjY=;
 b=flR0mkvy0iRkNrVIl7TC3fUnnyyyoBKarnQaQ4gdFswRtwOjYfl/IqdoqAG6QZsKEnUCOO
 WbTHRB+3mObJh8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E56E139A3
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:19:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id em08Eu8jcmkQOgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:19:43 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 22 Jan 2026 14:20:59 +0100
Message-ID: <20260122132059.24503-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122132059.24503-1-chrubis@suse.cz>
References: <20260122132059.24503-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] lib: shell: Switch cmd.optional to bool
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
 testcases/lib/tests/shell_loader_cmd.sh | 4 ++--
 testcases/lib/tst_run_shell.c           | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tests/shell_loader_cmd.sh b/testcases/lib/tests/shell_loader_cmd.sh
index 4e8e61eb6..1fba2a193 100755
--- a/testcases/lib/tests/shell_loader_cmd.sh
+++ b/testcases/lib/tests/shell_loader_cmd.sh
@@ -8,11 +8,11 @@
 #  "needs_cmds": [
 #   {
 #    "cmd": "ls",
-#    "optional": 1
+#    "optional": true
 #   },
 #   {
 #    "cmd": "mkfs.ext4 >= 1.0.0",
-#    "optional": 1
+#    "optional": true
 #   }
 #  ]
 # }
diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index ddcb606b2..c12361ef5 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -186,7 +186,7 @@ enum cmd_ids {
 
 static ujson_obj_attr cmd_attrs[] = {
 	UJSON_OBJ_ATTR_IDX(CMD, "cmd", UJSON_STR),
-	UJSON_OBJ_ATTR_IDX(OPTIONAL, "optional", UJSON_INT),
+	UJSON_OBJ_ATTR_IDX(OPTIONAL, "optional", UJSON_BOOL),
 };
 
 static ujson_obj cmd_obj = {
@@ -299,7 +299,7 @@ static struct tst_cmd *parse_cmds(ujson_reader *reader, ujson_val *val)
 				ret[i].cmd = strdup(val->val_str);
 			break;
 			case OPTIONAL:
-				ret[i].optional = val->val_int;
+				ret[i].optional = val->val_bool;
 			break;
 			}
 		}
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
