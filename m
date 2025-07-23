Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05DEC83F1A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 16:05:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F8343CCD81
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 18:05:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A77873C7B97
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 18:05:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D7CD1200B05
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 18:05:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C9A1218F4;
 Wed, 23 Jul 2025 16:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753286735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AooMuKK0EJlG/MlQ+HCJT2LVd0HrOhCT0oBa3Jfo48I=;
 b=qs0iDg0t72Jgze22ib5FGKqOpvivu1sh6dfDPeC7Xwym1CtYiXucO/3FI2E/sC/8MT0gxL
 7UpokGc1fcqyOg0chYnC2DsD5OoxTyZVOW9f5S6VtZ2WNT+EGD57QZflC9C+sHwgxgu8xq
 iTw3MsCWK0ZOMiXPMl/CtRlymInblG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753286735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AooMuKK0EJlG/MlQ+HCJT2LVd0HrOhCT0oBa3Jfo48I=;
 b=9O4gT2snRxQgs5NTuJ6vDC8HgFM1FFp8eqqSbwI/cEtkol4oxPFCpm7WFhRclgIQouShLi
 fP8HF4ZSuizr58CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753286735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AooMuKK0EJlG/MlQ+HCJT2LVd0HrOhCT0oBa3Jfo48I=;
 b=qs0iDg0t72Jgze22ib5FGKqOpvivu1sh6dfDPeC7Xwym1CtYiXucO/3FI2E/sC/8MT0gxL
 7UpokGc1fcqyOg0chYnC2DsD5OoxTyZVOW9f5S6VtZ2WNT+EGD57QZflC9C+sHwgxgu8xq
 iTw3MsCWK0ZOMiXPMl/CtRlymInblG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753286735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AooMuKK0EJlG/MlQ+HCJT2LVd0HrOhCT0oBa3Jfo48I=;
 b=9O4gT2snRxQgs5NTuJ6vDC8HgFM1FFp8eqqSbwI/cEtkol4oxPFCpm7WFhRclgIQouShLi
 fP8HF4ZSuizr58CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08F8213ABE;
 Wed, 23 Jul 2025 16:05:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4hQ8AE8IgWhiUAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 23 Jul 2025 16:05:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 23 Jul 2025 18:04:48 +0200
Message-Id: <20250723-xattr_bug_repr-v5-0-63183d865e97@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACAIgWgC/33Q0QqCMBTG8VeJXbdwZ5tzXfUeEeLmsXZRyqbDE
 N+9KQRi0OV34Pe/OBMJ6B0Gcj5MxGN0wbWvNOTxQOyjet2RujptAhnITGVAx6rvfWmGe+mx81Q
 WiptCKA2NIQl1Hhs3rsHrLe2HC33r32s/suX6TfF9KjLKqKxtI+saC5OzSxgCnmz7JEspwn8NS
 TMpUFcNgsj5TvOt1j+a04xypS1Y0MwYtdNio+HnCVEkLQwylIBa2Xyj53n+APhmFoBlAQAA
X-Change-ID: 20250702-xattr_bug_repr-5873b84792fb
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753286734; l=1490;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=wvbQfzL3u/bsmF7vPb3an8LpHfyt5XWF8UAVQlxPAlY=;
 b=KFkYNudV0PKsk0gC95KYpzusXyo7fJgZMUetpHbFnVwmhOtVEqzTZ0IfeAlrsURg+qWSmupXE
 bbjf56KHjurAaWAC28quQhHUuZWwc3+xBjpy0QZ8zKLjeqj2x4meVXg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/2] Add listxattr04 test reproducer
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

Reproducer for https://lore.kernel.org/linux-fsdevel/m1wm9qund4.fsf@gmail.com/T/

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v5:
- add tst_lsm_enabled()
- Link to v4: https://lore.kernel.org/r/20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com

Changes in v4:
- check if SELinux is enabled by looking at the mount point
- Link to v3: https://lore.kernel.org/r/20250709-xattr_bug_repr-v3-0-379c2c291bb7@suse.com

Changes in v3:
- add tst_selinux_enabled() utility
- Link to v2: https://lore.kernel.org/r/20250703-xattr_bug_repr-v2-1-154e9afe2463@suse.com

Changes in v2:
- only check if SELinux is up and running
- Link to v1: https://lore.kernel.org/r/20250703-xattr_bug_repr-v1-1-5dcf5dde8b61@suse.com

---
Andrea Cervesato (2):
      core: add tst_selinux_enabled() utility
      Add listxattr04 reproducer

 include/tst_security.h                            |   4 +
 lib/tst_security.c                                |  30 +++++-
 testcases/kernel/syscalls/listxattr/.gitignore    |   1 +
 testcases/kernel/syscalls/listxattr/Makefile      |   2 +
 testcases/kernel/syscalls/listxattr/listxattr04.c | 114 ++++++++++++++++++++++
 testcases/kernel/syscalls/lsm/lsm_common.h        |  34 +------
 6 files changed, 153 insertions(+), 32 deletions(-)
---
base-commit: 87cde3ff47d0728b7e7f937c6b20d7a95ad4e4aa
change-id: 20250702-xattr_bug_repr-5873b84792fb

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
