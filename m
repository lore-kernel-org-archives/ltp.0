Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B7EC88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:04:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECF183E8C41
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:04:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C83A03C72EC
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E7103600936
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3054F21AE1;
 Wed, 16 Sep 2026 14:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kv+RzgFBKtPVdy52r3TCN+2iIQnKHdTE6GZaFK3BCME=;
 b=iU2YyvSQNU9HD/Z+XZrjjgcoli/LlnEvud/B5Z6eL+niaQ2L+pczHUsgMEyJ6WpJyGannh
 asCVNupnQZIXkYvubJREGKmNvRGgPrCXG2UcTgIPyjUOycqGeNYAXtYExhYWpjO2NFoIp+
 kX5SQ91j2iomTTreRrSH1u0pkMuizRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kv+RzgFBKtPVdy52r3TCN+2iIQnKHdTE6GZaFK3BCME=;
 b=ItYzRcjAK6n6UssdGtACLibFDioC2BKMWW7/Ikl27XtpOxUdCvqWhpNtlP71tPNQxP6Zqa
 /fUgtQfT6Zr3TsBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ekIN9/3a";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ub61bmUU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kv+RzgFBKtPVdy52r3TCN+2iIQnKHdTE6GZaFK3BCME=;
 b=ekIN9/3a1At+FACO4ZR/GZdcj3wpClQIYVVWVTy9AWj2fcb5gvByx+4FHvOLZ4wXA/tNBm
 +WYIzCkawVFig4/TWRih+5gJNz4A+TDye992qX0Am6Xab7uMR/QQNwhk+17YiFWrZn9nrO
 gooTEdHgS4Mnm9ogcG8+cae8kkOQNt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kv+RzgFBKtPVdy52r3TCN+2iIQnKHdTE6GZaFK3BCME=;
 b=ub61bmUUZvTIF+tdnVnRCitnPfRw4slHlW7KteYRLAGR/42ovTHLjuoJtdHxZtP13f17ia
 e1M601QR+2KXFTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F3361348F;
 Wed, 16 Sep 2026 14:04:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:26 +0200
Message-ID: <20260916140402.1797325-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3054F21AE1
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 00/36] Improve coverage for keyctl() syscall
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

Hi,

I adjusted Andrea's great v2 patchset to be able to finish it before git
freeze. I hopefully addressed all Cyril's suggestions. If not, ideally
we'd merge at least the tests which are ready. (I added .iterations = 2
only to keyctl23.c, maybe it should be in other tests.


Changes v2->v3:
Described at the commits itself, e.g.:
* changing configure setup
* using SAFE_KEYCTL()
* changing helper functions in keyctl_common.h to macros

Other changes - new commits (1 from Cyril and 2 mine).

NOTE: I found on VM with 6.17.0-rc5-4.gc548b9b-default that keyctl15.c
fails:

keyctl15.c:46: TFAIL: empty label is not NUL terminated 
That might be a reason why Andrea did not test it on failure
(modification asked by Cyril).

I wonder if it's a bug or not.

Kind regards,
Petr

Link to v2:
https://lore.kernel.org/ltp/20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com/
https://patchwork.kernel.org/project/ltp/list/?series=1157990&state=*

Andrea Cervesato (33):
  lapi/keyctl.h: Add fallback definitions for extended ops
  keyctl10: Test KEYCTL_DESCRIBE format parsing
  keyctl11: Test KEYCTL_DESCRIBE with exact buffer size
  keyctl12: Test KEYCTL_DESCRIBE with too small buffer
  keyctl13: Test KEYCTL_DESCRIBE size query
  keyctl14: Negative tests for KEYCTL_DESCRIBE
  keyctl15: Test KEYCTL_GET_SECURITY label retrieval
  keyctl16: Test KEYCTL_GET_SECURITY truncated copy
  keyctl17: Negative tests for KEYCTL_GET_SECURITY
  keyctl18: Test basic KEYCTL_MOVE
  keyctl19: Test KEYCTL_MOVE with same source and destination
  keyctl20: Test KEYCTL_MOVE displacement
  keyctl21: Negative and boundary tests for KEYCTL_MOVE
  keyctl22: Test KEYCTL_RESTRICT_KEYRING reject-all
  keyctl23: Test KEYCTL_RESTRICT_KEYRING builtin_trusted
  keyctl24: Negative tests for KEYCTL_RESTRICT_KEYRING
  keyctl25: Test KEYCTL_DH_COMPUTE shared secret computation
  keyctl26: Test KEYCTL_DH_COMPUTE size query
  keyctl27: Test KEYCTL_DH_COMPUTE KDF key derivation
  keyctl28: Negative and boundary tests for KEYCTL_DH_COMPUTE
  lapi/keyctl.h: Add fallback definitions for public key ops
  keyctl29: Test KEYCTL_PKEY_QUERY on public key
  keyctl30: Test KEYCTL_PKEY_QUERY on private key
  keyctl31: Test KEYCTL_PKEY_ENCRYPT and KEYCTL_PKEY_DECRYPT
  keyctl32: Test KEYCTL_PKEY_SIGN and VERIFY
  keyctl33: Negative tests for KEYCTL_PKEY_*
  lapi/keyctl.h: Add capability fallback defines
  keyctl34: Test KEYCTL_CAPABILITIES flag retrieval
  keyctl35: Test KEYCTL_CAPABILITIES size query
  keyctl36: Test KEYCTL_CAPABILITIES buffer sizing
  keyctl37: Negative tests for KEYCTL_CAPABILITIES
  keyctl38: Test KEYCTL_WATCH_KEY add and remove
  keyctl39: Negative tests for KEYCTL_WATCH_KEY

