Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D06C27C5F
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 14:12:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 077663D0AAC
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 16:12:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 541D73D0A85
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 16:11:37 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9A5DA14098C0
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 16:11:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 645C01FBA0;
 Fri,  7 Jun 2024 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717769495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T168AVDCxYbMVgzTx0LSyLOVz37jSXadMemqv2EzzYQ=;
 b=H6QXEiGoDgJ/3D+Yqw/84kqYYG1+baafb/OorPmhCuQHXCmlYkDgd5CmeHLRo5Pp2TIIBw
 NlGwKYNfrCCQWIz3h6YxSHS1EZe0ReaspmXQhkchJvs6ethJEMWZA5CQNt8t308kkwA5li
 hHEaXkTb/t8nGqhy7+d6H/yfXz6DHDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717769495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T168AVDCxYbMVgzTx0LSyLOVz37jSXadMemqv2EzzYQ=;
 b=SRVPQw8fJoulyr0H0KLK/16ruKb6Pp/K/V3tyHRzW0lINafF7Cuu2gXQ1L+BW9Oh1f81e9
 Ro+KKfR5ovqZPVBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717769495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T168AVDCxYbMVgzTx0LSyLOVz37jSXadMemqv2EzzYQ=;
 b=H6QXEiGoDgJ/3D+Yqw/84kqYYG1+baafb/OorPmhCuQHXCmlYkDgd5CmeHLRo5Pp2TIIBw
 NlGwKYNfrCCQWIz3h6YxSHS1EZe0ReaspmXQhkchJvs6ethJEMWZA5CQNt8t308kkwA5li
 hHEaXkTb/t8nGqhy7+d6H/yfXz6DHDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717769495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T168AVDCxYbMVgzTx0LSyLOVz37jSXadMemqv2EzzYQ=;
 b=SRVPQw8fJoulyr0H0KLK/16ruKb6Pp/K/V3tyHRzW0lINafF7Cuu2gXQ1L+BW9Oh1f81e9
 Ro+KKfR5ovqZPVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C7D5133F3;
 Fri,  7 Jun 2024 14:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HAkrCRcVY2b3AwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jun 2024 14:11:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Jun 2024 16:11:27 +0200
Message-ID: <20240607141131.111470-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] doc: Add hyperlinks
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

*** BLURB HERE ***

Petr Vorel (2):
  doc: Link API pages, rename title
  doc: Remove part of old GitHub doc

 doc/conf.py                                   |    1 +
 doc/developers/api_c_tests.rst                |    4 +-
 doc/developers/api_shell_tests.rst            |    4 +-
 doc/developers/ltp_library.rst                |    5 +-
 doc/maintainers/patch_review.rst              |   10 +-
 doc/old/Build-System.asciidoc                 |  218 ----
 doc/old/C-Test-Case-Tutorial.asciidoc         | 1079 -----------------
 doc/old/Contact-Info.asciidoc                 |   28 -
 ...TP-Library-API-Writing-Guidelines.asciidoc |   84 --
 doc/old/LTP-Release-Procedure.asciidoc        |  171 ---
 ...Maintainer-Patch-Review-Checklist.asciidoc |  139 ---
 ...-kernel,-libc,-toolchain-versions.asciidoc |   77 --
 doc/old/Test-Writing-Guidelines.asciidoc      |  430 -------
 doc/old/User-Guidelines.asciidoc              |   73 --
 doc/old/rules.tsv                             |    6 -
 15 files changed, 13 insertions(+), 2316 deletions(-)
 delete mode 100644 doc/old/Build-System.asciidoc
 delete mode 100644 doc/old/C-Test-Case-Tutorial.asciidoc
 delete mode 100644 doc/old/Contact-Info.asciidoc
 delete mode 100644 doc/old/LTP-Library-API-Writing-Guidelines.asciidoc
 delete mode 100644 doc/old/LTP-Release-Procedure.asciidoc
 delete mode 100644 doc/old/Maintainer-Patch-Review-Checklist.asciidoc
 delete mode 100644 doc/old/Supported-kernel,-libc,-toolchain-versions.asciidoc
 delete mode 100644 doc/old/Test-Writing-Guidelines.asciidoc
 delete mode 100644 doc/old/User-Guidelines.asciidoc
 delete mode 100644 doc/old/rules.tsv

-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
