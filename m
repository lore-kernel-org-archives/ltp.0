Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7F0C55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 09:50:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2572A3E2D40
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 11:50:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E3AA3E01E7
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:49:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9B576200B36
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:49:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 76CCC7FD4D;
 Wed,  5 Aug 2026 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785923384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bapSFWOfv1N61bSo14lQ5JViIoCHTKr5JJUzOE07gus=;
 b=NwJ+V2QKBkuKZ/I8GWhtnGmlXl9kBDIiVfvdEcwxSDyix8UZ9zibURDCBEpA8CgZgy7TEP
 H0nBCXhI52rsPp//caayiUDwI/ZgwRQRrLq9XQdCZ5TAyRI0jkj3ewsHV38G5R9JrcMreG
 90veauOeU/JnGfYMjLHkxzVxqethCtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785923384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bapSFWOfv1N61bSo14lQ5JViIoCHTKr5JJUzOE07gus=;
 b=gK+18mr6ZeAzPM7VTOwVGBW09YxAP5ndhtWBHHkWKgepT2ojlXRiONN/73RZiBgrkrMZjT
 /5tB6yAPK51zvZBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785923380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bapSFWOfv1N61bSo14lQ5JViIoCHTKr5JJUzOE07gus=;
 b=n82dwxPfyopc9l59sytnwis3IxmEAbgh/mild+AC1eqsopAhmGN1w4zjmJPykV0Fa5Mfgq
 cnEVUisYZv6h9Es0Hlp8EPSqZhcrEkEk98hz/ohZDU9odweSAfMGWLT5YN0OJ2zoynExdX
 pcJWnRfkIVmj82cMW86ZNetUjEp5BPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785923380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bapSFWOfv1N61bSo14lQ5JViIoCHTKr5JJUzOE07gus=;
 b=1VNCNOsV3MPLHaU9L6vnRVqlDZ6K723qVYhVJS5rvPPZ90IZtfP1s/+eQcwG5sP3SvgQhh
 oS/LP0MekQL0Y0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35BC1779EB;
 Wed,  5 Aug 2026 09:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kB4sDDQHc2rvSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 09:49:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 11:49:34 +0200
Message-ID: <20260805094935.448896-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805094935.448896-1-pvorel@suse.cz>
References: <20260805094935.448896-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] doc: Update linuxdoc, sphinxcontrib-spelling
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

Update to the latest versions:
* linuxdoc: 20240924 => 20260504 (allowed to remove workaround
  installing setuptools==81.0.0, required previous commit to not run
  sphinx -v by default otherwise there would be too many kernel-doc INFO
  messages)
* sphinxcontrib-spelling: 7.7.0 => 8.0.2

Removing setuptools==81.0.0 dependency fixes CVE-2026-59890 (score 6.1).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/requirements.txt | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/doc/requirements.txt b/doc/requirements.txt
index f04676c7bd..ac5b43e415 100644
--- a/doc/requirements.txt
+++ b/doc/requirements.txt
@@ -3,8 +3,5 @@
 sphinx==8.2.3
 sphinx-rtd-theme==3.1.0
 
-linuxdoc==20240924
-sphinxcontrib-spelling==7.7.0
-
-# workaround for linuxdoc <= 20240924
-setuptools==81.0.0
+linuxdoc==20260504
+sphinxcontrib-spelling==8.0.2
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
