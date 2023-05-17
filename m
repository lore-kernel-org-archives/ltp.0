Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F591C77B7F
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 15:37:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41BD63CDCA2
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 17:37:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 605983CB8F3
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:36:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C73FD600A4C
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:36:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E920A1FF9F;
 Wed, 17 May 2023 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684337802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eyUv3n7bHSswH66CIcKc3OdYaR1eWVTGUe47L/U2G/c=;
 b=Eyd2B4vszRvtZco+Gm2s5Ws4dG8/AlB5t+gF1yd5Rwm8MRbzOhjccz7xzQf/KDG2QuNx+F
 9zp4Vlk3atLyNFod6CAt/v/o5yuZZPjcA6E/MJelwzr12Sy0+XUHZr6XJFUJorD102qJeE
 zE33Dya5ciKV/jwQ3sS+/S6qepFIviI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684337802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eyUv3n7bHSswH66CIcKc3OdYaR1eWVTGUe47L/U2G/c=;
 b=gCf6BCEXTDGryfNwiUM6yV0MJVbKkHKL9Md16205SjUsDyhYrqYnQCdpZ+Z8jCae4FGkmB
 rgJ9Ps4Qs+8HOOAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8EDE13478;
 Wed, 17 May 2023 15:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lBlBNIr0ZGSTCgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 17 May 2023 15:36:42 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Nicolai Stange <nstange@suse.de>,
	ltp@lists.linux.it
Date: Wed, 17 May 2023 17:36:35 +0200
Message-Id: <20230517153642.26919-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/7] Two AMD SVM vulnerability tests
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

Here are two more kernel vulnerability tests for AMD SVM:

kvm_svm02 checks that the host kernel intercepts VMLOAD and VMSAVE
instructions in nested VMs and translates guest addresses to the correct
physical address. Without the translation, nested SVM guest can read and
write part of an arbitrary physical memory page chosen by the parent VM.

The test tries to detect the CVE bug harmlessly at first by using VMLOAD
to read a buffer full of zeroes. If it finds any non-zero bytes in the VMCB
fields accessed by VMLOAD/VMSAVE, it'll fail because they must have come
from host memory due to missing address translation.

Since the harmless approach can produce false negatives, it'll also try
a destructive approach and write into memory using VMSAVE. If the bug
is present, the byte pattern in the destination buffer will not change
and the test will reliably fail.

kvm_svm03 checks that the host kernel correctly handles global interrupt
flag in nested VMs. Otherwise a malicious VM could lock up all CPUs
assigned to it, causing a limited denial of service attack.

The test needs synchronization between the VM and another host thread so
the patchset includes the necessary helper functions.

Martin Doucha (7):
  KVM: Add VMSAVE/VMLOAD intercept constants
  Add test for CVE 2021-3656
  lib: Add safe functions for pthread_kill() and mutexes
  KVM: Add async communication helper functions
  KVM: Allow expected KVM_RUN errors in tst_kvm_run_instance()
  KVM: Add STGI/CLGI intercept constants
  Add KVM test for CPU lockup through malicous SVM guest

 doc/kvm-test-api.txt                       |   9 +-
 include/tst_safe_pthread.h                 |  52 +++++++
 lib/safe_pthread.c                         | 161 ++++++++++++++++++++
 runtest/kvm                                |   2 +
 testcases/kernel/kvm/.gitignore            |   2 +
 testcases/kernel/kvm/Makefile              |   3 +
 testcases/kernel/kvm/include/kvm_common.h  |   8 +
 testcases/kernel/kvm/include/kvm_guest.h   |  14 ++
 testcases/kernel/kvm/include/kvm_host.h    |  21 ++-
 testcases/kernel/kvm/include/kvm_x86_svm.h |   7 +
 testcases/kernel/kvm/kvm_svm02.c           | 159 ++++++++++++++++++++
 testcases/kernel/kvm/kvm_svm03.c           | 164 +++++++++++++++++++++
 testcases/kernel/kvm/lib_guest.c           |  16 ++
 testcases/kernel/kvm/lib_host.c            |  46 +++++-
 14 files changed, 656 insertions(+), 8 deletions(-)
 create mode 100644 testcases/kernel/kvm/kvm_svm02.c
 create mode 100644 testcases/kernel/kvm/kvm_svm03.c

-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
