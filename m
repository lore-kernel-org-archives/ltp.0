Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A900CC6B03
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:05:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F9CB3EA83F
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:05:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 871543EA825
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EF46F1400997
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A49BA21F35;
 Tue, 13 Oct 2026 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8hu5wFOwpRBr6EY35KrS1CNQ5GjNmE2VA6HrUvvyTI=;
 b=ANYA1JxUQt9s4lmo9wASxGhid17AchUY3DEyvTAR7dBDndbytngoNjcULHAbLF3icbH5xc
 EMMyD/hlbHkJQDmWCKQROTL0tOg0F/4EmnqRQjlUs13Zl0XukiDk3Oe2dNnmK3IT21b01+
 yxC6Fceke5WW5xGvlo9+VmMoBr7WuWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8hu5wFOwpRBr6EY35KrS1CNQ5GjNmE2VA6HrUvvyTI=;
 b=E1sXYKza6ZEnCIP+VuDarmPnRS/QQYfcr9FVaaGckHpRWDu5erDtCwOFVxCJQkZLDYyfbH
 J+FOe0K+8WAM/ABg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cEsgojJN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6mRWQYFe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8hu5wFOwpRBr6EY35KrS1CNQ5GjNmE2VA6HrUvvyTI=;
 b=cEsgojJNTZavxDyxUo29CWowqoUMNzNomqhorzoJLFnzclFo3CpKgJwJYdN3VlPFz3fNaY
 68nRq/sPshxel7Wpo5K/cQ9wtnxvQpx8zXpkVJzLTHekC1CflPi+QIP9fRYUeqG4deBWmP
 iOgZJ1pykJgaslTX3qFT5necjRcwF8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8hu5wFOwpRBr6EY35KrS1CNQ5GjNmE2VA6HrUvvyTI=;
 b=6mRWQYFeJuScrLC/Y2w2ZhUxh84QiNig6zs7e+VOE1EE/oMc81s+pXZ1CqCJEGAYgz3Xm9
 xm2BCgxPN0WYOLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 043BE134E4;
 Tue, 13 Oct 2026 12:02:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig:T5
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:02:00 +0200
MIME-Version: 1.0
Message-Id: <20261013-fix_core_lib_deepseek-v2-4-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=944;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=A34dQUqNZGBtr1paNZ+YOziPy6VBfhljHlhBrdHbikI=;
 b=pfg9lBMZE53ZcKr8ehL/ub+YQ00sMQ2+MBCbAtm7cSDsA3FJGNqXLjHEymNC2Uwug8tiuD+Mh
 0rL/SfxA3g+BusofNhI3Q2laF9kc6YFFrHKiORLf/PSUCsSxD2dL9IK
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.de:dkim,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: A49BA21F35
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 04/15] ujson: writer: Fix open() return value check
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

open() returns -1 on failure and a non-negative file descriptor on
success (including 0). Checking !writer_file->fd wrongly rejects fd 0
as an error and accepts -1 on open failure. Check for negative fd
instead.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_writer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
index b5da494d1..040ae680e 100644
--- a/libs/ujson/ujson_writer.c
+++ b/libs/ujson/ujson_writer.c
@@ -475,7 +475,7 @@ ujson_writer *ujson_writer_file_open(const char *path)
 	writer_file = (void*)ret + sizeof(ujson_writer);
 
 	writer_file->fd = open(path, O_CREAT | O_WRONLY | O_TRUNC, 0664);
-	if (!writer_file->fd) {
+	if (writer_file->fd < 0) {
 		free(ret);
 		return NULL;
 	}

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
