Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5408ACEF148
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 09:42:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1BAD3C1876
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 11:42:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 911FB3C0831
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:16 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4C8C11A000BA
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4AB1121B48;
 Tue,  8 Oct 2024 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mbWrNjhOdJNax0PgQTkP029ZrvHU+2DXNxeNLhsJ/JE=;
 b=ZksaG0aTnUMuoEXFE8L9IfBlmSNNoWrhynpyCTU7It4EPIocshIIlg25LMmv4CpPEnx4be
 ofSdjmHeS+2vndW7EJ69h4ggCxGgniFi27+BrSoNSBwiOoL04GEi02gwLsZCL7do/vrZS0
 pQCcY5fcvmG9RXhffI2nanzN9BmyieM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mbWrNjhOdJNax0PgQTkP029ZrvHU+2DXNxeNLhsJ/JE=;
 b=4r0/ntcwQDZOsgb7XsPmtZZ3CqnQihcAjilrXPA/kxJVI4LZBWYhUngsDj5W8/hTMOFHBX
 dKtle5TdAotecJAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zrZJ2rUB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QI3Gwq5G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mbWrNjhOdJNax0PgQTkP029ZrvHU+2DXNxeNLhsJ/JE=;
 b=zrZJ2rUBZDobq6bXxofXPIYJ1h7p6hRiwQKGFE68FHzgGha3rVpsRTvSXg1wConD4PwdG3
 k87MQTvxcueluvWKjjbch59IRUknrsUfhT0VCAAk0IseLO9xSXk/TEXuKxurWHL0AII55T
 v9SPTikzVzIydhKrNE/D14kNd0iOSbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mbWrNjhOdJNax0PgQTkP029ZrvHU+2DXNxeNLhsJ/JE=;
 b=QI3Gwq5GVotpqNtK6xr9mYhQic6HbzHoOSTnxzFX97CzPw9LrnCPIl2k8o0JWtxLnFZf16
 OrOb3D2P5gEdOrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44A8D1340C;
 Tue,  8 Oct 2024 09:42:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pExeJ27+BGcZPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Oct 2024 09:42:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 11:41:53 +0200
Message-Id: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGH+BGcC/33NQQ6CMBAF0KuQrq0ZS4vUlfcwxhSYShOhpgONh
 nB3Cy50YdzN/8l/MzHC4JDYIZtYwOjI+T4FtclY3Zr+itw1KTMBQoLaFfzmaOj82A8XGsz74lC
 CLhQKWwKytLwHtO6xqqdzym3a+PBcn8R8af97MefAhbWyMkJXldkfaSTc1r5jCxflh9CgfxMyE
 blWqhQgm8bCFzHP8wt0O9j6+AAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728380526; l=4926;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=JHLWTQEfTdSAGzfKbiTwkMBKD84Wn8bH3V56aC5WNMQ=;
 b=G7saPa6xF7ImpRfNEyhnyhyHBW/9BwqNLyfE13ISD6oGDlDpQFKFUMivEVIrF/Ba7An5w4Eol
 XlNAArtqwuZDnquJWmHZ+kDleL5wwd2olBbBwfGk9hFrO54LNXygG2V
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 4AB1121B48
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.com:email, suse.com:mid, suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 00/16] statmount/listmount testing suites
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

This patch-set is adding new testing suites for statmount() and listmount()
syscalls, which have been recently added in kernel v6.8.
To find out more information, please read the following documentation since
there's no man pages yet:

https://lwn.net/Articles/950569/
https://lore.kernel.org/lkml/170474400576.2602.7882507604401153304.pr-tracker-bot@kernel.org/T/

Along with kernel source code:

https://github.com/torvalds/linux/blob/1b294a1f35616977caddaddf3e9d28e576a1adbc/include/uapi/linux/mount.h#L155
https://github.com/torvalds/linux/blob/1b294a1f35616977caddaddf3e9d28e576a1adbc/tools/testing/selftests/filesystems/statmount/statmount_test.c

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v5:
- usage of sx.data.stx_mask
- use TST_EXP_EQ_STR
- use tst_tmpdir_genpath()
- use !TST_PASS instead of TST_RET == -1
- listmount03
- listmount04
- statmount08
- Link to v4: https://lore.kernel.org/r/20240909-listmount_statmount-v4-0-39558204ddf0@suse.com

