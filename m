Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81262C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 07:42:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2ACF3E935B
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:42:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EC5E3E57EF
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:41:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 36D02600F18
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:41:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD44922B02;
 Fri,  4 Sep 2026 07:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788507684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vY67GMoIoK5urrl2Po3CVKS7E0r3nKYjofB5+zq5kp0=;
 b=XXfAJ4O9K2y4MJl8O+AoJzIobPfqOFZDwLpeOnAT3dh49lsoN+eqZYJFriNXYGgVdmUyYm
 eVFa2NiTBfy+g3FqxkGR6lcxYsxDVjLoR14wLOsFUULMxCflVSFD5oKsPj13ds1ORZtgQ4
 +OJs8Dnnda+nZNAFHVGRG+RU71UxWnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788507684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vY67GMoIoK5urrl2Po3CVKS7E0r3nKYjofB5+zq5kp0=;
 b=oO8W+nnTr7ggcj/FLVbya5XG3+YJcylsKeKne289Qa7KsNf/Z9rxwi6U5Uf/qd8O87yisG
 tJCuViwpmu6nLYDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788507680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vY67GMoIoK5urrl2Po3CVKS7E0r3nKYjofB5+zq5kp0=;
 b=B6uraS7BLfxBA/4LNuuju816RWDT/IW7rUiZIHnT41oeAZI2fUP/H0W34k/K5DGjQzwddq
 TipDTM59kLbCNdMArWueavi5eK7M6lpOUWxEoo1MQY1RyyDTmaAaLlIl9o7CcZAWOOq/h5
 iTofPuLemaThua7EkdSeLAvmhJdkVrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788507680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vY67GMoIoK5urrl2Po3CVKS7E0r3nKYjofB5+zq5kp0=;
 b=epIAhZ3LUSQBb9K16n4Qc/nVU1u81THvtuyo8/Ku2ZAURaX5XZ+4m94AA87r94HdKusDp8
 zT/8lpFULFFU+fAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CBD813736;
 Fri,  4 Sep 2026 07:41:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KRu3GyB2mmoGHAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 07:41:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 09:41:18 +0200
Message-Id: <20260904-cve-ghostlock-v8-0-bd999083c7fb@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB52mmoC/33PwU4DIRDG8VdpOIuBAQboyfcwHhZ26BK1mKVuN
 M2+u2wvbjD2+JH8/hmurNKcqbLj4cpmWnLN5dyGeziwOA3nE/E8ts1AAAonJI8L8dNU6uWtxFe
 ORDpAQp9GZM18zJTy1633/NL2lOulzN+3/CK31/9Ki+SCS+tayyVvBTzVz0qPsbyzLbTAHqseQ
 8MBhXHOGSW16LC6i1XDcSSn0qDBB9thvcOAPdYNG6Do9YioTOqw+cVeQI/NhtEHT0FZr2WHcY/
 /nI0NDwoshOAk6bHD9i62DVsryfthUMLs/7yu6w+Q/bf0FwIAAA==
X-Change-ID: 20260801-cve-ghostlock-6ee4b2f69fd6
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788507680; l=4281;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=wxSkxM2YrigOGCGd0Hp3ZJRDfdjMGibLITpTe7+czEg=;
 b=lVPdXbgQerhARlMbOK248hKrLaDuwgaaW0jpwDpHMI5dZWmqS/qcbozz8FN0J/bBF5fd/y+Vm
 c+FMfLwGsvRAJAxBaLvIOJVAlLxzQeYbHVYLE5BTDA1xRrCukrzZEum
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid, nebusec.ai:url, linux.it:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 0/5] Reproducer for ghostlock
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
      sched_setattr01: Convert to new API
      sched_getattr01: Convert to new API
      lapi/sched: add SAFE_SCHED_SETATTR()
      lapi/prctl: add more fallback definitions
      cve: add CVE-2026-43499 reproducer

 configure.ac                                       |   2 +
 include/lapi/prctl.h                               |  24 ++
 include/lapi/sched.h                               |  29 +++
 runtest/cve                                        |   1 +
 testcases/cve/.gitignore                           |   1 +
 testcases/cve/Makefile                             |   2 +-
 testcases/cve/ghostlock.c                          | 277 +++++++++++++++++++++
 testcases/kernel/syscalls/sched_getattr/Makefile   |   1 -
 .../syscalls/sched_getattr/sched_getattr01.c       | 134 ++++------
 testcases/kernel/syscalls/sched_setattr/Makefile   |   1 -
 .../syscalls/sched_setattr/sched_setattr01.c       | 231 ++++++++++-------
 11 files changed, 529 insertions(+), 174 deletions(-)
---
base-commit: 12724413534a6d4160ff9694ba6f09daa4ccb6bd
change-id: 20260801-cve-ghostlock-6ee4b2f69fd6

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
