Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB48CD6E57
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 10:09:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 888BA3E30B8
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 12:09:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9C363C7509
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:09:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3A127100286C
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:09:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 79EC3679E9;
 Tue,  2 Jun 2026 10:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780394970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XCOTLrLlkmICPn3nCMqC3J5U1sNpUVs/71UsQxrz+IU=;
 b=GJe33sM81w1DNZ/WOvYYQyikWcR2jNEVW4nGiuyrJ2TBFqUljhjASUiZ7jgnBylxoU2Orp
 znXidPMPMrTTpUnGZwG1aUUdfI1EuUfrZpfbKdlV+oMrpaiH0soz+zkvLL9GRr5hmhhllM
 8wITdnAoLR2mZfmSxnDX/6DXG3IONn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780394970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XCOTLrLlkmICPn3nCMqC3J5U1sNpUVs/71UsQxrz+IU=;
 b=vKVgfd6DX04TYEkUstxZgKnLTqVxK/FsNyJDrXEufzl6exx4hixEHv9HfyYU/0tvuK1+uO
 56AQjk3lmAsYjEAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GJe33sM8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vKVgfd6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780394970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XCOTLrLlkmICPn3nCMqC3J5U1sNpUVs/71UsQxrz+IU=;
 b=GJe33sM81w1DNZ/WOvYYQyikWcR2jNEVW4nGiuyrJ2TBFqUljhjASUiZ7jgnBylxoU2Orp
 znXidPMPMrTTpUnGZwG1aUUdfI1EuUfrZpfbKdlV+oMrpaiH0soz+zkvLL9GRr5hmhhllM
 8wITdnAoLR2mZfmSxnDX/6DXG3IONn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780394970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XCOTLrLlkmICPn3nCMqC3J5U1sNpUVs/71UsQxrz+IU=;
 b=vKVgfd6DX04TYEkUstxZgKnLTqVxK/FsNyJDrXEufzl6exx4hixEHv9HfyYU/0tvuK1+uO
 56AQjk3lmAsYjEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58CB2779A7;
 Tue,  2 Jun 2026 10:09:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5TQgFNqrHmo/dQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 02 Jun 2026 10:09:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 02 Jun 2026 12:09:28 +0200
Message-Id: <20260602-doc_add_missing_headers-v2-0-9ccd988c093d@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANirHmoC/4WNQQ6CMBBFr0JmbU1bpBFX3MMQ0nSmMAuo6SjRE
 O5u5QIu30v++xsIZSaBW7VBppWF01LAnioIk19GUoyFwWrrtNNGYQqDRxxmFuFlHCbySFlU8I3
 B9oq19QHK+pEp8vso3/vCE8sz5c9xtJqf/d9cjdLKRUNUm/bSYOzkJXQOaYZ+3/cvTWh5JL0AA
 AA=
X-Change-ID: 20260601-doc_add_missing_headers-ca51d98d32ac
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780394970; l=2250;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=ypoJsw7kjpTLXEBkvJxIWPTZGPwz5smOA8veTCX7ct8=;
 b=FYVH71bbcD1UDpn7CvMuP0kwPzAquHpBEmGtQ6NAvaIDs43unxZuS0h0VPrjxEdPWd9KAIzLf
 FhILK34l5EECviIvsk+hYKQWzr2q4FaaaOceKgGIl+CHcMD6up73fYq
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 79EC3679E9
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] Complete the documentation adding missing
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
 include/tst_device.h               | 165 ++++++++++------
 include/tst_fuzzy_sync.h           | 231 +++++++++++-----------
 include/tst_hugepage.h             |  35 +++-
 include/tst_kconfig.h              |  77 ++++----
 include/tst_taint.h                |  32 ++--
 12 files changed, 950 insertions(+), 291 deletions(-)
---
base-commit: fb3451954e9a16078d184e56a3b0b165fd95b24d
change-id: 20260601-doc_add_missing_headers-ca51d98d32ac

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
