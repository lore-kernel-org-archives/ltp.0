Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E56C3DA79
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 00:32:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8324E3CE373
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 01:32:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDA1F3C8B4E
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 01:32:24 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5EE8D10000D2
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 01:32:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A4951F911;
 Tue, 16 Jan 2024 00:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705365141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6w1p3ulfM3aa0tSDM8YitPwVd85mTkVL/pMPljp+h3c=;
 b=fagLnmPVgJaiwfzfep8sIrvrGWK4EYxj6WQrcTXxWZffq80GlZHzw4VUHJImVmk1YW99HB
 CBVTNHOW6OdTVruiYXTqgljmWf6/JUiH/0wPrOzk3sZ0icJhoyvM5RZ0DWOzE83V9TDxOA
 KGYq9VAMe8tZhXYWfz1yWWDwhuxhXQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705365141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6w1p3ulfM3aa0tSDM8YitPwVd85mTkVL/pMPljp+h3c=;
 b=HWXQZnJlNowuThXIdadSsE3JLit9tZhMU0aNl+sx4/Njp62INUEJ6CBhSFoX/miaDiz0RX
 AdQ7uTptb4UwMJCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705365141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6w1p3ulfM3aa0tSDM8YitPwVd85mTkVL/pMPljp+h3c=;
 b=fagLnmPVgJaiwfzfep8sIrvrGWK4EYxj6WQrcTXxWZffq80GlZHzw4VUHJImVmk1YW99HB
 CBVTNHOW6OdTVruiYXTqgljmWf6/JUiH/0wPrOzk3sZ0icJhoyvM5RZ0DWOzE83V9TDxOA
 KGYq9VAMe8tZhXYWfz1yWWDwhuxhXQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705365141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6w1p3ulfM3aa0tSDM8YitPwVd85mTkVL/pMPljp+h3c=;
 b=HWXQZnJlNowuThXIdadSsE3JLit9tZhMU0aNl+sx4/Njp62INUEJ6CBhSFoX/miaDiz0RX
 AdQ7uTptb4UwMJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 475E613676;
 Tue, 16 Jan 2024 00:32:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /TWFEJXOpWWQEwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Jan 2024 00:32:21 +0000
Date: Tue, 16 Jan 2024 01:32:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <20240116003219.GD2535088@pevik>
References: <20240115125351.7266-1-chrubis@suse.cz>
 <20240115125351.7266-2-chrubis@suse.cz>
 <20240115230952.GA2535088@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240115230952.GA2535088@pevik>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] lib: Add tst_fd iterator
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

[ removed kernel folks to not bother them with our old distros ]

> Obviously ready to merge, thanks!

I'm sorry, there are still 2 build failures [1] even with my attempt to fix it [2]:

Both Leap 42.2 and Ubuntu Bionic fail to build on:

In file included from ../include/lapi/io_uring.h:17:0,
                 from tst_fd.c:21:
/usr/include/sys/mount.h:35:3: error: expected identifier before numeric constant
   MS_RDONLY = 1,  /* Mount read-only.  */
   ^

I found quite useful to have new LTP for these old distros, but if it's too much
pain I'm ok to drop them. I'm not even sure if it's possible to fix it.
The only way to do that would be for these old distros (which cannot combine
these two headers) to also avoid BPF and io_uring. Code below compiles [3], but
I don't think myself it's a good solution even if we polish the check (transform
into m4 macro).

