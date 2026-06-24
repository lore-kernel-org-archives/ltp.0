Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C00CDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:19:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E12383E5345
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:19:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A91AA3E535A
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4FF9B600A44
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F47176112
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUBVhrZERnsIqnWBOVSbgo3vCpk2ZhnTedtX6VhMeb8=;
 b=kiSMllOh2Q2Qp1kaglT2EVh2MU5rnZIo3xD5lK5KayBy3VRQSEJ/QxQTOZX2xpzRG/6hjP
 ljabYHeueoujL9881oDfYN1qLnXp4jZ9iFqXH9wX/ZwVbOQGWc3ebODnkIFEmXJm1k4qVb
 OUU4binxCohlR3YFARidGqFOSebsCzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUBVhrZERnsIqnWBOVSbgo3vCpk2ZhnTedtX6VhMeb8=;
 b=tonmjUC8qbk78piEMQDAn4CnJIiL1sX7SmPBYKMFPplrOU6kf/LORb371aB16XE100+dlf
 lXcyH69mFXFpJgDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUBVhrZERnsIqnWBOVSbgo3vCpk2ZhnTedtX6VhMeb8=;
 b=pSkXPbc7WD+MuRnxfYRn+rSdEaAE0KVGiCIqHlcEb3Z64EH8LqlHWeV4TG6+sbgPRBPlxe
 nz+vEpx+4XZ8bfnTQCNJIri87umyZBglrjpOcn6pjtwtAtQ3qwwbsWTWd5NpdomMom0YR3
 clzOCzOtu5hf1/CYMSAHEwLZ9tYfRxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUBVhrZERnsIqnWBOVSbgo3vCpk2ZhnTedtX6VhMeb8=;
 b=RqvqCqLe2QYTHGenL7xs+Afe4e1xOamgOJFFgWFNNleQcbH1ArGpvxl8/l/0Gps2Y9wav4
 R9tNofud/tngSoBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B997779AE
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TU3KEQahO2pNAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:02 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:18:51 +0200
Message-ID: <20260624091900.4107041-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624091900.4107041-1-chrubis@suse.cz>
References: <20260624091900.4107041-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/13] tst_run_shell: Add support for groups in the
 env JSON
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

If present we assert that the groups is an array of strings but we don't
use the value since it's not used by the test itself. With that we can
add groups to the shell tests and they will end up being carried on to
the metadata.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/tst_run_shell.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 2778fb6d5..fa893304a 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -57,6 +57,7 @@ enum test_attr_ids {
 	DEV_MIN_SIZE,
 	FILESYSTEMS,
 	FORMAT_DEVICE,
+	GROUPS,
 	MIN_CPUS,
 	MIN_MEM_AVAIL,
 	MIN_KVER,
@@ -91,6 +92,7 @@ static ujson_obj_attr test_attrs[] = {
 	UJSON_OBJ_ATTR_IDX(DEV_MIN_SIZE, "dev_min_size", UJSON_INT),
 	UJSON_OBJ_ATTR_IDX(FILESYSTEMS, "filesystems", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(FORMAT_DEVICE, "format_device", UJSON_BOOL),
+	UJSON_OBJ_ATTR_IDX(GROUPS, "groups", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(MIN_CPUS, "min_cpus", UJSON_INT),
 	UJSON_OBJ_ATTR_IDX(MIN_MEM_AVAIL, "min_mem_avail", UJSON_INT),
 	UJSON_OBJ_ATTR_IDX(MIN_KVER, "min_kver", UJSON_STR),
@@ -125,7 +127,7 @@ static ujson_obj test_obj = {
 	.attr_cnt = UJSON_ARRAY_SIZE(test_attrs),
 };
 
-static const char *const *parse_strarr(ujson_reader *reader, ujson_val *val)
+static const char *const *parse_strarr(ujson_reader *reader, ujson_val *val, bool alloc)
 {
 	unsigned int cnt = 0, i = 0;
 	char **ret;
@@ -141,6 +143,9 @@ static const char *const *parse_strarr(ujson_reader *reader, ujson_val *val)
 		cnt++;
 	}
 
+	if (!alloc)
+		return NULL;
+
 	ujson_reader_state_load(reader, state);
 
 	ret = SAFE_MALLOC(sizeof(char *) * (cnt + 1));
@@ -242,7 +247,7 @@ static struct tst_fs *parse_filesystems(ujson_reader *reader, ujson_val *val)
 		UJSON_OBJ_FOREACH_FILTER(reader, val, &fs_obj, ujson_empty_obj) {
 			switch ((enum fs_ids)val->idx) {
 			case MKFS_OPTS:
-				ret[i].mkfs_opts = parse_strarr(reader, val);
+				ret[i].mkfs_opts = parse_strarr(reader, val, true);
 			break;
 			case MKFS_SIZE_OPT:
 				ret[i].mkfs_size_opt = strdup(val->val_str);
@@ -462,6 +467,9 @@ static void parse_metadata(void)
 		case FORMAT_DEVICE:
 			test.format_device = val.val_bool;
 		break;
+		case GROUPS:
+			parse_strarr(&reader, &val, false);
+		break;
 		case MIN_CPUS:
 			if (val.val_int <= 0)
 				ujson_err(&reader, "Minimal number of cpus must be > 0");
@@ -514,7 +522,7 @@ static void parse_metadata(void)
 			test.needs_hugetlbfs = val.val_bool;
 		break;
 		case NEEDS_KCONFIGS:
-			test.needs_kconfigs = parse_strarr(&reader, &val);
+			test.needs_kconfigs = parse_strarr(&reader, &val, true);
 		break;
 		case NEEDS_ROFS:
 			test.needs_rofs = val.val_bool;
@@ -538,7 +546,7 @@ static void parse_metadata(void)
 			test.save_restore = parse_save_restore(&reader, &val);
 		break;
 		case SKIP_FILESYSTEMS:
-			test.skip_filesystems = parse_strarr(&reader, &val);
+			test.skip_filesystems = parse_strarr(&reader, &val, true);
 		break;
 		case SKIP_IN_COMPAT:
 			test.skip_in_compat = val.val_bool;
@@ -550,7 +558,7 @@ static void parse_metadata(void)
 			test.skip_in_secureboot = val.val_bool;
 		break;
 		case SUPPORTED_ARCHS:
-			test.supported_archs = parse_strarr(&reader, &val);
+			test.supported_archs = parse_strarr(&reader, &val, true);
 		break;
 		case TAGS:
 			test.tags = parse_tags(&reader, &val);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
