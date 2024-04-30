Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C1BC4345F
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 12:23:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8370F3CB42F
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 14:23:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 207A63CB3F0
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:06 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 670D914004EB
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE58834026
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vEAJXqcH5QepFIBdueze4HQ/SiO8qZ6Yo7NIfqrIwEI=;
 b=M8BPEZ1jsntTyQfZxLIlVQJdFnI2OU0XDG1ZLNKs2FwWiPpgoUxjUg4UXVVUPAeUYMngZe
 Dsf+hix4b9CYl4L4EbX4ERO4onL9YSXrcaPd6ZqQwqATRGOaav0EDKUgQg9lVgII8K42/q
 8EcI8BYXONt+orfjTmRXYEHgUgs7ewg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vEAJXqcH5QepFIBdueze4HQ/SiO8qZ6Yo7NIfqrIwEI=;
 b=wEI/vIoXa396hgiAVe0OcnVvKss4lSNfq5N5PAOFnTfAMnYfa/PSY1GxXxSuhmhYKEwJBc
 TNX4wrUu1ShWb2Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M8BPEZ1j;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="wEI/vIoX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vEAJXqcH5QepFIBdueze4HQ/SiO8qZ6Yo7NIfqrIwEI=;
 b=M8BPEZ1jsntTyQfZxLIlVQJdFnI2OU0XDG1ZLNKs2FwWiPpgoUxjUg4UXVVUPAeUYMngZe
 Dsf+hix4b9CYl4L4EbX4ERO4onL9YSXrcaPd6ZqQwqATRGOaav0EDKUgQg9lVgII8K42/q
 8EcI8BYXONt+orfjTmRXYEHgUgs7ewg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vEAJXqcH5QepFIBdueze4HQ/SiO8qZ6Yo7NIfqrIwEI=;
 b=wEI/vIoXa396hgiAVe0OcnVvKss4lSNfq5N5PAOFnTfAMnYfa/PSY1GxXxSuhmhYKEwJBc
 TNX4wrUu1ShWb2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7CF8136A8
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PvrHKKjiMGaQHAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Apr 2024 14:21:56 +0200
Message-ID: <20240430122208.13043-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AE58834026
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/9] Add functional test for AMD VMSAVE/VMLOAD
 instructions
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

Thanks to a minor bug in LTP KVM library, LTP test kvm_svm02 found a kernel
bug in emulation of VMSAVE and VMLOAD instructions in nested VMs. Add
a thorough functional test for both instructions which can detect and pinpoint
emulation bugs.

Also implement basic printf-like formatting for tst_res() and tst_brk() so
that the test can print incorrect register values to simplify result analysis.
Only standard integer and character conversions are supported. Floating point
number conversions, field alignment and padding are not implemented.

Martin Doucha (9):
  KVM: Disable EBP register use in 32bit code
  KVM: Implement strchr() and basic sprintf()
  KVM: Implement printf-like formatting for tst_res() and tst_brk()
  kvm_svm02: Fix saved stack segment index value
  kvm_find_free_descriptor(): Skip descriptor 0
  KVM: Add system control MSR constants
  KVM: Add VMSAVE/VMLOAD functions to x86 SVM library
  KVM: Add functional test for VMSAVE/VMLOAD instructions
  KVM: Move kvm_pagefault01 to the end of KVM runfile

 runtest/kvm                                |   4 +-
 testcases/kernel/kvm/.gitignore            |   1 +
 testcases/kernel/kvm/Makefile              |   2 +-
 testcases/kernel/kvm/include/kvm_guest.h   |  23 +-
 testcases/kernel/kvm/include/kvm_x86.h     |  10 +
 testcases/kernel/kvm/include/kvm_x86_svm.h |   6 +
 testcases/kernel/kvm/kvm_svm02.c           |  14 +-
 testcases/kernel/kvm/kvm_svm04.c           | 307 ++++++++++++++++++
 testcases/kernel/kvm/lib_guest.c           | 348 ++++++++++++++++++++-
 testcases/kernel/kvm/lib_x86.c             |  20 +-
 10 files changed, 713 insertions(+), 22 deletions(-)
 create mode 100644 testcases/kernel/kvm/kvm_svm04.c

-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
