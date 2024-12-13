Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9553CE7717F
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 22:22:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08C4E3EB88D
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 23:22:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A39E3EB886
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:20:22 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 966576008AF
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:20:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45B6F210F9;
 Fri, 13 Dec 2024 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=B0rBFqzhoReaaWOAr2v8CgoK1TbJdfJ+f/XaqZXqAoQ=;
 b=zSeAm1gSnu6xtMe/Fv8HVLgEEsxuVcRKrsdj3x4b2B3qt7+C0ppuBlm6ufZC01sUUqoAde
 T+1TkhK5n0rDLvJteMRnopxUj/2/nkNvQU9orINI3QN4l+s9OsPBUkyVAfqLLInL1BcIuT
 Xjd+P44yg9uWZlfMZxvG3wCFxzcyq1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734128418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=B0rBFqzhoReaaWOAr2v8CgoK1TbJdfJ+f/XaqZXqAoQ=;
 b=BlrtJPdOXYe9NWz6sVLoDCogyhSFF+okA3vnPkC6KmjacftTGBbhMrKNYTjlfTASio74kO
 qHkkMpNvnz/iAsBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734128417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=B0rBFqzhoReaaWOAr2v8CgoK1TbJdfJ+f/XaqZXqAoQ=;
 b=xLgo2Ts8SPY97EIGLBHmuMv9qNIl1XFzXLt5Re0KKJaR+p9Yi6XOKpzRjy71PYGD/hriv+
 Cvb6AyqSvGdkcyQY3EECGpyGLw4X66tQb3CLdDVmEzWQggCf64PCYEgVJ+q4cQPj+3/+fO
 xsPFF4QR+y4EjS2p/jYsIgQ7KEyKTo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734128417;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=B0rBFqzhoReaaWOAr2v8CgoK1TbJdfJ+f/XaqZXqAoQ=;
 b=TOwdJmI4EKGntD7INk4RdVuLk9/ZK9xqWUnqjwwoUzszFGvniRHeNMzJqAAWpeVAMbR4yl
 j82SgU1pi1IqC2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E292137CF;
 Fri, 13 Dec 2024 22:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OjoBBiGzXGf5QQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Dec 2024 23:20:06 +0100
Message-ID: <20241213222014.1580991-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/8]	LTP tests: load predefined policy, enhancements
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

Changes v1->v2:
* Removed ont_measure fsmagic=0x1021994 from TCB example policy
* More reasons to fail when uploading policy
  (testcases/kernel/security/integrity/ima/README.md)
* New commits:
  - tst_test.sh: IMA: Allow to disable LSM warnings and use it for IMA
  - ima_setup: Print warning when policy not readable
  - ima_kexec.sh: Move checking policy if readable to ima_setup.sh
  - IMA: Add example policy for ima_violations.sh
  - ima_violations.sh: Check for a required policy
  - [RFC] ima_kexec.sh: Relax result on unreadable policy to TCONF

TODO:
* ima_measurements.sh: check for example policy as an variant to
  ima_policy=tcb command line parameter.
* Use LTP shell loader for ima_boot_aggregate.c and ima_mmap.c


Petr Vorel (8):
  IMA: Add TCB policy as an example for ima_measurements.sh
  ima_setup.sh: Allow to load predefined policy
  tst_test.sh: IMA: Allow to disable LSM warnings and use it for IMA
  ima_setup: Print warning when policy not readable
  ima_kexec.sh: Move checking policy if readable to ima_setup.sh
  IMA: Add example policy for ima_violations.sh
  ima_violations.sh: Check for a required policy
  [RFC] ima_kexec.sh: Relax result on unreadable policy to TCONF

 .../kernel/security/integrity/ima/README.md   | 12 ++++
 .../ima/datafiles/ima_measurements/tcb.policy | 19 +++++
 .../ima_violations/violations.policy          |  1 +
 .../security/integrity/ima/tests/ima_kexec.sh | 10 +--
 .../integrity/ima/tests/ima_measurements.sh   | 17 ++++-
 .../security/integrity/ima/tests/ima_setup.sh | 72 ++++++++++++++++---
 .../integrity/ima/tests/ima_violations.sh     |  5 +-
 testcases/lib/tst_test.sh                     |  2 +-
 8 files changed, 118 insertions(+), 20 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy

-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
