Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B85C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 12:52:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 754D73EAD9A
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 14:52:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 947103EAD5F
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:52:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7992460006E
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:52:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 12C3F1FCFF;
 Thu,  3 Sep 2026 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788439923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S+CIbe8KN51AMCAWqBmgdaPfnExwGAIeDclMaQXRdBE=;
 b=kqtMPrQ2vGMmicqBFp/iHlEg4tyHf3ZRJ6TzJ4Hrbac1YUT4fqE62vjg+kgmNxUBI9JUEs
 aAXcJHtB9k/8GP14ooCWjSZj0tOEH4r/gOjNu6Csrnj7mfZorTsgiblp/C8WpeK6jERRwy
 lpAr+mEvOmBbWTx3tw8eKr3SBrU5L/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788439923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S+CIbe8KN51AMCAWqBmgdaPfnExwGAIeDclMaQXRdBE=;
 b=mSKHEulGmXPzfV3Rgpj1myKO+WB/sGoxudjuWSFG8FQplAWvFaATD4+6+KLeWjesHLE+lM
 eipDDbODtD4XotAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788439919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S+CIbe8KN51AMCAWqBmgdaPfnExwGAIeDclMaQXRdBE=;
 b=FLOIQ8eQ+bPCxCX0TcuPNnN89P/wHNAVAJ1kKmgbY7dHjXy9b7NqyKrMtpiwyTEMnMw1GR
 WnKwk3iDdDo/8n7aBK0GdvbDARcFN4om67sN44YbWn5oSn/EDLcVzxQNyey0gDTfkDJFdl
 Y/xW4SUBOto/bnbgyWIdiuR5FylSvQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788439919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S+CIbe8KN51AMCAWqBmgdaPfnExwGAIeDclMaQXRdBE=;
 b=pq5Sr/vHVyQmjIecSKsVcE6tDAtjQ0aW6HipHn3wCWJfWqrgwRb2SAlEoiCldDODVN071A
 Fg6nIJ7SmOt+U3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C84D2136E6;
 Thu,  3 Sep 2026 12:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vXQtLm5tmWr7MgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 03 Sep 2026 12:51:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 03 Sep 2026 14:51:54 +0200
Message-Id: <20260903-cve-ghostlock-v7-0-771e99aa3057@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGptmWoC/33OwU4DIRDG8VdpOIuBAQbw5HuYHhZ26BK1mKXda
 Jp9d9le3GD0+E3y+2durNKcqbKnw43NtOSay7kN+3BgcRrOJ+J5bJuBABROSB4X4qep1Mtbia8
 ciXSAhD6NyJr5mCnlz3vv5dj2lOulzF/3/CK361+lRXLBpXWt5ZK3Ap7rtdJjLO9sCy2wx6rH0
 HBAYZxzRkktOqz+xarhOJJTadDgg+2w3mHAHuuGDVD0ekRUJnXY/GAvoMdmw+iDp6Cs17LDuMe
 /3saGBwUWQnCS9LjD67p+A7ItOFPaAQAA
X-Change-ID: 20260801-cve-ghostlock-6ee4b2f69fd6
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788439918; l=4082;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=xUvbYyZ91OVW1qUCTETKJrtSOQWw5Rr01Un/EO9tWhk=;
 b=WKmzn4+DHzs42gckJiu7gWOhNQTzTk6iEQ1dRvziAaPW2moFQJ8vEPYDKfWyDNnZV/o60U/ZR
 kjgAo0E1pPHCOqaSyvmbQWW4RMdcHhsm7/GIVT48i/wYNA17coeoxvv
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url, suse.com:email, suse.com:mid,
 nebusec.ai:url, linux.it:email, imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/5] Reproducer for ghostlock
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
 testcases/cve/ghostlock.c                          | 271 +++++++++++++++++++++
 testcases/kernel/syscalls/sched_getattr/Makefile   |   1 -
 .../syscalls/sched_getattr/sched_getattr01.c       | 134 ++++------
 testcases/kernel/syscalls/sched_setattr/Makefile   |   1 -
 .../syscalls/sched_setattr/sched_setattr01.c       | 231 +++++++++++-------
 11 files changed, 523 insertions(+), 174 deletions(-)
---
base-commit: 12724413534a6d4160ff9694ba6f09daa4ccb6bd
change-id: 20260801-cve-ghostlock-6ee4b2f69fd6

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
