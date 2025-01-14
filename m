Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC7FE77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 11:30:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4813F3C7A3B
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 12:30:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42E793C7A26
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 12:29:25 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6216D665579
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 12:29:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6BB552117C;
 Tue, 14 Jan 2025 11:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736854163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fO/s0NZFEMKAk0O+hRINtnsWQ1xdbifZa+NKDJ5KFd8=;
 b=LUpwNvJd3SX7e3G+1gnh2kuSdpxP7DIYWRi9+D7SRV6XOADTZ18pJCFN2uleZt691uQzEc
 M4fWq0vLCZTUWxSFESxbU+1JT0eaBpDCmHRDlqFUn1mvNzAMqHX4aCo3t0W+kWQ+ydDroo
 kQOw8+eKMtaMHMi0hnT8cAAHUrapiJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736854163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fO/s0NZFEMKAk0O+hRINtnsWQ1xdbifZa+NKDJ5KFd8=;
 b=RYIGfKg5isC934otZjO4An+0/xzy2R9wONn2owIkTREnsyPV7FKUiZ4BtqK3zzIGlD9f3X
 nrdv5eWcpZsH3SCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736854163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fO/s0NZFEMKAk0O+hRINtnsWQ1xdbifZa+NKDJ5KFd8=;
 b=LUpwNvJd3SX7e3G+1gnh2kuSdpxP7DIYWRi9+D7SRV6XOADTZ18pJCFN2uleZt691uQzEc
 M4fWq0vLCZTUWxSFESxbU+1JT0eaBpDCmHRDlqFUn1mvNzAMqHX4aCo3t0W+kWQ+ydDroo
 kQOw8+eKMtaMHMi0hnT8cAAHUrapiJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736854163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fO/s0NZFEMKAk0O+hRINtnsWQ1xdbifZa+NKDJ5KFd8=;
 b=RYIGfKg5isC934otZjO4An+0/xzy2R9wONn2owIkTREnsyPV7FKUiZ4BtqK3zzIGlD9f3X
 nrdv5eWcpZsH3SCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BC99139CB;
 Tue, 14 Jan 2025 11:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b7RgDZNKhmeMIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 11:29:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 Jan 2025 12:29:05 +0100
Message-ID: <20250114112915.610297-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 00/10] LTP tests: load predefined policy,
 enhancements
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

Changes v2->v3:
* Rewrite verifying logic if policy needs to be loaded and how it is
  loaded.
* Allow testing when policy is not reliable, but relax failures to TCONF.
* Add TCB policy example.
* Document LTP_IMA_LOAD_POLICY in doc/users/setup_tests.rst.
* Fix test policy installation (previously wrong Makefile).
* Removed some of the previous commits ("ima_kexec.sh: Relax result on
  unreadable policy to TCONF", "ima_violations.sh: Check for a required policy",
  "ima_setup: Print warning when policy not readable").
* More cleanup.

TODO: ima_measurements.sh and ima_violations.sh use detection for
ima_policy=tcb builtin policy. But if example policy is loaded there is
no longer tcb policy. Not sure how to fix it - some tooling might not
support reboot, thus I wanted to use ima_policy=tcb, which previously
worked.

Petr Vorel (10):
  ima_violations.sh: Fix log detection
  IMA: Add TCB policy as an example for ima_measurements.sh
  IMA: Move requirement check to ima_setup.sh
  IMA: Add example policy for ima_violations.sh
  IMA: Read required policy from file
  ima_violations.sh: Declare tcb builtin policy
  ima_setup.sh: Add digest index detection for ima-buf format
  ima_setup.sh: Allow to load predefined policy
  ima_measurements.sh: Check policy for test3
  tst_test.sh: IMA: Allow to disable LSM warnings and use it for IMA

 doc/users/setup_tests.rst                     |   3 +
 .../kernel/security/integrity/ima/README.md   |  12 ++
 .../security/integrity/ima/datafiles/Makefile |   4 +-
 .../ima/datafiles/ima_measurements/Makefile   |  11 ++
 .../ima/datafiles/ima_measurements/tcb.policy |  20 +++
 .../ima/datafiles/ima_violations/Makefile     |  11 ++
 .../ima_violations/violations.policy          |   2 +
 .../integrity/ima/tests/evm_overlay.sh        |   3 +-
 .../security/integrity/ima/tests/ima_kexec.sh |  20 +--
 .../security/integrity/ima/tests/ima_keys.sh  |  48 ++-----
 .../integrity/ima/tests/ima_measurements.sh   |  19 ++-
 .../integrity/ima/tests/ima_selinux.sh        |  23 ++-
 .../security/integrity/ima/tests/ima_setup.sh | 135 +++++++++++++++---
 .../integrity/ima/tests/ima_violations.sh     |  15 +-
 testcases/lib/tst_test.sh                     |   4 +-
 15 files changed, 235 insertions(+), 95 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_measurements/Makefile
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_violations/Makefile
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy

-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