Changes in v4:
- listmount01: remove all filesystems run
- listmount02: better descriptions and proper unmount()
- statmount01: check all fields are zeroed
- statmount02: check also readonly flag
- statmount03: now it checks for all mount flags
- statmount04: moved read_peer_group inside statmount.h
- statmount07: add test for invalid values
- generic style fixes 
- fix statx import
- Link to v3: https://lore.kernel.org/r/20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com

---
Andrea Cervesato (16):
      Add SAFE_STATX macro
      Add TST_EXP_EQ_STR macro
      Add listmount/statmount syscalls
      Add listmount/statmount fallback declarations
      Add listmount01 test
      Add listmount02 test
      Add statmount01 test
      Add statmount02 test
      Add statmount03 test
      Add statmount04 test
      Add statmount05 test
      Add statmount06 test
      Add statmount07 test
      Add statmount08 test
      Add listmount03 test
      Add listmount04 test

 configure.ac                                      |   2 +
 include/lapi/mount.h                              |  70 +++++++++++
 include/lapi/stat.h                               | 111 ++++++++++++-----
 include/lapi/syscalls/aarch64.in                  |   2 +
 include/lapi/syscalls/arc.in                      |   2 +
 include/lapi/syscalls/arm.in                      |   2 +
 include/lapi/syscalls/hppa.in                     |   2 +
 include/lapi/syscalls/i386.in                     |   2 +
 include/lapi/syscalls/ia64.in                     |   2 +
 include/lapi/syscalls/loongarch.in                |   2 +
 include/lapi/syscalls/mips_n32.in                 |   2 +
 include/lapi/syscalls/mips_n64.in                 |   2 +
 include/lapi/syscalls/mips_o32.in                 |   2 +
 include/lapi/syscalls/powerpc.in                  |   2 +
 include/lapi/syscalls/powerpc64.in                |   2 +
 include/lapi/syscalls/s390.in                     |   2 +
 include/lapi/syscalls/s390x.in                    |   2 +
 include/lapi/syscalls/sh.in                       |   2 +
 include/lapi/syscalls/sparc.in                    |   2 +
 include/lapi/syscalls/sparc64.in                  |   2 +
 include/lapi/syscalls/x86_64.in                   |   2 +
 include/tst_test_macros.h                         |  14 +++
 runtest/syscalls                                  |  14 +++
 testcases/kernel/syscalls/listmount/.gitignore    |   4 +
 testcases/kernel/syscalls/listmount/Makefile      |   7 ++
 testcases/kernel/syscalls/listmount/listmount.h   |  27 +++++
 testcases/kernel/syscalls/listmount/listmount01.c |  63 ++++++++++
 testcases/kernel/syscalls/listmount/listmount02.c | 105 ++++++++++++++++
 testcases/kernel/syscalls/listmount/listmount03.c |  62 ++++++++++
 testcases/kernel/syscalls/listmount/listmount04.c |  97 +++++++++++++++
 testcases/kernel/syscalls/statmount/.gitignore    |   8 ++
 testcases/kernel/syscalls/statmount/Makefile      |   7 ++
 testcases/kernel/syscalls/statmount/statmount.h   |  51 ++++++++
 testcases/kernel/syscalls/statmount/statmount01.c |  82 +++++++++++++
 testcases/kernel/syscalls/statmount/statmount02.c |  84 +++++++++++++
 testcases/kernel/syscalls/statmount/statmount03.c | 138 ++++++++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount04.c | 105 ++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount05.c | 123 +++++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount06.c |  68 +++++++++++
 testcases/kernel/syscalls/statmount/statmount07.c |  75 ++++++++++++
 testcases/kernel/syscalls/statmount/statmount08.c |  65 ++++++++++
 41 files changed, 1386 insertions(+), 32 deletions(-)
---
base-commit: 701212f08d6e850457cc2b10238f28662ef48471
change-id: 20240516-listmount_statmount-080965e2f80e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
