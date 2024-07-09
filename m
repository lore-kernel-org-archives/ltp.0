Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C77C2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 10:46:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DC343D394B
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 12:46:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E63893D0CD5
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:45:57 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0389D1400BD9
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:45:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E4331F7B0;
 Tue,  9 Jul 2024 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720521956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EUizHhR+SNJmGHDGegA7iApUSeiYs+n+jHDDSiFOv8A=;
 b=EuaUZOCWNehDmfh1lPiT8dAfc5q5z1kH/yFOfxO+riQ165FFY7JRKu6zYshZ2iWlbNeNuX
 1JJQ0jY99vlwpOU7/3brsmwtt6uN4WlHde6u8xbGDWpEGPQCwsda2aolAyFsCXwqLDnGkw
 HLwCgskNfWWeaZXur/d/VIUjRbZxii0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720521956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EUizHhR+SNJmGHDGegA7iApUSeiYs+n+jHDDSiFOv8A=;
 b=PU6lg7ay2IiLOqI4Uh40g0aMigo9ZF0N0GJYDTwTv+EqJOkHWB5vNXtSmUGMKg6G77P1cP
 1MLbZbZJd4p7z1DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EuaUZOCW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PU6lg7ay
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720521956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EUizHhR+SNJmGHDGegA7iApUSeiYs+n+jHDDSiFOv8A=;
 b=EuaUZOCWNehDmfh1lPiT8dAfc5q5z1kH/yFOfxO+riQ165FFY7JRKu6zYshZ2iWlbNeNuX
 1JJQ0jY99vlwpOU7/3brsmwtt6uN4WlHde6u8xbGDWpEGPQCwsda2aolAyFsCXwqLDnGkw
 HLwCgskNfWWeaZXur/d/VIUjRbZxii0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720521956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EUizHhR+SNJmGHDGegA7iApUSeiYs+n+jHDDSiFOv8A=;
 b=PU6lg7ay2IiLOqI4Uh40g0aMigo9ZF0N0GJYDTwTv+EqJOkHWB5vNXtSmUGMKg6G77P1cP
 1MLbZbZJd4p7z1DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBE9A1369A;
 Tue,  9 Jul 2024 10:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id le6oM+MUjWaBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 09 Jul 2024 10:45:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 09 Jul 2024 12:45:30 +0200
Message-Id: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMoUjWYC/2XMQQ6CMBCF4auQWVszHSFQV97DsIB2lC6kplMbD
 endrWxd/i8v3wbC0bPAudkgcvbiw1qDDg3YZVrvrLyrDYTUYo+kJE0JW2WZ526YBzQaoZ6fkW/
 +vUPXsfbiJYX42d2sf+sfkbVCxdQ7Y7oTaXQXeQkfbXjAWEr5AoGOacebAAAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1706;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=vKloH4vP2nSi5zydzJ5VQdo2/3WmgGiPLO1DsYVMWyM=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjRTRs68Rd4OYS+WmkAcJpKdYv20p4/ObrKvZf
 hU24WCTFPiJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo0U0QAKCRDLzBqyILPm
 RrzXDACQQYJ3AdioncgKqxmB6tMrFQP0IQxrDk7pYpMFyOVT0Rsklo5GgWhF4Az826kfZD0jE7D
 /qGl0g+SMzA1EC/tIZVsbpFT3hJeQlAM7VOd2mq9ex3hgcsXpjphoEOpAyGT4QT+0gcfKNj0mgj
 No4tPtxtEo0ZqkF5Uj/i1bNp7B0CzqY9U66NogZ4MrTYtYCdmSaDLdm5uaRulV5xjacEQQwJbHq
 EnhzNZHwXR4fE5WeZRIrX/YyyVlbVluvuvTowKlHnR5ewZC//locV8E1xcl8Ue38GB3Ewwb9Xep
 Ezma8ZLabM0ULuc8SY05WSEEcNqoatdQpF2grh1NtsLZ8KfrNE3W9UusLOuSSocuv+y0JwwYE6B
 aoetDocHVXtopzPWuhzjuRWnkCeMKgq+QivKbZR7zBmbACEgpyC45p7vg+zsnbHz5GZ0lhB6c+a
 fcVOjwoiu4OyMbh2K0li8uRxqX2zf7N+LtfUeLN5comjHP6YMe0V0Ppx8LMjsYzYPEyfQ=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: 1E4331F7B0
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/5] symlink01 split
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

This is a developement series (requested by Petr Vorel) that handle
symlink01 split, which has been already merged in the master branch.

In this series we face the next part of symlink01 split that
includes stat04, lstat03, open15 and chmod08.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- update TST_EXP_EXTR to support stringification
- call stat() inside the test run() routine
- call lstat() inside the test run() routine
- simplify chmod08
- simplify open15
- Link to v1: https://lore.kernel.org/r/20240702-stat04-v1-0-e27d9953210d@suse.com

---
Andrea Cervesato (5):
      Add stat04 test
      Fix TST_EXP_EXTR() stringification
      Add lstat03 test
      Add chmod08 test
      Add open15 test

 include/tst_test_macros.h                  |   5 +-
 runtest/smoketest                          |   4 +-
 runtest/syscalls                           |  11 +--
 testcases/kernel/syscalls/chmod/.gitignore |   1 +
 testcases/kernel/syscalls/chmod/chmod08.c  |  45 +++++++++++
 testcases/kernel/syscalls/fork/fork04.c    |   6 +-
 testcases/kernel/syscalls/lstat/.gitignore |   2 +
 testcases/kernel/syscalls/lstat/lstat03.c  | 101 ++++++++++++++++++++++++
 testcases/kernel/syscalls/open/.gitignore  |   1 +
 testcases/kernel/syscalls/open/open15.c    |  64 +++++++++++++++
 testcases/kernel/syscalls/stat/.gitignore  |   2 +
 testcases/kernel/syscalls/stat/stat04.c    | 120 +++++++++++++++++++++++++++++
 12 files changed, 350 insertions(+), 12 deletions(-)
---
base-commit: 4dc77b84b1865b37d1023f895f176a418c06b8a7
change-id: 20240702-stat04-ceeb58b80910

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
