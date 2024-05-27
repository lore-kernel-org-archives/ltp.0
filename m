Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D41C25B74
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 06:36:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B2D03D037E
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 08:36:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D19F13D0324
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:58 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6E52C600F9A
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22F5021CB8;
 Mon, 27 May 2024 06:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRlBRd17+qLLJ1LKEYx2gX4WzGSBe6FYND6W73k/g2k=;
 b=cnlv7WvwT9ErpKjr8Q2/euj9I0yzwFdrWzACmJDOdd+6UnJ3Yr06aE2I2ng8YMLmU9d3pT
 LmSLsW3ZFzPTJvF3x3eW1r6xOHQZkIqwCL7NpU39Wn6fZ6D6w26jfwxVTQN/1mJ/bNFirP
 LXAlNO55wIgQ3lDLmcgCgfikYQiGErs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRlBRd17+qLLJ1LKEYx2gX4WzGSBe6FYND6W73k/g2k=;
 b=+ZRDMxBk8jUQfOwtmxKd11zK7TcMpruEtSsVDwrgsIHtE2aVaf6gsS8rZmOB9LT8LgwIv+
 GXjyJ5ZSez/DhrCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRlBRd17+qLLJ1LKEYx2gX4WzGSBe6FYND6W73k/g2k=;
 b=cnlv7WvwT9ErpKjr8Q2/euj9I0yzwFdrWzACmJDOdd+6UnJ3Yr06aE2I2ng8YMLmU9d3pT
 LmSLsW3ZFzPTJvF3x3eW1r6xOHQZkIqwCL7NpU39Wn6fZ6D6w26jfwxVTQN/1mJ/bNFirP
 LXAlNO55wIgQ3lDLmcgCgfikYQiGErs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRlBRd17+qLLJ1LKEYx2gX4WzGSBe6FYND6W73k/g2k=;
 b=+ZRDMxBk8jUQfOwtmxKd11zK7TcMpruEtSsVDwrgsIHtE2aVaf6gsS8rZmOB9LT8LgwIv+
 GXjyJ5ZSez/DhrCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0044913A6C;
 Mon, 27 May 2024 06:33:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cNq2OlUpVGZAFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 May 2024 06:33:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 May 2024 08:33:45 +0200
Message-ID: <20240527063346.289771-15-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527063346.289771-1-pvorel@suse.cz>
References: <20240527063346.289771-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 14/15] fanout01: Remove kernel >= 3.19 check
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

Since 9e9654cf2 LTP supports kernel >= 4.4.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/packet/fanout01.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/network/packet/fanout01.c b/testcases/network/packet/fanout01.c
index 4243f8400..30c132621 100644
--- a/testcases/network/packet/fanout01.c
+++ b/testcases/network/packet/fanout01.c
@@ -85,7 +85,6 @@ void run(void)
 }
 
 static struct tst_test test = {
-	.min_kver = "3.19",
 	.setup = setup,
 	.test_all = run,
 	.cleanup = cleanup,
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
