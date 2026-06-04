Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C916FCD6E57
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 08:45:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CEF13E54FC
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 10:45:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBAA33E2773
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 10:45:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 91E7B200988
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 10:45:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 17D4467EB5;
 Thu,  4 Jun 2026 08:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780562711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fTrsTSVCU6DgFK8n3QjsNxw7i9J5hxkrp8kzTwJ5Q0M=;
 b=QmyqGVESBAk9e5X/I137mGBri9EXUItghENlN0Z6dPl4P6aXCC/TJTrc+JT3BrCjjF/lsY
 mP+Jh6CPyP0vTHMldB0Z8DMNzneiYOBAWrmwVBfnx5sm11aR+lW8gB8Wc1nwuhYEnxRfnP
 NA1/behIhN5Zn0wjMlgbsjl//HlBWig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780562711;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fTrsTSVCU6DgFK8n3QjsNxw7i9J5hxkrp8kzTwJ5Q0M=;
 b=X+WtdbhRvnXrTHCx1PT3X6c8ddh7mmUOQa4Q//7CYp5UBjAoC4Mue1AfNSnuzXFSJdyHwr
 9vdRCTYisJByY2CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780562711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fTrsTSVCU6DgFK8n3QjsNxw7i9J5hxkrp8kzTwJ5Q0M=;
 b=QmyqGVESBAk9e5X/I137mGBri9EXUItghENlN0Z6dPl4P6aXCC/TJTrc+JT3BrCjjF/lsY
 mP+Jh6CPyP0vTHMldB0Z8DMNzneiYOBAWrmwVBfnx5sm11aR+lW8gB8Wc1nwuhYEnxRfnP
 NA1/behIhN5Zn0wjMlgbsjl//HlBWig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780562711;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fTrsTSVCU6DgFK8n3QjsNxw7i9J5hxkrp8kzTwJ5Q0M=;
 b=X+WtdbhRvnXrTHCx1PT3X6c8ddh7mmUOQa4Q//7CYp5UBjAoC4Mue1AfNSnuzXFSJdyHwr
 9vdRCTYisJByY2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB651779A8;
 Thu,  4 Jun 2026 08:45:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BQDlNxY7IWrwHQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 04 Jun 2026 08:45:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 04 Jun 2026 10:45:07 +0200
Message-Id: <20260604-doc_add_missing_headers-v5-0-2e0adc082d5a@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABM7IWoC/43OzQrCMAzA8VeRnq30c3OefA+RUZLU9eAmjQ5l7
 N2tnoYgevwH8ksmwZQTsditJpFpTJyGvoRfrwR0oT+RTFhaGGUqVSktcYA2ILbnxJz6U9tRQMo
 sIXiNzRatCSDK9iVTTPe3fDiW7hJfh/x4Hxr1a/rbHLVUsoqayOrGeYx7vjFtYDiLFzmaJWO+M
 6YwDUB5bwuqsfjB2D8ZWxhXO6QY6xpN+GDckrHfGVcYHckGWxvQ3i+YeZ6fs33eo5IBAAA=
X-Change-ID: 20260601-doc_add_missing_headers-ca51d98d32ac
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780562710; l=3314;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=pZadQyA6dXLlifyG7xZ2GJ1QzCnTuSxsNr8TdYjKVus=;
 b=JzCQYcn+3v/EEhQGTvl49wZ5fMP7bPNFOASqQpv/irlRAGoLzQrxZ9a/9IMvn46RuodUEBN//
 5oY0ihq/3c0Ac+LLIZaeWSO9B1Ojn3ZMWtKSq04g6i1+E5psnOAoBeA
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/3] Complete the documentation adding missing
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
base-commit: e85bc426c4af42b61d16b52987b47c934e74c952
change-id: 20260601-doc_add_missing_headers-ca51d98d32ac

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
