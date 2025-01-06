Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0B4E77198
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 10:31:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1355B3C306E
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 11:31:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 800A33C0E08
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 11:31:27 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E33A5142171F
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 11:31:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 93D1B1F383;
 Mon,  6 Jan 2025 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736159485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fxZDQbHRbK//MLwL+MwNdr0Ejf6G9xSklda3Jk8zdqg=;
 b=NNy5S3wezAok2n68edOspaI/VNi+Qjp46XzBjbRkbHlPB+hMWDOUxR7YZm5RanuiSiD9VM
 M/NP2sKQiCfODj7JA80p6GkogYPpxlDL2rBcD3bjXfntMb5Um4DQn+m0DiacFZ2FRxQ2wX
 ylDgz8NZ40nTqnIBMra+twSayjdI3Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736159485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fxZDQbHRbK//MLwL+MwNdr0Ejf6G9xSklda3Jk8zdqg=;
 b=JB7jOFQ1rvFylIKx4eiIGGaxBoCzco+btZINZpmGSoMY5qnWB6FgV/hKLq8iEO24g7sMQG
 FJJCFtQkszwheWBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736159485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fxZDQbHRbK//MLwL+MwNdr0Ejf6G9xSklda3Jk8zdqg=;
 b=NNy5S3wezAok2n68edOspaI/VNi+Qjp46XzBjbRkbHlPB+hMWDOUxR7YZm5RanuiSiD9VM
 M/NP2sKQiCfODj7JA80p6GkogYPpxlDL2rBcD3bjXfntMb5Um4DQn+m0DiacFZ2FRxQ2wX
 ylDgz8NZ40nTqnIBMra+twSayjdI3Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736159485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fxZDQbHRbK//MLwL+MwNdr0Ejf6G9xSklda3Jk8zdqg=;
 b=JB7jOFQ1rvFylIKx4eiIGGaxBoCzco+btZINZpmGSoMY5qnWB6FgV/hKLq8iEO24g7sMQG
 FJJCFtQkszwheWBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78793137DA;
 Mon,  6 Jan 2025 10:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tvKZG/2we2fGfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 06 Jan 2025 10:31:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 06 Jan 2025 11:31:22 +0100
Message-Id: <20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPqwe2cC/2WNwQ6CMBBEf4Xs2Zq21EI8+R+GEFIW2YNgurXRk
 P67K/Hm8U1m3mzAGAkZztUGETMxrYuAPVQQ5mG5oaJRGKy2zljt1ESvnjExjX1CTqzaxg/OW9/
 Y9gQye0SUzq68dsIzcVrje3/I5pv+ZMb8y7JRWqHR9VT74EV74SfjMax36EopH5MkAE2vAAAA
X-Change-ID: 20241204-fix_setsid_tests-876a46267285
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736159485; l=1983;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Jk5wlkYhJ/V/dr2xCWBT1H/KWoPBiy5h6VPUqrySUto=;
 b=3A+c9kHniWV22r0sx1R9eSXjHrevRt5WXKF/7csDtIwsWuyRLRNWixQaKFiqao3K5RzqXmZ3E
 eRA/ez4JNxWDp0HiotOtYPr+lEoLU3yyipkKUSxzo5riGG49xmUDQ3j
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 00/11] Fix tests failing with setsid
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

Following tests are failing when running on a new session started with
setsid command/syscall: pty01, ptem01, setpgid01.

Tihs patch-set refactor them in order to fix this issue. Some tests like
pty01 and ptem01 have been split into multiple files due to their
complexity.

Fixes: https://github.com/linux-test-project/kirk/issues/28
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- add SAFE_PTSNAME macro
- ptem01: check ptsname() with TBROK
- Link to v1: https://lore.kernel.org/r/20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com

---
Andrea Cervesato (11):
      Refactor setpgid01 test
      Add SAFE_PTSNAME macro
      Refactor ptem01 test
      Add ptem02 test
      Add ptem03 test
      Add ptem04 test
      Add ptem05 test
      Add ptem06 test
      Refactor pty01 test
      Add pty08 test
      Add pty09 test

 include/tst_safe_macros.h                     |   4 +
 lib/tst_safe_macros.c                         |  14 +
 runtest/pty                                   |   7 +
 testcases/kernel/pty/.gitignore               |   7 +
 testcases/kernel/pty/ptem01.c                 | 454 +++-----------------------
 testcases/kernel/pty/ptem02.c                 |  73 +++++
 testcases/kernel/pty/ptem03.c                 |  51 +++
 testcases/kernel/pty/ptem04.c                 |  52 +++
 testcases/kernel/pty/ptem05.c                 |  53 +++
 testcases/kernel/pty/ptem06.c                 |  54 +++
 testcases/kernel/pty/pty01.c                  | 416 +++--------------------
 testcases/kernel/pty/pty08.c                  |  57 ++++
 testcases/kernel/pty/pty09.c                  |  86 +++++
 testcases/kernel/syscalls/setpgid/setpgid01.c | 152 ++-------
 14 files changed, 570 insertions(+), 910 deletions(-)
---
base-commit: 7aea2cea9ad5d9e1586112a57948c7f85dc12970
change-id: 20241204-fix_setsid_tests-876a46267285

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
