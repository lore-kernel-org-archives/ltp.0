Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B3CC52D6F
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 13:49:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2C4E3D2270
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 15:49:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C06D3D225A
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 15:49:25 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F13E414004EC
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 15:49:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 445A721AF0
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724248163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gOPwycRkBk6ruK1b3PVoBKO2Ix5XJ7MEC1Hl5i4XQqA=;
 b=pa8zQTTwWrfRKGA9mUwOIsztBOSuyX1fPeKrTyxikixmyvKxCSZPImYKL/PwxNlJOLdAJj
 7kAWZcwuKtt3TCZVNr6yeyJmGoFQeXiYyrT/V/a2WgomVg6BYaZ+a9V13DB6Tl9vKeXyt5
 rtkqNi3CRXCGfX3fjMG+3y/lsVbGumw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724248163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gOPwycRkBk6ruK1b3PVoBKO2Ix5XJ7MEC1Hl5i4XQqA=;
 b=V80nrTeqHWeob7D9roP3S8GNH7LIssKhWlwseFiyDfsO7xruNUabFJcSMakFi6g2NVVUdK
 abPrYg+HwXI1pKBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724248163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gOPwycRkBk6ruK1b3PVoBKO2Ix5XJ7MEC1Hl5i4XQqA=;
 b=pa8zQTTwWrfRKGA9mUwOIsztBOSuyX1fPeKrTyxikixmyvKxCSZPImYKL/PwxNlJOLdAJj
 7kAWZcwuKtt3TCZVNr6yeyJmGoFQeXiYyrT/V/a2WgomVg6BYaZ+a9V13DB6Tl9vKeXyt5
 rtkqNi3CRXCGfX3fjMG+3y/lsVbGumw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724248163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gOPwycRkBk6ruK1b3PVoBKO2Ix5XJ7MEC1Hl5i4XQqA=;
 b=V80nrTeqHWeob7D9roP3S8GNH7LIssKhWlwseFiyDfsO7xruNUabFJcSMakFi6g2NVVUdK
 abPrYg+HwXI1pKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DD16139C2
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 13:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oG1BCWPwxWbeKAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 13:49:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 21 Aug 2024 15:49:12 +0200
Message-Id: <20240821-landlock_houdini-v3-0-15fc43055d02@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFnwxWYC/32NwQ6CMBAFf8X0bE27rQie/A9jTClb2YitodJoC
 P9u4cTBeJyXzLyRRewJIztuRtZjokjBZ1DbDbOt8Tfk1GRmIECLEgTvjG+6YO/XNgwNeeIOtHZ
 7wPJgFcvas0dH7yV5vmRuKb5C/1kekpzXP7EkueTOqdo5Wyk05hSHiDsbHmxuJVj78ocPXPBaF
 yClNYV21cqfpukLWcTn8O8AAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724248163; l=1072;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=pPGZatrfxnb5YbWnhV4yUwJ18W9sPqQzqng5hdtJUvI=;
 b=veHD5RIXO11U45452XIuXcUE7G3NHXQkTwKsM8HVYK/SPMjp03590bsMait1pAJlKsQ4Opi4p
 HvZMJIk3BmTCS2xfc2CxXsQ/Ol2rPdE1Sxxr4ZT2et4MCCeCTwe+4xB
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Reproducer for the landlock houdini bug
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

More information at:
https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-42318

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- verify return value of keyctl() according with manual
- Link to v2: https://lore.kernel.org/r/20240821-landlock_houdini-v2-0-b46211ca64f9@suse.com

Changes in v2:
- add SAFE_KEYCTL macro
- verify in setup that landlock is activated
- Link to v1: https://lore.kernel.org/r/20240820-landlock_houdini-v1-1-ff3bffc93eaa@suse.com

---
Andrea Cervesato (2):
      Add SAFE_KEYCTL macro
      Add landlock07 test

 include/lapi/keyctl.h                           |  49 +++++++++++
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/landlock/.gitignore   |   1 +
 testcases/kernel/syscalls/landlock/landlock07.c | 109 ++++++++++++++++++++++++
 4 files changed, 160 insertions(+)
---
base-commit: edc79222abdcf32a344c806275a30a5c7cbf1ef3
change-id: 20240820-landlock_houdini-f244f52e87c3

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
