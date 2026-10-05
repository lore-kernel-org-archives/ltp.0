Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7122CCA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:27:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE97E3E2E37
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:27:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97FEA3E5E11
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0EE941A004D3
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 72ED01F7CD;
 Mon,  5 Oct 2026 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+pGungoRseByLcaUJSQCtMjyeGFJV2sqE4S7HHLMI4=;
 b=zHq6/qprtS24JHrY1w1L2ED1wVfxXhnEFOgCW9COQSkW7H42TJx2I1R5jb/Y1hQ+BDHSGZ
 y9qlB0Sq2EvvPjOE8SqyJ5uFfZ/ODqv8ohQPz6clMRtE7TxTdfM9VPcwb6brJDipsziZZ4
 +h10nlie2LEvSfQJdcnn9ts1zAVj4/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+pGungoRseByLcaUJSQCtMjyeGFJV2sqE4S7HHLMI4=;
 b=lgBG5ZOm9hSNDLkUz4smUeIpfbPbU3H8DTS6zWNAYQew/8HujTTn2g/HG401cow+9pFHFI
 o02iCehx3K7/2RAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PzYLpBKw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ADBRWc6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+pGungoRseByLcaUJSQCtMjyeGFJV2sqE4S7HHLMI4=;
 b=PzYLpBKwOBGLlH1kFn4YogRetHqcc9OFOCjKZO7+GgRWG2hlZVHTgQWsb+qcEKH/d23BPw
 KtpfJXnL0or+2A83QY22imiSQstqq/PVuBFGemPSZfE8L9DWRnfOa+aBMqf175bpAW/e9p
 MlwT8BhxikrNy/U2AnhgpZCUGSz6M98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+pGungoRseByLcaUJSQCtMjyeGFJV2sqE4S7HHLMI4=;
 b=ADBRWc6DrNzBVACIbhPU6vcExt8BQi8Hmq1a5jOINWXW0OK4STn1lihJZI9++gS9cZQfAC
 m7YUSsq+odWFaBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B36D13AEC;
 Mon,  5 Oct 2026 13:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q4tkH06lw2oibAAAD6G6ig:T5
 (envelope-from <andrea.cervesato@suse.de>); Mon, 05 Oct 2026 13:25:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 05 Oct 2026 15:25:32 +0200
MIME-Version: 1.0
Message-Id: <20261005-fix_core_lib_deepseek-v1-4-fec334ce8e80@suse.com>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206734; l=899;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=wyHrxzkPR6mkB75SYjwuL5pTHxy3WVXa+n7aAnt2Gto=;
 b=Qf8neG9eTEmkRmdgpTQxKXaH3Wno3QudB36M2V8D8sujONKYUafEYXDTlUZ4DfgKUSI/IX5lH
 CRz3htruDWVBIunCIXq1eCKZTzwo6xJNnbhGC9RJshwRxaaOkBCavhp
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 72ED01F7CD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.964]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/15] ujson: writer: Fix open() return value check
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
