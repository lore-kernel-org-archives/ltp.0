Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E22CA0EF8
	for <ltp@archiver.kernel.org>; Wed, 20 Aug 2025 09:00:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0386C3CCB47
	for <ltp@archiver.kernel.org>; Wed, 20 Aug 2025 11:00:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B00F3C782A
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 10:59:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ABAAA6009E2
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 10:59:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A29321749;
 Wed, 20 Aug 2025 08:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755680384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TekrMj8YqLsXW/ii7fPsdIK3cB/WSLwOD4+phsySGeM=;
 b=JRSJaWN0d6vt5UFi3uOkyPTm+L8Jm7fjQ4gZl40cyiowxakS3ZQe4K4YwEyCGx4WiexI09
 xHuliuNbdDVeBfxpLs3wz2G3AwFrvxqBUOduvRR6TKYBOJqzYxUBF8l6SRo1uscSzHM8dd
 T7buAyOhvKYQoTjKAIM7oyBTmdIPmfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755680384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TekrMj8YqLsXW/ii7fPsdIK3cB/WSLwOD4+phsySGeM=;
 b=hDPU8KvGvcX75f/u7eOcVktiLA6/iU/tooXodn3IHXjRjleZukas8rEzZkntFE5MSW992t
 AzNR5HE2WVUiypDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755680384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TekrMj8YqLsXW/ii7fPsdIK3cB/WSLwOD4+phsySGeM=;
 b=JRSJaWN0d6vt5UFi3uOkyPTm+L8Jm7fjQ4gZl40cyiowxakS3ZQe4K4YwEyCGx4WiexI09
 xHuliuNbdDVeBfxpLs3wz2G3AwFrvxqBUOduvRR6TKYBOJqzYxUBF8l6SRo1uscSzHM8dd
 T7buAyOhvKYQoTjKAIM7oyBTmdIPmfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755680384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TekrMj8YqLsXW/ii7fPsdIK3cB/WSLwOD4+phsySGeM=;
 b=hDPU8KvGvcX75f/u7eOcVktiLA6/iU/tooXodn3IHXjRjleZukas8rEzZkntFE5MSW992t
 AzNR5HE2WVUiypDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57AE61368B;
 Wed, 20 Aug 2025 08:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fsA5FYCOpWgHdQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 20 Aug 2025 08:59:44 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Aug 2025 10:59:35 +0200
Message-ID: <20250820085937.50868-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Makefile: Fix module dirs search
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

Module dirs search runs relative to current working directory instead
of the source directory. In an out-of-tree build, the search for makefiles
will come up empty and grep will try to read from standard input, blocking
indefinitely. Search for makefiles relative to the source directory to fix
the issue.

Fixes: e3e1fa0e78 ("Makefile: Add kernel modules related make targets")
Signed-off-by: Martin Doucha <mdoucha@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---

Changes since v1: Removed $(abs_srcdir) from module targets because now it's
already included in $(dir)

 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 77270bc7c..d47b2528e 100644
--- a/Makefile
+++ b/Makefile
@@ -213,24 +213,24 @@ test-metadata: metadata-all
 	$(MAKE) -C $(abs_srcdir)/metadata test
 
 MODULE_DIRS :=  $(shell \
-	dirname $$(grep -l 'include.*module\.mk' $$(find testcases/ -type f -name 'Makefile')))
+	dirname $$(grep -l 'include.*module\.mk' $$(find $(abs_srcdir)/testcases/ -type f -name 'Makefile')))
 
 
 .PHONY: modules modules-clean modules-install
 modules:
 	@$(foreach dir,$(MODULE_DIRS),\
 		echo "Build $(dir)";\
-		$(MAKE) -C $(abs_srcdir)/$(dir) || exit $$?; \
+		$(MAKE) -C $(dir) || exit $$?; \
 )
 modules-clean:
 	@$(foreach dir,$(MODULE_DIRS),\
 		echo "Build $(dir)";\
-		$(MAKE) -C $(abs_srcdir)/$(dir) clean || exit $$?; \
+		$(MAKE) -C $(dir) clean || exit $$?; \
 )
 modules-install: modules
 	@$(foreach dir,$(MODULE_DIRS),\
 		echo "Build $(dir)";\
-		$(MAKE) -C $(abs_srcdir)/$(dir) install || exit $$?; \
+		$(MAKE) -C $(dir) install || exit $$?; \
 )
 
 ## Help
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
