Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC09E64AB6
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 15:15:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49BC93DE303
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 16:15:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DA663DE2BE
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 16:15:21 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EF29066FD9E
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 16:15:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 153A01F445
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733238920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBAace4V3ZWzoOGHlrX8t30mXrSXiRiyxCqVzZRPJqU=;
 b=QSfttG7k2iqxWhimpXJmH9dm8RkOU9Do9kVSpQ0ZZt8SSPuFhwm4khTGFD+OGlCaLyHTlC
 xOuMF6pqG9JZEB8nqpYeNhsE0lq58xs7XhzGFjtMRzOGDOfCGBNE85REkJxsNK5NMTDulF
 iIyLAM2wS2SgKgJ3xvR4fmi3zYMC3Ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733238920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBAace4V3ZWzoOGHlrX8t30mXrSXiRiyxCqVzZRPJqU=;
 b=DrVOyxs+soibAVUw1uOfau0/t2MvQPwFbs8EXE/2JotXp9MKMlY3pQ8nIRnPLah8uXct75
 0XFo9nTvuuMVdjDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733238920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBAace4V3ZWzoOGHlrX8t30mXrSXiRiyxCqVzZRPJqU=;
 b=QSfttG7k2iqxWhimpXJmH9dm8RkOU9Do9kVSpQ0ZZt8SSPuFhwm4khTGFD+OGlCaLyHTlC
 xOuMF6pqG9JZEB8nqpYeNhsE0lq58xs7XhzGFjtMRzOGDOfCGBNE85REkJxsNK5NMTDulF
 iIyLAM2wS2SgKgJ3xvR4fmi3zYMC3Ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733238920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBAace4V3ZWzoOGHlrX8t30mXrSXiRiyxCqVzZRPJqU=;
 b=DrVOyxs+soibAVUw1uOfau0/t2MvQPwFbs8EXE/2JotXp9MKMlY3pQ8nIRnPLah8uXct75
 0XFo9nTvuuMVdjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0258B13A2E
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 15:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5h8YO4cgT2eiQwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 03 Dec 2024 15:15:19 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Dec 2024 16:15:26 +0100
Message-ID: <20241203151530.16882-2-chrubis@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] tst_run_shell: Add save_restore parser
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
 testcases/lib/tst_run_shell.c | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 95cac0d60..836e01f18 100644
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
@@ -299,6 +301,73 @@ static struct tst_tag *parse_tags(ujson_reader *reader, ujson_val *val)
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
+		int flags_set = 0;
+		unsigned int flags = 0;
+
+		UJSON_ARR_FOREACH(reader, val) {
+			if (val->type != UJSON_STR) {
+				ujson_err(reader, "Expected string!");
+				return NULL;
+			}
+
+			if (!path) {
+				path = strdup(val->val_str);
+			} else if (!flags_set) {
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
+		ret[i].val = NULL;
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
@@ -385,6 +454,9 @@ static void parse_metadata(void)
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
