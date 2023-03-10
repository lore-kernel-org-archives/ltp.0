Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD24C6FA99
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 12:42:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5B723CB7B1
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 13:42:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F8813CADCD
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 13:41:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 84B71600690
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 13:41:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 767202064D;
 Fri, 10 Mar 2023 12:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678452090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6JZf2KdrfDiFCf00qf8MI70Wab1HpvnquSbkCTX2b1Q=;
 b=FBpw29JyKIeH2ocoK0Rq1nipQenM7LVfaqx7G+3b3coUTBjb8SH1Up11XXaIVtwTvZ3NMy
 jqHQu0JNYc203MqlOrOkkPtrlgUsmWyvY9/IXkG2Ylr5r5flzWfWZFzUOBUqoidaOTIO6W
 9MjR84wimprVJ6TnxWbwhfmPwKS+CTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678452090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6JZf2KdrfDiFCf00qf8MI70Wab1HpvnquSbkCTX2b1Q=;
 b=kgr7Cbj1rRu6jsoqqM2BXzTemN+hfNLGcOHjX2bf0s5W65XiUvmq4JL/QqXyYyFm7Oq9lo
 eIOsfjZtrKrFfqBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54FF713592;
 Fri, 10 Mar 2023 12:41:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Sk7jEnolC2T1JgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 10 Mar 2023 12:41:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Mar 2023 13:41:22 +0100
Message-Id: <20230310124125.14279-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Move container utils to testcases/lib/
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

Preparation for https://github.com/linux-test-project/ltp/issues/991.

NOTE: this patch conflicts with my other patch [1]
(touching testcases/lib/{Makefile,.gitignore}).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20230307145517.1359-2-pvorel@suse.cz/


Petr Vorel (3):
  ns_exec.c: Rename to testcases/lib/tst_ns_exec.c
  ns_create.c: Rename to testcases/lib/tst_ns_create.c
  ns_ifmove.c: Rename to testcases/lib/tst_ns_ifmove.c

 doc/namespaces-helper-tools.txt               | 14 ++++++------
 .../ns_common.h => include/tst_ns_common.h    |  6 ++---
 .../kernel/containers/netns/netns_lib.sh      | 22 +++++++++----------
 .../kernel/containers/netns/netns_sysfs.sh    | 13 ++++++-----
 testcases/kernel/containers/share/.gitignore  |  3 ---
 testcases/kernel/containers/share/Makefile    | 22 -------------------
 testcases/kernel/fs/fs_bind/fs_bind_lib.sh    |  7 +++---
 testcases/lib/.gitignore                      |  3 +++
 testcases/lib/Makefile                        |  2 +-
 testcases/lib/tst_net.sh                      | 16 +++++++-------
 .../share/ns_create.c => lib/tst_ns_create.c} |  5 +++--
 .../share/ns_exec.c => lib/tst_ns_exec.c}     |  8 +++----
 .../share/ns_ifmove.c => lib/tst_ns_ifmove.c} |  2 +-
 13 files changed, 52 insertions(+), 71 deletions(-)
 rename testcases/kernel/containers/share/ns_common.h => include/tst_ns_common.h (89%)
 delete mode 100644 testcases/kernel/containers/share/.gitignore
 delete mode 100644 testcases/kernel/containers/share/Makefile
 rename testcases/{kernel/containers/share/ns_create.c => lib/tst_ns_create.c} (92%)
 rename testcases/{kernel/containers/share/ns_exec.c => lib/tst_ns_exec.c} (91%)
 rename testcases/{kernel/containers/share/ns_ifmove.c => lib/tst_ns_ifmove.c} (97%)

-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
