Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE306C3DA63
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 18:00:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 559D03D1C79
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 20:00:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF5C63D1C12
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:59:15 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 522591A01526
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:59:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CB3B1FD60;
 Tue, 23 Jul 2024 17:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721757548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q1+NsdFw4uw0Y8nNtfNz29Rm6bFiSAQOoypVfkfb8NQ=;
 b=Vl8pmfNYlTi63sUDi4taF+YaQLYmyjbu3BacO3JJysmrNzwdQjli1ouu7m6qvTY59ggy4E
 d0/7KxpQxpxFX2R/9DdWX8wJNovNpzQtFpV0rezNJ4b+a6IJjUo/YDmCip4L+c5flPfY04
 aHBBHYkoLb3HxbThhdkVB3Kg91lNigU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721757548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q1+NsdFw4uw0Y8nNtfNz29Rm6bFiSAQOoypVfkfb8NQ=;
 b=019MeH2nasDNWuLY0Ehil5AFtBHE7rpqA4L/lYZdhc5qVEqbZQWXPyMRI91Y8j3bNraFM9
 hMd33bUKSEsHgkBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721757548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q1+NsdFw4uw0Y8nNtfNz29Rm6bFiSAQOoypVfkfb8NQ=;
 b=Vl8pmfNYlTi63sUDi4taF+YaQLYmyjbu3BacO3JJysmrNzwdQjli1ouu7m6qvTY59ggy4E
 d0/7KxpQxpxFX2R/9DdWX8wJNovNpzQtFpV0rezNJ4b+a6IJjUo/YDmCip4L+c5flPfY04
 aHBBHYkoLb3HxbThhdkVB3Kg91lNigU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721757548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q1+NsdFw4uw0Y8nNtfNz29Rm6bFiSAQOoypVfkfb8NQ=;
 b=019MeH2nasDNWuLY0Ehil5AFtBHE7rpqA4L/lYZdhc5qVEqbZQWXPyMRI91Y8j3bNraFM9
 hMd33bUKSEsHgkBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30BB51377F;
 Tue, 23 Jul 2024 17:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1Ic5BFTvn2aMEgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 17:58:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 17:41:02 +0200
Message-Id: <20240723-fchmodat2-v2-0-e658a98b113e@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA7Pn2YC/03MSw6CMBSF4a2QO7am9wZoceQ+DAPow3YANS02G
 tK9W4kDh//JybdDMtGbBJdmh2iyTz6sNejUgHLTejfM69pAnFreoWBWuSXoaSPWzZJkL7RAq6D
 +H9FY/zqs21jb+bSF+D7ojN/1pxD+KRkZZzjg3E6D7Ovhmp7JnFVYYCylfAAS7op6oQAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3472;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=d5IcFxXnzg2Q3BaTNNkde5q8k2ufxj+OOt1oD8bKylg=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn+9PmIE2oFW2gsgRsutVIHE1lSG7rTGcr7aBe
 Jc+eDaY+7SJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp/vTwAKCRDLzBqyILPm
 RiQ8DACbjpOqHNqrFYRFU270qcOubN7Pxm00HVRHScDLugMO+c1LH0k7PbSN50z+iC1fAWJWPeg
 0sTN1NDeCYdETT/VYUiRFzgJK3CfvrN1FNTr6bKPfC8LkZiwWQ1WpQjgi5DGabwlztRKTXQNVd9
 CLahbeyDzR+BaYd2rirEBec29/el5qJJ150wd0So1Jr9BYAjIr/K2P7zhMbcwPJHnCHpx8wkfkZ
 vOSua1f6Y3/UUmzBKj1rHdY2Y4XXdViictjKUyZ92cIPfPaIqZBgBbqS8ltg47mL98c5sydkrNU
 pRqePQ4+EoSY+5ZibIN2ZXhCLOJ7TroFl7bFs9cOE84Fjbq9c8GHkZvg6QyvuurpFL78JmcqH80
 0JcqzfIAXAOHJkJPLV6AAWikg75qx4JQhuTQd3tT0x1iJBT0QpaKxD3oWnU/D1Rhy3YYXNt1Xcj
 zL8FcYGtnnInCaFNrDmbCDLR+23El5mXTVosHVg+ngHGo7iUENC0wimyU89xYnjejKFCY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 phoronix.com:url]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/5] Add fchmodat2 testing suite
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

This is a patch-set that implements fchmodat2() syscall coverage.
fchmodat2() has been added in kernel 6.6 in order to support
AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
There's no man pages yet, so please take the following links as
main documentation along with kernel source code:

https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fdaad50@brauner/

***********
* WARNING *
***********

fchmodat2_02 fails with EOPNOTSUPP because of missing feature.
According to documentation, the feature has been implemented in
kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
on symbolic files. Also kselftests, which are meant to test the
functionality, are not working and they are treating fchmodat2()
syscall failure as SKIP. Please take a look at the following code
before reviewing:

https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- merge first 3 tests into a unique one
- move fchmodat2 in lapi/stat.h
- add test for error checking
- Link to v1: https://lore.kernel.org/r/20240521-fchmodat2-v1-0-191b4a986202@suse.com

---
Andrea Cervesato (5):
      Add SAFE_SYMLINKAT macro
      Add fchmodat2 syscalls definitions
      Add fchmodat2 fallback definition
      Add fchmodat2_01 test
      Add fchmodat2_02 test

 include/lapi/stat.h                                |  13 +++
 include/lapi/syscalls/aarch64.in                   |   1 +
 include/lapi/syscalls/arc.in                       |   1 +
 include/lapi/syscalls/arm.in                       |   1 +
 include/lapi/syscalls/hppa.in                      |   1 +
 include/lapi/syscalls/i386.in                      |   1 +
 include/lapi/syscalls/ia64.in                      |   1 +
 include/lapi/syscalls/loongarch.in                 |   1 +
 include/lapi/syscalls/mips_n32.in                  |   1 +
 include/lapi/syscalls/mips_n64.in                  |   1 +
 include/lapi/syscalls/mips_o32.in                  |   1 +
 include/lapi/syscalls/powerpc.in                   |   1 +
 include/lapi/syscalls/powerpc64.in                 |   1 +
 include/lapi/syscalls/s390.in                      |   1 +
 include/lapi/syscalls/s390x.in                     |   1 +
 include/lapi/syscalls/sh.in                        |   1 +
 include/lapi/syscalls/sparc.in                     |   1 +
 include/lapi/syscalls/sparc64.in                   |   1 +
 include/lapi/syscalls/x86_64.in                    |   1 +
 include/safe_macros_fn.h                           |   4 +
 include/tst_safe_macros.h                          |   3 +
 lib/safe_macros.c                                  |  20 ++++
 runtest/syscalls                                   |   3 +
 testcases/kernel/syscalls/fchmodat2/.gitignore     |   2 +
 testcases/kernel/syscalls/fchmodat2/Makefile       |   7 ++
 testcases/kernel/syscalls/fchmodat2/fchmodat2.h    |  20 ++++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 105 +++++++++++++++++++++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c |  68 +++++++++++++
 28 files changed, 263 insertions(+)
---
base-commit: c5d95b6d34e2356bd19e6b646da06f1bce66a024
change-id: 20240517-fchmodat2-5b82867d71fc

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
