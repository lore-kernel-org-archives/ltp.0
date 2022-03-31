Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B35C433EF
	for <ltp@archiver.kernel.org>; Thu, 31 Mar 2022 11:34:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98E533C9F04
	for <ltp@archiver.kernel.org>; Thu, 31 Mar 2022 13:34:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 755F73C8B2A
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 13:33:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2A6B41A00A3C
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 13:33:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2856721A9A
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 11:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648726405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Rrt6eRckNpEh79l/uqkjI84qFCO0g37ZWEx608nZUgo=;
 b=oZaCmmldzrFFwn3b7kmCgMro0psd3+SIuaD60RxGSsP5xR5QzQ3JbjI2dkTK2EAs4aIroF
 orW6szLCBcmu761SvclbAP+HfrVUpJ5pPaCIOa9kLXJgtkfnsCjcqcXeXy1AwD7OR/Ti4x
 ytoqsdJZoDFSNI4J1NTum37yXcG6o9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648726405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Rrt6eRckNpEh79l/uqkjI84qFCO0g37ZWEx608nZUgo=;
 b=KnYjWP5Aj9u3Of8qCiwvJ4hlUle7GukH1XuAn+/JdUY9v+iSNMHWZRYEqNV2pHv5RivW/8
 uX/MtyZd3hQrB8Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1763B132DC
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 11:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h//QBIWRRWKCeQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 11:33:25 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 31 Mar 2022 13:33:21 +0200
Message-Id: <20220331113324.14742-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] KVM testing
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

Martin Doucha (3):
  Add AX_CHECK_COMPILE_FLAG() autoconf macro
  KVM test infrastructure
  Add test for CVE 2021-38198

 configure.ac                              |   3 +
 include/mk/config.mk.in                   |   2 +
 include/mk/env_post.mk                    |   1 +
 include/mk/rules.mk                       |   8 +
 m4/ax_check_compile_flag.m4               |  53 +++
 runtest/kvm                               |   1 +
 testcases/kernel/Makefile                 |   1 +
 testcases/kernel/kvm/.gitignore           |   1 +
 testcases/kernel/kvm/Makefile             |  62 +++
 testcases/kernel/kvm/bootstrap_x86.S      | 368 ++++++++++++++++
 testcases/kernel/kvm/bootstrap_x86_64.S   | 515 ++++++++++++++++++++++
 testcases/kernel/kvm/include/kvm_common.h |  31 ++
 testcases/kernel/kvm/include/kvm_guest.h  |  82 ++++
 testcases/kernel/kvm/include/kvm_host.h   | 115 +++++
 testcases/kernel/kvm/include/kvm_test.h   |  23 +
 testcases/kernel/kvm/include/kvm_x86.h    | 157 +++++++
 testcases/kernel/kvm/kvm_pagefault01.c    | 234 ++++++++++
 testcases/kernel/kvm/lib_guest.c          | 183 ++++++++
 testcases/kernel/kvm/lib_host.c           | 215 +++++++++
 testcases/kernel/kvm/lib_x86.c            | 150 +++++++
 testcases/kernel/kvm/linker/payload.lds   |  11 +
 testcases/kernel/kvm/linker/x86.lds       |  74 ++++
 testcases/kernel/kvm/linker/x86_64.lds    |  74 ++++
 23 files changed, 2364 insertions(+)
 create mode 100644 m4/ax_check_compile_flag.m4
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
