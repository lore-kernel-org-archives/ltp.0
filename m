Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9F9C624D4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 07:27:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98B9C3E97DC
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 09:27:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 357503E938F
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 09:26:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 326A4600925
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 09:26:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A47D1FDB1;
 Thu,  3 Sep 2026 07:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788420401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UW6GpSYuTyk99i7wilOj9Sgow7bQt2nEHZSHvbM+HWw=;
 b=JjWzjJ0s2/c2N8mgK8Ueiil4/bV+Se3O+jdwu11VMk1EmSVtd9O2UcfDNpgk5L2Q7I1aVF
 mqMci9qbd83+byKuYM1Lr49Eh5EehanW3+rrBnUlS+y6BN2zCqStiVvWgurN35rY/YdlFV
 Z1Zv2ZVzOGFZnBhVvF3nioPFJ86/4vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788420401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UW6GpSYuTyk99i7wilOj9Sgow7bQt2nEHZSHvbM+HWw=;
 b=dahLsd1OT2KmisStI3zzZGorxmAgClIOgmQ8ODe9dD/+YFYJGiVXTh4crbfsqTPH1SuKsl
 k8zPHM08hasuh5Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="CNy597/U";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hZ1vGOPJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788420397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UW6GpSYuTyk99i7wilOj9Sgow7bQt2nEHZSHvbM+HWw=;
 b=CNy597/UNNmvv72EmOYk+kSe1CH6QC/eu5aDfDZP5ezGbQ2ubWrw4FhFkypvDQh6y+lCXc
 AjZA/SP/uSSD3jhjO47kDL8lIyFVDLw1YaIEUcLxGrV0oZUwrSCTXn4RIoWWOGoEFdbqNK
 BXTuYGhLEz9QuW2/wBRHArm9hU0yMtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788420397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UW6GpSYuTyk99i7wilOj9Sgow7bQt2nEHZSHvbM+HWw=;
 b=hZ1vGOPJcBwlBOC+JWiEjXfnybexFMhsDp/OA807jGPuDxmifFElj6iHqiNb4Tz0FfuIbU
 0Rq+eN8nI+Zh/bAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2888F136E6;
 Thu,  3 Sep 2026 07:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OM82By0hmWqGaAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 03 Sep 2026 07:26:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 03 Sep 2026 09:26:34 +0200
Message-Id: <20260903-cve-ghostlock-v6-0-a3272bb81e4d@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACohmWoC/33MQW7DIBCF4atErEsEA4whq96j6iLgIUZJQ2VS1
 Cry3YuziYXULt+Tvv/OCs2JCjvs7mymmkrK1zbwZcfCdLyeiKexbQYCUFgheajET1Mut0sOZ45
 E2kNEF0dkzXzOFNP3o/f23vaUyi3PP498lev7V6lKLrgcbGvZ6AYBr+Wr0D7kD7aGKmyx6jE07
 FEYa61RUosOq3+xajiMZFU8anB+6LDeYMAe64YNUHB6RFQmdtg8sRPQY7NidN6RV4PTcoOXZfk
 F1rTRhZ0BAAA=
X-Change-ID: 20260801-cve-ghostlock-6ee4b2f69fd6
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788420397; l=2632;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=dIImuq58og4rP6DnV8EI+c2AMEaVUutLdo0n4Wh6zLY=;
 b=3QnArFkVXcuaQ2soydEvEEW8s89V2+VE5oH87dH7pLIaO+fk8aRV92+LJNaJ7ySi64l7CycYx
 4XBTsHHauSuA3qLCJx2R3pZfPyNF+YMdjtmR6gRHAcL4J2tr79KSyNH
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6A47D1FDB1
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nebusec.ai:url, suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, suse.de:dkim]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/3] Reproducer for ghostlock
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

---
Andrea Cervesato (3):
      lapi/sched: add SAFE_SCHED_SETATTR()
      lapi/prctl: add more fallback definitions
      cve: add CVE-2026-43499 reproducer

 configure.ac              |   2 +
 include/lapi/prctl.h      |  26 +++++
 include/lapi/sched.h      |  31 +++++-
 runtest/cve               |   1 +
 testcases/cve/.gitignore  |   1 +
 testcases/cve/Makefile    |   2 +-
 testcases/cve/ghostlock.c | 246 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 307 insertions(+), 2 deletions(-)
---
base-commit: 12724413534a6d4160ff9694ba6f09daa4ccb6bd
change-id: 20260801-cve-ghostlock-6ee4b2f69fd6

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
