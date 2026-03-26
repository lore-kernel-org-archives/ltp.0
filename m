Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C43C10A88E7
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 17:04:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 867D33C0206
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 18:04:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7E2A3C0206
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 18:04:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 346C620026A
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 18:04:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7AC7E4D490;
 Thu, 26 Mar 2026 17:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774544677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KVlVEJNBUefniKav2SONBJ1TKvbhiEOFbMUxLi21yXs=;
 b=MKB5gsVRaUdTHpKggpBrIDRxxODL6vo8M3JBZKj4tS+joi+bg6MM+6JKMyM2Lq+iDJ+ch/
 +i4d0pt+WYwAVZZUoJqFD7wVlvohiw+nhqpBl84qguqhuuKRzfTzgmqAs55VM4MaKILA+F
 cQQqHNLZhNCAbV09hao6KfO9lwCNhQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774544677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KVlVEJNBUefniKav2SONBJ1TKvbhiEOFbMUxLi21yXs=;
 b=tHUZAoFzD/pdsZcdoiY6nN0610X7pAkmLPQvL9MTP7XzkAzBU8grpPyLMWsuGd1c9ZS4tM
 0PbnpcX0fJRghjAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MKB5gsVR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tHUZAoFz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774544677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KVlVEJNBUefniKav2SONBJ1TKvbhiEOFbMUxLi21yXs=;
 b=MKB5gsVRaUdTHpKggpBrIDRxxODL6vo8M3JBZKj4tS+joi+bg6MM+6JKMyM2Lq+iDJ+ch/
 +i4d0pt+WYwAVZZUoJqFD7wVlvohiw+nhqpBl84qguqhuuKRzfTzgmqAs55VM4MaKILA+F
 cQQqHNLZhNCAbV09hao6KfO9lwCNhQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774544677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KVlVEJNBUefniKav2SONBJ1TKvbhiEOFbMUxLi21yXs=;
 b=tHUZAoFzD/pdsZcdoiY6nN0610X7pAkmLPQvL9MTP7XzkAzBU8grpPyLMWsuGd1c9ZS4tM
 0PbnpcX0fJRghjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46E2E4A0A3;
 Thu, 26 Mar 2026 17:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qRm7DyVnxWnqTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 26 Mar 2026 17:04:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Mar 2026 18:04:32 +0100
Message-ID: <20260326170435.22566-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 7AC7E4D490
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] lib: LTP_DEBUG cleanup
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

Changes v1->v2:
* 2 more commits (first commit is the same, I'm sorry for the noise)

Petr Vorel (3):
  lib: Ignore empty LTP_ENABLE_DEBUG
  lib: Rename variable LTP_ENABLE_DEBUG => LTP_DEBUG
  lib: Prefer LTP_DEBUG over -D

 doc/developers/debugging.rst     |  2 +-
 doc/old/C-Test-API.asciidoc      |  2 +-
 doc/users/setup_tests.rst        |  4 ++--
 lib/newlib_tests/tst_res_flags.c |  2 +-
 lib/tst_test.c                   | 34 +++++++++++++++++---------------
 5 files changed, 23 insertions(+), 21 deletions(-)

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
