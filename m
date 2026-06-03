Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F790CD6E64
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 09:57:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D75133E619B
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 11:56:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7044B3CD509
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:56:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9EC60600219
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:56:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EE0F6728B;
 Wed,  3 Jun 2026 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780480581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=++UocZ4D5UmH95sDKOSR6NgumKAm2mYOHMjdmZk1wZc=;
 b=bNrOZvtGrbgCp1asvEYLCcGsfpVOKInYe0nZSEzYQYpBOPwxvxQh3921N3b2ah9daUugh2
 MxzTJVBYtmt52Y5cIkLYg8DQf9+ATgypfjxxS+Nlwird/SfF2NFN8rFDWT1vLvZSviT2W9
 6u1hefp0oEpKUC6OsVJ15nJRuaoH1Ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780480581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=++UocZ4D5UmH95sDKOSR6NgumKAm2mYOHMjdmZk1wZc=;
 b=4jPGzJTLoZVlkOobz6SSZ23+M7BSeBWx5L+uYUoWtirRXm/xc4jWFvTztElvy+t/bJYa8a
 cZGVNTVDSBb6u+Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bNrOZvtG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4jPGzJTL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780480581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=++UocZ4D5UmH95sDKOSR6NgumKAm2mYOHMjdmZk1wZc=;
 b=bNrOZvtGrbgCp1asvEYLCcGsfpVOKInYe0nZSEzYQYpBOPwxvxQh3921N3b2ah9daUugh2
 MxzTJVBYtmt52Y5cIkLYg8DQf9+ATgypfjxxS+Nlwird/SfF2NFN8rFDWT1vLvZSviT2W9
 6u1hefp0oEpKUC6OsVJ15nJRuaoH1Ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780480581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=++UocZ4D5UmH95sDKOSR6NgumKAm2mYOHMjdmZk1wZc=;
 b=4jPGzJTLoZVlkOobz6SSZ23+M7BSeBWx5L+uYUoWtirRXm/xc4jWFvTztElvy+t/bJYa8a
 cZGVNTVDSBb6u+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E40B75A4DA;
 Wed,  3 Jun 2026 09:56:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6YMbNkT6H2pycgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 03 Jun 2026 09:56:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 03 Jun 2026 11:56:19 +0200
Message-Id: <20260603-doc_add_missing_headers-v4-0-1fe3a372c155@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEP6H2oC/43OSwrCMBCA4auUrI3k0acr7yFSQmbSZtFWMhqU0
 rubdlUE0eU/MN/MzAiDR2KnbGYBoyc/jSnyQ8Zsb8YOuYfUTAlVilJIDpNtDUA7eCI/dm2PBjA
 Qt6aQ0NSglbEsbd8COv/c5Ms1de/pPoXXdijKdfrbjJILXjqJqGWTF+DO9CA82mlgKxnVnlHfG
 ZWYxtr0Xm1Fo+GD0X8yOjF5lQM6V1WgzI5ZluUNaQGuYksBAAA=
X-Change-ID: 20260601-doc_add_missing_headers-ca51d98d32ac
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780480580; l=2767;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=6zGXq6nwtwKLr6XjaDVwG4PvR2s/MxvtCMXzomxfI+M=;
 b=C4ih5R4M/4NFQNcv8aLz4pj1fY/CqEV6JSzg3T7dM9IAcmKyymMPJoiKrAq5lvqBkV5Nul8zr
 j2dbgHWA40xC3kqFQcrpVvNZl1T3tMXrDTGdjpZNGc/xxIuqVL9dkuW
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0EE0F6728B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/3] Complete the documentation adding missing
 headers
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

This conversion and fix has been done with Claude Code.
Complete this review before adding these changes:

https://patchwork.ozlabs.org/project/ltp/list/?series=506891

- add missing headers
- convert documentation from doxygen to kernel-doc
- add SAFE_* macro section

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- fix build errors
- Link to v3: https://lore.kernel.org/r/20260602-doc_add_missing_headers-v3-0-474deff77d2a@suse.com

Changes in v3:
- PATCH 3: add the missing blank line between tst_mount_has_opt() and
  the tst_is_mounted() kernel-doc block in tst_device.h
- PATCH 3: restore the "Requires <string.h>" note (for strlen()) in the
  TST_KCONFIG_INIT() kernel-doc comment in tst_kconfig.h
- Link to v2: https://lore.kernel.org/r/20260602-doc_add_missing_headers-v2-0-9ccd988c093d@suse.com

Changes in v2:
- PATCH 1: drop the incorrect claim about fixing the tse_numa.h
  kernel-doc reference (it was already correct) and correct the header
  count from 12 to 10 (tse_numa.h and tse_swap.h were already present)
- PATCH 1: remove leftover Doxygen directives (@param, @return,
  @relates, @sa) in tst_fuzzy_sync.h that the new kernel-doc comments
  superseded
- PATCH 2: drop the already-applied field-rename claims (.runtime,
  .hugepages, dev_* moves) from the commit message and correct the
  added-field count from 10 to 8
- PATCH 3: fix the copyright year (2025 -> 2026), remove the duplicate
  SAFE_MMAP entry from the core macros section, and correct the macro
  count from 217 to 216
- Link to v1: https://lore.kernel.org/r/20260601-doc_add_missing_headers-v1-0-6f1ee31945df@suse.com

---
Andrea Cervesato (3):
      doc: Add missing API references to api_c_tests.rst
      doc: Complete struct tst_test table and shell API docs
      doc: Add SAFE_* macros reference page

 doc/developers/api_c_tests.rst     |  71 +++++--
 doc/developers/api_safe_macros.rst | 382 +++++++++++++++++++++++++++++++++++++
 doc/developers/api_shell_tests.rst | 163 ++++++++++++++++
 doc/developers/writing_tests.rst   |  28 ++-
 doc/index.rst                      |   4 +
 include/tse_uinput.h               |  30 +--
 include/tst_clone.h                |  23 ++-
 include/tst_device.h               | 166 ++++++++++------
 include/tst_fuzzy_sync.h           | 230 +++++++++++-----------
 include/tst_hugepage.h             |  35 +++-
 include/tst_kconfig.h              |  78 ++++----
 include/tst_taint.h                |  32 ++--
 12 files changed, 951 insertions(+), 291 deletions(-)
---
base-commit: e85bc426c4af42b61d16b52987b47c934e74c952
change-id: 20260601-doc_add_missing_headers-ca51d98d32ac

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
