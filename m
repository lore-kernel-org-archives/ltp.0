Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03C6CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 08:28:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51F363E6A52
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:28:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C98D23E2C3F
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:27:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 35D4210001C1
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:27:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E9C56B478;
 Fri, 12 Jun 2026 08:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781252843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gg/FO8xzlRos/xTrVCP1mv2+qR+xoPqkQLcNhSUxnXs=;
 b=HvzQeRwit7uZb3VR2Gpssi6yxj+vmKCEKjfUk55Il1zSB8nlKdFOGckLLZP8isajlVQi67
 0UvyKff6gQ2I9V8hQo9nSna2PkThAejf4NALg58YOp5fuB1F8V7vYocu0GxvFFtlxdAYtO
 wyN7dGdcyz/TTQwnDuhxpTG1kiBmYu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781252843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gg/FO8xzlRos/xTrVCP1mv2+qR+xoPqkQLcNhSUxnXs=;
 b=a7hShkccJZP5wZE4gIcWMDKH3076xKJkdqlgKuWiBe1U3IOi/ISFzzHSUvg2X6cA8YTGq1
 b9bupQ47Kksp2dCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="nrmn/Pjy";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yZKAV2Nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781252842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gg/FO8xzlRos/xTrVCP1mv2+qR+xoPqkQLcNhSUxnXs=;
 b=nrmn/Pjy72kM2WPcuFI1bV+YxU9WslOKNbxAgvNGu5GH/SAqrVEihj3+eX+aQt/W9JN9iW
 HpxG6nsqMZXP5Zm1YPNRvl+2UktzJ4J+qjT5aALkOg7S16HoyiMQ8Da9aRe9c9sy3NpAzF
 lJflcvRBpvpbYGwAfL1XF3AlaMHCSFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781252842;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gg/FO8xzlRos/xTrVCP1mv2+qR+xoPqkQLcNhSUxnXs=;
 b=yZKAV2Nlxr9FMFMFwkh2PDoHVzIQ2rYdFRoKZ+unw3b0rdn3Cff02TvORX8MxYYDwwJyWh
 cn5uq5qZdxHc+TDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE56A779A7;
 Fri, 12 Jun 2026 08:27:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0vqVNOnCK2rTRAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 12 Jun 2026 08:27:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 12 Jun 2026 10:27:19 +0200
Message-Id: <20260612-doc_add_missing_headers-v8-0-a4639c49cad8@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOfCK2oC/43Ry0rFMBAG4Fc5ZG0l94sr30OkhJnJaRanlUSLc
 ui7m55VKBRd/hPmy09yZ5VKpspeLndWaM01L3ML/unCYIrzlYaMLTPJpeWWiwEXGCPieMu15vk
 6ThSRSh0gGoHBo5IRWNv+KJTy90N+e295yvVzKT+Pi1axT/82VzHwwSZBpETQBtNr/ar0DMuN7
 eQqe0aeM7IxAaDV88CDwgOj/smoxminkVJyDmU8MLpn1DmjGyMSqaicBGHMgTE9o88Z0xhJPCJ
 wL9Ec29ieMeeM3Z/Y+RhBcRktPzCuZ8I54xrjXADhoZ1T/1Pbtv0C+Pc0pWcCAAA=
X-Change-ID: 20260601-doc_add_missing_headers-ca51d98d32ac
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781252841; l=4108;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=s6sH2P1W36tUWo4k6782w1ZAafFEovbRnWPfdyD+98s=;
 b=ViLcBe1Ug9weUygBOidF5epTwTXkT2byjg6AdqOwtKLp+h2379YkzfpmgJ9inEAkP7U11Yrjs
 8NSG1ZaYzYOA7GRz8Ou0300n5FTGneHssua+tM3OZF0xpRD+rspppyT
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0E9C56B478
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 0/2] doc: Add missing headers and complete API docs
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

Add kernel-doc directives for 10 headers that were missing from the C
API documentation page and convert plain and Doxygen-style comments to
kernel-doc format so the documentation builder can extract them.

Complete the struct tst_test comparison table in writing_tests.rst and
add a shell API variables reference to api_shell_tests.rst.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v8:
- PATCH 1: add usage pattern description linking tst_dev_sync() and
  tst_dev_bytes_written() in tst_device.h
- PATCH 1: remove duplicate inline comments from tst_fzsync_pair struct
  fields (already documented in the top-level kernel-doc block)
- PATCH 1: remove stray double '::' in tst_fzsync_pair_update() comment
- PATCH 2: remove Shell API variables
- Link to v7: https://lore.kernel.org/r/20260609-doc_add_missing_headers-v7-0-779c18caddef@suse.com

Changes in v7:
- Rewrite cover letter subject and body
- Drop the api_safe_macros.rst patch from the series
- Link to v6: https://lore.kernel.org/r/20260605-doc_add_missing_headers-v6-0-678aac302a60@suse.com

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
Andrea Cervesato (2):
      doc: Add missing API references to api_c_tests.rst
      doc: complete struct tst_test documentation

 doc/developers/api_c_tests.rst   |  71 +++++++++---
 doc/developers/writing_tests.rst |  28 ++++-
 include/tse_uinput.h             |  30 ++---
 include/tst_clone.h              |  24 ++--
 include/tst_device.h             | 174 ++++++++++++++++++----------
 include/tst_fuzzy_sync.h         | 243 ++++++++++++++-------------------------
 include/tst_hugepage.h           |  35 ++++--
 include/tst_kconfig.h            |  78 ++++++-------
 include/tst_taint.h              |  32 ++----
 9 files changed, 387 insertions(+), 328 deletions(-)
---
base-commit: 6e9798bd429f7f341db078388ddb7087b81fb67b
change-id: 20260601-doc_add_missing_headers-ca51d98d32ac

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
