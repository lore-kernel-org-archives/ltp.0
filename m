Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB429C71157
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 07:47:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2BC43CC1EE
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 09:47:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D53B3CC186
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 09:47:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 657C21000D97
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 09:47:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 78AB221196;
 Tue, 17 Jun 2025 07:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750146429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrwMzHyMnNTXG3ex0JKMO2K9uJwYKe+PHX4HRrQB7UQ=;
 b=uu2YHWmuezYjnbOkhhyed31OaQFZprpG0MqDJk5Jj/Q61Zn4zRQ2aJEmyUn4cXYRLWCBLj
 v9EcYnbD88k1NRsRgdpdAzsKtBdTlph2i3pgcwHyBSaejoAi7ur04DNuOg9j6pzlAAHWyg
 fwfVNSW7xLGp5PFIwt6gCjFfNWD8YnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750146429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrwMzHyMnNTXG3ex0JKMO2K9uJwYKe+PHX4HRrQB7UQ=;
 b=6ll7OZ7CREo+q8omATl6b+NCmGvexYQ47slxLc8fQS3PDFwoiuXsU3tII9RZLlFs/MNkc1
 D/pTxZXXgmekZxBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750146429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrwMzHyMnNTXG3ex0JKMO2K9uJwYKe+PHX4HRrQB7UQ=;
 b=uu2YHWmuezYjnbOkhhyed31OaQFZprpG0MqDJk5Jj/Q61Zn4zRQ2aJEmyUn4cXYRLWCBLj
 v9EcYnbD88k1NRsRgdpdAzsKtBdTlph2i3pgcwHyBSaejoAi7ur04DNuOg9j6pzlAAHWyg
 fwfVNSW7xLGp5PFIwt6gCjFfNWD8YnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750146429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrwMzHyMnNTXG3ex0JKMO2K9uJwYKe+PHX4HRrQB7UQ=;
 b=6ll7OZ7CREo+q8omATl6b+NCmGvexYQ47slxLc8fQS3PDFwoiuXsU3tII9RZLlFs/MNkc1
 D/pTxZXXgmekZxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40E0C13AE1;
 Tue, 17 Jun 2025 07:47:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8EzyDH0dUWioaAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 17 Jun 2025 07:47:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 17 Jun 2025 09:47:03 +0200
MIME-Version: 1.0
Message-Id: <20250617-doc_fix_table_generate-v1-1-e96beeb2bdf7@suse.com>
References: <20250617-doc_fix_table_generate-v1-0-e96beeb2bdf7@suse.com>
In-Reply-To: <20250617-doc_fix_table_generate-v1-0-e96beeb2bdf7@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750146428; l=611;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=NmOsOs4nu4GLAier3R1SC4+sOG2D2Dw4qwmNijGSvcw=;
 b=qPHqJV8mCSOlIhfu3XNGbqUaWSxLQqhpvFR9neqR0aZZXJAtqXr+2M9ziruoxP7fWKUgPSCKL
 +84dFJ2GqFyBszLW1CY3Z22m2CNimd0kj3CF7HwvGacIV+/GJEFUVw0
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] docs: make sure docs are built if filesystems is
 empty
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/conf.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/conf.py b/doc/conf.py
index 23fe7a1b9742f604a5b97f0db62b29ed9c64c445..da768232b5451bd507d2ffacc12e20c2e0a8321c 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -422,7 +422,8 @@ def _generate_setup_table(keys):
             else:
                 values.append(value)
 
-        table.extend(_generate_table_cell(key, values))
+        if values:
+            table.extend(_generate_table_cell(key, values))
 
     return table
 

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
