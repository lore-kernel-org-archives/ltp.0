Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FFCCA5FFC
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 14:01:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 367133E9C81
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 16:01:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EB0B3CD600
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 16:00:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 404B210009BA
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 16:00:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E7F4B21BBA;
 Wed,  7 Oct 2026 14:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791381650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Y2nmYzI8pVOyus6HTl43GIwN9r5AjP6ROKC9GeP1lo=;
 b=uYOMfClE6gM0Nb7a61VPSPtDOWeoJnCWNYXlbr1CrckGYAvu7AogoQgcPkoqlHDicgRBzc
 GmllwgmiA8J5t+XnGRX4S4xamIa5fs7NMR9DWVzn/jMuXiYgHNsXY6mUert8aJf9mH1vgi
 SDtmf2YhfsKENbyHxgYU8311tZCHvyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791381650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Y2nmYzI8pVOyus6HTl43GIwN9r5AjP6ROKC9GeP1lo=;
 b=D0pYOr9mMel4Xynh+pB9kCQ+p/U8UXjKL4QCUKoOj/m+qh2pweCRx9ueTXBHGF+ANfRikx
 oc6O55O0M3687QAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VWMsMX25;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BeT3gQQW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791381648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Y2nmYzI8pVOyus6HTl43GIwN9r5AjP6ROKC9GeP1lo=;
 b=VWMsMX25IEEgPa3d2nyOg5zVK59eTj1G3lkvKzJVDn2R87D8Jbm71pWTfY95aJruU9HN88
 diIvpQ5/DaJhsHrS7pVqlyQZ2DZ5ZygQSOcA2PVcsqzI5Iq4Qf9WQaDcXs27DKaJ1g6g3+
 4N5+AMsa6ATftA3niKVo6wNGZWQgslo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791381648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Y2nmYzI8pVOyus6HTl43GIwN9r5AjP6ROKC9GeP1lo=;
 b=BeT3gQQWtkzzrHWYrQXjqFZM1xztTk4MDz1s02n47rHUfClpjJvi1hIpTlPiSVYLwlyBtT
 Kzj6d4scl9Vl4VCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA0C5139AC;
 Wed,  7 Oct 2026 14:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cP34H5BQxmqSLgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 07 Oct 2026 14:00:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 07 Oct 2026 16:00:44 +0200
Message-Id: <20261007-fix_leftovers-v1-0-63a1e7acd0e6@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIxQxmoC/yXMUQqDMBCE4avIPhvYRGjBq4iIiRO7pWjJqgji3
 U3r4wcz/0GKJFCqi4MSNlGZpwxbFhRe/TTCyJBNjt3DMj9NlL37IC7zhqSm8tEFcLS9Zcqfb0I
 e/HtNe1tX/0ZYfhE6zwuFY//JcQAAAA==
X-Change-ID: 20261007-fix_leftovers-3bf2ce0f1a10
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791381648; l=1985;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=FpzkjRjkcRseOcVqMVnEZWkJVmnbUWJhQvPheU353Xk=;
 b=vKtvAY2KM+UKzJ4eRZc+5C5QJq1Q4InZT0f4Fcrt7tKreFKMU232pxQzH/MfLa4StIvp5gDO3
 yQPLOWGoxGLDxfLTKAwGL9czQTQS3Hv2eBSizOaWCm0CgsEtz2Fgy6l
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E7F4B21BBA
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Clean up various repository leftovers
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

This series cleans up several leftover files, declarations, and ignore
rules that remained after earlier refactorings, API conversions, and
test removals:

1. Remove unused common_sparse.h header from
   testcases/kernel/io/ltp-aiodio. The header has been dead code since
   aiodio_sparse and dio_sparse were refactored to the new LTP API.
2. Remove .needs_checkpoints = 1 from tests that do not use checkpoints.
   This avoids unnecessary initialization of checkpoint IPC resources.
3. Remove stale .gitignore entries across the tree for test binaries that
   have been removed or merged.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (3):
      ltp-aiodio: Remove unused common_sparse.h
      tree: Remove needs_checkpoints leftovers
      tree: Remove stale .gitignore entries

 lib/newlib_tests/.gitignore                        |   1 -
 testcases/commands/.gitignore                      |   1 -
 testcases/cve/cve-2015-3290.c                      |   1 -
 testcases/kernel/containers/sysvipc/shmnstest.c    |   1 -
 testcases/kernel/containers/utsname/utsname04.c    |   1 -
 testcases/kernel/io/ltp-aiodio/common_sparse.h     | 129 ---------------------
 .../kernel/syscalls/exit_group/exit_group01.c      |   1 -
 testcases/kernel/syscalls/getitimer/.gitignore     |   1 -
 .../syscalls/set_mempolicy/set_mempolicy01.c       |   1 -
 .../syscalls/set_mempolicy/set_mempolicy02.c       |   1 -
 .../syscalls/set_mempolicy/set_mempolicy03.c       |   1 -
 .../syscalls/set_mempolicy/set_mempolicy04.c       |   1 -
 testcases/kernel/syscalls/syslog/.gitignore        |   1 -
 testcases/kernel/uevents/uevent03.c                |   1 -
 testcases/network/.gitignore                       |   3 -
 15 files changed, 145 deletions(-)
---
base-commit: 78e6353fdff663b2fc2f77704ceec6c3ca786b96
change-id: 20261007-fix_leftovers-3bf2ce0f1a10

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
