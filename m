Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B311C88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 13:15:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4CDE3E9225
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:15:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 840EF3E2E82
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:14:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A970B600634
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:14:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F86D1FEF4;
 Fri, 11 Sep 2026 13:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789132481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2qJLL3rHL+fUVExfpvMwQkZQqPtrWgBCe5PDBL3iV3I=;
 b=ZOjKysouMN4KzBQ8yu1Dor8kFgR2w6ZBpa53mM6W5ViFvWCuPzYOut/6OzCpndxVKbMTbr
 k4UOoOvbUk+cWSXGoaN16QMzXdJ0t4ZD9on7ZMHhxB3yv8kaPGNMpJwHKXZo6dE62iI9Ki
 PNCp6fZWVL9mhMvx7xPzXpiQyVdYZUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789132481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2qJLL3rHL+fUVExfpvMwQkZQqPtrWgBCe5PDBL3iV3I=;
 b=qAxRawSl83FzPIPdB8f7XlxhVCv+QdUyY51Om5Y+TnrfVmPPf8oiOLK59xTKhQ+gKarKPq
 freJR5MBhW5DEdCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="DP5wN/ob";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xxDboB0W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789132477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2qJLL3rHL+fUVExfpvMwQkZQqPtrWgBCe5PDBL3iV3I=;
 b=DP5wN/obQgULvddb7CW/Vl+D2NkxwgN8l2A7aTcCeyV4+d6mPScXCPDiicuuR7BGsrRvXz
 Bo3+aLyIarFtgaqeB0oFmAYHiyxAYegpAk/sFrE1hGrsUa9ZOcVf7ZGcZSzf1vHE+E7AYZ
 7/cNdBoPQr+iGbixBCcNoq54T+GaAAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789132477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2qJLL3rHL+fUVExfpvMwQkZQqPtrWgBCe5PDBL3iV3I=;
 b=xxDboB0W6JqH6+fYGb/Qpfl4jyQsigZCN7ScuZZdXpLsiChfUj3rzi7vjQV9MZNVZADoLa
 70ka3eltLy7wzrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AB40136ED;
 Fri, 11 Sep 2026 13:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GTDUBL3+o2qLLgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 13:14:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 15:14:33 +0200
Message-Id: <20260911-cve-ghostlock-v10-0-817cfb0187eb@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALr+o2oC/33QS07DMBCA4atUXmPktz1dcQ/EIrbHTQQ0KC4Rq
 MrdcbrBGkSXM9L3a+wrq7hMWNnxcGULrlOd5nMbpHg4sDQO5xPyKbcFU0I5EYTkaUV+Gud6eZv
 TK3eIJqrioGTHmvlYsExft+DzS5vHqV7m5fvWX+W+/a+0Si649KG1QgEv1FP9rPiY5ne2h1bVY
 02xajg6YUMIVksjCNZ3sW44ZQy6DEZB9ASbDitHsWnYKkxgsnPaFoLtLwahKLY7dhABo/ZgJMG
 ux3/Odg0PWnkVY5BoMsH+LvYNey8RYBi0sPTNoceG4rD/dgYAEXTyJRIMHZaCYmi4FJ209CBTd
 h3etu0HL1u4nZICAAA=
X-Change-ID: 20260801-cve-ghostlock-6ee4b2f69fd6
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789132476; l=4962;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=3f6CD5acRIVJAqWTaQfUjPTfLD5VYJC0uI/JHjTeDVY=;
 b=g8FPU0dzfmiHXEWBE9yqIEGGP0r5aglGL1fBtntQruHBdMXO4Yu44Dx+Jb9Anr8/vDpiD0Y3P
 2rLFjB+QdDdDyPy4ErfNeIHYD0OkFiQt65Y2C3VsLOmxUmuvgzItYqC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5F86D1FEF4
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 0/5] Reproducer for ghostlock
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

Test for CVE-2026-43499 (GhostLock), a stack use-after-free in the
rtmutex PI code, fixed in kernel v7.1:
3bfdc63936dd ("rtmutex: Use waiter::task instead of current in remove_waiter()")

