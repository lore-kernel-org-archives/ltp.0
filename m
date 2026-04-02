Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90E7D39418
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:15:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6109E3E2A18
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:15:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 806E53E2F46
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2DD5710006CD
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C171C4D32C
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCz1glNtLrRdu84aSM8UzkCrKDifdb5nOL4WaJJmDXk=;
 b=W4SRvv9jR7DjcWsl2LtMEQYs8j/2kyiOOuiulW1i02rK+Oa0kk2ksL5mHKbHK4d6rBlTYF
 P6Bh/aLo06mVmEWufnEDzXk9L1AiVO8qXw+DIXBpPjKsurUc+5a15xSUT8M4Xh4vVcsAiO
 h3GwPspv37HYcRlCdfgxAE/oAmCJnO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCz1glNtLrRdu84aSM8UzkCrKDifdb5nOL4WaJJmDXk=;
 b=yPqdf7q5PmlU33QYJtYikn8jorH7AJZtEo14wgYfgksfMFqyD5WaCWL1Mm4wdcVhdscio/
 wjiwnZjqUOEqR8Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCz1glNtLrRdu84aSM8UzkCrKDifdb5nOL4WaJJmDXk=;
 b=W4SRvv9jR7DjcWsl2LtMEQYs8j/2kyiOOuiulW1i02rK+Oa0kk2ksL5mHKbHK4d6rBlTYF
 P6Bh/aLo06mVmEWufnEDzXk9L1AiVO8qXw+DIXBpPjKsurUc+5a15xSUT8M4Xh4vVcsAiO
 h3GwPspv37HYcRlCdfgxAE/oAmCJnO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCz1glNtLrRdu84aSM8UzkCrKDifdb5nOL4WaJJmDXk=;
 b=yPqdf7q5PmlU33QYJtYikn8jorH7AJZtEo14wgYfgksfMFqyD5WaCWL1Mm4wdcVhdscio/
 wjiwnZjqUOEqR8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACCC54A0B1
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D6j8KIRdzmmfDgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:13:56 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:41 +0200
Message-ID: <20260402121356.31266-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402121356.31266-1-chrubis@suse.cz>
References: <20260402121356.31266-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/17] lib: shell: Remove needs_drivers from JSON
 parser
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

No shell tests were using it at the moment.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/tst_run_shell.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index c12361ef5..2778fb6d5 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -68,7 +68,6 @@ enum test_attr_ids {
 	NEEDS_CMDS,
 	NEEDS_DEVFS,
 	NEEDS_DEVICE,
-	NEEDS_DRIVERS,
 	NEEDS_HUGETLBFS,
 	NEEDS_KCONFIGS,
 	NEEDS_ROFS,
@@ -103,7 +102,6 @@ static ujson_obj_attr test_attrs[] = {
 	UJSON_OBJ_ATTR_IDX(NEEDS_CMDS, "needs_cmds", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(NEEDS_DEVFS, "needs_devfs", UJSON_BOOL),
 	UJSON_OBJ_ATTR_IDX(NEEDS_DEVICE, "needs_device", UJSON_BOOL),
-	UJSON_OBJ_ATTR_IDX(NEEDS_DRIVERS, "needs_drivers", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(NEEDS_HUGETLBFS, "needs_hugetlbfs", UJSON_BOOL),
 	UJSON_OBJ_ATTR_IDX(NEEDS_KCONFIGS, "needs_kconfigs", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(NEEDS_ROFS, "needs_rofs", UJSON_BOOL),
@@ -512,9 +510,6 @@ static void parse_metadata(void)
 		case NEEDS_DEVICE:
 			test.needs_device = val.val_bool;
 		break;
-		case NEEDS_DRIVERS:
-			test.needs_drivers = parse_strarr(&reader, &val);
-		break;
 		case NEEDS_HUGETLBFS:
 			test.needs_hugetlbfs = val.val_bool;
 		break;
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
