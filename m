Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F4AC25B74
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 12:33:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 042B33CFA6A
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 14:33:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75EEC3CF9A3
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:43 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0B6AF1400B69
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D8FE75C34A
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nCRxKkfyqkM5Hf8YVk4pa/a3jEJEZUmkVooHDGuTewY=;
 b=WI4zfxfAwzrxGiKDy8T4skkPDTo93rrPf0jnE9Pq8ktGtchtBrmQl9RJdx6C1k9N6qm10o
 bNfZ1lShXYpRnKzeW4KCD3pl0gHvFqmuXN4fTMPtZyG3fWNMHYCeR1zcM+Ij3cNkHBWe0+
 vwaPDsek5r+ca/Lw24DINvzJm+tqtto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nCRxKkfyqkM5Hf8YVk4pa/a3jEJEZUmkVooHDGuTewY=;
 b=Uv59u9Z0Iyoabtlj87MRkdnXjUV4xnxPtvDbq4M6DXauBTrBHKvQx23cDkuM32xrN9JgIS
 7khj+kzx4CkNpjBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iTEE0qYT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K13IF4Cy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nCRxKkfyqkM5Hf8YVk4pa/a3jEJEZUmkVooHDGuTewY=;
 b=iTEE0qYTzrJ9L/8KRYnjUepQ6qOe1LEIddUA8CmiKuhICs0yj1BuZSFJboNyg5JKdM372k
 CPagHV4vdVyM2YGx/4Dj99HXqHouvGlZTe3v3Ns9I7pk0kxZWvo/lPYeWVGV2Wh2j8o8Ax
 Gi/52JjHaP7iV29cE09wzhaptPEToBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nCRxKkfyqkM5Hf8YVk4pa/a3jEJEZUmkVooHDGuTewY=;
 b=K13IF4Cygyi7RZbaEhuu4YE4W6MDq8DNFWIvEslZYxw1TiEnPXXgCFStnMo4sabguz6joA
 VpaHQxu6HV8aqbCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDEA5137C3
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PKQMLS78RWbOfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 May 2024 14:29:08 +0200
Message-Id: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABX8RWYC/yWM2wpAQBBAf0XzbGusS/gVSRuDKZZ2lpT8u423c
 x7OuUHIMQnU0Q2OThbebJA0jqCfjZ1I8RAcNOoM86RQC4tft8P6Trz5SWGJVZGTHkskCOXuaOT
 ruzbt87wNkZfhZQAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3918;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=gu86DKAKCfzSKcz0YCjeCkDhl0Qzf2uRXZuafJzQ8GU=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmRfwhOdxPahOijJhv6heQR4bwn2298OfuKhxYQ
 AmJ05+OzC+JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkX8IQAKCRDLzBqyILPm
 RnqTDACJvvBlxghCI7dvKDHToTzBk1/1Y2LscSPGpzs1XbXhfCJBLh/bWhFtbFeXrSDzZqrUip4
 DmHBymXGfE1QSa1EGfioI4zIRS3CMthLd7juEDYD7KqMqkAcPSkk0RGqyHEd/tnxAKCRJ347ENd
 eX0ilTBUYlAtisWGyk9I2MvNthTz2APk046GaFGcMHpR4S9G7t6/LU90/Rj+RHZ88Qm5iTie9LM
 TFpRrNbiUxyIeGDqQlo0pkoiRNcdBFYWbs12VG3m2x5E/uM9JHmQb6QT+GK9rPt+UQqYt2I51PA
 XvKGwTYyJsFiBaHXcmf1YLq62UmbN546q0WflQPn1CIctoYqmZF6fvL4e87EceJi3b7tg1lGqYT
 RIAToYl/cRfPNVK4in+idd11CRrqg7T4eHfp7ev4UN6eOEcr9T07u0zH5GV4EKTMHd+Es24LwKt
 uT0t26NM+pdHzCa0aVyh5yu8AJfPOh84NLtpr1HgahRLVmAIo8NsuH2uLzJVfLLpldJtw=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D8FE75C34A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 00/11] statmount/listmount testing suites
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

v2:
- split syscalls definitions from fallback declarations
- remove usless tst_test parameters declarations
- fixed documentation tags (kdoc -> asciidoc)

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (11):
      Add SAFE_STATX macro
      Add listmount/statmount syscalls
      Add listmount/statmount fallback declarations
      Add listmount01 test
      Add listmount02 test
      Add stamount01 test
      Add statmount02 test
      Add statmount03 test
      Add statmount04 test
      Add statmount05 test
      Add statmount06 test

 configure.ac                                      |   5 +
 include/lapi/mount.h                              |  70 +++++++++++
 include/lapi/stat.h                               |  10 +-
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
 include/tst_safe_macros.h                         |   7 ++
 lib/tst_safe_macros.c                             |  22 ++++
 runtest/syscalls                                  |  10 ++
 testcases/kernel/syscalls/listmount/.gitignore    |   2 +
 testcases/kernel/syscalls/listmount/Makefile      |   7 ++
 testcases/kernel/syscalls/listmount/listmount.h   |  26 +++++
 testcases/kernel/syscalls/listmount/listmount01.c |  66 +++++++++++
 testcases/kernel/syscalls/listmount/listmount02.c | 106 +++++++++++++++++
 testcases/kernel/syscalls/statmount/.gitignore    |   6 +
 testcases/kernel/syscalls/statmount/Makefile      |   7 ++
 testcases/kernel/syscalls/statmount/statmount.h   |  26 +++++
 testcases/kernel/syscalls/statmount/statmount01.c |  69 +++++++++++
 testcases/kernel/syscalls/statmount/statmount02.c |  76 ++++++++++++
 testcases/kernel/syscalls/statmount/statmount03.c |  97 +++++++++++++++
 testcases/kernel/syscalls/statmount/statmount04.c | 131 +++++++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount05.c | 136 ++++++++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount06.c |  72 ++++++++++++
 38 files changed, 986 insertions(+), 1 deletion(-)
---
base-commit: e644691d30c3948a9788b735c51e09ca849ea47f
change-id: 20240516-listmount_statmount-080965e2f80e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
