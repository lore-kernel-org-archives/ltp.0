Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DF2CC6B08
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:02:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 892DB3EA821
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:02:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 607073EA812
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CC887600468
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 529E91F456;
 Tue, 13 Oct 2026 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rO88S0hSMHFghxDj6bXLjyqJkJCRRPa1nNj5q9bd0LE=;
 b=aU+tyMuwuY9Z2vZJmb+UiiMOiVeC0A6bi1s6RN2YuBtfTP81Hzei6m9qf9wTUfFpeAyJb/
 z4nGG+NkU08himDSEfUYea3TZFjpyMK4nR4R0f2Egy6hRwkoC2OMz47fy9ELKFH4vmC8sq
 yqVqaNJ26VEtSgZS2bdTS0HBZq8TmJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rO88S0hSMHFghxDj6bXLjyqJkJCRRPa1nNj5q9bd0LE=;
 b=QpVRSOBym45jhef6VuRuOTtfY4KopTLZXm8sg1MFauM/Ue+9Ff9L4SDDyuQk1vRmjoCjtM
 xOik4JAe3P0ooYCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aU+tyMuw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QpVRSOBy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rO88S0hSMHFghxDj6bXLjyqJkJCRRPa1nNj5q9bd0LE=;
 b=aU+tyMuwuY9Z2vZJmb+UiiMOiVeC0A6bi1s6RN2YuBtfTP81Hzei6m9qf9wTUfFpeAyJb/
 z4nGG+NkU08himDSEfUYea3TZFjpyMK4nR4R0f2Egy6hRwkoC2OMz47fy9ELKFH4vmC8sq
 yqVqaNJ26VEtSgZS2bdTS0HBZq8TmJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rO88S0hSMHFghxDj6bXLjyqJkJCRRPa1nNj5q9bd0LE=;
 b=QpVRSOBym45jhef6VuRuOTtfY4KopTLZXm8sg1MFauM/Ue+9Ff9L4SDDyuQk1vRmjoCjtM
 xOik4JAe3P0ooYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B71613503;
 Tue, 13 Oct 2026 12:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig:T6
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:02:01 +0200
MIME-Version: 1.0
Message-Id: <20261013-fix_core_lib_deepseek-v2-5-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=911;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=d6Sj+G60K7vji2ni8XDa22x7SwkG18Q/97Wzkn+UYu8=;
 b=1RtBSgYSut3b7z13NtyZO+dR4umeWBE+5RU4eaxqW3dOv8l0YitPKOR0SkvOjTI6Xj3mpeATE
 sLvQ/1PU1bDC6AURNBB7auV4xjYyAx6R0/rU/GesoHPtsgzlPvzVJih
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 SUBJECT_HAS_EXCLAIM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 529E91F456
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 05/15] ujson: reader: Return UTF-8 length when !str
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

When parse_ucode_esc() is called without an output buffer to calculate
string length, it returned the unicode code point instead of the UTF-8
byte length. This vastly overestimated the required buffer size. Return
the UTF-8 byte length instead.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
index 3cd7fcce5..6dde06e01 100644
--- a/libs/ujson/ujson_reader.c
+++ b/libs/ujson/ujson_reader.c
@@ -135,7 +135,7 @@ static unsigned int parse_ucode_esc(ujson_reader *buf, char *str,
 		return 0;
 
 	if (!str)
-		return ucode;
+		return ujson_utf8_bytes(ucode);
 
 	if (ujson_utf8_bytes(ucode) + 1 >= len - off) {
 		ujson_err(buf, "String buffer too short!");

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
