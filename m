Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3E2E77188
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 13:27:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C09903C4BC8
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 14:26:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B23F3C4BC8
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:26:24 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B68A9225B6F
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:26:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 150D81F441;
 Mon,  6 Jan 2025 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736169983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bveTlPVljAQGfXC0Vsc27D+gd8ZRKdq7VA/7qEEFTmU=;
 b=zUrG9ZjGi9M5lO2CZgGvnEwtbE5JxC5LouaRb9CVJ+5zkUDc10YKTTeO/omL/P6J47TSW+
 hKCZ1IwPV0laK5R/oSiwi778Oo9Qyy8owVndqaoex93o4fTBgtDP2NKZwo3n550Nu0JqG5
 ajLbuGBQkNkP6cSrRFXgrMm12J+lFvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736169983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bveTlPVljAQGfXC0Vsc27D+gd8ZRKdq7VA/7qEEFTmU=;
 b=hrUNnClixWxo2zab5t95pD83Y+Gqi+GB29MZmQF8x+TXtRQfmPXOlbGjbARfwkshF6YbgZ
 p41jncVzs3hCEQBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aSixaEDi;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ME+KXX55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736169982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bveTlPVljAQGfXC0Vsc27D+gd8ZRKdq7VA/7qEEFTmU=;
 b=aSixaEDi3Vb+yzD0wZxWGthLrOYQknwUih3rpuC1c3bcHlekZKNUYbTu6ZLuMRCBXIwI1y
 75SctMZQ+ZCTlvtPmRVbFjdLapm2LJErCwyl44EXZkMEeAYw2ZRMvu449DSoQsYHAw7jqF
 RoEFloPXA57n60hud6DNYnmxdGB1lrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736169982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bveTlPVljAQGfXC0Vsc27D+gd8ZRKdq7VA/7qEEFTmU=;
 b=ME+KXX55Bxr79l0UltNd3mKhHxEisEqyLitnCzrp+jmTkaP2x9lYPgIXJI3mI2cochWTNi
 FDkQOpJD4Pr7TYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA1013A96;
 Mon,  6 Jan 2025 13:26:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RT2hOP3Ze2fEKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 06 Jan 2025 13:26:21 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Jan 2025 14:26:02 +0100
Message-ID: <20250106132607.25627-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250106132607.25627-1-chrubis@suse.cz>
References: <20250106132607.25627-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 150D81F441
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/6] tst_run_shell: Add save_restore parser
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_run_shell.c | 87 +++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 95cac0d60..0b86233dd 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -74,6 +74,7 @@ enum test_attr_ids {
 	NEEDS_ROOT,
 	NEEDS_TMPDIR,
 	RESTORE_WALLCLOCK,
+	SAVE_RESTORE,
 	SKIP_FILESYSTEMS,
 	SKIP_IN_COMPAT,
 	SKIP_IN_LOCKDOWN,
@@ -106,6 +107,7 @@ static ujson_obj_attr test_attrs[] = {
 	UJSON_OBJ_ATTR_IDX(NEEDS_ROOT, "needs_root", UJSON_BOOL),
 	UJSON_OBJ_ATTR_IDX(NEEDS_TMPDIR, "needs_tmpdir", UJSON_BOOL),
 	UJSON_OBJ_ATTR_IDX(RESTORE_WALLCLOCK, "restore_wallclock", UJSON_BOOL),
+	UJSON_OBJ_ATTR_IDX(SAVE_RESTORE, "save_restore", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(SKIP_FILESYSTEMS, "skip_filesystems", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(SKIP_IN_COMPAT, "skip_in_compat", UJSON_BOOL),
 	UJSON_OBJ_ATTR_IDX(SKIP_IN_LOCKDOWN, "skip_in_lockdown", UJSON_BOOL),
@@ -299,6 +301,88 @@ static struct tst_tag *parse_tags(ujson_reader *reader, ujson_val *val)
 	return ret;
 }
 
+static struct tst_path_val *parse_save_restore(ujson_reader *reader, ujson_val *val)
+{
+	unsigned int i = 0, cnt = 0;
+	struct tst_path_val *ret;
+
+	ujson_reader_state state = ujson_reader_state_save(reader);
+
+	UJSON_ARR_FOREACH(reader, val) {
+		if (val->type != UJSON_ARR) {
+			ujson_err(reader, "Expected array!");
+			return NULL;
+		}
+		ujson_arr_skip(reader);
+		cnt++;
+	}
+
+	ujson_reader_state_load(reader, state);
+
+	ret = SAFE_MALLOC(sizeof(struct tst_path_val) * (cnt + 1));
+	memset(&ret[cnt], 0, sizeof(ret[cnt]));
+
+	UJSON_ARR_FOREACH(reader, val) {
+		char *path = NULL;
+		char *pval = NULL;
+		int flags_set = 0;
+		int val_set = 0;
+		unsigned int flags = 0;
+
+		UJSON_ARR_FOREACH(reader, val) {
+			if (!path) {
+				if (val->type != UJSON_STR) {
+					ujson_err(reader, "Expected string!");
+					return NULL;
+				}
+
+				path = strdup(val->val_str);
+			} else if (!val_set) {
+				if (val->type == UJSON_STR) {
+					pval = strdup(val->val_str);
+				} else if (val->type != UJSON_NULL) {
+					ujson_err(reader, "Expected string or NULL!");
+					return NULL;
+				}
+				val_set = 1;
+			} else if (!flags_set) {
+				if (val->type != UJSON_STR) {
+					ujson_err(reader, "Expected string!");
+					return NULL;
+				}
+
+				if (!strcmp(val->val_str, "TCONF")) {
+					flags = TST_SR_TCONF;
+				} else if (!strcmp(val->val_str, "TBROK")) {
+					flags = TST_SR_TBROK;
+				} else if (!strcmp(val->val_str, "SKIP")) {
+					flags = TST_SR_SKIP;
+				} else {
+					ujson_err(reader, "Invalid flags!");
+					return NULL;
+				}
+
+				flags_set = 1;
+			} else {
+				ujson_err(reader, "Expected only two members!");
+				return NULL;
+			}
+		}
+
+		if (!path || !flags_set) {
+			ujson_err(reader, "Expected [\"/{proc,sys}/path\", {\"TCONF\", \"TBROK\", \"TSKIP\"}]!");
+			return NULL;
+		}
+
+		ret[i].path = path;
+		ret[i].val = pval;
+		ret[i].flags = flags;
+		i++;
+	}
+
+	return ret;
+}
+
 static void parse_metadata(void)
 {
 	ujson_reader reader = UJSON_READER_INIT(metadata, metadata_used, UJSON_READER_STRICT);
@@ -385,6 +469,9 @@ static void parse_metadata(void)
 		case RESTORE_WALLCLOCK:
 			test.restore_wallclock = val.val_bool;
 		break;
+		case SAVE_RESTORE:
+			test.save_restore = parse_save_restore(&reader, &val);
+		break;
 		case SKIP_FILESYSTEMS:
 			test.skip_filesystems = parse_strarr(&reader, &val);
 		break;
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
