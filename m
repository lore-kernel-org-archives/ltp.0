Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB0CCF9C6B
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 08:07:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7663A3C4B91
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 10:07:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D7FE3C28AE
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 10:06:53 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 93784600147
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 10:06:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 69C2D21B03
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727165211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qd/WB504Bzgsig63grHmqCLd96CqiN36kK0MJdhYb/I=;
 b=snHsceSJ6gIsH4456Di0OMTXRibxQAVS34MclpD89LycYykjGe39ifT7ihrBnC6B5bfmo7
 mIgLy2qjgYkLDp55QlYyM8yIqAhEOQAFyQWkN9+xL+xizJm4v01FBqkInG6JNc4xMdjHIN
 xc6JfEcXpX8HE+q3hRYpJJFbRiPVVG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727165211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qd/WB504Bzgsig63grHmqCLd96CqiN36kK0MJdhYb/I=;
 b=PgFRF22tuKjuhalXyFl9lbeZAQqve+ODBw7YumQlkMKdJvXf5DDLsTJOV3QPv6ot9uJBBj
 AUGbJYJYPfCpTHDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727165211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qd/WB504Bzgsig63grHmqCLd96CqiN36kK0MJdhYb/I=;
 b=snHsceSJ6gIsH4456Di0OMTXRibxQAVS34MclpD89LycYykjGe39ifT7ihrBnC6B5bfmo7
 mIgLy2qjgYkLDp55QlYyM8yIqAhEOQAFyQWkN9+xL+xizJm4v01FBqkInG6JNc4xMdjHIN
 xc6JfEcXpX8HE+q3hRYpJJFbRiPVVG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727165211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qd/WB504Bzgsig63grHmqCLd96CqiN36kK0MJdhYb/I=;
 b=PgFRF22tuKjuhalXyFl9lbeZAQqve+ODBw7YumQlkMKdJvXf5DDLsTJOV3QPv6ot9uJBBj
 AUGbJYJYPfCpTHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58CEC13AA8
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 08:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vtpaFBtz8mYVcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 08:06:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 24 Sep 2024 10:06:25 +0200
Message-Id: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAFz8mYC/x3M2wpAQBCA4VfRXNtaQzm8iqQ9DKa0tCORvLvN5
 Xfx/w8IRSaBLnsg0snCW0go8gzcYsJMin0yoMZKt1iqmQJFc9AotzizrqLqRnuHiLX1FlK3R5r
 4+p/98L4fAYQIwGMAAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727165210; l=2713;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=w1fsJNLRf2fJL0apkDvT1Hop1MzCSlWmIYEBAaw8ImI=;
 b=RhJhYLSDlHnwrrTFvF1+tJuHRZy2JH6f6KZ/Mxrhai0I5K4BsTersPhFXB6bQ65XZkTdEJnXZ
 vSbuyuDK2y3CpzAgktwPawqfnKolc6ljc2XaoGT2nC77eJGSuqbPtdg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] Automatically generate syscalls.h
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

The problem we have at the moment is that all syscalls input files must
be changed by hand each time we need to test a new syscall. The idea is
to simplify this process, providing a script that is able to read from
kernel sources and to generate all syscalls files we need.

This is done by the generate_syscalls.sh script that can be used as
following:

./generate_syscalls.sh path/to/kernel/source path/to/syscalls.h

This approach requires a certain type of attention, due to the fact that
we need to generate syscalls.h at each kernel version, or when new
syscalls have been added in the kernel.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (4):
      Rename syscalls order file to supported-arch.txt
      Add script to generate syscalls.h
      Deprecate old syscalls input files
      Save syscalls.h inside repo

 include/lapi/.gitignore                            |     1 -
 include/lapi/syscalls.h                            | 34272 +++++++++++++++++++
 include/lapi/syscalls/aarch64.in                   |   306 -
 include/lapi/syscalls/arc.in                       |   325 -
 include/lapi/syscalls/arm.in                       |   404 -
 include/lapi/syscalls/blacklist-syscalls.txt       |     6 +
 include/lapi/syscalls/generate_syscalls.sh         |   292 +
 include/lapi/syscalls/hppa.in                      |    52 -
 include/lapi/syscalls/i386.in                      |   439 -
 include/lapi/syscalls/ia64.in                      |   956 +-
 include/lapi/syscalls/loongarch.in                 |   310 -
 include/lapi/syscalls/mips_n32.in                  |   379 -
 include/lapi/syscalls/mips_n64.in                  |   355 -
 include/lapi/syscalls/mips_o32.in                  |   425 -
 include/lapi/syscalls/powerpc.in                   |   432 -
 include/lapi/syscalls/powerpc64.in                 |   432 -
 include/lapi/syscalls/regen.sh                     |   129 -
 include/lapi/syscalls/s390.in                      |   419 -
 include/lapi/syscalls/s390x.in                     |   367 -
 include/lapi/syscalls/sh.in                        |   413 -
 include/lapi/syscalls/sparc.in                     |   418 -
 include/lapi/syscalls/sparc64.in                   |   383 -
 include/lapi/syscalls/strip_syscall.awk            |    19 -
 .../lapi/syscalls/{order => supported-arch.txt}    |     1 -
 include/lapi/syscalls/x86_64.in                    |   396 -
 25 files changed, 35174 insertions(+), 6757 deletions(-)
---
base-commit: 968e6245d93bc91723e72086a71e6bc50f495d0b
change-id: 20240923-generate_syscalls-780dc2227bdb

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
