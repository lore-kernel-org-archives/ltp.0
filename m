Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBE3C87FCF
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 18:17:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECBBB3CCFEF
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 20:17:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05C483C8D08
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:17:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3B9F1100023A
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:17:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6268C1F393;
 Mon,  4 Aug 2025 18:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754331433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=edpSunDmJFnyKY8vhDBQRD/XyftDkh14yDy5N39FJOA=;
 b=TTH+TEBq3UGOn2fifPs4MtR5Ii4G+WzXGMFVac+XpvXlQB/OzqtjMs3O0vJy2aPgYEN+3Y
 Q5RmRcEqsDCWUaL2wDh7vFqTXCEaEru0RIEFhh4czE2sSgj7t7M5s6crPzKDI9yH89DhAa
 u/hUdkpLyUCqGeAi9RW4S2mxJsDUOXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754331433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=edpSunDmJFnyKY8vhDBQRD/XyftDkh14yDy5N39FJOA=;
 b=EiUDoZBZZeedKTAkwPO+Cwm7/caCTcNu7GP6ZGgoIFzWBrDg3Ysgeik5GzXlka81EIUHGt
 nVgQ8tPvZx084LCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754331432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=edpSunDmJFnyKY8vhDBQRD/XyftDkh14yDy5N39FJOA=;
 b=MGu7xnRNZYBHFGx0/1mpMrM4XjG53XnFSLaol7sxqdCj+IushN99hkB073Ihj6TJRPfwdc
 pcodVFxXsvycK874Q0Z2kOWZgmQWwvxB/PlScLZY2weCtDjiZ1xjqhUC8NcqTj1DLDs6WM
 a0Bmi6J/cfZJv7gQsfBJIJZy9q0xzyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754331432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=edpSunDmJFnyKY8vhDBQRD/XyftDkh14yDy5N39FJOA=;
 b=L+vKCYNazupEdzuYUXlJjEBwNSfGxUAFQwhS/xY33Haw2qV1iJVYqHBNUYqgdr0q7LQRrF
 clLqc+/mmpm8noAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D711133D1;
 Mon,  4 Aug 2025 18:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9TdwDCj5kGgoKQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Aug 2025 18:17:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 Aug 2025 20:17:09 +0200
Message-Id: <20250804-file_setattr_getattr-v2-0-651e50ec59e7@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACX5kGgC/22NzQ6CMBCEX4Xs2ZpSKH8n38MQgmWBTZSabiUa0
 ne3Yrx5mnyTzDcbMDpChibZwOFKTHaJoA4JmLlfJhQ0RAYllZaVTMVIV+wYfe+966ZvijKvi2w
 ctLpIDXF6dzjSc9ee28gzsbfutb+s6af9CfP/wjUVUhR9npmsLpSpyhM/GI/G3qANIbwBuc9O/
 7cAAAA=
X-Change-ID: 20250801-file_setattr_getattr-74963fd52b05
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754331432; l=2539;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=VgE0NpawM6VIxXZ05nyoxhh4WK6jiU2jvTAgc6vtNMg=;
 b=jFjBC2kQg8i2iRby5Tn1TgvqkrUxR0nf82sSf0RUyAWM2V7VeCt/ViuPCYT9LpmDnL5xRjUHL
 gkdoVrCjENYBTpOHT0ejAKrp5roK2vQl2YOF5qyQGxu5wQTBZFxKp44
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, configure.ac:url,
 suse.com:email, suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/6] file_setattr/file_getattr testing suite
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

This testing suite is validating file_getattr and file_setattr
syscalls, introducing tests for error validation and basic
functionalities. These features have been introduced in the kernel 6.17.

https://lore.kernel.org/lkml/20250725-vfs-fileattr-fcfc534aac44@brauner/

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- remove unrelated files
- fix fs.h ifndef
- Link to v1: https://lore.kernel.org/r/20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com

---
Andrea Cervesato (6):
      Update LTP to the latest syscalls
      fs: add struct fsxattr fallback definitions
      fs: add file_setattr/file_getattr fallback definitions
      Add file_attr01 test
      Add file_attr02 test
      Add file_attr03 test

 configure.ac                                      |   3 +
 include/lapi/fs.h                                 |  52 +++++++
 include/lapi/syscalls/arc.in                      |   7 +
 include/lapi/syscalls/arm.in                      |   7 +
 include/lapi/syscalls/arm64.in                    |   7 +
 include/lapi/syscalls/i386.in                     |   7 +
 include/lapi/syscalls/loongarch64.in              |   7 +
 include/lapi/syscalls/mips64.in                   |   7 +
 include/lapi/syscalls/mips64n32.in                |   7 +
 include/lapi/syscalls/mipso32.in                  |   7 +
 include/lapi/syscalls/parisc.in                   |   7 +
 include/lapi/syscalls/powerpc.in                  |   7 +
 include/lapi/syscalls/powerpc64.in                |   7 +
 include/lapi/syscalls/s390.in                     |   7 +
 include/lapi/syscalls/s390x.in                    |   7 +
 include/lapi/syscalls/sh.in                       |   7 +
 include/lapi/syscalls/sparc.in                    |   7 +
 include/lapi/syscalls/sparc64.in                  |   7 +
 include/lapi/syscalls/x86_64.in                   |   7 +
 runtest/syscalls                                  |   4 +
 testcases/kernel/syscalls/file_attr/.gitignore    |   3 +
 testcases/kernel/syscalls/file_attr/Makefile      |   8 +
 testcases/kernel/syscalls/file_attr/file_attr01.c | 171 ++++++++++++++++++++++
 testcases/kernel/syscalls/file_attr/file_attr02.c |  94 ++++++++++++
 testcases/kernel/syscalls/file_attr/file_attr03.c |  81 ++++++++++
 25 files changed, 535 insertions(+)
---
base-commit: 6505f9e29960fa842067ee622cdc6632f9142fb7
change-id: 20250801-file_setattr_getattr-74963fd52b05

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
