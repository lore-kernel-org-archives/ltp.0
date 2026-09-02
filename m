Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFC2C624D6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:04:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E5993E588C
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:04:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E639C3E2D90
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4BEE1600B45
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 778401F7D4;
 Wed,  2 Sep 2026 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A7UbcEo+ccdM4Ko1NJVhRJ2JU5iKp3+EneZrzwM+NNU=;
 b=VnS/K1bRMzBLAJdt9w26x076ySzyfZYsngKw4dotSw9GDOBlnDe+ypHAnrzZuTmFGq/BiX
 UBl6hXypMD6gJT1vcP91wYYV0KLzfXdDFHsZwyeykVkx/3J5UPfFlxnWN/JwKTI25wJ7lz
 M1U1x8vcBDZXKhTdA6MGPE3wdjPigQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A7UbcEo+ccdM4Ko1NJVhRJ2JU5iKp3+EneZrzwM+NNU=;
 b=YlVa4l7wa4ZjevcZTI3Ttag2cpnL4KQXQC2XLGwfX/eBY3djmzAzWq1ry6UwsdKojF+/bT
 yXqamf6k8S5BSTDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A7UbcEo+ccdM4Ko1NJVhRJ2JU5iKp3+EneZrzwM+NNU=;
 b=fCrpEC/JrgX3jhXDTSEAB/603G/Hi2QsX+wpOlHsZoYcNVX9Dy5wWjoptKVM/VYdMOl7mW
 faCnOe0WuKYSz8uWeytPmulz3dH5IjrzHHn+nkifnk0xLMD4ZsyDs0jy4H1j9G02L4/4Pj
 r1xUyyeC5AMJHJ1OgRx00FLCSJsYOmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A7UbcEo+ccdM4Ko1NJVhRJ2JU5iKp3+EneZrzwM+NNU=;
 b=91bsOVe59O10PtfdcU9n9L7DijHjcUIgBnzbKzmn70QikxhQZW4hp/bUHjleITPu2KF6iG
 VBQIXKteDL+YYADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 466DB13515;
 Wed,  2 Sep 2026 11:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6Sx5D7YCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:15 +0200
Message-Id: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK8CmGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC2ND3ezUyuSSnPjk/LLUokSgtLGJaaJJskmKuaWlkRJQV0FRalpmBdj
 E6FgIv7g0KSs1uQRkjFJtLQANz3BgcwAAAA==
X-Change-ID: 20260831-keyctl_coverage-345a4c4d7992
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=5088;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=A9ksYJd6m9jS/cZY9nOlfR3WLIRgmjYu2ZedhOR4eNw=;
 b=0JbD1UT4UnzGxdSAmB2//ZgeifVDKR7XF1YMS139yLImx4i6NGaq2jWX9LmZavXq+ML5BMQoD
 0lXKtGYAwK6ApJU2yfFBYRJ0UPgrSHyPZBn7JOJSR6qvHa0z6nAb12T
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email, opensuse.org:url,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/33] Improve coverage for keyctl() syscall
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

Improve the keyctl() syscall coverage by adding more tests for the
following features, which are not currently tested in LTP:

- KEYCTL_DESCRIBE
- KEYCTL_GET_SECURITY
- KEYCTL_MOVE
- KEYCTL_RESTRICT_KEYRING
- KEYCTL_DH_COMPUTE
- KEYCTL_PKEY_*
- KEYCTL_CAPABILITIES
- KEYCTL_WATCH_KEY

The testing suite has been assisted by GLM 5.3 for coverage analysis
and Gemini Flash 3.7 for the tests skeleton.

Validation: https://openqa.opensuse.org/tests/6199954#

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
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

 include/lapi/keyctl.h                              | 102 +++++++++
 runtest/syscalls                                   |  30 +++
 testcases/kernel/syscalls/keyctl/.gitignore        |  30 +++
 testcases/kernel/syscalls/keyctl/keyctl10.c        |  99 +++++++++
 testcases/kernel/syscalls/keyctl/keyctl11.c        |  62 ++++++
 testcases/kernel/syscalls/keyctl/keyctl12.c        |  62 ++++++
 testcases/kernel/syscalls/keyctl/keyctl13.c        |  46 ++++
 testcases/kernel/syscalls/keyctl/keyctl14.c        |  54 +++++
 testcases/kernel/syscalls/keyctl/keyctl15.c        |  66 ++++++
 testcases/kernel/syscalls/keyctl/keyctl16.c        |  74 ++++++
 testcases/kernel/syscalls/keyctl/keyctl17.c        |  55 +++++
 testcases/kernel/syscalls/keyctl/keyctl18.c        |  60 +++++
 testcases/kernel/syscalls/keyctl/keyctl19.c        |  43 ++++
 testcases/kernel/syscalls/keyctl/keyctl20.c        |  62 ++++++
 testcases/kernel/syscalls/keyctl/keyctl21.c        | 111 +++++++++
 testcases/kernel/syscalls/keyctl/keyctl22.c        |  54 +++++
 testcases/kernel/syscalls/keyctl/keyctl23.c        | 142 ++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl24.c        | 173 +++++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl25.c        |  66 ++++++
 testcases/kernel/syscalls/keyctl/keyctl26.c        |  53 +++++
 testcases/kernel/syscalls/keyctl/keyctl27.c        |  78 +++++++
 testcases/kernel/syscalls/keyctl/keyctl28.c        | 140 ++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl29.c        |  90 ++++++++
 testcases/kernel/syscalls/keyctl/keyctl30.c        |  86 +++++++
 testcases/kernel/syscalls/keyctl/keyctl31.c        | 110 +++++++++
 testcases/kernel/syscalls/keyctl/keyctl32.c        | 121 ++++++++++
 testcases/kernel/syscalls/keyctl/keyctl33.c        | 247 +++++++++++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl34.c        |  62 ++++++
 testcases/kernel/syscalls/keyctl/keyctl35.c        |  49 ++++
 testcases/kernel/syscalls/keyctl/keyctl36.c        |  88 ++++++++
 testcases/kernel/syscalls/keyctl/keyctl37.c        |  63 ++++++
 testcases/kernel/syscalls/keyctl/keyctl38.c        |  91 ++++++++
 testcases/kernel/syscalls/keyctl/keyctl39.c        | 149 +++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl_common.h   |  73 ++++++
 testcases/kernel/syscalls/keyctl/keyctl_dh_data.h  |  79 +++++++
 .../kernel/syscalls/keyctl/keyctl_pkey_data.h      | 152 +++++++++++++
 36 files changed, 3122 insertions(+)
---
base-commit: 12724413534a6d4160ff9694ba6f09daa4ccb6bd
change-id: 20260831-keyctl_coverage-345a4c4d7992

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
