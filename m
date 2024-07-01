Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86164C3065A
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 15:45:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1637B3D3FF3
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 17:45:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E11923D3FDE
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 17:42:58 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 690826017CD
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 17:42:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E3CDE1FB50;
 Mon,  1 Jul 2024 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719848574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YtSmFaWgNP7os5BA16E0J0KaVwasOXSVdH82tmvrmO4=;
 b=Hj1c9MkzoEVkejMrImax9qQILUcOMFTWcJL9Yz2xXATWI0NgeXGXfinbRTzXSDH7vqbjqO
 gYsXxPE2erWTmnMMS3OXQSaYFP3N7FZDUG45L0wmc4pYJNu9iv9XMok3vRMWXHNpZYaeSi
 DnOADRnM8nHifeD4JeDfOnxvtpvlsI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719848574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YtSmFaWgNP7os5BA16E0J0KaVwasOXSVdH82tmvrmO4=;
 b=vKvIos2zpjVNQyGL5abn52U7pHQvq7av1fgbTKnhIg/ELxcTooxhqql6AzYJgIKcXP0P0u
 gwBh95PX4i/ArtAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="nIVX/OjV";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="8Vylsd/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719848573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YtSmFaWgNP7os5BA16E0J0KaVwasOXSVdH82tmvrmO4=;
 b=nIVX/OjVNkqwCl/nXVWZqOKoxS3ZGy+9lt3VnVlE9aWCd4LB152Mg6r2QpODGgDh/f3WnW
 sOtIEmgJLf7HJ2Vl6j8JXlGuomjiogeUyzrNJjHdhpg2wUs0Zohq9fPAoDhPYquLV4pfVQ
 fWKsUXo/cHMxYzMm7qVVwMuiGJ2DOVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719848573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YtSmFaWgNP7os5BA16E0J0KaVwasOXSVdH82tmvrmO4=;
 b=8Vylsd/WAYlG1fAhuBqhz+uxSSDmwTnJI/z9qEpnyWKO4GmpLRINr+FlxQ9fadLav/N3QH
 tBY5HSnUgSGEhlAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF92A13800;
 Mon,  1 Jul 2024 15:42:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CKNKLH3OgmZfCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jul 2024 15:42:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jul 2024 17:42:05 +0200
Message-Id: <20240701-landlock-v1-0-58e9af649a72@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAE3OgmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Nz3ZzEvJSc/ORs3WQTi0QTMyPjRBMTcyWg8oKi1LTMCrBR0bG1tQB
 YZIVfWgAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2994;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=XUXRB1UO/HkfKP7yFANmPZET0JUKwnLd5KuNx9Cf8Sk=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmgs5U5b8bjCuc7VCC/TYBG0yHXO52suY8BfFXa
 8B0U44cEXCJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoLOVAAKCRDLzBqyILPm
 RrEEC/4rz6hVHvAfvHR+s6/XO1ONUwuheZYEvaqENeCnQppZ5NhbXXkWvzsmBgowh/W0kfmlZvv
 cvuYXJtOS9lEvNXZVF67qPcTHGCE5H/zg7VANLnExeaXZ43ViG2GgCDMXLoKdR6EW5Ru/IkrqlE
 arvbpteatj08I58+EKD4ytVcB5HWGI8w1ARyelvyVk2YWn/hEBvByLBMnp+a3e6HEI+L1cSpDgQ
 qrl3z+OPkhkgy4RXqj810S0d3IyoITN1vs0jmkDRecIw7nSksk7UFaD/MEuBIpkU24LhxgwiA1c
 R6nr9EUTi9UZDp0+qf/nn1YIOsLQRHNF/if0AReaW78CiqT+FJjyZDzr74IljPKxnj0SnPoGW5K
 nUH7UtxLteOqXgHsE+5uOBb3QQ0Nl32KrPMoyAE5HuZY7qGj/lKl1LgctAaSz4U+Uhqe1761ved
 Lkddb7baTWrm2021Wc3z7YyR7zSrB+CK2Fyo5APfRRNDwW/87dGYDuQP+Jb5jJibIAWUo=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E3CDE1FB50
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/10] landlock testing suite
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

This testing suite is meant to test the following syscalls:

- landlock_create_ruleset
- landlock_add_rule
- landlock_restrict_self

Documentation can be found in kernel manuals and inside the official
kernel documentation at

https://www.kernel.org/doc/html/latest/userspace-api/landlock.html

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (10):
      Add landlock syscalls definitions
      Add lapi/landlock.h fallback
      Add landlock SAFE_* macros
      Add SAFE_PRCTL macro
      Add landlock01 test
      Add landlock02 test
      Add landlock03 test
      Add landlock04 test
      Add landlock05 test
      Add landlock06 test

 configure.ac                                       |   5 +
 include/lapi/landlock.h                            | 120 +++++++
 include/lapi/syscalls/aarch64.in                   |   3 +
 include/lapi/syscalls/arc.in                       |   3 +
 include/lapi/syscalls/arm.in                       |   3 +
 include/lapi/syscalls/hppa.in                      |   3 +
 include/lapi/syscalls/i386.in                      |   3 +
 include/lapi/syscalls/ia64.in                      |   3 +
 include/lapi/syscalls/mips_n32.in                  |   3 +
 include/lapi/syscalls/mips_n64.in                  |   3 +
 include/lapi/syscalls/mips_o32.in                  |   3 +
 include/lapi/syscalls/powerpc.in                   |   3 +
 include/lapi/syscalls/powerpc64.in                 |   3 +
 include/lapi/syscalls/s390.in                      |   3 +
 include/lapi/syscalls/s390x.in                     |   3 +
 include/lapi/syscalls/sh.in                        |   3 +
 include/lapi/syscalls/sparc.in                     |   3 +
 include/lapi/syscalls/sparc64.in                   |   3 +
 include/lapi/syscalls/x86_64.in                    |   3 +
 include/tst_safe_macros.h                          |  25 ++
 lib/tst_safe_macros.c                              |  66 ++++
 runtest/syscalls                                   |   7 +
 testcases/kernel/syscalls/landlock/.gitignore      |   7 +
 testcases/kernel/syscalls/landlock/Makefile        |  15 +
 testcases/kernel/syscalls/landlock/landlock01.c    |  87 +++++
 testcases/kernel/syscalls/landlock/landlock02.c    | 153 +++++++++
 testcases/kernel/syscalls/landlock/landlock03.c    | 119 +++++++
 testcases/kernel/syscalls/landlock/landlock04.c    | 143 +++++++++
 testcases/kernel/syscalls/landlock/landlock05.c    | 113 +++++++
 testcases/kernel/syscalls/landlock/landlock06.c    | 110 +++++++
 .../kernel/syscalls/landlock/landlock_common.h     |  74 +++++
 testcases/kernel/syscalls/landlock/landlock_exec.c |   9 +
 .../kernel/syscalls/landlock/landlock_tester.h     | 350 +++++++++++++++++++++
 33 files changed, 1454 insertions(+)
---
base-commit: 53b4930da635e29b34af694f2b2a0a22411ec5a0
change-id: 20240617-landlock-c48a4623a447

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
