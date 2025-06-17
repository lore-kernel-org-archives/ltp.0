Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686EEC71136
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 07:48:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 058A33CC208
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 09:48:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7412E3CC21C
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 09:47:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9D9E01A0108C
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 09:47:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BBF0A1F454;
 Tue, 17 Jun 2025 07:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750146429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bLUsmtMOBTgN/wXhIW33rjdFu6lmfrB1/n7hCR09DE=;
 b=n2kcSEr/iZXiY4IPNTsFCGn0WAuOlHb1sgmCCIBP6IaOJYylpqJ5CGhyWr8Y4ikZKkClgs
 s7cFFFnocjVRR9os15GSQrbJR+6QyuVEtDrIzCnIjHRdGx6+7C1y8qlWlLCl1gd1slxQMe
 sRVGVi//ro6uT0tBb9jQiftL5fcLtnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750146429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bLUsmtMOBTgN/wXhIW33rjdFu6lmfrB1/n7hCR09DE=;
 b=XabZRNpQBYQTsPS5PLRy3wQC7rqjjKGscq+PWlvf3K6eHBFFbaneqYezkIzrIjq/4W3oS7
 TWakIs83zyBZ/RAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750146429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bLUsmtMOBTgN/wXhIW33rjdFu6lmfrB1/n7hCR09DE=;
 b=n2kcSEr/iZXiY4IPNTsFCGn0WAuOlHb1sgmCCIBP6IaOJYylpqJ5CGhyWr8Y4ikZKkClgs
 s7cFFFnocjVRR9os15GSQrbJR+6QyuVEtDrIzCnIjHRdGx6+7C1y8qlWlLCl1gd1slxQMe
 sRVGVi//ro6uT0tBb9jQiftL5fcLtnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750146429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bLUsmtMOBTgN/wXhIW33rjdFu6lmfrB1/n7hCR09DE=;
 b=XabZRNpQBYQTsPS5PLRy3wQC7rqjjKGscq+PWlvf3K6eHBFFbaneqYezkIzrIjq/4W3oS7
 TWakIs83zyBZ/RAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87D4D13AE2;
 Tue, 17 Jun 2025 07:47:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cL1UHn0dUWioaAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 17 Jun 2025 07:47:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 17 Jun 2025 09:47:04 +0200
MIME-Version: 1.0
Message-Id: <20250617-doc_fix_table_generate-v1-2-e96beeb2bdf7@suse.com>
References: <20250617-doc_fix_table_generate-v1-0-e96beeb2bdf7@suse.com>
In-Reply-To: <20250617-doc_fix_table_generate-v1-0-e96beeb2bdf7@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750146428; l=662;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Vh1DCyMLUE7vJE4Th0NHus/PDSivzCxWksq3AWxEvQ0=;
 b=KcgMWBpqIlJfkXJ3qzFmTX8A563hYtkVBE/9plB5NSujBWjyUq045YaKljfAN7XTOrV8ObePx
 1OJELbDpGAIAc7tgWKS65mazQnnGA7Sfgz6c08sX9cohxo2/EXWo5oH
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] docs: make sphinx verbose so it's easier to debug
 in CI
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
 doc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/Makefile b/doc/Makefile
index 2062d6e935618d96c169b4a6183441715e768ef6..3123b1cd7a1568d2c7783c28a3d42cb313253e3c 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -24,7 +24,7 @@ ${abs_top_builddir}/metadata/ltp.json:
 	$(MAKE) -C ${abs_top_builddir}/metadata
 
 all: ${abs_top_builddir}/metadata/ltp.json
-	$(RUN_VENV); sphinx-build -b html . html
+	$(RUN_VENV); sphinx-build -v -b html . html
 
 spelling:
 	$(RUN_VENV); sphinx-build -b spelling -d build/doctree . build/spelling

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
