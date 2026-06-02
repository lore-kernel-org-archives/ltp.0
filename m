Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D5DCD6E57
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 15:50:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9B223E723A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 17:50:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 204C33CC04D
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 17:49:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5513A600274
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 17:49:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 135ED672A0;
 Tue,  2 Jun 2026 15:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780415375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MuLJdWO3eY7PM9bIXeHnNWf8FGbhIDygWRzvvCSm//s=;
 b=ogaNzPZCupNlwxdJ+GgsQ0ChJuCnxnBheCNPJUMn28wflqDDkrxh0nnqg2PXswM26+zvC3
 p3DM1FbDmdPkH9pgf3i5oZ6r6QJAsq6T6Ln0XKGW5Rd5d6p6SfLITnH49huBX3fsBjthVI
 ZRev2AtJuvQFHD4diX/XRL/yaVHyydw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780415375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MuLJdWO3eY7PM9bIXeHnNWf8FGbhIDygWRzvvCSm//s=;
 b=ibd2/R1zf6fXfaWdQGzyjlirwZgNI+aKXU8CI7gmf4IkQMmUaI7IdrXYk88piXIKLKQtWe
 1xGC23jvPMCu+eCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780415375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MuLJdWO3eY7PM9bIXeHnNWf8FGbhIDygWRzvvCSm//s=;
 b=ogaNzPZCupNlwxdJ+GgsQ0ChJuCnxnBheCNPJUMn28wflqDDkrxh0nnqg2PXswM26+zvC3
 p3DM1FbDmdPkH9pgf3i5oZ6r6QJAsq6T6Ln0XKGW5Rd5d6p6SfLITnH49huBX3fsBjthVI
 ZRev2AtJuvQFHD4diX/XRL/yaVHyydw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780415375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MuLJdWO3eY7PM9bIXeHnNWf8FGbhIDygWRzvvCSm//s=;
 b=ibd2/R1zf6fXfaWdQGzyjlirwZgNI+aKXU8CI7gmf4IkQMmUaI7IdrXYk88piXIKLKQtWe
 1xGC23jvPMCu+eCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5035779A7;
 Tue,  2 Jun 2026 15:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QohUNo77Hmr8RAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 02 Jun 2026 15:49:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 02 Jun 2026 17:49:25 +0200
Message-Id: <20260602-doc_add_missing_headers-v3-0-474deff77d2a@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIX7HmoC/4XOzQ6CMAzA8VcxOzuzDyHMk+9hDFnaAjvAzKqLh
 vDuDk5cjMd/k/7aWTClQCwuh1kkyoFDnErY40HA4KeeZMDSwihTq1ppiRFaj9iOgTlMfTuQR0o
 swVcaXYPWeBBl+5GoC+9Nvt1LD4GfMX22Q1mv0/9m1lLJutNEVrtzhd2VX0wniKNYyWz2jPnNm
 MI4gPJeA8pZ3DHLsnwB60y9SwQBAAA=
X-Change-ID: 20260601-doc_add_missing_headers-ca51d98d32ac
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780415374; l=2628;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=2+X3rx5UPjnh01/BAlbbR4TOIsdSYsY70dTfLBlwL6E=;
 b=xUTCYy1CpnpbK7knNpIxqQb8UWkDZkDmxi/uQ55XBb0S0QCcOR3ozs2k8qIrtxj3MnNEV+RFF
 6/O7jW1tl1rDV7r4EJURT/3bCZvcU/fWobHzD3bgk4kV5obYfqAeEko
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] Complete the documentation adding missing
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
 include/tst_fuzzy_sync.h           | 231 +++++++++++-----------
 include/tst_hugepage.h             |  35 +++-
 include/tst_kconfig.h              |  78 ++++----
 include/tst_taint.h                |  32 ++--
 12 files changed, 952 insertions(+), 291 deletions(-)
---
base-commit: fb3451954e9a16078d184e56a3b0b165fd95b24d
change-id: 20260601-doc_add_missing_headers-ca51d98d32ac

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
