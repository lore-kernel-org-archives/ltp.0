Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC5BC4345F
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 12:46:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48C3C3CFF2D
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 14:46:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF3E33C006F
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 14:46:30 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DF50E1A00E17
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 14:46:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B0686351C2;
 Mon, 22 Apr 2024 12:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713789988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0s8c8Fioo18CQr0MriYuO8ROrzEtagO3vlnUoIx+IOg=;
 b=eZiUE7/5jSUJ3FeL9+csjIgMWoVBsbnr/gQicWqSZ6xoEO39x8VynR49pIyTnU+BnRtuvn
 SI0FM3e4YW/QCNu1Xo7ScOsnbDOTS6eXgGcYMADR4gp79cld8rJVrCV1l++d1bFM+QZKpt
 puvD4tiVc2Mv+Xa1hkSgT35Cvvd7f+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713789988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0s8c8Fioo18CQr0MriYuO8ROrzEtagO3vlnUoIx+IOg=;
 b=6V7EirWcmLw2vbDDxxY0FA7e64sVeMPw381z64Ofzbl3zR0PJ7Nj5qMmGj/bg+Mk5cmPaH
 xySUxfJANJuWq3Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713789988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0s8c8Fioo18CQr0MriYuO8ROrzEtagO3vlnUoIx+IOg=;
 b=eZiUE7/5jSUJ3FeL9+csjIgMWoVBsbnr/gQicWqSZ6xoEO39x8VynR49pIyTnU+BnRtuvn
 SI0FM3e4YW/QCNu1Xo7ScOsnbDOTS6eXgGcYMADR4gp79cld8rJVrCV1l++d1bFM+QZKpt
 puvD4tiVc2Mv+Xa1hkSgT35Cvvd7f+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713789988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0s8c8Fioo18CQr0MriYuO8ROrzEtagO3vlnUoIx+IOg=;
 b=6V7EirWcmLw2vbDDxxY0FA7e64sVeMPw381z64Ofzbl3zR0PJ7Nj5qMmGj/bg+Mk5cmPaH
 xySUxfJANJuWq3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A58613894;
 Mon, 22 Apr 2024 12:46:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5s+uHyRcJmYiTAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 22 Apr 2024 12:46:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 22 Apr 2024 14:46:27 +0200
Message-Id: <20240422124627.26479-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.25 / 50.00]; BAYES_HAM(-2.45)[97.50%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.977];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] doc: update syscalls statistics
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

This patch black-list a few syscalls which are not implemented in the
kernel, untestable or either really old (=< 2.6 kernel version), as well
as defining already tested syscalls.
Also fixed an index issue with table generation.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/conf.py | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index 9408ee46e..810dfe5c6 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -76,14 +76,27 @@ def generate_syscalls_stats(_):
         'io_uring_register',
         'epoll_pwait2',
         'quotactl_fd',
+        'pread64',
+        'pwrite64',
+        'fadvise64',
     ]
 
-    # populate with non-syscalls which are present in the kernel sources
-    # syscalls file
+    # populate with not implemented, reserved, unmaintained syscalls defined
+    # inside the syscalls file
     black_list = [
         'reserved177',
         'reserved193',
-        'rseq'
+        'rseq',
+        '_newselect',
+        '_sysctl',
+        'create_module',
+        'get_kernel_syms',
+        'query_module',
+        'nfsservctl',
+        'afs_syscall',
+        'sysmips',
+        'mq_getsetattr',
+        'vserver',
     ]
 
     # fetch syscalls file
@@ -184,12 +197,12 @@ def generate_syscalls_stats(_):
 
     left = index_tested % 3
     if left > 0:
-        for index in range(0, left + 1):
+        for index in range(0, 3 - left):
             table_tested.append(f'      -\n')
 
     left = index_untest % 3
     if left > 0:
-        for index in range(0, left + 1):
+        for index in range(0, 3 - left):
             table_untest.append(f'      -\n')
 
     text.extend(table_tested)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
