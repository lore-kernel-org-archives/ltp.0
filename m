Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C304E77198
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 13:27:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE4733C4BFC
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 14:27:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C12093C4BC7
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:26:24 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 11B001BCD0E7
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:26:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F65B1F449;
 Mon,  6 Jan 2025 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736169983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0UiwOnzqrkcMWQDAIXOwmsuFTX/gRfF9Pry6ctaq1M=;
 b=Ezc08oarxvkJhth+bloSYjEQbQs7+3MZx6+lrp/YbIYtlzL54O5EvncIRIFqmDRYQJ3pFx
 hYRyq4guog5qfkDzEzdIIHLjjqFHAIWuqj3MKf7XtS/jNetIJpCEks2vniNk2NDFVXMIkj
 Mo6y+dPJRxgExSChcxZM/qSSx4A3DOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736169983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0UiwOnzqrkcMWQDAIXOwmsuFTX/gRfF9Pry6ctaq1M=;
 b=f21wgU31l/XlYq5ycnFq+6Jf+WC0sCcyTU+3MOSmiqcp+eS9yYzW5Zb4JHGi33+QTr0rpf
 i1RKXi6t/QDJaxDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nUR4YXQQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gkkrseiX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736169982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0UiwOnzqrkcMWQDAIXOwmsuFTX/gRfF9Pry6ctaq1M=;
 b=nUR4YXQQaMC57/xh2DeXjfv5op8UcqjSj/ebNv3GDAS1cq/v/hrHpqcktPJnjSD4P4tBCv
 j4XWCCI3zewRg8snbvyfu6m3Nol1bwCqfsNywnDx4rnwuIUzsg+TlR5y0SnjLOyyNO6ljY
 rGamv5FAGrWboWH+sYir9tHDKkVBt+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736169982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0UiwOnzqrkcMWQDAIXOwmsuFTX/gRfF9Pry6ctaq1M=;
 b=gkkrseiXepesRqB7H5QWhu+Z0AmM3BQyN2btsG7vLVp3EOjXQHI/9rSFc1saLFDKDwk7oK
 iv7uNju7WAJSxyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A23413AB5;
 Mon,  6 Jan 2025 13:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K4CQFP7Ze2fIKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 06 Jan 2025 13:26:22 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Jan 2025 14:26:03 +0100
Message-ID: <20250106132607.25627-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250106132607.25627-1-chrubis@suse.cz>
References: <20250106132607.25627-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6F65B1F449
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/6] tst_run_shell: Make the tst_test struct static
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
Suggested-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_run_shell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 0b86233dd..54463c04d 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -26,7 +26,7 @@ static void run_shell_tcnt(unsigned int n)
 	tst_run_script(shell_filename, params);
 }
 
-struct tst_test test = {
+static struct tst_test test = {
 	.runs_script = 1,
 };
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
