Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129FEC3DA49
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 09:24:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AC143D1C97
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 11:24:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0479C3D0FA8
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 11:23:52 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D21BF1400179
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 11:23:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0BDAB1F7EE;
 Thu, 25 Jul 2024 09:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721899431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XSVXiv4TLvMA3az1OkEbCDx10NsPp8Y+u9eFVdeOQbc=;
 b=GstOtAia3eBA0HwhlpaWphch5lHQTh109A3UkOFCKTK8Uoy4pgJuMx7SDEQQXQqbBlcKzj
 xVzLp6ilNQgJ9GByRb1AZ6qFD2eeX/15+/0befEh4hqRqOPeaA9a5Cyiioy5OieMVVxbkB
 yt4iayCLnowws1+E/zfCTj1bDioRAnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721899431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XSVXiv4TLvMA3az1OkEbCDx10NsPp8Y+u9eFVdeOQbc=;
 b=hiKyJzT0LsSaAi1H7dS6RcU0Ln0fPJWN3HCc+q7By8SQFZgt9RXIPJCl3A78kwJkCkvqTU
 U1p5YVRQS40PmbDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721899431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XSVXiv4TLvMA3az1OkEbCDx10NsPp8Y+u9eFVdeOQbc=;
 b=GstOtAia3eBA0HwhlpaWphch5lHQTh109A3UkOFCKTK8Uoy4pgJuMx7SDEQQXQqbBlcKzj
 xVzLp6ilNQgJ9GByRb1AZ6qFD2eeX/15+/0befEh4hqRqOPeaA9a5Cyiioy5OieMVVxbkB
 yt4iayCLnowws1+E/zfCTj1bDioRAnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721899431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XSVXiv4TLvMA3az1OkEbCDx10NsPp8Y+u9eFVdeOQbc=;
 b=hiKyJzT0LsSaAi1H7dS6RcU0Ln0fPJWN3HCc+q7By8SQFZgt9RXIPJCl3A78kwJkCkvqTU
 U1p5YVRQS40PmbDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B83913874;
 Thu, 25 Jul 2024 09:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ugBQBqYZombZNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 25 Jul 2024 09:23:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 25 Jul 2024 11:23:10 +0200
Message-Id: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAH4ZomYC/13NQQ7CIBRF0a00jMUApaU4ch/GAYWPJdZiQImm6
 d6ldSBx+H44lxlFCA4iOlQzCpBcdH7Kg+8qpAc1XQA7kzdihHHSUoFHNZnR6yvWvFO8ZbXiXKD
 8/B7AuteWOp3zHlx8+PDeyomu129EEPqLJIoJbjqQyrZcKsGO8Rlhr/0NrY3ECkdJ4Vh21gppe
 kKFacSfq0tX/ldnp0VPQIKxsieFW5blA0OLRd4PAQAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2347;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=9XU5pyXoT3O/I8xcLNHVqFmfu8aF+Meltrr9FKwiZis=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmohmMN9+7GFEItLn49HJbA60hy3dz8iEnaK94V
 ypEZMSp+9WJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqIZjAAKCRDLzBqyILPm
 RpEQC/wNJmOSyqvQqKWOqcbjzyJ9xG+IxqS+XV8CZWFzL3veB4uXFYZXr1M3eFv3rbhnFCrgyjU
 YgH4Sdda0WEBV8qhBZVtmHz8+a/zpyAgG27n8imnSiBGGO5iwVyrlfWIIxXpPuxUSLnhcjbaN8l
 RADkRnTz9qQBX1S1ogTk1UOsK/MJduV0yu7L2sx4I+fsaFo7oklRbEzqf8W+npbnX+UTS00ohHp
 wHZZLWjLgzoYmWMwdW+SmYWDQrxo2T3ugHHVPr/D/ibeaOtg+Eqt62AneDuV29jx71Pf0vhgCw3
 KVf/hfnb7Uu1+IG4rb1omgfDp7MfmzoH9LaN5eG4ujYN7+7p/OHxaDKEfvsbkWeva3Jm4YmKYhJ
 LEvKRs7AV/zl1sEySPUhx2Eu8GyX5d7XTm1bs3MwJAS8M3oBK9E5IXjKOL6Ufrl4fPqKKlgx2T6
 uLmQDVqdTtn7Ce0x1hbSk77lCfhxjcy+7ouPv6cuCjbGsXFKz8xdmtxJfadj5vPe3m6AI=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-1.10 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/5] landlock testing suite
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
Cc: mic@digikod.net, gnoack@google.com
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
Changes in v4:
- landlock03: fix TBROK on -i usage
- landlock04: fix EINVAL caused by namespace sharing on kernel <=6.6
- Link to v3: https://lore.kernel.org/r/20240711-landlock-v3-0-c7b0e9edf9b0@suse.com

Changes in v3:
- landlock01: 1 byte less when
  HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET is defined
- landlock04: dynamically assign read/exec permissions to dependences
- landlock05: estetic fix and skip exfat
- landlock06: estetic fix and skip exfat
- Link to v2: https://lore.kernel.org/r/20240710-landlock-v2-0-ff79db017d57@suse.com

Changes in v2:
- remove -lc unused dependency from Makefile
- move SAFE_LANDLOCK_* macros in lapi/landlock.h
- define CAP_MKNOD in the lapi/capability.h
- fix landlock fallback in order to let LTP build properly
- fix landlock01 EINVAL test when "struct landlock_ruleset_attr" size is
  too small
- Link to v1: https://lore.kernel.org/r/20240701-landlock-v1-0-58e9af649a72@suse.com

---
Andrea Cervesato (5):
      Add landlock03 test
      Add CAP_MKNOD fallback in lapi/capability.h
      Add landlock04 test
      Add landlock05 test
      Add landlock06 test

 include/lapi/capability.h                          |  12 +-
 runtest/syscalls                                   |   4 +
 testcases/kernel/syscalls/landlock/.gitignore      |   5 +
 testcases/kernel/syscalls/landlock/landlock03.c    | 128 ++++++++
 testcases/kernel/syscalls/landlock/landlock04.c    | 214 +++++++++++++
 testcases/kernel/syscalls/landlock/landlock05.c    | 116 +++++++
 testcases/kernel/syscalls/landlock/landlock06.c    | 112 +++++++
 testcases/kernel/syscalls/landlock/landlock_exec.c |   9 +
 .../kernel/syscalls/landlock/landlock_tester.h     | 343 +++++++++++++++++++++
 9 files changed, 939 insertions(+), 4 deletions(-)
---
base-commit: c68112b0774bf4f13bfb7b121ecc6671d15d133e
change-id: 20240617-landlock-c48a4623a447

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
