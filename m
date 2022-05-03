Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80423C433EF
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 15:30:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F19463CA923
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:30:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 635793CA8C7
 for <ltp@lists.linux.it>; Tue,  3 May 2022 17:29:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D67E8200221
 for <ltp@lists.linux.it>; Tue,  3 May 2022 17:29:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D27042187D;
 Tue,  3 May 2022 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651591796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nKQaDU7a0wibuOb+HjQUwZu9PBVWAKpgxF+ek+cXtIg=;
 b=krcZHB8a1HjbFWT/f2NitmSTbVirZU3//S/MEx4G8vQDnf0lsFrdrMFmVFCIz4vRwt5Kx4
 O/DlVEi1XqONYqizsVeG30R0Oj6csbbC2e6zVmHKeuLlux6HrJBh/XHogH+dgYDEK67FfE
 7TtAUipujMPrYfjmmOex9OZGw1qnAAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651591796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nKQaDU7a0wibuOb+HjQUwZu9PBVWAKpgxF+ek+cXtIg=;
 b=2fcOVNu/heqgnkJhmFzBH+0Y22efuU8ROlg1sM4yPKCnMY0+E+yU9FTmN2XtecTkR9VCpI
 ywsYl7fvor3w9iCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59D1A13ABE;
 Tue,  3 May 2022 15:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id u/2PE3RKcWKtBQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 May 2022 15:29:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 17:29:46 +0200
Message-Id: <20220503152948.6369-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Fix constant redefinition
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

Hi,

sorry for introducing regression via merging unreviewed patchset.

Kind regards,
Petr

Petr Vorel (2):
  lapi/mount.h: Remove <linux/mount.h>
  Remove duplicate include of <sys/mount.h>

 include/lapi/fsmount.h                              | 7 +++++--
 include/lapi/mount.h                                | 6 +-----
 lib/tst_cgroup.c                                    | 1 -
 testcases/kernel/syscalls/open/open12.c             | 1 -
 testcases/kernel/syscalls/pivot_root/pivot_root01.c | 2 --
 testcases/kernel/syscalls/statx/statx06.c           | 1 -
 testcases/kernel/syscalls/umount2/umount2_01.c      | 1 -
 testcases/kernel/syscalls/umount2/umount2_02.c      | 1 -
 8 files changed, 6 insertions(+), 14 deletions(-)

-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
