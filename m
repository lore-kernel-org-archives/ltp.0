Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43543C9830E
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 11:26:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FE7D3E6579
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 13:26:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1353E3E65CB
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:25:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7F42710000CD
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:25:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C2BC21EF0;
 Thu, 24 Sep 2026 11:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790249120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=P3gdzDwyJKG7+zVyMXrdtxLPLLkgM2u/9PBiRSdJ3T0=;
 b=ATra1lFM8HvTR6zLWCC7tP1DA0Q4egu4/jqwUznf0DqlHC7m8Di8OTAYmLH+OuZ9jn2VuS
 8u63nUzAVI/wDUUFd9p+K7prhl+AR/RmP2239SJlT4DFWZs8sbz+v883AT/iWJipvD7xKH
 rqyv86EopFf+ajUbow2atu+K3L3Bmk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790249120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=P3gdzDwyJKG7+zVyMXrdtxLPLLkgM2u/9PBiRSdJ3T0=;
 b=ANzWrPfrLMQwZui4xyyVT0KcTrXpwMs+F0C/bLp01kJL24lqI6oBchMVgw3QK5aGLbA9rO
 xuJc8B0aYsBTpUAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790249116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=P3gdzDwyJKG7+zVyMXrdtxLPLLkgM2u/9PBiRSdJ3T0=;
 b=Wafp79cltoDpueKspN9zbcspLh3iwcYT3dLePOPMQMEocPVV2+BknbB7VEa570Qc1liIyc
 OLLfOyhXR2UFSgVLdFG3NwJOTS2nu2MOtDSEPInHQAsbyUnOjLUIWH6lSIU63KZjIBp6h+
 o7l8gNtshXYPcd5A0b9f9r8rjyDrU0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790249116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=P3gdzDwyJKG7+zVyMXrdtxLPLLkgM2u/9PBiRSdJ3T0=;
 b=UlK3RvFmcApuvDPL1PL2zCZDHahk0djKSCVvFt3IvWMs7pB4On8v7ZT4v9oVJogTsOo4yu
 cVHbem48Cx6SJrAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 116AF13668;
 Thu, 24 Sep 2026 11:25:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y/X9L5sItWoLIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 24 Sep 2026 11:25:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 24 Sep 2026 13:25:11 +0200
Message-ID: <20260924112514.2375626-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.995];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] shmctl03: Fix shmmax clamped to INT_MAX in
 32bit compat mode
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

1st and 2nd commit are pre-release fixes.
NOTE: 3rd commit can be postponed after the release.

Changes v1->v2:
* PATH_KERN_SHMMAX >= INT_MAX check (Cyril)
* General test cleanup in the 3rd commit

Link to v2:
https://patchwork.kernel.org/project/ltp/list/?series=1168638&state=*
https://lore.kernel.org/ltp/20260918125021.1939455-1-pvorel@suse.cz/T/#t

Kind regards,
Petr

Andrea Cervesato (2):
  tst_assert: Use 'long long' to fix 32bit compat mode truncation
  shmctl03: Fix shmmax clamped to INT_MAX in 32bit compat mode

Petr Vorel (1):
  shmctl03: Use safe_shmctl(), TST_EXP_LE_LU()

 lib/tst_assert.c                            |  9 ++++----
 testcases/kernel/syscalls/shmctl/shmctl03.c | 24 ++++++++++-----------
 2 files changed, 16 insertions(+), 17 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
