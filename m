Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21150103E173
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 13:27:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 534923E608D
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 14:27:03 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 066C63E4875
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:26:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 559FA600102
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:26:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 889DF4D34C;
 Wed, 18 Mar 2026 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773840403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=H5hsuyGs7A51RsotDfqee6vx4Si6ogv8c2ieAkPQZzA=;
 b=VTX//SlIZgmJjQyFa2RxZKdMiA3p7HI4YXRTtWDlr/yk/jkxSqsvzHJZ/x1aLlUviP8Zxd
 4d8Ze3Zv61reHOwo3Tg+rHZP/OddZ/6NK1t36ZFX3LjEnJfSVauUytr5o1oTSVRIDpMU6y
 1IXfsI8FMotX/66i1+e4wSqoM2EuBYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773840403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=H5hsuyGs7A51RsotDfqee6vx4Si6ogv8c2ieAkPQZzA=;
 b=deq4DfsKvVcdwa9lfPg7tXJM+JwHBokxKokyX8w2I+E4diAXU4ZTCmWQmkAageG7VBbYTj
 W6FFEhoV+Vun9IBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773840403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=H5hsuyGs7A51RsotDfqee6vx4Si6ogv8c2ieAkPQZzA=;
 b=VTX//SlIZgmJjQyFa2RxZKdMiA3p7HI4YXRTtWDlr/yk/jkxSqsvzHJZ/x1aLlUviP8Zxd
 4d8Ze3Zv61reHOwo3Tg+rHZP/OddZ/6NK1t36ZFX3LjEnJfSVauUytr5o1oTSVRIDpMU6y
 1IXfsI8FMotX/66i1+e4wSqoM2EuBYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773840403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=H5hsuyGs7A51RsotDfqee6vx4Si6ogv8c2ieAkPQZzA=;
 b=deq4DfsKvVcdwa9lfPg7tXJM+JwHBokxKokyX8w2I+E4diAXU4ZTCmWQmkAageG7VBbYTj
 W6FFEhoV+Vun9IBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 497D14273B;
 Wed, 18 Mar 2026 13:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mTAMEBOouml3HwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Mar 2026 13:26:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Mar 2026 14:26:37 +0100
Message-ID: <20260318132639.18818-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.991];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] power_management: cleanup
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I wanted to delete whole old testsuite (README mentions ancient kernel
2.6.29.4 etc) but because Intel folks contributed power management test
[1] and CPUFREQ/CPUIDLE sysfs tests are probably valid and should be
rewritten.

Of course README itself is also outdated (some scripts has been removed
and code put into the servers).

[1] https://lore.kernel.org/ltp/20260318130250.68495-2-piotr.kubaj@intel.com/

Petr Vorel (2):
  runpwtests03.sh: Replace modprobe -l to lsmod
  power_management: Remove runpwtests0[125].sh

 runtest/power_management_tests                |  3 -
 testcases/kernel/power_management/.gitignore  |  1 -
 .../power_management/pm_get_sched_values.c    | 36 ---------
 .../kernel/power_management/runpwtests01.sh   | 71 -----------------
 .../kernel/power_management/runpwtests02.sh   | 68 -----------------
 .../kernel/power_management/runpwtests03.sh   | 13 ++--
 .../kernel/power_management/runpwtests05.sh   | 76 -------------------
 7 files changed, 7 insertions(+), 261 deletions(-)
 delete mode 100644 testcases/kernel/power_management/.gitignore
 delete mode 100644 testcases/kernel/power_management/pm_get_sched_values.c
 delete mode 100755 testcases/kernel/power_management/runpwtests01.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests02.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests05.sh

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
