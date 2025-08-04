Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685D8C87FCF
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 18:10:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D78913CCFD4
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 20:10:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E94BD3C8EB8
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:09:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2506E200046
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:09:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9BFD521990;
 Mon,  4 Aug 2025 18:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754330967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jY0EOx8/RNiB7+me/wASOqJ35srxDYPRv5VZpD4OG5Q=;
 b=QenMAzAaPdJj5H85AGrk75Deo6QwtpNd6bpFa8yq7zjKFwaEQIXrTjjHgM8bCrGqBsNbSb
 0YKoJfIr94AhQSDPW/SggU8HD75OIjewDfWN6bTMm+vexLiV+XgcYR/aQmIb5QM+X7InUe
 H4wki2p/2XR3l4FWosALZyzYmsTOlcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754330967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jY0EOx8/RNiB7+me/wASOqJ35srxDYPRv5VZpD4OG5Q=;
 b=oFWUDOqNN+G/9dwA02S/OBKlmnXdsNGqpEQa8FvoMBUPlY//qB3MEdL6J15q5jfeXlfi3c
 7WIoaPAjF445daBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QenMAzAa;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oFWUDOqN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754330967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jY0EOx8/RNiB7+me/wASOqJ35srxDYPRv5VZpD4OG5Q=;
 b=QenMAzAaPdJj5H85AGrk75Deo6QwtpNd6bpFa8yq7zjKFwaEQIXrTjjHgM8bCrGqBsNbSb
 0YKoJfIr94AhQSDPW/SggU8HD75OIjewDfWN6bTMm+vexLiV+XgcYR/aQmIb5QM+X7InUe
 H4wki2p/2XR3l4FWosALZyzYmsTOlcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754330967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jY0EOx8/RNiB7+me/wASOqJ35srxDYPRv5VZpD4OG5Q=;
 b=oFWUDOqNN+G/9dwA02S/OBKlmnXdsNGqpEQa8FvoMBUPlY//qB3MEdL6J15q5jfeXlfi3c
 7WIoaPAjF445daBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 722FC133D1;
 Mon,  4 Aug 2025 18:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AXgWGVf3kGjyJgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Aug 2025 18:09:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 Aug 2025 20:09:18 +0200
Message-Id: <20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAE73kGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwND3bTMnNT44tSSxJKSovh0CK1rbmJpZpyWYmqUZGCqBNRaUJSallk
 BNjY6trYWACUHWJVmAAAA
X-Change-ID: 20250801-file_setattr_getattr-74963fd52b05
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754330967; l=2499;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=M1dHdYRn5e1gHCK7U6ogwMMuK2EraYOiZafBuI3QJWM=;
 b=Sapl6e08ngNnGbea3xs4e1SGFmdhEVEzLaVocVzX1sr3eEifxCxXleFt/LNPvK+4Q8fuhnWAq
 jDjRtaS3xWIB5+g+/BO/sGsSx+UxcRYMoOGSp84OHH81vSTDqVVLv5Q
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 9BFD521990
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] file_setattr/file_getattr testing suite
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
Andrea Cervesato (6):
      Update LTP to the latest syscalls
      fs: add struct fsxattr fallback definitions
      fs: add file_setattr/file_getattr fallback definitions
      Add file_attr01 test
      Add file_attr02 test
      Add file_attr03 test

 compile_flags.txt                                 |   5 +
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
 testcases/kernel/syscalls/getxattr/getxattr06.c   |  53 +++++++
 27 files changed, 593 insertions(+)
---
base-commit: 6505f9e29960fa842067ee622cdc6632f9142fb7
change-id: 20250801-file_setattr_getattr-74963fd52b05

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
