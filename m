Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77495C48BC1
	for <ltp@archiver.kernel.org>; Wed, 14 Feb 2024 17:10:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8E5B3D0527
	for <ltp@archiver.kernel.org>; Wed, 14 Feb 2024 18:10:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79AE23D0519
 for <ltp@lists.linux.it>; Wed, 14 Feb 2024 18:10:05 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 81C1120D3AE
 for <ltp@lists.linux.it>; Wed, 14 Feb 2024 18:10:04 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1E6E1FD29;
 Wed, 14 Feb 2024 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707930603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfc8JYCVIA5Ty0h+MahVUDli7DlWP1yuP/avvnuP0uo=;
 b=i7n2A6QbY2fyYHDoYojuvd2Sft4ijatLQPqQhoSGfIGQgd7UV6gcqBSzTlXbbhCZqTFJfG
 yZJWsrPTm5+AafxHsstxNW7bf03S+e2euV7wl51Txa1RkQQceTFkGiqJZJ9PUdfEv7/jLo
 tjKU7a8/ICVUaeXE8nVq04zsc5dNAnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707930603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfc8JYCVIA5Ty0h+MahVUDli7DlWP1yuP/avvnuP0uo=;
 b=P26GyD2na5u85sQO4WhjyXms6AfeT+afTNQhZ74+0Coq3rZAcL5zeQRFuTiJ+mpj2ryqZZ
 /oDFJMC1UEsz7LCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707930602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfc8JYCVIA5Ty0h+MahVUDli7DlWP1yuP/avvnuP0uo=;
 b=1OpI00SXn9tAqll78/SdISxZR5woJbeAefUpkxpiv5XzC45NegzdLAnIfAIojzBX7gQ1pp
 6NYrwhCOlanSyjg/ZxfBBsBgdqkoLt5/Nxm46suDvvc2vHKhMf6PaCg57obE+Ztr3IaiSN
 wSyyU23t2+/2CSc5gG4QSLCxdtOnN68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707930602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfc8JYCVIA5Ty0h+MahVUDli7DlWP1yuP/avvnuP0uo=;
 b=oI6Ou5Qp6fHb6gBlufm7I28pB3M2cpknYoa+R+06A6Oc0KsQa+Mydl03T5OPZfnMlE57sK
 ILmf6j2cPUxPX/Bw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BA23913A35;
 Wed, 14 Feb 2024 17:10:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id IG7JKunzzGUnNQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 14 Feb 2024 17:10:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 14 Feb 2024 18:09:49 +0100
