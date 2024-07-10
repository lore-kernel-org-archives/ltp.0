Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C72DC3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 18:05:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 358AF3D4880
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 20:05:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9557B3D3862
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:32 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E4C2C20819A
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DEACC1F84C;
 Wed, 10 Jul 2024 18:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nCo3oaHwThdy08qOSk6coix+KLP5t+G8B924U4LKz5g=;
 b=0i2Ubj1KA/5B+6sSV/eiG2uhBRbZgwAiNlP+PSMQTA8ZXToD/MN81lf7HeV0ianRu1sjfJ
 7YBCPvoja1qT5v9h51LZWGO/RnSVAsJkh7pmtlGvJP8pUIMRGke1DMO2S4pL2+vWx9Pelu
 mfyT0ZehLoAseEhILw64vjgMDIxaCNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nCo3oaHwThdy08qOSk6coix+KLP5t+G8B924U4LKz5g=;
 b=qN0oWVbQEJdJKpgXD+4HGjKu0cK0X56f7SbEKjVMeWRdrCX5V7eq7ma/L8l9zgPB+O1CrD
 3JZU9TAQAIX4u3Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="TTCKY/r1";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UJnJjXVt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nCo3oaHwThdy08qOSk6coix+KLP5t+G8B924U4LKz5g=;
 b=TTCKY/r1S7kd1YyruY0dN4cU+0DujyVi3EBm7h+7U1UAlVlzhGSPh4IGXrRUpo8IiGwb7D
 cmrCIcO5jKB9gTiMLqKQfrSwKBHZULQ++7dtTn/kGz/3exz0QsF5iY4+fWHfyiHywXw42m
 lztLP7rfNHAwQqdRc+soa1sfMGalyZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nCo3oaHwThdy08qOSk6coix+KLP5t+G8B924U4LKz5g=;
 b=UJnJjXVt3QlqSGNcVZZosX7ae9y451QPlIEZCuKE5b62YvIVzogVUMXUgQCvK6EB7YCS6+
 fwkEOq5ThpMG2wDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCC69137D2;
 Wed, 10 Jul 2024 18:02:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cV9eLKrMjmZJfAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 18:02:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 20:01:55 +0200
Message-Id: <20240710-landlock-v2-0-ff79db017d57@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJPMjmYC/0XMQQ7CIBCF4as0sxYDiNC68h6miwmdWmKFBpRoG
 u4u1oXL/+XlWyFRdJTg1KwQKbvkgq8hdw3YCf2VmBtqg+RScS0Mm9EPc7A3ZlWLSssDKmWg3pd
 Io3tt1KWvPbn0CPG9yVl81x9iuPgjWTDOji11OGrVoZHn9Ey0t+EOfSnlAz6hFmKfAAAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3549;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=AAjwSBm5eIOMZIanMKfsxfQCJIXGe89pjh8HzFliprQ=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjsydA+hccw3DUsG37DdD5uDYdhMSxsDpQ6WRC
 zuj+OXLj4iJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7MnQAKCRDLzBqyILPm
 RiW2C/99gMaegbSG3n+8c90o2yAq0G/QK2fggY2h4E4RU4sqtQ2uyx4hNDaJpQGrE2XoqS/9e0Y
 ugOkDJdD2cbHvCxvqVE3GaoMHxiYxlG2QVyxU1UI40aLgfYYwhWeksjfPiot44ek6tw3Rn3c0nZ
 xVZAQJEsNf8GvI/y2/lvA4qRU1hvoGpqdcc5TtgcqB/bAf0lLL/yOqUymJsegniPu8yS9qNzwc3
 vU+J6tqBzUFT5EIMXD29/+hbguHb/eo3FJyUYT6tPje32heEiRPy+CtMMzTKX6m0aohluW9cG8v
 cKpuFzHSzyHY1Xe5g11wG0tiQC1o2oFgXEZz26EC0lTIlz8zORtFazXuWKK3amtq5HueFTwdnuM
 nlVLh5FMtrk8OXDCrlH6Ba6LdAoItJhh3TZNsg2KMHr0fPFqfYRLLnuNvnJpR6EU+i131aL69g+
 RpHYNrJRRW9yJSb6e7WjYLM7GnSO0qPV5R/95hagbAlfUpNNOmraOjoJawWL33CJ4/sI4=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DEACC1F84C
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 00/11] landlock testing suite
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
Changes in v2:
- remove -lc unused dependency from Makefile
- move SAFE_LANDLOCK_* macros in lapi/landlock.h
- define CAP_MKNOD in the lapi/capability.h
- fix landlock fallback in order to let LTP build properly
- fix landlock01 EINVAL test when "struct landlock_ruleset_attr" size is
  too small
- Link to v1: https://lore.kernel.org/r/20240701-landlock-v1-0-58e9af649a72@suse.com

---
Andrea Cervesato (11):
      Add landlock syscalls definitions
      Add lapi/landlock.h fallback
      Added three more SAFE_* macros for landlock sandbox:
      Add SAFE_PRCTL macro
      Add landlock01 test
      Add landlock02 test
      Add landlock03 test
      Add CAP_MKNOD fallback in lapi/capability.h
      Add landlock04 test
      Add landlock05 test
      Add landlock06 test

 configure.ac                                       |   6 +
 include/lapi/capability.h                          |  12 +-
 include/lapi/landlock.h                            | 184 +++++++++++
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
 include/tst_safe_macros.h                          |   6 +
 lib/tst_safe_macros.c                              |  17 +
 runtest/syscalls                                   |   7 +
 testcases/kernel/syscalls/landlock/.gitignore      |   7 +
 testcases/kernel/syscalls/landlock/Makefile        |   7 +
 testcases/kernel/syscalls/landlock/landlock01.c    |  92 ++++++
 testcases/kernel/syscalls/landlock/landlock02.c    | 153 +++++++++
 testcases/kernel/syscalls/landlock/landlock03.c    | 119 +++++++
 testcases/kernel/syscalls/landlock/landlock04.c    | 176 +++++++++++
 testcases/kernel/syscalls/landlock/landlock05.c    | 114 +++++++
 testcases/kernel/syscalls/landlock/landlock06.c    | 110 +++++++
 .../kernel/syscalls/landlock/landlock_common.h     |  74 +++++
 testcases/kernel/syscalls/landlock/landlock_exec.c |   9 +
 .../kernel/syscalls/landlock/landlock_tester.h     | 350 +++++++++++++++++++++
 34 files changed, 1490 insertions(+), 4 deletions(-)
---
base-commit: cdf739f26f33e589ab9cdf074a6b7fc04842eca2
change-id: 20240617-landlock-c48a4623a447

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
