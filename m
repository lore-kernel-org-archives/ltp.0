Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA41CD6E56
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 10:36:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 494BF3E4B69
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 12:36:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 783143CE107
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 12:36:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5253D1A001CE
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 12:36:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C28B66D8F;
 Mon,  1 Jun 2026 10:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780310172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ScGHhIP9t5UZbDusXrXXSsnqbTYG5VZ7923c+Ozqdmw=;
 b=xw8hnIovoNYbIUcavesbpC5KT3duYQ+JB5YPw282ZLmRsVThLutPVi5IE1bFTWbFSHWjK7
 VI3jnfqG35788+ZW/BqkRleMezP8TDz2Yf1h2K8x1dJyAyO+C9yBDNl/AvDxuVYirU4qBf
 k7x09Z7dMJhxPJfeI/ABgrQjlgeaxIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780310172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ScGHhIP9t5UZbDusXrXXSsnqbTYG5VZ7923c+Ozqdmw=;
 b=N3dAEaIslFQijf81cL0JAm/1od71N6efr5SbAXYNwSQgzxK3sg4QPBceBDFVX2r4ceIyW8
 nMqdZdv19UVaHQDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xw8hnIov;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N3dAEaIs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780310172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ScGHhIP9t5UZbDusXrXXSsnqbTYG5VZ7923c+Ozqdmw=;
 b=xw8hnIovoNYbIUcavesbpC5KT3duYQ+JB5YPw282ZLmRsVThLutPVi5IE1bFTWbFSHWjK7
 VI3jnfqG35788+ZW/BqkRleMezP8TDz2Yf1h2K8x1dJyAyO+C9yBDNl/AvDxuVYirU4qBf
 k7x09Z7dMJhxPJfeI/ABgrQjlgeaxIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780310172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ScGHhIP9t5UZbDusXrXXSsnqbTYG5VZ7923c+Ozqdmw=;
 b=N3dAEaIslFQijf81cL0JAm/1od71N6efr5SbAXYNwSQgzxK3sg4QPBceBDFVX2r4ceIyW8
 nMqdZdv19UVaHQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F97D779A7;
 Mon,  1 Jun 2026 10:36:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +zcaGZxgHWpjFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jun 2026 10:36:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jun 2026 12:36:10 +0200
Message-Id: <20260601-doc_add_missing_headers-v1-0-6f1ee31945df@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJpgHWoC/x3MMQqAMAxA0atIZgttRVGvIlJCEzWDVRoQQby7x
 fEN/z+gnIUVxuqBzJeoHKnA1RXEDdPKRqgYvPWd7awzdMSARGEXVUlr2BiJs5qIraOhp8ZjhFK
 fmRe5//M0v+8HOa6JG2kAAAA=
X-Change-ID: 20260601-doc_add_missing_headers-ca51d98d32ac
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780310172; l=1436;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=TLzC8frohzD/eoaojb2oR4Swkl81aN4+A0+c8B64XVg=;
 b=1hsFZ2xVwCxYeOZOnOeUTOryiq8ZDSj+MPCjrlfRPuUJMGUMI/3mDeDGyVImmgoX3QZGA+qbz
 AKP6q/kPkHjAHv74IzMkJHakMGSLD+ooaWaAcdnT4xFqPb6hiAhPc10
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8C28B66D8F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Complete the documentation adding missing headers
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
Andrea Cervesato (3):
      doc: Add missing API references to api_c_tests.rst
      doc: Complete struct tst_test table and shell API docs
      doc: Add SAFE_* macros reference page

 doc/developers/api_c_tests.rst     |  71 ++++++--
 doc/developers/api_safe_macros.rst | 326 +++++++++++++++++++++++++++++++++++++
 doc/developers/api_shell_tests.rst | 163 +++++++++++++++++++
 doc/developers/writing_tests.rst   |  28 +++-
 doc/index.rst                      |   4 +
 include/tse_uinput.h               |  30 ++--
 include/tst_clone.h                |  23 ++-
 include/tst_device.h               | 165 ++++++++++++-------
 include/tst_fuzzy_sync.h           | 163 +++++++++++++------
 include/tst_hugepage.h             |  35 ++--
 include/tst_kconfig.h              |  77 ++++-----
 include/tst_taint.h                |  32 ++--
 12 files changed, 896 insertions(+), 221 deletions(-)
---
base-commit: 2ee13a3772ae4942597afa615b3cb411d380db86
change-id: 20260601-doc_add_missing_headers-ca51d98d32ac

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
