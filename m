Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB416CD6E5D
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 09:17:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6CD23E547B
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 11:17:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E84C3C7509
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:17:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8F0AE1000A0E
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:17:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 979AD758EA;
 Fri,  5 Jun 2026 09:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780651034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wojy5u0Nu9ZhtESzduD7CFryxM299TwGRA627BhIDQ8=;
 b=TnHzZhclPcWnF/w9C62FjI22T9UsedtfFiZ2ABNq70Md+LuYnjzMlODoy0TpF1fGoipwGg
 YvP5Y1DCqhCQ1d1vTp/qLiaKsG61GBDN9LMLgDdaVqzVep+JS0nN0ry66zYzx6IO3PasBM
 jbMyHOmGNKDuBYLAdjaVOyfczodURUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780651034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wojy5u0Nu9ZhtESzduD7CFryxM299TwGRA627BhIDQ8=;
 b=vWZyJ3ZlHDoSTi7mLlqnyVgQ82F11t7NLpi05YrXWPuh0YiDSlaUZzyrmaTSe2pT5THGe/
 9Kicu0s3hYepvAAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TnHzZhcl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vWZyJ3Zl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780651034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wojy5u0Nu9ZhtESzduD7CFryxM299TwGRA627BhIDQ8=;
 b=TnHzZhclPcWnF/w9C62FjI22T9UsedtfFiZ2ABNq70Md+LuYnjzMlODoy0TpF1fGoipwGg
 YvP5Y1DCqhCQ1d1vTp/qLiaKsG61GBDN9LMLgDdaVqzVep+JS0nN0ry66zYzx6IO3PasBM
 jbMyHOmGNKDuBYLAdjaVOyfczodURUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780651034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wojy5u0Nu9ZhtESzduD7CFryxM299TwGRA627BhIDQ8=;
 b=vWZyJ3ZlHDoSTi7mLlqnyVgQ82F11t7NLpi05YrXWPuh0YiDSlaUZzyrmaTSe2pT5THGe/
 9Kicu0s3hYepvAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63B44779A9;
 Fri,  5 Jun 2026 09:17:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 61KLFRqUImodHAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 05 Jun 2026 09:17:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 05 Jun 2026 11:17:12 +0200
Message-Id: <20260605-doc_add_missing_headers-v6-0-678aac302a60@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABiUImoC/43OTWrDMBAF4KsErasijST/dNV7hGLEzCjWInbRN
 KYl+O5VsjIG0y7fwHzv3ZVwySzq7XRXhZcseZ5qaF5OCsc4XVhnqlmBgcY0xmqacYhEwzWL5Ok
 yjByJi2iMwVLfkYOIqn5/Fk75+ymfP2oes3zN5edZtNjH9W9zsdroJllmZ3sfKL3LTfgV56t6k
 AtsGThmoDI9Yp3Xoekd7Rj3T8ZVxreeOKW2JYg7xm8Zd8z4ytjELroW0IawY8KW8cdMqAywiYS
 mAwrbNeu6/gJpM5Dr2QEAAA==
X-Change-ID: 20260601-doc_add_missing_headers-ca51d98d32ac
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780651034; l=3561;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=DmP242ChNEVWcClsM10eZBuEQxijY1tfwdfd/2K7nyI=;
 b=GepI58zri8KtXqJkdN9Q5lRQMr8cMlCJJWX8+BrYXUtq/Ru1DjsOjSX/KCsrgTiP8VR6hHNKJ
 YyHtwzvhLwBCjqZx7Tjrdcj9mwebl+6A4+kYf96TWgrg77fEl63ieCk
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 979AD758EA
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/3] Complete the documentation adding missing
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
Changes in v6:
- PATCH 3: replace the U+2014 em-dash next to SAFE_CLOSE in
  api_safe_macros.rst with an ASCII '--' so doc/ stays ASCII-only
- Link to v5: https://lore.kernel.org/r/20260604-doc_add_missing_headers-v5-0-2e0adc082d5a@suse.com

Changes in v5:
- PATCH 1: drop the stray empty "Verdict:" line accidentally left in
  the commit message body
- PATCH 1: remove the leftover "@sa tst_fzsync_pair" Doxygen directive
  from the file-level overview comment in tst_fuzzy_sync.h
- PATCH 2: extend the shell API variables reference with the remaining
  public inputs (TST_DISABLE_APPARMOR, TST_DISABLE_SELINUX,
  TST_SKIP_LSM_WARNINGS, TST_NO_DEFAULT_RUN, TST_TMPDIR_RHOST)
- Link to v4: https://lore.kernel.org/r/20260603-doc_add_missing_headers-v4-0-1fe3a372c155@suse.com

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
 doc/developers/api_shell_tests.rst | 183 ++++++++++++++++++
 doc/developers/writing_tests.rst   |  28 ++-
 doc/index.rst                      |   4 +
 include/tse_uinput.h               |  30 +--
 include/tst_clone.h                |  24 ++-
 include/tst_device.h               | 166 ++++++++++------
 include/tst_fuzzy_sync.h           | 232 +++++++++++-----------
 include/tst_hugepage.h             |  35 +++-
 include/tst_kconfig.h              |  78 ++++----
 include/tst_taint.h                |  32 ++--
 12 files changed, 972 insertions(+), 293 deletions(-)
---
base-commit: d635eefe6f4cc0791c6cbd3c564c420ca303e729
change-id: 20260601-doc_add_missing_headers-ca51d98d32ac

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
