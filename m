Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD281C021A1
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 23:36:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B52A3C9991
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 00:36:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F36F3C998B
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 00:36:06 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2AE28677848
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 00:36:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F0F541F7B9;
 Tue, 11 Feb 2025 23:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739316964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osh66FPjaPi5jF7m40aZAG4uMka4V/4WKj2vI/0rsVs=;
 b=r7sxVddBMwqR3JYuay+D25850G5jt4RIDS4xjIKrZs0d7jFidfGcC1i+esS+KlWaHAFBjf
 N2gus803ZdKmnqxmEwSquPhG4Ci/MnhtAAT8Bd801F1o+IT6VaIzC+Z6SkjPg/HXfysUxC
 7xNJau/SfmFsfQEWb3cD1UcUvQqOONk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739316964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osh66FPjaPi5jF7m40aZAG4uMka4V/4WKj2vI/0rsVs=;
 b=afJm9jbHp5Xkqb4qfwydw8nmjO9IuhB4xr18EuvSz2BnsbbLgOwIrz/S/pugclYahSJ2nd
 gJlcgvkJDCaM9iBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739316963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osh66FPjaPi5jF7m40aZAG4uMka4V/4WKj2vI/0rsVs=;
 b=UHy8O6FOAu1ROrWuhDACB8gjYQ5NVSFtdJVi55eFCwazy1YkXdyVeZ97Ok50xtKHasXAV6
 XUnl42hS+GJ72t+si/FiAp1gd8mAUXcV6j2qE0BtGVnYfHIf6EDCv1+lPIWzIFzFyoV0Ct
 Peb7gUKF99R7JCTwfKe5VBysgiCPnwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739316963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osh66FPjaPi5jF7m40aZAG4uMka4V/4WKj2vI/0rsVs=;
 b=xpdrU37WTGoY5AhoOF4b4x7V4iclcHB4MMqs1xBnEGVvm9q1G7SSPMxhC8fRk19XHRaaYD
 LAyxbbIumhoqr4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEF6A13AA6;
 Tue, 11 Feb 2025 23:36:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kK+wLePeq2fPdgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Feb 2025 23:36:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 12 Feb 2025 00:35:52 +0100
Message-ID: <20250211233552.1990618-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211233552.1990618-1-pvorel@suse.cz>
References: <20250211233552.1990618-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] Makefile: Update 'doc' target to build sphinx
 doc
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

'doc' target previously run docparse documentation. Point it to doc/
directory so that it build sphinx docs.

NOTE: Until docparse is removed it's also being build because its build
is triggered by metadata dependency.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2.

This was supposed to be part of 'Remove asciidoc{,tor} doc' patchset,
but it can be merged even before.
https://patchwork.ozlabs.org/project/ltp/list/?series=443287&state=*

Kind regards,
Petr

 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 5066789349..760c897c25 100644
--- a/Makefile
+++ b/Makefile
@@ -170,7 +170,9 @@ INSTALL_TARGETS		+= $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))
 $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
 
 .PHONY: doc
+
 doc: metadata-all
+	$(MAKE) -C $(abs_builddir)/doc
 
 .PHONY: check
 check: $(CHECK_TARGETS)
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
