Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5631C7EE23
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 13:35:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBE6F3CD180
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 15:35:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA7B23CA154
 for <ltp@lists.linux.it>; Fri, 26 May 2023 15:34:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 482A21A00646
 for <ltp@lists.linux.it>; Fri, 26 May 2023 15:34:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 49C341F74A;
 Fri, 26 May 2023 13:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685108076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Gi28/tVvZ8ZqmuQDDolxO12HLcMnjVD11atwuX+hFkw=;
 b=OYHHy47gQj0B10GmwNkiwpacQNT6RLVhspEqH4I89/QR6vshRtGtLuhmsWxPdjNCEmyTbH
 mUW56dKvGXEIvb4yuLtLa9MkGufcnsNeXf/Wc098P3fiuh9CKAdfHgSG5bcFVM9/v09Uec
 f5ZMHmaM904tX0YWvJ1regqD8M5KUZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685108076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Gi28/tVvZ8ZqmuQDDolxO12HLcMnjVD11atwuX+hFkw=;
 b=h2ALE8LxZ02dHkSzHe1wkmCFUOK4paqH8DDgSo1BlM+HnW+koFdtsv+2VoB1RHRMsFxfag
 AIZXUPV8ASrBtGAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35FCF138E6;
 Fri, 26 May 2023 13:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CxVEDGy1cGTMZQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 26 May 2023 13:34:36 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 26 May 2023 15:34:28 +0200
Message-Id: <20230526133435.7369-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/7] Two AMD SVM vulnerability tests
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
Cc: Nicolai Stange <nstange@suse.de>
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
 testcases/kernel/kvm/Makefile              |   4 +
 testcases/kernel/kvm/include/kvm_common.h  |   8 +
 testcases/kernel/kvm/include/kvm_guest.h   |  14 ++
 testcases/kernel/kvm/include/kvm_host.h    |  20 ++-
 testcases/kernel/kvm/include/kvm_x86_svm.h |   9 ++
 testcases/kernel/kvm/kvm_svm02.c           | 152 ++++++++++++++++++
 testcases/kernel/kvm/kvm_svm03.c           | 169 +++++++++++++++++++++
 testcases/kernel/kvm/lib_guest.c           |  16 ++
 testcases/kernel/kvm/lib_host.c            |  55 ++++++-
 14 files changed, 665 insertions(+), 8 deletions(-)
 create mode 100644 testcases/kernel/kvm/kvm_svm02.c
 create mode 100644 testcases/kernel/kvm/kvm_svm03.c

-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
