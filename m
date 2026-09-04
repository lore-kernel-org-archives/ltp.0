Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E8BC624D3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:09:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64E9D3E9764
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:09:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7D483E60EA
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3F361140122E
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0B2EB22B32;
 Fri,  4 Sep 2026 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=swLbbFlnpZWQR8Mp3xnHvfmMGin3rp+QrxE968w3RuA=;
 b=k3b3+aQsJZ9uJhXZOWnr0QCULjiOUftRFjiiXmE+ywyCX9ctu4keS5rOYm479GZxW4BfG7
 SHlrEsaLdBJ/Xv2soeAi6e62YkhofXJ/YrEP6cYPzgsnJQXXHrQCS4/OzohPQJ6a8Dj0fw
 tM5C9SUEkRk1fDZFM5ISHksiSaUjdus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=swLbbFlnpZWQR8Mp3xnHvfmMGin3rp+QrxE968w3RuA=;
 b=A+tc+sZTBwyxFsb6qWrElIHx2BNhlNsA9wxOc5SGu68vR53Xi9+wpYN0HXCTYkwSEBMMCf
 UwfcmfZ2blpibQBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zmMwPk+5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="1QDXkW/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=swLbbFlnpZWQR8Mp3xnHvfmMGin3rp+QrxE968w3RuA=;
 b=zmMwPk+56EhLyZ6TuEZrCdAU445G7LAuCwK5fX6B4tsUO/Kad6v0yZehC7wW3BBc9QBk+/
 YmDQsE4ikxLmELD/OicQ9tP8X5NNor9N9KMlPkxGTe4BOrVDu4tDJTv9jkTkTjNrj6Ik6M
 NGiX4iwI48XftdvVDDugS9biq5uiY7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523732;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=swLbbFlnpZWQR8Mp3xnHvfmMGin3rp+QrxE968w3RuA=;
 b=1QDXkW/teAo7ltbRzkgrrAWJAOY+o2+JCDByCMGdWoi5/U/hnnerXvbtZ/qEiXPdJ8D85T
 mRzMaXHoYqMkN+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC25613678;
 Fri,  4 Sep 2026 12:08:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y5LkKtO0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:08:49 +0200
Message-Id: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANG0mmoC/2WNyw6CMBBFf8V0bU0Z8FFX/ochpkwHqQ9qOtBIC
 P9ugaXLk3vvuaNgCo5YnDejCBQdO98mgO1GYGPaO0lnEwtQcFCnPJNPGrB73dBHCibFebE3BRb
 2qDWItPoEqt13MV7LlbmvHoTdrJkbjePOh2G5jNncW+1awZ89ZlJJC9rWBqhCqi/cM+3Qv0U5T
 dMPu3rKgL8AAAA=
X-Change-ID: 20260831-keyctl_coverage-345a4c4d7992
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=5342;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=ySp25oh5JRATecwh3BJ6KuXXF52IpC/Fpf58/2wYdqk=;
 b=wbXUJxAmglUNXHNsNm7XsR1zuxHVN06ucYAwUEpkLzVUdb7R7nhMYBxM+zlM7NFOOETlfMgl7
 46NZ3a3aRcRDDMkasFVCUYkpcGCZejLh6GNHndgHlT3iGkx/c0LZE2U
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0B2EB22B32
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,linux.it:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.de:dkim];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[opensuse.org:url,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,linux.it:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 00/33] Improve coverage for keyctl() syscall
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
Changes in v2:
- fix build
- Link to v1: https://lore.kernel.org/20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com

To: Linux Test Project <ltp@lists.linux.it>

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

 include/lapi/keyctl.h                              | 141 +++++++++++-
 m4/ltp-keyutils.m4                                 |  13 ++
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
 37 files changed, 3173 insertions(+), 1 deletion(-)
---
base-commit: 043bdc49af410f55ece6f61abcdaba7d9580f86a
change-id: 20260831-keyctl_coverage-345a4c4d7992

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
