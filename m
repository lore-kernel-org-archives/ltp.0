Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A09C369D3
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 15:31:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 487DF3CB960
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 17:31:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 086F63CB903
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 17:30:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4FDB120017B
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 17:30:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B06A1F394;
 Fri, 25 Apr 2025 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745595049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=e8YsMv/Txv3aHKWv/Agg5s8b9R/Bt3tU9G30SKvW24c=;
 b=ME7CpQvE22G/8L8/LRGodPi+IPq29lx5FC/TKQCLHwZsRe4e1/5MRuGbxmfh42c4fRq7FD
 Dn7MDCegYW+Ql06UN5h08aeFugN1UFEla6EeBAECIZzn3pvroUEuFZdcqbO1e3ZcmcN4OZ
 FFWyZU+6MdUy6qbQWIufJQcCIRVr354=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745595049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=e8YsMv/Txv3aHKWv/Agg5s8b9R/Bt3tU9G30SKvW24c=;
 b=uwt9SuZsP8ViD3O//BpQpgsG2KIySqpzopJbHiji4hNURJqls5NUfUB4PXUxoilQCQF1Tc
 hnuGl5VzyUY7gQBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745595049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=e8YsMv/Txv3aHKWv/Agg5s8b9R/Bt3tU9G30SKvW24c=;
 b=ME7CpQvE22G/8L8/LRGodPi+IPq29lx5FC/TKQCLHwZsRe4e1/5MRuGbxmfh42c4fRq7FD
 Dn7MDCegYW+Ql06UN5h08aeFugN1UFEla6EeBAECIZzn3pvroUEuFZdcqbO1e3ZcmcN4OZ
 FFWyZU+6MdUy6qbQWIufJQcCIRVr354=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745595049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=e8YsMv/Txv3aHKWv/Agg5s8b9R/Bt3tU9G30SKvW24c=;
 b=uwt9SuZsP8ViD3O//BpQpgsG2KIySqpzopJbHiji4hNURJqls5NUfUB4PXUxoilQCQF1Tc
 hnuGl5VzyUY7gQBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 047351388F;
 Fri, 25 Apr 2025 15:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wwt0O6iqC2gSdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Apr 2025 15:30:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 25 Apr 2025 17:30:41 +0200
Message-ID: <20250425153046.63853-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,ozlabs.org:url,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] Workaround broken openSUSE repositories
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

Hi,

patchwork.sh tested manually - see the last "ltpci/opensuse-leap_latest"
line in:
https://patchwork.ozlabs.org/project/ltp/patch/20250425125057.38992-1-pvorel@suse.cz/

Kind regards,
Petr

Petr Vorel (4):
  ci: patchwork.sh: Add check for number of parameters
  ci: patchwork.sh: Add optional 5th parameter
  ci/tumbleweed.sh: Retry on broken repos
  ci: Skip openSUSE builds on broken repositories

 .github/workflows/ci-docker-build.yml | 10 +++-
 ci/tools/patchwork.sh                 | 24 ++++++++--
 ci/tumbleweed.sh                      | 67 ++++++++++++++++-----------
 3 files changed, 71 insertions(+), 30 deletions(-)

-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
