Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B26C282DE
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 09:16:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36D093CA4EA
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 10:16:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1B083C8F94
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 10:15:51 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1336A1400BE3
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 10:15:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D95F11F452;
 Thu, 13 Mar 2025 09:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741857350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9fY29VI9Y9rG5dCjiy/dZicQeQNi2ZbD6at9S+DIHT8=;
 b=kdBqASgEd90K7OeKKpO6mQEnowEMtHFiRW+G1AdKi4fbQb7okbCAJ7bYmGLEMnm+jOjMc4
 WMJf6uTWE3aLcFZWPFe/8Ww0BqB6eEqy9hmKj5LuwhcXcT8en+y6NCxWeh1D/m7bFupsCo
 RbYZu39/YUT3URqSjzcPl12GkZPikNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741857350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9fY29VI9Y9rG5dCjiy/dZicQeQNi2ZbD6at9S+DIHT8=;
 b=nGHqt3g+bqcQaGdL9liSvjWEPaJ7WohAZ0AFrxNZRyV7dUgDmi5bgL55YdYTY6Q2TTDwnf
 8NCByWCJHZ0bEEAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741857349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9fY29VI9Y9rG5dCjiy/dZicQeQNi2ZbD6at9S+DIHT8=;
 b=ZrWaDlYAr/vrbFV7uR/GWxRjBNz10bGoE4KSHBx/gxE2MPFey13lnYzX08FeS7hz/TNoUv
 IdWjUw/9HdNnAuqah8TXu624CcbrVYDyV8hSrAWpO64+NdS6jrGznNXo/Rdjy6zbPoIfNL
 nQLNT9it6owzrRdkcFCfBPV5xsXBoPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741857349;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9fY29VI9Y9rG5dCjiy/dZicQeQNi2ZbD6at9S+DIHT8=;
 b=A7l+7AuOe/EluUo/WCJAaIoI3PARaox3UYfJhyWHweezsfQM3Sppv1Z9DBXQtT+pUznHXt
 SbAzEUF084UdZVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC049137BA;
 Thu, 13 Mar 2025 09:15:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P1RlMUWi0mczNQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 13 Mar 2025 09:15:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 13 Mar 2025 10:15:33 +0100
Message-Id: <20250313-mmap_suite_refactoring-v3-0-eb9172686230@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADWi0mcC/3XNzw6CMAwG8FcxOztTOjajJ9/DGDJYhR74kw0WD
 eHdHSQmXDh+7ddfZxHIMwVxP83CU+TAfZeCOp9E1diuJskuZYGAGhC0bFs7FGHikQpPb1uNvee
 ulgoRcrRlqbQR6XhIS/5s8POVcsMhNb/bn5it0z95PSJjJkE6AONumFHu9CNMgS5V34pVjLhTM
 jhUMCmGHFllc2WU3SnLsvwACCqzAwEBAAA=
X-Change-ID: 20250205-mmap_suite_refactoring-322042abb356
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741857349; l=1881;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=2a+9xmIK26Fw+ovN3OEV4tfEG1tJ4fBRV5NBzbcdJYI=;
 b=dltIZTo7vTCNc311g2lShF3oqWlloUabOjEc0iESLTc83Enn4G5x4QSfwqKjoJLQsDsgML3C9
 5cshGWFhgxEBxtxQvraYvjZkwMEVbl89DOxq08ge+tX7xKCPxauldlP
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/8] Cleanup the mmap testing suite
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
 testcases/kernel/syscalls/mmap/mmap03.c   | 263 ++++++++----------------------
 testcases/kernel/syscalls/mmap/mmap10.c   | 255 ++++++++++-------------------
 testcases/kernel/syscalls/mmap/mmap12.c   |  30 +---
 testcases/kernel/syscalls/mmap/mmap17.c   |  52 +++---
 testcases/kernel/syscalls/mmap/mmap18.c   |  90 +++++-----
 testcases/kernel/syscalls/mmap/mmap19.c   |   2 +-
 testcases/kernel/syscalls/mmap/mmap20.c   |   3 -
 testcases/kernel/syscalls/mmap/mmap21.c   |  99 +++++++++++
 12 files changed, 330 insertions(+), 665 deletions(-)
---
base-commit: a92aedfabd5826d07809559508c8486c12ff7b96
change-id: 20250205-mmap_suite_refactoring-322042abb356

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
