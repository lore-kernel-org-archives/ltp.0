Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2F6C433F5
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 12:34:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B4AC3CA6F1
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 14:34:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 405B23CA6F8
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 14:33:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D7F336009E2
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 14:33:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E826821112
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 12:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650544431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FVJdIc4u8SMOTUhlLPlysYks10DilhXM9w9pyl/AkwU=;
 b=DTNBvSWafcoyVqJUsKoCVK3Gqam0ap2BS4rzsjKHURMOyjWUSqpQt7rY8UEMCJP+nuZ4Y4
 XPaVaLKpzkmU4hdChQXob1TFei+nhoJkvsrknOTbJyACnq0apx8m6bvHtT1h4eIvHfyDbd
 N7wELV1BFLDicWgBe3k73FbsV61Rf/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650544431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FVJdIc4u8SMOTUhlLPlysYks10DilhXM9w9pyl/AkwU=;
 b=2K4pV4Byc1zjok5PBtN3CPTbPOQ4MxAZo0SYqrRtk5nxdBu2lvdhs42xa4tmNyrRNgYOB2
 42nXrFwo1PgKnsDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D961513A84
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 12:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gHAwNC9PYWL/GgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 12:33:51 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 21 Apr 2022 14:33:49 +0200
Message-Id: <20220421123351.17645-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] KVM testing
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

Implement LTP infrastructure for tests which require executing a special
program inside KVM virtual machine. Basic test for CVE 2021-38198 written
using the KVM infrastrucutre (pagetable permission check bypass under software
emulated MMU) is included.

Martin Doucha (2):
  KVM test infrastructure
  Add test for CVE 2021-38198

 configure.ac                              |   3 +
 include/mk/config.mk.in                   |   2 +
 include/mk/env_post.mk                    |   1 +
 include/mk/rules.mk                       |   8 +
 runtest/kvm                               |   1 +
 testcases/kernel/Makefile                 |   1 +
 testcases/kernel/kvm/.gitignore           |   1 +
 testcases/kernel/kvm/Makefile             |  62 +++
 testcases/kernel/kvm/bootstrap_x86.S      | 368 ++++++++++++++++
 testcases/kernel/kvm/bootstrap_x86_64.S   | 515 ++++++++++++++++++++++
 testcases/kernel/kvm/include/kvm_common.h |  31 ++
 testcases/kernel/kvm/include/kvm_guest.h  |  85 ++++
 testcases/kernel/kvm/include/kvm_host.h   | 115 +++++
 testcases/kernel/kvm/include/kvm_test.h   |  23 +
 testcases/kernel/kvm/include/kvm_x86.h    | 157 +++++++
 testcases/kernel/kvm/kvm_pagefault01.c    | 234 ++++++++++
 testcases/kernel/kvm/lib_guest.c          | 179 ++++++++
 testcases/kernel/kvm/lib_host.c           | 215 +++++++++
 testcases/kernel/kvm/lib_x86.c            | 150 +++++++
 testcases/kernel/kvm/linker/payload.lds   |  11 +
 testcases/kernel/kvm/linker/x86.lds       |  74 ++++
 testcases/kernel/kvm/linker/x86_64.lds    |  74 ++++
 22 files changed, 2310 insertions(+)
 create mode 100644 runtest/kvm
 create mode 100644 testcases/kernel/kvm/.gitignore
 create mode 100644 testcases/kernel/kvm/Makefile
 create mode 100644 testcases/kernel/kvm/bootstrap_x86.S
 create mode 100644 testcases/kernel/kvm/bootstrap_x86_64.S
 create mode 100644 testcases/kernel/kvm/include/kvm_common.h
 create mode 100644 testcases/kernel/kvm/include/kvm_guest.h
 create mode 100644 testcases/kernel/kvm/include/kvm_host.h
 create mode 100644 testcases/kernel/kvm/include/kvm_test.h
 create mode 100644 testcases/kernel/kvm/include/kvm_x86.h
 create mode 100644 testcases/kernel/kvm/kvm_pagefault01.c
 create mode 100644 testcases/kernel/kvm/lib_guest.c
 create mode 100644 testcases/kernel/kvm/lib_host.c
 create mode 100644 testcases/kernel/kvm/lib_x86.c
 create mode 100644 testcases/kernel/kvm/linker/payload.lds
 create mode 100644 testcases/kernel/kvm/linker/x86.lds
 create mode 100644 testcases/kernel/kvm/linker/x86_64.lds

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