Cyril Hrubis (1):
  lib: tst_test: Move the iterations to struct tst_test

Petr Vorel (2):
  lapi/keyctl.h: Add SAFE_ADD_KEY()
  tree: keyctl: Use SAFE_ADD_KEY()

 include/lapi/keyctl.h                         | 168 +++++++++++-
 include/tst_test.h                            |   4 +
 lib/tst_test.c                                |   8 +-
 m4/ltp-keyutils.m4                            |   7 +
 runtest/syscalls                              |  30 +++
 testcases/cve/cve-2016-7042.c                 |   4 +-
 testcases/kernel/syscalls/add_key/add_key03.c |   9 +-
 testcases/kernel/syscalls/add_key/add_key04.c |  14 +-
 testcases/kernel/syscalls/keyctl/.gitignore   |  30 +++
 testcases/kernel/syscalls/keyctl/keyctl02.c   |   8 +-
 testcases/kernel/syscalls/keyctl/keyctl03.c   |   4 +-
 testcases/kernel/syscalls/keyctl/keyctl06.c   |   6 +-
 testcases/kernel/syscalls/keyctl/keyctl10.c   |  99 +++++++
 testcases/kernel/syscalls/keyctl/keyctl11.c   |  62 +++++
 testcases/kernel/syscalls/keyctl/keyctl12.c   |  62 +++++
 testcases/kernel/syscalls/keyctl/keyctl13.c   |  46 ++++
 testcases/kernel/syscalls/keyctl/keyctl14.c   |  54 ++++
 testcases/kernel/syscalls/keyctl/keyctl15.c   |  64 +++++
 testcases/kernel/syscalls/keyctl/keyctl16.c   |  74 ++++++
 testcases/kernel/syscalls/keyctl/keyctl17.c   |  55 ++++
 testcases/kernel/syscalls/keyctl/keyctl18.c   |  51 ++++
 testcases/kernel/syscalls/keyctl/keyctl19.c   |  43 +++
 testcases/kernel/syscalls/keyctl/keyctl20.c   |  51 ++++
 testcases/kernel/syscalls/keyctl/keyctl21.c   | 111 ++++++++
 testcases/kernel/syscalls/keyctl/keyctl22.c   |  54 ++++
 testcases/kernel/syscalls/keyctl/keyctl23.c   | 134 ++++++++++
 testcases/kernel/syscalls/keyctl/keyctl24.c   | 171 ++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl25.c   |  66 +++++
 testcases/kernel/syscalls/keyctl/keyctl26.c   |  53 ++++
 testcases/kernel/syscalls/keyctl/keyctl27.c   |  78 ++++++
 testcases/kernel/syscalls/keyctl/keyctl28.c   | 140 ++++++++++
 testcases/kernel/syscalls/keyctl/keyctl29.c   |  90 +++++++
 testcases/kernel/syscalls/keyctl/keyctl30.c   |  86 ++++++
 testcases/kernel/syscalls/keyctl/keyctl31.c   | 110 ++++++++
 testcases/kernel/syscalls/keyctl/keyctl32.c   | 121 +++++++++
 testcases/kernel/syscalls/keyctl/keyctl33.c   | 247 ++++++++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl34.c   |  61 +++++
 testcases/kernel/syscalls/keyctl/keyctl35.c   |  46 ++++
 testcases/kernel/syscalls/keyctl/keyctl36.c   |  84 ++++++
 testcases/kernel/syscalls/keyctl/keyctl37.c   |  63 +++++
 testcases/kernel/syscalls/keyctl/keyctl38.c   |  91 +++++++
 testcases/kernel/syscalls/keyctl/keyctl39.c   | 149 +++++++++++
 .../kernel/syscalls/keyctl/keyctl_common.h    |  62 +++++
 .../kernel/syscalls/keyctl/keyctl_dh_data.h   |  79 ++++++
 .../kernel/syscalls/keyctl/keyctl_pkey_data.h | 152 +++++++++++
 .../syscalls/request_key/request_key01.c      |   4 +-
 .../syscalls/request_key/request_key02.c      |   4 +-
 testcases/kernel/watchqueue/common.h          |   4 +-
 48 files changed, 3167 insertions(+), 46 deletions(-)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl10.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl11.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl12.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl13.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl14.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl15.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl16.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl17.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl18.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl19.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl20.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl21.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl22.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl23.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl24.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl25.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl26.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl27.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl28.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl29.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl30.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl31.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl32.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl33.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl34.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl35.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl36.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl37.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl38.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl39.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl_common.h
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl_dh_data.h
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl_pkey_data.h

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
