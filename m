Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA45C282EC
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 11:14:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DFD63CABE1
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 12:14:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5049A3CAB9B
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:14:03 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3DDB81A000B4
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:14:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5EE6B216E8;
 Tue, 18 Mar 2025 11:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742296440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=21tMmT8SCXUZ/6u7Q96J4kjNssqAy6KN++/mG1je9Xw=;
 b=HhGc55FqD1JaG5owv5h7elVsc4nnUZXe1gfvGa8YGAVjE1zIm6ZnVI6AxgDzsaMFPUMbCT
 x3cbrgHjvoSsi8JTyXfGiilZEF7YTQ1rmKmx6I29/FjgON2V0LjUvHXHWgIgD4q8EApjmc
 l5etdSPvNvTcttsvmxdIYYTB62Bi+Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742296440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=21tMmT8SCXUZ/6u7Q96J4kjNssqAy6KN++/mG1je9Xw=;
 b=Ln4Yt7MPvBxFdjDxJ2+VOI6UTRbGNwa7ENPy1A/0VPjF1rzNP5iSSKDeZADNYt7onjWCRz
 8frDkotoxVBl0xCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742296440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=21tMmT8SCXUZ/6u7Q96J4kjNssqAy6KN++/mG1je9Xw=;
 b=HhGc55FqD1JaG5owv5h7elVsc4nnUZXe1gfvGa8YGAVjE1zIm6ZnVI6AxgDzsaMFPUMbCT
 x3cbrgHjvoSsi8JTyXfGiilZEF7YTQ1rmKmx6I29/FjgON2V0LjUvHXHWgIgD4q8EApjmc
 l5etdSPvNvTcttsvmxdIYYTB62Bi+Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742296440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=21tMmT8SCXUZ/6u7Q96J4kjNssqAy6KN++/mG1je9Xw=;
 b=Ln4Yt7MPvBxFdjDxJ2+VOI6UTRbGNwa7ENPy1A/0VPjF1rzNP5iSSKDeZADNYt7onjWCRz
 8frDkotoxVBl0xCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21C92139D2;
 Tue, 18 Mar 2025 11:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 63nlAXhV2WdGRgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 18 Mar 2025 11:14:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 18 Mar 2025 12:13:52 +0100
Message-Id: <20250318-mmap_suite_refactoring-v5-0-1b087988f1c9@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHBV2WcC/43OzQrCMAwH8FcZPVtJk7bbPPkeItKt0fWwTVYdi
 uzd7QRRhIHHfz5+yUNEHgJHsckeYuAxxNB3KZhVJurGdSeWwacsENAAgpFt686HeA0XPgx8dPW
 lH0J3koQIGl1VkbEiLZ9TM9xe8G6fchNimry/7oxqrr7JfIkclQTpAawvUbH2Zhuvkdd134pZH
 PFLUbCoYFIse3bkNFlyPwp9FFK0qFBSuCpVjrawSPCj6P8UPStHbwvkmqn8/mWapiddnvA+jQE
 AAA==
X-Change-ID: 20250205-mmap_suite_refactoring-322042abb356
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742296439; l=2645;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=zP5mUUHxXh/RgchEgr1zQGlgP893MqhgMzD6kJbQ4oM=;
 b=Hrzy75K+2uWR/xOlF+EtAAjKo4ByHeciMj9Q8MZ75tyVOyYUbSvbdtaH6Xw64CfaP8YGhIUPc
 e8MKMQXILjQBK8R6YevupL9OZNKHqB1/kJ8SjHz8jdxrI8m79/uegxh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/8] Cleanup the mmap testing suite
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

Some of the tests in the mmap testing suites are using old API, having
documentation which is not linked to the metadata or need to be cleaned
up a bit. This patch-set is meant to fix these issues. mmap11 is for
IA64 only and that will require a separate patch and discussion.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v5:
- mmap10: fix - move tst_res inside inner if
- mmap21: set memory_data = NULL after SAFE_MUNMAP()
- Link to v4: https://lore.kernel.org/r/20250313-mmap_suite_refactoring-v4-0-efd682ece39a@suse.com

Changes in v4:
- mmap03: keep mips only arch and move buffer handling in setup/cleanup
- mmap10: remove ifdef for MADV_MERGEABLE, since it's available from 2.6
  get rid of options and use testcases instead
- mmap12: remove [Description]
- mmap17: move mmap() in setup
- mmap19: munmap() if mmap() doesn't fail and simplify description
- mmap21: create mmap21_01/02, remove child crash check and
  allocate/deallocate in setup/cleanup
- Link to v3: https://lore.kernel.org/r/20250313-mmap_suite_refactoring-v3-0-eb9172686230@suse.com

Changes in v3:
- mmap01: this and that
- Link to v2: https://lore.kernel.org/r/20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com

Changes in v2:
- mmap21: verify SIGSEGV
- Link to v1: https://lore.kernel.org/r/20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com

---
Andrea Cervesato (8):
      Refactor mmap03 test
      Refactor mmap10 test
      Cleanup mmap12 test
      Cleanup mmap17 test
      Cleanup mmap18 test
      Cleanup mmap19 test
      Cleanup mmap20 test
      Refactor mmap001 test and move it to mmap21

 runtest/mm                                |  13 +-
 runtest/syscalls                          |   3 +-
 testcases/kernel/syscalls/mmap/.gitignore |   2 +-
 testcases/kernel/syscalls/mmap/mmap001.c  | 183 ---------------------
 testcases/kernel/syscalls/mmap/mmap03.c   | 265 ++++++++----------------------
 testcases/kernel/syscalls/mmap/mmap10.c   | 255 ++++++++++------------------
 testcases/kernel/syscalls/mmap/mmap12.c   |  30 +---
 testcases/kernel/syscalls/mmap/mmap17.c   |  53 +++---
 testcases/kernel/syscalls/mmap/mmap18.c   |  90 +++++-----
 testcases/kernel/syscalls/mmap/mmap19.c   |   2 +-
 testcases/kernel/syscalls/mmap/mmap20.c   |   3 -
 testcases/kernel/syscalls/mmap/mmap21.c   | 101 ++++++++++++
 12 files changed, 335 insertions(+), 665 deletions(-)
---
base-commit: a92aedfabd5826d07809559508c8486c12ff7b96
change-id: 20250205-mmap_suite_refactoring-322042abb356

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
