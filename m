Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B334C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 20:47:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C69703CE75C
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:47:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 419683C810A
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D31B11A0064F
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 583A221E20;
 Thu,  4 Jan 2024 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OrG/6xRUPcYpF1gnMoiUPrx8m24IzFmbhb4yuY1ceHk=;
 b=KfWqEg++rQLBqAgTkYPLJIoAkKNiHup7GM4talzhMz35dqnvhKM8Ky6tJd3Rg4FA0Evqnc
 FAWBeJ9RQW3Th9U7V4c750WlqNrTxJsnFyU0Mt2ulzAhn8R2J34eb+MD+iILRHjj6oSdl1
 6vfxONdeJ2HdT9UnhW75AxVydLjHtDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401182;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OrG/6xRUPcYpF1gnMoiUPrx8m24IzFmbhb4yuY1ceHk=;
 b=7uTCYYbXEdovdIfnuzLQNrTzqV9W706ACNZOhTiO9q7vTU/hjWAxSjHYGGqxLG8nqUI1XW
 jopvKbeCe5cG18Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OrG/6xRUPcYpF1gnMoiUPrx8m24IzFmbhb4yuY1ceHk=;
 b=KfWqEg++rQLBqAgTkYPLJIoAkKNiHup7GM4talzhMz35dqnvhKM8Ky6tJd3Rg4FA0Evqnc
 FAWBeJ9RQW3Th9U7V4c750WlqNrTxJsnFyU0Mt2ulzAhn8R2J34eb+MD+iILRHjj6oSdl1
 6vfxONdeJ2HdT9UnhW75AxVydLjHtDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401182;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OrG/6xRUPcYpF1gnMoiUPrx8m24IzFmbhb4yuY1ceHk=;
 b=7uTCYYbXEdovdIfnuzLQNrTzqV9W706ACNZOhTiO9q7vTU/hjWAxSjHYGGqxLG8nqUI1XW
 jopvKbeCe5cG18Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32912137E8;
 Thu,  4 Jan 2024 20:46:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OBCkCR4Zl2WsIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 20:46:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 21:46:13 +0100
Message-ID: <20240104204614.1426027-9-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104204614.1426027-1-pvorel@suse.cz>
References: <20240104204614.1426027-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KfWqEg++;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7uTCYYbX
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.53 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-1.96)[94.82%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 583A221E20
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 8/9] ci/debian: Allow to install packages only for
 docparse
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

Will be used in next commit.

NOTE: Add libwww-perl as explicit dependency (pulled by Debian, but not
by current Ubuntu).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ci/debian.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/ci/debian.sh b/ci/debian.sh
index 96b55a35b..1002bf17a 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -1,6 +1,6 @@
 #!/bin/sh -eux
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018-2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
 
 # workaround for missing oldstable-updates repository
 # W: Failed to fetch http://deb.debian.org/debian/dists/oldstable-updates/main/binary-amd64/Packages
@@ -13,6 +13,20 @@ export DEBIAN_FRONTEND="noninteractive"
 
 apt="apt install -y --no-install-recommends"
 
+# see .github/workflows/metadata.yml
+if [ "${PACKAGES_FOR_DOCPARSE_ONLY:-}" ]; then
+	$apt \
+		asciidoctor \
+		autoconf \
+		automake \
+		gcc \
+		libjson-perl \
+		libwww-perl \
+		ruby-asciidoctor-pdf
+
+	return 0
+fi
+
 $apt \
 	acl-dev \
 	asciidoc \
@@ -35,6 +49,7 @@ $apt \
 	libc6 \
 	libc6-dev \
 	libjson-perl \
+	libwww-perl \
 	libkeyutils-dev \
 	libkeyutils1 \
 	libmnl-dev \
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
