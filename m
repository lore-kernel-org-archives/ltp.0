Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CDEC53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 09:58:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAE543E4B5D
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 11:58:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F0E43E4A7C
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:57:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8250D6002DB
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:57:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 95FBE7C9C6;
 Wed, 29 Jul 2026 09:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785319071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3N15KOxFqiNQYBw75vDnnXKPQJldg9LouwL/0YaU004=;
 b=wLfI8g5+kAPCK1mkqgkU84EqIpKwS+/Tecno/m7tK6KGSKsV+ACtOZK61Iyg3rZmllL+fT
 dsZKnbJuaCMJUd6ztM9JSDYjluNYKgHTy3W7Gidr8bRipfzmrN1na+Ue2CazzE8Ytc0qfN
 LTN6f2SEN6GD22BVdI2/rkLayVFSZtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785319071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3N15KOxFqiNQYBw75vDnnXKPQJldg9LouwL/0YaU004=;
 b=XoGIw1o78BNSH3Bci77XcmXtdamI3dmNuwwNSyb+nvpWAqtGkLZu3JjrXv78vSbPn4+fGz
 vk0p9VrmnyHLhSAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VDyUM1OP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nYomS6pO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785319067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3N15KOxFqiNQYBw75vDnnXKPQJldg9LouwL/0YaU004=;
 b=VDyUM1OP8DQsUAGTxVN24BfPVirSoxypCjnN76E7KZTKHS615DugjRJswGuH1SMV9f6LNg
 l6o74Kqlf50l4NXebjR/rBvrKFChUt+zSU+15BqaUW8/bzVxTJXqH3gXi7CGoCiladQmFR
 WbIAz9Yhp6N4uSDa9Kk5BWZyT2n6OeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785319067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3N15KOxFqiNQYBw75vDnnXKPQJldg9LouwL/0YaU004=;
 b=nYomS6pOZkH6qOqKkrtt+O5bLUMalxg7iaR/QGhhdJYpyJXL9rYqaf8dB5L38xTSV7Wus5
 bvKi4+2NHJlmxDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70255779B1;
 Wed, 29 Jul 2026 09:57:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pTR3GpvOaWrTJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Jul 2026 09:57:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 11:57:25 +0200
Message-ID: <20260729095730.29185-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 95FBE7C9C6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/5] Add support for .max_kver
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
* Fixed version 6.11 => 6.10 (execve04, creat07)
* Fixed version 7.2 => 7.1 (fanotify20)

Link to v1:
https://lore.kernel.org/ltp/20260729091717.23042-1-pvorel@suse.cz/T/#t
https://patchwork.ozlabs.org/project/ltp/list/?series=516120&state=*

More changes needed => v2. I'm sorry for the noise.

Petr Vorel (5):
  lib: Rename function check_kver() => check_min_kver()
  lib: Add support for max_kver to struct tst_test and tst_fs
  execve04: Use .max_kver
  creat07: Use .max_kver
  fanotify20: Skip on v7.2

 include/tst_test.h                            |  9 +++-
 lib/tst_test.c                                | 49 +++++++++++++++++--
 testcases/kernel/syscalls/creat/creat07.c     | 14 ++----
 testcases/kernel/syscalls/execve/execve04.c   | 14 ++----
 .../kernel/syscalls/fanotify/fanotify20.c     |  4 ++
 5 files changed, 64 insertions(+), 26 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
