Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B13C4345F
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 08:21:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25BEA3CFFA7
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 10:21:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 750193CFD75
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 10:21:30 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7A4E41400069
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 10:21:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D590B37C0C;
 Tue, 23 Apr 2024 08:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713860486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5683tD4WETb1vQrQlIQz8k0bDr3gr4CmZdvBxPxPzvE=;
 b=Zu2/ifqT7M/GSlv0CqvnFv5RLM9vPLFnnCSzi6TyZjFEj+q6yxSJkOvyM50snZmjUrEs45
 /X5pLclKPZdftftK6Zn+uiDBjtLgSv0cVuhatRqfnC/0rziCKwWJa/7e1EEQyFr+NIS2Up
 8n1An7XV0hZLXCfut2/Dc4sdPU+tskI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713860486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5683tD4WETb1vQrQlIQz8k0bDr3gr4CmZdvBxPxPzvE=;
 b=/V0MQBaf8JYEPbxt2PtSV8ajF7f9v7WAM8DMLwnfpZhtcH3bWo/+cvLrEz74FuwCd9YYf8
 vAcCRaWbWyZm/ICw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713860486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5683tD4WETb1vQrQlIQz8k0bDr3gr4CmZdvBxPxPzvE=;
 b=Zu2/ifqT7M/GSlv0CqvnFv5RLM9vPLFnnCSzi6TyZjFEj+q6yxSJkOvyM50snZmjUrEs45
 /X5pLclKPZdftftK6Zn+uiDBjtLgSv0cVuhatRqfnC/0rziCKwWJa/7e1EEQyFr+NIS2Up
 8n1An7XV0hZLXCfut2/Dc4sdPU+tskI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713860486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5683tD4WETb1vQrQlIQz8k0bDr3gr4CmZdvBxPxPzvE=;
 b=/V0MQBaf8JYEPbxt2PtSV8ajF7f9v7WAM8DMLwnfpZhtcH3bWo/+cvLrEz74FuwCd9YYf8
 vAcCRaWbWyZm/ICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73BDD13929;
 Tue, 23 Apr 2024 08:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +ePXFoZvJ2YqCQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Apr 2024 08:21:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 23 Apr 2024 10:21:19 +0200
Message-Id: <20240423082119.16117-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] doc: update syscalls statistics
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
 doc/conf.py | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index 9408ee46e..d0f185b28 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -76,14 +76,31 @@ def generate_syscalls_stats(_):
         'io_uring_register',
         'epoll_pwait2',
         'quotactl_fd',
+        'pread64',
+        'pwrite64',
+        'fadvise64',
+        'getmsg',
+        'getpmsg',
+        'putmsg',
+        'putpmsg',
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
@@ -184,12 +201,12 @@ def generate_syscalls_stats(_):
 
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
