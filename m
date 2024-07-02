Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EADC30658
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 07:39:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C40FC3D3EAC
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 09:39:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1C8E3D3EA6
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:38:38 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8F320207239
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:38:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8DB491FB90;
 Tue,  2 Jul 2024 07:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719905916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JototY1wY2s3wvRD5rbuLE6TBWokIuwFLiPqLYcncdk=;
 b=ySJWOe/IeuU5jRuxV+NIrVOZlLVfvQKTseyvDr47vkIjAVAtbOX+T37KmtSY4WA2B/XZmT
 /Zx1ry0ccbLQgipPruXys/BpPzFOksZgN1uygLqAkeWTHJvBRUFCs+Tz8sF5LYvVwyiwtF
 /kZh6/Esbkgk7973hfbPUIC8o6vcoKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719905916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JototY1wY2s3wvRD5rbuLE6TBWokIuwFLiPqLYcncdk=;
 b=hSKs1j2iKQCbDBBW4VkGvsNZmK8x8K98/2qWXNiKuH6n2O/4YlkqQEku4JLfYKKVTDGO6f
 QmQ07bHv/5dCkGCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ySJWOe/I";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hSKs1j2i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719905916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JototY1wY2s3wvRD5rbuLE6TBWokIuwFLiPqLYcncdk=;
 b=ySJWOe/IeuU5jRuxV+NIrVOZlLVfvQKTseyvDr47vkIjAVAtbOX+T37KmtSY4WA2B/XZmT
 /Zx1ry0ccbLQgipPruXys/BpPzFOksZgN1uygLqAkeWTHJvBRUFCs+Tz8sF5LYvVwyiwtF
 /kZh6/Esbkgk7973hfbPUIC8o6vcoKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719905916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JototY1wY2s3wvRD5rbuLE6TBWokIuwFLiPqLYcncdk=;
 b=hSKs1j2iKQCbDBBW4VkGvsNZmK8x8K98/2qWXNiKuH6n2O/4YlkqQEku4JLfYKKVTDGO6f
 QmQ07bHv/5dCkGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6232813A9A;
 Tue,  2 Jul 2024 07:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zPL5FXyug2aUCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 02 Jul 2024 07:38:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 02 Jul 2024 09:38:16 +0200
Message-Id: <20240702-unlink09-v4-0-d8df24772a76@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGiug2YC/23MTQ7CIBCG4asY1mJgoH+uvIdxUWCwRKUGLNE0v
 bu0K2JcfpN53plEDA4jOe5mEjC56Eafh9zviB56f0XqTN4EGEhWM0knf3f+xjpqtGwZ2LYB25H
 8/gxo3XtLnS95Dy6+xvDZyomv1z+RxCmnxpoWBXKtQJ3iFPGgxwdZGwlKVxUOKKPK9kwpo9umE
 j9OlK4unMhONFrXHDQyawq3LMsXtdlsqQ8BAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=zclnxE7392H7vtZn2KJBX3b7HSyhYQQc+tkF7w7Y51A=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmg65uOtBj3tDxfmx/zIiUJe+9TOsrxF+hGRLY9
 h8mNT29jgKJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoOubgAKCRDLzBqyILPm
 RrRKDACemYoUeWHBT9dZI188mKDlgONQaMNOQ/Gib1SFn+g21ZsROkbDu8oS6d5y8zKl62G2sRb
 Z/HaVq30hb0clzgNEZwFrP6nI6dMFXHxYvymeJuALW/NV/5PWw2NpcPcInYNp9EquRlzGsVEfWV
 J8hdzMGzEYPPEKkpSDdaVNf8PzTqXsfpLzPRvz2MkyQnbDriOMKJifJ7MZ519K8uBPQ/JgHoR20
 G+nTxdpE3mdoQgxa15SlYTRR+nSWLMReLZFlAwXGnVHE/D1SvcsNROAHNjiQQh1jSu5KeP6+Svg
 femV0RnyfFXDa5U4L6BS/jfoDAW5Gh9w1ZCYZaIKHOQ8AF9kZc2Bs5am73Dmj2WFCUuTkIGNz/Y
 oFh4J+JiJAHy3H1Mr4ze+fejg9Q0LJdENu6niPyomK9kTNcqXd13cDWHKCIuLW2pGdJ3sg69tCs
 K7/jIWk2ZWuaUP4mQE+fCglLq+yMksRlQtWGIWt7ThqXC6hyf+61O4CWs7COTtSLNUbiA=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8DB491FB90
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] Fix unlink09 test
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

This will fix the 2cf78f47a6 and resolve issues on filesystems
which are not supporting inode attributes. Split unlink09 read-only
check and move it into unlink10.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- added exfat and fuse to .skip_filesystems
- Link to v3: https://lore.kernel.org/r/20240606-unlink09-v3-0-37cc612ce0fd@suse.com

Changes in v3:
- added .mount_device = 1
- added .skip_filesystems (vfat and ntfs)
- skip test execution when the tmpfs is used on kernel<6.0
- Link to v2: https://lore.kernel.org/r/20240605-unlink09-v2-0-bfa0bbdc8753@suse.com

Changes in v2:
- moved read-only FS check out of unlink09 and created unlink10
- check when FS doesn't support inode attributes and print a TBROK
- simplified inode attributes setup by adding a common function
- added .all_filesystems support
- Link to v1: https://lore.kernel.org/r/20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com

---
Andrea Cervesato (2):
      Fix unlink09 test
      Add unlink10 test

 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/unlink/.gitignore |   1 +
 testcases/kernel/syscalls/unlink/unlink09.c | 108 ++++++++++++++++------------
 testcases/kernel/syscalls/unlink/unlink10.c |  33 +++++++++
 4 files changed, 99 insertions(+), 44 deletions(-)
---
base-commit: 072f359ac54395af1d5ade4ca8cc347c5afe6310
change-id: 20240604-unlink09-dc4802f872f9

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
