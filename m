Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A92C25B7C
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 16:00:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 943883D0196
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 18:00:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B56DA3CFC05
 for <ltp@lists.linux.it>; Thu, 23 May 2024 17:59:49 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1DFC51000D3A
 for <ltp@lists.linux.it>; Thu, 23 May 2024 17:59:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 78B9120319
 for <ltp@lists.linux.it>; Thu, 23 May 2024 15:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716479988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5/HAxiN974g/k6NS/hQ7h0n15ANo88G0ClF2uiOQP4U=;
 b=agKj/oHIqqeq8yjoMxZwZlM8lOIaeAiiFWVzNe8Otxijz6l2X3P78UKEl6AmTXRgt91Ibb
 K8XB818763sHi5MqrsWwbCpz33u2SVgPE8ew5ECdTx7BvQDkjyTrXAwI7kTBhXzBmP3czH
 fF0XZpN6YTPeMit9psohWHHykDOYn+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716479988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5/HAxiN974g/k6NS/hQ7h0n15ANo88G0ClF2uiOQP4U=;
 b=XWEcKACD+P9pQb29Z0dOlQdBZR1Zmp1gGm/vE5SyUsSbUklTKR6z/dKDNdyVAPZqvTEGAO
 Th6XNO1qkZNPijDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716479987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5/HAxiN974g/k6NS/hQ7h0n15ANo88G0ClF2uiOQP4U=;
 b=tsKP+PhaN/zYWjWouXQsgv6hwR0aVqukq4Uat3UkquI3VXfVcxIQvvTu2vuxnmM3rU0zHi
 4FG0h6qDiOR+YeEoVA01tBcckUFEgy2Qh3CMO0F2NgC61Fpl9h7NHnnc3eY9dxmSIyZA2+
 bWCZYkhNggRRjcdpLegfPyDOu/23T8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716479987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5/HAxiN974g/k6NS/hQ7h0n15ANo88G0ClF2uiOQP4U=;
 b=I7/iWrJgxC+VxfStX/XzWGMU/+GHTAe+p/eG+PnEN59YS49nhFL+I5Wa0oRcWAsFuDMY+O
 uXilArAT5X+HEwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66C1E13A6C
 for <ltp@lists.linux.it>; Thu, 23 May 2024 15:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DfO4F/NnT2a8awAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 May 2024 15:59:47 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 May 2024 17:59:32 +0200
Message-ID: <20240523155932.26393-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/msgstress01: Fix off by one in array access
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

The size returned from recvmsg() is the size of the payload but the
payload is defined as:

struct {
        char len;
        char pbytes[99];
} data;

So the lenght of the pbytes is actually one byte shorter than the size
and we access one byte after the array in the comparsion.

Better fix for this would be removal of the len from the data payload
but since we are close to the release lets do the minimal fix now and do
the cleanup after the release.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/msgstress/msgstress01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 5c84957b3..b0d945a11 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -131,7 +131,7 @@ static void reader(const int id, const int pos)
 			return;
 		}
 
-		for (int i = 0; i < size; i++) {
+		for (int i = 0; i < msg_recv.data.len; i++) {
 			if (msg_recv.data.pbytes[i] != buff->msg.data.pbytes[i]) {
 				tst_res(TFAIL, "Received wrong data at index %d: %x != %x", i,
 					msg_recv.data.pbytes[i],
-- 
2.43.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
