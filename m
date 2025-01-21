Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD61C0218B
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 16:45:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC33E3C296A
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 17:45:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 059503C29D3
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:31 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8DEDF1020C20
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34F142110B
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t+YBCJeLedKtkTefMIrVyPMmcDIzIctYtOStsSRYlwQ=;
 b=aV7HYzJtJ4YXwacs68bv/ujhoVvvs54zni+bTbCRJ3FUf5E9rEKgrk5V5AoS9zQOgAKDMj
 7f3pL+ngRQz+Rjf3bG4Rn9GvAu9ETM5xLUndbEknDMApmOBlZqKCL4k3o7GjKmLvISy7uq
 riaIxOyrvjqQ9OTmn1dKmlkPgGFuTSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t+YBCJeLedKtkTefMIrVyPMmcDIzIctYtOStsSRYlwQ=;
 b=08zJ/OBll8x5hNWu9ZTWKAH6xjgMGyzSYAayt38J6DLUMUenWx889emcZAplvygvSY/1I5
 VHgs3+hT7jnXtMAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t+YBCJeLedKtkTefMIrVyPMmcDIzIctYtOStsSRYlwQ=;
 b=aV7HYzJtJ4YXwacs68bv/ujhoVvvs54zni+bTbCRJ3FUf5E9rEKgrk5V5AoS9zQOgAKDMj
 7f3pL+ngRQz+Rjf3bG4Rn9GvAu9ETM5xLUndbEknDMApmOBlZqKCL4k3o7GjKmLvISy7uq
 riaIxOyrvjqQ9OTmn1dKmlkPgGFuTSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t+YBCJeLedKtkTefMIrVyPMmcDIzIctYtOStsSRYlwQ=;
 b=08zJ/OBll8x5hNWu9ZTWKAH6xjgMGyzSYAayt38J6DLUMUenWx889emcZAplvygvSY/1I5
 VHgs3+hT7jnXtMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E5B61387C
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IfWvBu3Oj2erPQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Jan 2025 17:44:14 +0100
Message-ID: <20250121164426.27977-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/10] Basic KVM test for Intel VMX
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

Since we already have some functional and CVE tests for AMD SVM, we should
also add tests for Intel VMX. This patchset adds the necessary support code
for creating nested VMs on Intel VMX and a simple functional test
for VMREAD/VMWRITE instructions similar to kvm_svm04.

The changes include refactoring of existing tests so let's merge it
after the upcoming LTP release.

Martin Doucha (10):
  kvm_read_sregs(): Read the TR segment register
  kvm_svm_vmrun(): Simplify VM state save/load with macros
  kvm_x86: Define CR0 flags and additional CPUID/MSR constants
  KVM: Implement helper functions for setting x86 control registers
  KVM: Add memcmp() helper function
  KVM: Add helper functions for nested Intel VMX virtualization
  lib: Add helper function for reloading kernel modules
  lib: Add helper function for reading boolean sysconf files
  kvm_pagefault01: Use library functions to reload KVM modules
  KVM: Add functional test for emulated VMREAD/VMWRITE instructions

 include/tst_module.h                       |   3 +
 include/tst_sys_conf.h                     |   2 +
 lib/tst_module.c                           |  28 ++
 lib/tst_sys_conf.c                         |  35 ++
 testcases/kernel/kvm/bootstrap_x86.S       | 123 ++++-
 testcases/kernel/kvm/bootstrap_x86_64.S    | 153 ++++--
 testcases/kernel/kvm/include/kvm_guest.h   |   2 +
 testcases/kernel/kvm/include/kvm_x86.h     |  19 +-
 testcases/kernel/kvm/include/kvm_x86_vmx.h | 201 ++++++++
 testcases/kernel/kvm/kvm_pagefault01.c     |  59 +--
 testcases/kernel/kvm/kvm_vmx01.c           | 282 +++++++++++
 testcases/kernel/kvm/lib_guest.c           |  12 +
 testcases/kernel/kvm/lib_x86.c             | 515 +++++++++++++++++++++
 13 files changed, 1322 insertions(+), 112 deletions(-)
 create mode 100644 testcases/kernel/kvm/include/kvm_x86_vmx.h
 create mode 100644 testcases/kernel/kvm/kvm_vmx01.c

-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
