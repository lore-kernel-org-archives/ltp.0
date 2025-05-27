Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6E8C54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 10:55:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E98113C57AF
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 12:55:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9BB33C1AFF
 for <ltp@lists.linux.it>; Tue, 27 May 2025 12:54:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1AD071A00A40
 for <ltp@lists.linux.it>; Tue, 27 May 2025 12:54:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A6C421EB5;
 Tue, 27 May 2025 10:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748343288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SnovtZpn6QmJ+uMxJeCpgG7TD/aUARZjg6y+RjbNfHM=;
 b=g4mmN6przuUdh2bMhlTKv/v7AduGCNp/qA5+xfn2O9+X/z6tCqB2N3QvoA2/nie3Vsne9B
 EaOiZHA8r1sLn6HfFRPIumNiN1ilDVOcyoZmJKnuSMXCRRhPPnTBBVbpK3hVB7dQRMFvMT
 1e15MMiNQWn8N//r+4pvQ5eFgXCi4qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748343288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SnovtZpn6QmJ+uMxJeCpgG7TD/aUARZjg6y+RjbNfHM=;
 b=+iZOf9/DuKDXeLf9L3H49vrDu5fwPR7gTjZTXosjx/zu13gp4ynYp1FPMFYfFTKoihQMv2
 C11KkbXJCOqIM/Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748343288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SnovtZpn6QmJ+uMxJeCpgG7TD/aUARZjg6y+RjbNfHM=;
 b=g4mmN6przuUdh2bMhlTKv/v7AduGCNp/qA5+xfn2O9+X/z6tCqB2N3QvoA2/nie3Vsne9B
 EaOiZHA8r1sLn6HfFRPIumNiN1ilDVOcyoZmJKnuSMXCRRhPPnTBBVbpK3hVB7dQRMFvMT
 1e15MMiNQWn8N//r+4pvQ5eFgXCi4qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748343288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SnovtZpn6QmJ+uMxJeCpgG7TD/aUARZjg6y+RjbNfHM=;
 b=+iZOf9/DuKDXeLf9L3H49vrDu5fwPR7gTjZTXosjx/zu13gp4ynYp1FPMFYfFTKoihQMv2
 C11KkbXJCOqIM/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38FCD1388B;
 Tue, 27 May 2025 10:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Kd6hB/iZNWihdQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 27 May 2025 10:54:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 27 May 2025 12:54:36 +0200
Message-Id: <20250527-landlock_unix_socket-v4-0-80d3d579094b@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOyZNWgC/43OYQuCMBAG4L8S+9xi3rypfep/RIhuZ45Mw6kY4
 n9vCoFEQd/uPXifu4k5ai05dtxNrKXBOtvUPoT7HdNlVl+JW+MzAwEoJCCvstpUjb6lfW3H1Pm
 JOo4J5LkQKDEn5quPlgo7ruz54nNpXde0z/XKECzbNxh9B4eAC45xqFAWSplEn1zv6KCbO1u8A
 bZG/MMAbxgjRQSJAh3ChyH/MaQ3CFTo38AckDbGPM8vYgflLz8BAAA=
X-Change-ID: 20250325-landlock_unix_socket-592bb00535be
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748343288; l=1820;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=b8RVqffOSP4zA6bZM9GIQHaKkLznV5opSbdsrThgkX4=;
 b=uU8E8FZeucQyz+tiI/rV23tSW79B3QUVSW3R2MswvqkjeZvhDjAzTPO4L1ASLIBZ4kaaSzVIT
 bvheVwJaKYLA+gKnFSEdfomBNB26WrLRAEhG27hiN2bYA4rGBc0dC0b
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/4] Landlock tests for ABI v6
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

Landlock released a new feature for IPC scoping in the new ABI.
This includes the following new rules which will be tested in
this patch-set:

- LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
- LANDLOCK_SCOPE_SIGNAL

https://docs.kernel.org/userspace-api/landlock.html#ipc-scoping

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- retrigger patchwork
- Link to v3: https://lore.kernel.org/r/20250328-landlock_unix_socket-v3-0-e2643f65b25e@suse.com

Changes in v3:
- import <stddef.h> for offsetof declaration
- fix build error caused by DOMAIN_CNT in metadata parser. Just use
  .tst_variants = 3
- Link to v2: https://lore.kernel.org/r/20250328-landlock_unix_socket-v2-0-dd3072962c42@suse.com

Changes in v2:
- add landlock09 and landlock10 to runtest file
- DOMAIN_LENGTH -> DOMAIN_CNT
- Link to v1: https://lore.kernel.org/r/20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com

---
Andrea Cervesato (4):
      Add landlock ABI v6 fallback
      landlock02: support landlock ABI v6
      landlock: add landlock09 test
      landlock: add landlock10 test

 include/lapi/landlock.h                            |  23 +++-
 runtest/syscalls                                   |   2 +
 testcases/kernel/syscalls/landlock/.gitignore      |   2 +
 testcases/kernel/syscalls/landlock/landlock02.c    |  12 +-
 testcases/kernel/syscalls/landlock/landlock09.c    | 131 +++++++++++++++++++++
 testcases/kernel/syscalls/landlock/landlock10.c    | 108 +++++++++++++++++
 .../kernel/syscalls/landlock/landlock_common.h     |  11 ++
 7 files changed, 280 insertions(+), 9 deletions(-)
---
base-commit: db887f441f20f4323b1300624dbca2a03c1c8ed1
change-id: 20250325-landlock_unix_socket-592bb00535be

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