OTOH fsopen haven't been defined in <sys/mount.h> yet in libc (checked: glibc,
musl, uclibc-ng, bionic), thus the effect would be that we'd just use
<linux/mount.h> instead of <sys/mount.h> in lib/*.c. And mount() related tests
which test <sys/mount.h> (or use lapi/mount.h) could not include <linux/mount.h>
nor <linux/io_uring.h> nor <lapi/bpf.h>. Of course, we can't keep these two old
distros too long.

Kind regards,
Petr

[1] https://github.com/pevik/ltp/actions/runs/7534892435
[2] https://lore.kernel.org/ltp/20240105002914.1463989-1-pvorel@suse.cz/
[3] https://github.com/pevik/ltp/actions/runs/7535285434

> Kind regards,
> Petr

diff --git include/lapi/fsmount.h include/lapi/fsmount.h
index 07eb42ffa..a9491a16d 100644
--- include/lapi/fsmount.h
+++ include/lapi/fsmount.h
@@ -11,12 +11,11 @@
 #include "config.h"
 #include <sys/syscall.h>
 #include <sys/types.h>
-#include <sys/mount.h>
 
-#ifndef HAVE_FSOPEN
-# ifdef HAVE_LINUX_MOUNT_H
+#if !defined(HAVE_FSOPEN) && defined(HAVE_LINUX_MOUNT_H)
 # include <linux/mount.h>
-# endif
+#else
+# include <sys/mount.h>
 #endif
 
 #include "lapi/fcntl.h"
diff --git include/tst_fd.h include/tst_fd.h
index 2183ea068..cdf9867e6 100644
--- include/tst_fd.h
+++ include/tst_fd.h
@@ -26,8 +26,10 @@ enum tst_fd_type {
 	TST_FD_INOTIFY,
 	TST_FD_USERFAULTFD,
 	TST_FD_PERF_EVENT,
+#if defined(HAVE_FSOPEN) || !defined(HAVE_LINUX_MOUNT_H)
 	TST_FD_IO_URING,
 	TST_FD_BPF_MAP,
+#endif
 	TST_FD_FSOPEN,
 	TST_FD_FSPICK,
 	TST_FD_OPEN_TREE,
diff --git lib/tst_fd.c lib/tst_fd.c
index b0d6fb1d6..0766328a9 100644
--- lib/tst_fd.c
+++ lib/tst_fd.c
@@ -18,9 +18,12 @@
 #include "tst_safe_macros.h"
 
 #include "lapi/pidfd.h"
+#include "lapi/fsmount.h"
+
+#if defined(HAVE_FSOPEN) || !defined(HAVE_LINUX_MOUNT_H)
 #include "lapi/io_uring.h"
 #include "lapi/bpf.h"
-#include "lapi/fsmount.h"
+#endif
 
 #include "tst_fd.h"
 
@@ -190,6 +193,7 @@ static void open_perf_event(struct tst_fd *fd)
 	}
 }
 
+#if defined(HAVE_FSOPEN) || !defined(HAVE_LINUX_MOUNT_H)
 static void open_io_uring(struct tst_fd *fd)
 {
 	struct io_uring_params uring_params = {};
@@ -216,6 +220,7 @@ static void open_bpf_map(struct tst_fd *fd)
 			"Skipping %s", tst_fd_desc(fd));
 	}
 }
+#endif
 
 static void open_fsopen(struct tst_fd *fd)
 {
@@ -281,8 +286,10 @@ static struct tst_fd_desc fd_desc[] = {
 	[TST_FD_INOTIFY] = {.open_fd = open_inotify, .desc = "inotify"},
 	[TST_FD_USERFAULTFD] = {.open_fd = open_userfaultfd, .desc = "userfaultfd"},
 	[TST_FD_PERF_EVENT] = {.open_fd = open_perf_event, .desc = "perf event"},
+#if defined(HAVE_FSOPEN) || !defined(HAVE_LINUX_MOUNT_H)
 	[TST_FD_IO_URING] = {.open_fd = open_io_uring, .desc = "io uring"},
 	[TST_FD_BPF_MAP] = {.open_fd = open_bpf_map, .desc = "bpf map"},
+#endif
 	[TST_FD_FSOPEN] = {.open_fd = open_fsopen, .desc = "fsopen"},
 	[TST_FD_FSPICK] = {.open_fd = open_fspick, .desc = "fspick"},
 	[TST_FD_OPEN_TREE] = {.open_fd = open_open_tree, .desc = "open_tree"},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