Reproducer based on the Nebula Security writeup and open-sourced PoC
(https://nebusec.ai/research/ionstack-part-2/, https://github.com/NebuSec/CyberMeowfia).
Beware, this test will crash the system on a vulnerable kernel.

Assisted by Kimi K3 for the analysis and written mostly with Gemini Pro
3.1 Max.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v10:
- use tst_syscall() directly in safe_sched_setattr() to fix build on glibc 2.41+
- Link to v9: https://lore.kernel.org/20260910-cve-ghostlock-v9-0-ff3c31791cd6@suse.com

Changes in v9:
- split sched_setattr test into sched_setattr01 (positive) and sched_setattr02 (negative)
- register sched_setattr02 in runtest/syscalls and .gitignore
- update commit message to reflect the split
- Link to v8: https://lore.kernel.org/20260904-cve-ghostlock-v8-0-bd999083c7fb@suse.com

Changes in v8:
- remove PR_SET_MM_MAP_SIZE from commit message
- remove redundant assignment in ghostlock
- Link to v7: https://lore.kernel.org/20260903-cve-ghostlock-v7-0-771e99aa3057@suse.com

Changes in v7:
- wrap doc-comment lines in sched_setattr01 to stay under 80 columns
- allocate read_attr via .bufs in sched_getattr01
- keep const in sched_setattr() fallback prototype in lapi/sched.h
- update SAFE_SCHED_SETATTR() commit message to describe test usage and remove forward references
- remove unused PR_SET_MM_MAP_SIZE fallback definition from lapi/prctl.h
- wrap doc-comment lines in ghostlock.c to stay under 80 columns
- format multi-line comment in ghostlock.c spray loop
- add explanation comment for try_sizes[] in ghostlock.c
- check return values of TST_THREAD_STATE_WAIT() in ghostlock.c
- check futex_lock_pi() and futex_unlock_pi() returns, report ENOSYS as TCONF, and abort on errors
- add ENOSYS checks for FUTEX_WAIT_REQUEUE_PI and FUTEX_CMP_REQUEUE_PI in ghostlock.c
- Link to v6: https://lore.kernel.org/20260903-cve-ghostlock-v6-0-a3272bb81e4d@suse.com

Changes in v6:
- drop const from sched_setattr() and safe_sched_setattr() prototypes to match glibc 2.41+
- add kernel-doc comment for SAFE_SCHED_SETATTR()
- fix struct prctl_mm_map fallback guard in lapi/prctl.h
- validate futex_wait_requeue_pi() outcome before waking spray checkpoint
- sort ghostlock entry in testcases/cve/.gitignore
- Link to v5: https://lore.kernel.org/20260902-cve-ghostlock-v5-0-569b9eb37941@suse.com

Changes in v5:
- reduced synchronization checkpoints from 5 to 3
- introduced and used SAFE_SCHED_SETATTR() in lapi/sched.h
- dropped unused PR_SET_MM_MAP_SIZE probe in setup()
- fixed duplicated -pthread entry in Makefile
- fixed CVE numerical ordering in runtest/cve
- Link to v4: https://lore.kernel.org/20260826-cve-ghostlock-v4-0-52ec94d6635f@suse.com

Changes in v4:
- handle runtime inside the test
- increase futext wait so we don't TBROK before runtime
- comment prctl() syscall
- move static vars out of the run function
- Link to v3: https://lore.kernel.org/20260803-cve-ghostlock-v3-0-cde83fa429b7@suse.com

Changes in v3:
- improve sync mechanism
- fix lapi imports
- Link to v2: https://lore.kernel.org/20260803-cve-ghostlock-v2-0-b60588853140@suse.com

Changes in v2:
- fix build
- fix 32bit run
- Link to v1: https://lore.kernel.org/20260801-cve-ghostlock-v1-0-178f698f9702@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (5):
      sched_setattr: Convert to new API
      sched_getattr01: Convert to new API
      lapi/sched: add SAFE_SCHED_SETATTR()
      lapi/prctl: add more fallback definitions
      cve: add CVE-2026-43499 reproducer

 configure.ac                                       |   2 +
 include/lapi/prctl.h                               |  24 ++
 include/lapi/sched.h                               |  36 +++
 runtest/cve                                        |   1 +
 runtest/syscalls                                   |   1 +
 testcases/cve/.gitignore                           |   1 +
 testcases/cve/Makefile                             |   2 +-
 testcases/cve/ghostlock.c                          | 277 +++++++++++++++++++++
 testcases/kernel/syscalls/sched_getattr/Makefile   |   1 -
 .../syscalls/sched_getattr/sched_getattr01.c       | 134 ++++------
 testcases/kernel/syscalls/sched_setattr/.gitignore |   1 +
 testcases/kernel/syscalls/sched_setattr/Makefile   |   1 -
 .../syscalls/sched_setattr/sched_setattr01.c       | 138 +++-------
 .../syscalls/sched_setattr/sched_setattr02.c       | 140 +++++++++++
 14 files changed, 576 insertions(+), 183 deletions(-)
---
base-commit: f6933a16f304f36045ec39300c6496dae452933d
change-id: 20260801-cve-ghostlock-6ee4b2f69fd6

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
