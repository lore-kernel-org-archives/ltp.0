Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17880C83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:18:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A616A3CCD94
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 16:18:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A51E93CCD8B
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BA9C660020E
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5E5C11F78C;
 Wed, 23 Jul 2025 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nRtpln9k0z8EokIaNfJr5vnndgqopmmbV7Set5eSb8A=;
 b=ZoosL1j0M+OhdlpcgeDQWT5ppHl6Hhp7PVGPuCGyaqNtOSAoUedInpemQopYk8TiKzj9VT
 LXuJMkQ/mc8u0aISajBUYTY8GCU3oyhzi4sof1YVWVOOiDolVlBdeMc+ma0sXZqpbIflY8
 YVNty3UpxMiikofdDSzGxP1IwKzVK0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nRtpln9k0z8EokIaNfJr5vnndgqopmmbV7Set5eSb8A=;
 b=YvqsY5tEj+U8s/mLMTisWWF7CuHrt4caynd9LAljFMYfx3p7IwBi1Dcrh/dq55Cjy1ISAL
 kUEKbxlLOEBOgXDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=btP9mV3Z;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/KMQVCjy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nRtpln9k0z8EokIaNfJr5vnndgqopmmbV7Set5eSb8A=;
 b=btP9mV3Zbkgje4XM+i9xY4zYKPsC+jz/7b3BYCvg3YvYWs4CwtFzr0Wqk3m/vcjoMOFFBg
 ShHkhRjsXtrpoOwtXoO7Li85GKDz1hgL7yiHYmxuAkNow+udPbV+rjraTO1gmaDWFGFY0N
 llWZRyu+itQ6+dpCLUJlGqLpu1/0jqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nRtpln9k0z8EokIaNfJr5vnndgqopmmbV7Set5eSb8A=;
 b=/KMQVCjy8yiPWmcjBIn36JAX+DMFnAEGXlyJWLcMf3S0dl+R485TSaPKhmuCDK8wVBpQZh
 Dsa9QMGOI2LWGVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AA9913ABE;
 Wed, 23 Jul 2025 14:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zwijDKTugGj2LwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 23 Jul 2025 14:16:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 23 Jul 2025 16:15:14 +0200
Message-Id: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHLugGgC/33N0QqCMBTG8VeJXbeYx21qV71HhEx3lgdKxakU4
 rs3vUlCuvx/cH5nYh47Qs/Oh4l1OJKnpg4hjwdWVqa+IycbmoEAJTRoTk3ZP/KWrLO5H6hHHgM
 YA3GiSgks3LUdOnqt5vUWuiLfN917fTFGy/pPGyMueKRVkZnCCcj0xQ8eT2XzZAs2whdIhNwDI
 ABparTU2mZOww8Qb4FkD4gDAFAYaSOFKLbAPM8fiIUHRzMBAAA=
X-Change-ID: 20250626-ioctl_pidfd_suite-322aa2375c42
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753280164; l=2450;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Z97BGKaURFmyN3x41uWLCd8AnrDucwfCAIFsn+dAAJY=;
 b=RTIJ6laAzamokIasL8K1N5yXvfWXzl74ImxS+w7gaTreVD9x1I7XlnNk4AtnQIbLcAUJe3LIX
 vXUKfmuBS+kCSpEsn2Ebt/wQtfXhlb67wMWwN5qL9NF2DhyDM8qGNpO
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,configure.ac:url,suse.de:dkim,suse.com:mid,suse.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 5E5C11F78C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/8] ioctl_pidfd testing suite
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

The testing suite has been created to cover the new feature
PIDFD_INFO_EXIT provided by kernel 6.15.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- use ioctl_pidfd_info_exit_supported() name and check for minimum
  kernel version inside it
- close pidfd at the end of tests
- fix wrong import in autoconf for sys/linux.h
- Link to v3: https://lore.kernel.org/r/20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com

Changes in v3:
- ioctl_pidfd02: compare exit_code with status from waitpid()
- check for PIDFD_INFO_EXIT support ioctl_pidfd.h
  ioctl_pidfd_suite-v1-0-165b9abf0296
- Link to v2: https://lore.kernel.org/r/20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com

Changes in v2:
- ioctl_pidfd02: check all flags of info before and after process being
  reaped. Include a fork() test
- ioctl_pidfd03: verify process info before being reaped
- add more error tests
- Link to v1: https://lore.kernel.org/r/20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com

---
Andrea Cervesato (8):
      Provide pidfd parameter in tst_clone_args
      Fallback PIDFD_GET_INFO related definitions
      Add ioctl_pidfd01 test
      Add ioctl_pidfd02 test
      Add ioctl_pidfd03 test
      Add ioctl_pidfd04 test
      Add ioctl_pidfd05 test
      Add ioctl_pidfd06 test

 configure.ac                                    |  2 +
 include/lapi/pidfd.h                            | 39 +++++++++++-
 include/tst_clone.h                             |  1 +
 lib/tst_clone.c                                 |  1 +
 runtest/syscalls                                |  7 ++
 testcases/kernel/syscalls/ioctl/.gitignore      |  6 ++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd.h   | 41 ++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c | 58 +++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c | 85 +++++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c | 64 +++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c | 71 +++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 59 +++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 66 +++++++++++++++++++
 13 files changed, 499 insertions(+), 1 deletion(-)
---
base-commit: bf14e296a9bc5f18cdc7f91d8e005297ab2ae2a2
change-id: 20250626-ioctl_pidfd_suite-322aa2375c42

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
