Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DDBD6552F
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 17:38:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFCD63DB2EB
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 18:38:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6618F3DB2DC
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 18:38:35 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5587F20F5C8
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 18:38:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E83321F74D;
 Tue, 26 Nov 2024 17:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732642713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fx6DRM8qIUzT8avrFzQ2pTwHoO30bEvRwWkQP/XWKrE=;
 b=JQIKK73hLP4QT8cbgvvvE04fmJVniSDF37wuBHOIZrmFoTswkiaZrW6OPJjMnI+7hJHFC3
 GpFmKcO2wnuLwTDP2YBUfOtTnQFzAUsKLJ2BG6PH136+4yI6VFxmLKACLP26nRg8bNJH7q
 DMx0QHZHzVHyJRehKFB5T57HMQ9YBdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732642713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fx6DRM8qIUzT8avrFzQ2pTwHoO30bEvRwWkQP/XWKrE=;
 b=pVHJUYKJvnuwJTRU6x9VWFSxufNCkH7m7maOdru1PNq0ASRkFHMvVFHaF17eKh2w+61V1/
 ng21h39mQUMrpWBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732642712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fx6DRM8qIUzT8avrFzQ2pTwHoO30bEvRwWkQP/XWKrE=;
 b=ExgUgwuuuII29GFMzdZO0R6UJq449K5lqA6Y/s56l9palfKh6RFHFUTaj18M7Nwy3R1R31
 VEGLi3xXotU4vPruKZzVF+QpLDpzwChQT/doDKxM+KIp1vUfzzqqm/YQrdfUMkAIv6FTLA
 p0MOlYyv6TEJGT447W3uwb0fkVh4g8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732642712;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fx6DRM8qIUzT8avrFzQ2pTwHoO30bEvRwWkQP/XWKrE=;
 b=yBM65ZHwD6AuVnTXZu7k2GK822INQ4kDsH74A53Q9vAPYDZH3AaRW9C0A8jQ2aGGFuKspL
 wAFeyH4AEm1+FxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2E6C13890;
 Tue, 26 Nov 2024 17:38:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5A4/LpgHRmf2OAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 26 Nov 2024 17:38:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 26 Nov 2024 18:38:27 +0100
Message-ID: <20241126173830.98960-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,vger.kernel.org];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] LTP tests: load predefined policy
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Petr Vorel <petr.vorel@gmail.com>

Hi Mimi, all,

this effort allows to load policy LTP provides as example
via LTP_IMA_LOAD_POLICY=1 environment variable (off by default).

This should allow better coverage for these who just run runtest/ima.
But it requires tooling which runs LTP to do the restart after each
test.

Kind regards,
Petr

Petr Vorel (3):
  ima: Add TCB policy as an example
  ima_setup.sh: Allow to load predefined policy
  ima_{kexec,keys,selinux}: Set minimal kernel version

 .../kernel/security/integrity/ima/README.md   |  6 +++
 .../ima/datafiles/ima_measurements/tcb.policy | 20 +++++++
 .../security/integrity/ima/tests/ima_kexec.sh |  1 +
 .../security/integrity/ima/tests/ima_keys.sh  |  1 +
 .../integrity/ima/tests/ima_measurements.sh   | 17 +++++-
 .../integrity/ima/tests/ima_selinux.sh        |  1 +
 .../security/integrity/ima/tests/ima_setup.sh | 52 ++++++++++++++++---
 7 files changed, 89 insertions(+), 9 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy

-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