Message-ID: <20240214170949.793338-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214170949.793338-1-pvorel@suse.cz>
References: <20240214170949.793338-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWELVE(0.00)[12];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[richiejp.com:email,huawei.com:email,suse.com:email,suse.cz:email,mbobrowski.org:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[suse.cz,redhat.com,fujitsu.com,gmail.com,mbobrowski.org,richiejp.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] tree: Relicense GPL-2.0 (v2 only) =>
 GPL-2.0-or-later
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
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc: Jan Stancek <jstancek@redhat.com>
Cc: Martin Doucha <mdoucha@suse.cz>
Cc: Richard Palethorpe <io@richiejp.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

I'm sorry to steal your time with license cleanup.

LTP started as GPL v2 only around 2001. Later new tests were changed to
GPL v2+. When we later started using SPDX, we use GPL-2.0 which actually
means GPL-2.0-only. Please if you agree with changing GPL-2.0-or-later
for tests you wrote ack this (or send a patch where you change it if you
prefer). If you don't agree or you don't reply your files will stay
GPL v2 only (just SPDX will be changed to GPL-2.0-only to be obvious.)

Kind regards,
Petr

Matthew Bobrowski
testcases/kernel/syscalls/fanotify/fanotify12.c
testcases/kernel/syscalls/fanotify/fanotify13.c
testcases/kernel/syscalls/fanotify/fanotify14.c
testcases/kernel/syscalls/fanotify/fanotify_child.c

Amir Goldstein
testcases/kernel/syscalls/fanotify/fanotify06.c
testcases/kernel/syscalls/fanotify/fanotify10.c
testcases/kernel/syscalls/fanotify/fanotify23.c
testcases/kernel/syscalls/fcntl/fcntl38.c
testcases/kernel/syscalls/fcntl/fcntl39.c
testcases/kernel/syscalls/inotify/inotify10.c

Jan Kara
testcases/kernel/syscalls/fanotify/fanotify01.c
testcases/kernel/syscalls/fanotify/fanotify02.c
testcases/kernel/syscalls/fanotify/fanotify03.c
testcases/kernel/syscalls/fanotify/fanotify04.c
testcases/kernel/syscalls/fanotify/fanotify05.c
testcases/kernel/syscalls/fanotify/fanotify06.c
testcases/kernel/syscalls/fanotify/fanotify10.c

Richard Palethorpe
testcases/kernel/controllers/io/io_control01.c
testcases/kernel/syscalls/close_range/close_range01.c
testcases/kernel/syscalls/close_range/close_range02.c

Martin Doucha
testcases/kernel/syscalls/ptrace/ptrace08.c

Jan Stancek
testcases/kernel/syscalls/readahead/readahead01.c

Cyril Hrubis
lib/tst_fs_type.c
lib/tst_process_state.c
lib/tst_timer.c
include/tst_process_state.h (originally v2 only, but changed by me to v2+, can be kept?)

 lib/tst_fs_type.c                                     | 2 +-
 lib/tst_process_state.c                               | 2 +-
 lib/tst_timer.c                                       | 2 +-
 testcases/kernel/controllers/io/io_control01.c        | 2 +-
 testcases/kernel/syscalls/close_range/close_range01.c | 2 +-
 testcases/kernel/syscalls/close_range/close_range02.c | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify01.c       | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify02.c       | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify03.c       | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify04.c       | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify05.c       | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify06.c       | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify10.c       | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify12.c       | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify13.c       | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify14.c       | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify23.c       | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify_child.c   | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl38.c             | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl39.c             | 2 +-
 testcases/kernel/syscalls/inotify/inotify10.c         | 2 +-
 testcases/kernel/syscalls/ptrace/ptrace08.c           | 2 +-
 testcases/kernel/syscalls/readahead/readahead01.c     | 2 +-
 23 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
index 7f0d61a8e..e9efb89dc 100644
--- a/lib/tst_fs_type.c
+++ b/lib/tst_fs_type.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2005-2021 Linux Test Project
  *
diff --git a/lib/tst_process_state.c b/lib/tst_process_state.c
index c15283c3d..033af2023 100644
--- a/lib/tst_process_state.c
+++ b/lib/tst_process_state.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2012-2014 Cyril Hrubis chrubis@suse.cz
  * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
diff --git a/lib/tst_timer.c b/lib/tst_timer.c
index 62d8f9080..ecf165ca4 100644
--- a/lib/tst_timer.c
+++ b/lib/tst_timer.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  */
diff --git a/testcases/kernel/controllers/io/io_control01.c b/testcases/kernel/controllers/io/io_control01.c
index 691196886..47ae0f104 100644
--- a/testcases/kernel/controllers/io/io_control01.c
+++ b/testcases/kernel/controllers/io/io_control01.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
  */
diff --git a/testcases/kernel/syscalls/close_range/close_range01.c b/testcases/kernel/syscalls/close_range/close_range01.c
index 072bbab66..c2a0c9619 100644
--- a/testcases/kernel/syscalls/close_range/close_range01.c
+++ b/testcases/kernel/syscalls/close_range/close_range01.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Taken from the kernel self tests, which in turn were based on
  * a Syzkaller reproducer.
diff --git a/testcases/kernel/syscalls/close_range/close_range02.c b/testcases/kernel/syscalls/close_range/close_range02.c
index 2aa6d2c9f..48d9a31df 100644
--- a/testcases/kernel/syscalls/close_range/close_range02.c
+++ b/testcases/kernel/syscalls/close_range/close_range02.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2021 SUSE LLC
  */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 3cb485c2a..5d18fe851 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 SUSE.  All Rights Reserved.
  *
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index 3321e5526..19854064a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 SUSE.  All Rights Reserved.
  *
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 028da742c..3ed78e5fa 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 SUSE.  All Rights Reserved.
  *
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index 8541a7b96..378bc57c0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 SUSE.  All Rights Reserved.
  *
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 04670cb1c..12c240881 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 SUSE Linux.  All Rights Reserved.
  *
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index 618c85a43..8779e34d9 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 SUSE.  All Rights Reserved.
  *
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 6c89ca1d0..c6d8ec922 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 SUSE.  All Rights Reserved.
  * Copyright (c) 2018 CTERA Networks.  All Rights Reserved.
diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index 42ba08800..60ba27e16 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Matthew Bobrowski. All Rights Reserved.
  *
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 6086a81fc..5cd857707 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Matthew Bobrowski. All Rights Reserved.
  *
diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 0b0da89ca..d02d81495 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Matthew Bobrowski. All Rights Reserved.
  * Copyright (c) Linux Test Project, 2020-2022
diff --git a/testcases/kernel/syscalls/fanotify/fanotify23.c b/testcases/kernel/syscalls/fanotify/fanotify23.c
index 5a03503e9..35a613fea 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify23.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify23.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2022 CTERA Networks.  All Rights Reserved.
  *
diff --git a/testcases/kernel/syscalls/fanotify/fanotify_child.c b/testcases/kernel/syscalls/fanotify/fanotify_child.c
index 2e4e189cb..73f634514 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify_child.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify_child.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Matthew Bobrowski. All Rights Reserved.
  *
diff --git a/testcases/kernel/syscalls/fcntl/fcntl38.c b/testcases/kernel/syscalls/fcntl/fcntl38.c
index 2f1b0229e..d867bf876 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl38.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl38.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 CTERA Networks. All Rights Reserved.
  *
diff --git a/testcases/kernel/syscalls/fcntl/fcntl39.c b/testcases/kernel/syscalls/fcntl/fcntl39.c
index 973b6a652..30aada2aa 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl39.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl39.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2021 CTERA Networks. All Rights Reserved.
  *
diff --git a/testcases/kernel/syscalls/inotify/inotify10.c b/testcases/kernel/syscalls/inotify/inotify10.c
index ed91b920f..6a9a0a436 100644
--- a/testcases/kernel/syscalls/inotify/inotify10.c
+++ b/testcases/kernel/syscalls/inotify/inotify10.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 CTERA Networks. All Rights Reserved.
  *
diff --git a/testcases/kernel/syscalls/ptrace/ptrace08.c b/testcases/kernel/syscalls/ptrace/ptrace08.c
index d17d6b411..9e64edc48 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace08.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace08.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Andrew Lutomirski
  * Copyright (C) 2020 SUSE LLC <mdoucha@suse.cz>
diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index a1f313605..0f610daf8 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2012 Linux Test Project, Inc.
  * Copyright (C) 2023-2024 Cyril Hrubis <chrubis@suse.cz>
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
