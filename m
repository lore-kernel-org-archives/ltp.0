Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEA5C4345F
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 12:01:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB30D3D0386
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 14:01:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E598E3CFF84
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 14:00:54 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A8C75600B4D
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 14:00:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A12E20C0C;
 Fri, 26 Apr 2024 12:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714132852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kddr4sQh0YPYfmvsujlqOGwuWXyjmhuppUdmiMS17PI=;
 b=1OJiodOM73722rJ1jV6jAAjinxzYYcBi5mKjQsZvJ7Qz1b9rxn7JH/Oo7Wt4oWyT4+ZbgJ
 O1UDHmfLNXqATzRf2UwPErqtsJNqsSvOQexvmsvxoTZIG+ZRivstYuYH0m6TyEF7YTuIUQ
 1UCXYLUNLMUhXhulz5UTLpQcUN0qTbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714132852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kddr4sQh0YPYfmvsujlqOGwuWXyjmhuppUdmiMS17PI=;
 b=7/5XgUS921xox0poko1/NCJYjv/cGaRjFn/TIomosk9/T/0lR26QDx9V4PCdvKEqvuqe1Z
 KPLorhRc8RmOLzCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1OJiodOM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="7/5XgUS9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714132852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kddr4sQh0YPYfmvsujlqOGwuWXyjmhuppUdmiMS17PI=;
 b=1OJiodOM73722rJ1jV6jAAjinxzYYcBi5mKjQsZvJ7Qz1b9rxn7JH/Oo7Wt4oWyT4+ZbgJ
 O1UDHmfLNXqATzRf2UwPErqtsJNqsSvOQexvmsvxoTZIG+ZRivstYuYH0m6TyEF7YTuIUQ
 1UCXYLUNLMUhXhulz5UTLpQcUN0qTbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714132852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kddr4sQh0YPYfmvsujlqOGwuWXyjmhuppUdmiMS17PI=;
 b=7/5XgUS921xox0poko1/NCJYjv/cGaRjFn/TIomosk9/T/0lR26QDx9V4PCdvKEqvuqe1Z
 KPLorhRc8RmOLzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 720E7136DB;
 Fri, 26 Apr 2024 12:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pE/MGXSXK2ZbSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 26 Apr 2024 12:00:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 26 Apr 2024 14:00:51 +0200
Message-Id: <20240426120051.21806-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9A12E20C0C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] doc: update more syscalls stats
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

Some more syscalls are already tested in LTP, but they are part of
different testing suites. For example, seccomp() is tested in prctl()
testing suite. Some other syscalls need to be blacklisted, since they
are part of MIPS or internal kernel usage.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/conf.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/conf.py b/doc/conf.py
index d0f185b28..b54e0e60d 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -83,6 +83,8 @@ def generate_syscalls_stats(_):
         'getpmsg',
         'putmsg',
         'putpmsg',
+        'seccomp',
+        'semtimedop',
     ]
 
     # populate with not implemented, reserved, unmaintained syscalls defined
@@ -101,6 +103,8 @@ def generate_syscalls_stats(_):
         'sysmips',
         'mq_getsetattr',
         'vserver',
+        'cachectl',
+        'restart_syscall',
     ]
 
     # fetch syscalls file
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
