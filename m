Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9D8C36013
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 14:26:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 021DF3CA46C
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 15:26:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92B293C023C
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 15:25:43 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E26461400258
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 15:25:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C903211D5;
 Fri, 28 Mar 2025 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743171942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uUDD2oGauwWjq80B+zAxHGBNRNJN6vPeDKFpvpbpMVo=;
 b=IEzo6ZRTKu86ZTkyIKRkyBIPCY3ZHLnn6f1XN2yPidH+TAKvX1pbHQBLf1bfWkV4mehtes
 tpTPpqoaZibTYt8KEpleJrLDgH6fvyoLim1j12CkqdNNZAHMfaDSt8f8tPWP5X+kxZd1CW
 5rtFbcPov1zmLsm65WguqimmAApQ5qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743171942;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uUDD2oGauwWjq80B+zAxHGBNRNJN6vPeDKFpvpbpMVo=;
 b=HEHZJOFCNJ6XS1S7HcFP/DPCCvhuzVFc4fg79zNWr99iHk57o/WY9OyqeglNs5JDqyE1T8
 AypxBittKbkXkBBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IEzo6ZRT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HEHZJOFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743171942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uUDD2oGauwWjq80B+zAxHGBNRNJN6vPeDKFpvpbpMVo=;
 b=IEzo6ZRTKu86ZTkyIKRkyBIPCY3ZHLnn6f1XN2yPidH+TAKvX1pbHQBLf1bfWkV4mehtes
 tpTPpqoaZibTYt8KEpleJrLDgH6fvyoLim1j12CkqdNNZAHMfaDSt8f8tPWP5X+kxZd1CW
 5rtFbcPov1zmLsm65WguqimmAApQ5qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743171942;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uUDD2oGauwWjq80B+zAxHGBNRNJN6vPeDKFpvpbpMVo=;
 b=HEHZJOFCNJ6XS1S7HcFP/DPCCvhuzVFc4fg79zNWr99iHk57o/WY9OyqeglNs5JDqyE1T8
 AypxBittKbkXkBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01DA813927;
 Fri, 28 Mar 2025 14:25:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E40WOmWx5mfndgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Mar 2025 14:25:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Mar 2025 15:24:52 +0100
Message-Id: <20250328-landlock_unix_socket-v3-0-e2643f65b25e@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADSx5mcC/3XNSw6CMBCA4auYrq0pU8rDlfcwhkA7SCO2poUGQ
 7i7hcSEhe7mn2S+mYlHp9GT82EmDoP22poY/HggsqvNHalWsQkwEIyDoH1tVG/loxqNniofJxy
 oKKFpGBNcNEji6cthq6eNvd5id9oP1r23LyFZt18w/w2GhDIqijQTvM0yVcqLHz2epH2S1QuwN
 4o/BkRDKc5yKDOQKeyMZVk+xf2cvPsAAAA=
X-Change-ID: 20250325-landlock_unix_socket-592bb00535be
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743171941; l=1681;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=R+KzkpYtfKgfy9fVT/6YbQgUIodU6ewKzBJc1KhIEFo=;
 b=t/2q7SfmwXVH7pdJyV0LL9n547QL+tmMVtrvrSbo46Lhv+EK/FJg8fC+eZBfThA4AKwl3m/ts
 NyJDw2mD++VB0puKUZlrZ/b99w7OdR1lxina32GmkKDEkPcLAy+6m1J
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 2C903211D5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.com:mid, suse.com:email, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] Landlock tests for ABI v6
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
base-commit: e3aef569f0d0e7079bdb646965afaf419035eaa5
change-id: 20250325-landlock_unix_socket-592bb00535be

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
