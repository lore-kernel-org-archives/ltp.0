Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF23ECA0FE1
	for <ltp@archiver.kernel.org>; Mon, 25 Aug 2025 11:27:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E024F3CD0A4
	for <ltp@archiver.kernel.org>; Mon, 25 Aug 2025 13:27:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 304423C1BA2
 for <ltp@lists.linux.it>; Mon, 25 Aug 2025 13:27:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D2C0B200253
 for <ltp@lists.linux.it>; Mon, 25 Aug 2025 13:27:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A1DD1F78F;
 Mon, 25 Aug 2025 11:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756121234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BxiOQmBHtx0VNcmrrfJGQ9cRnJaS/mR5jzohaUuU/sA=;
 b=Jl78n0EKWyIPzECAQe+inaFkLD8Ok+AF0E0JGF3BQvBM5Ve4cuBhtMkTvxIf1bYv+opa7I
 18+JSlh8zRE+KkM/lJ4K/FeLW1QYtUwqjQIVfHa9+TTDM5aKXx3kkrUentll1YydWblNNN
 LNi5yD9FvqzIWWW5PFrc+aNsJgLSx8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756121234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BxiOQmBHtx0VNcmrrfJGQ9cRnJaS/mR5jzohaUuU/sA=;
 b=0cbkh/4htdYxsjwjSUI78cN4zzXZlCyxMWGVwLdGi5ACbPrAeL5BAndxctspf36fdGtK9f
 Xe/JV06VNKycwCBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756121234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BxiOQmBHtx0VNcmrrfJGQ9cRnJaS/mR5jzohaUuU/sA=;
 b=Jl78n0EKWyIPzECAQe+inaFkLD8Ok+AF0E0JGF3BQvBM5Ve4cuBhtMkTvxIf1bYv+opa7I
 18+JSlh8zRE+KkM/lJ4K/FeLW1QYtUwqjQIVfHa9+TTDM5aKXx3kkrUentll1YydWblNNN
 LNi5yD9FvqzIWWW5PFrc+aNsJgLSx8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756121234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BxiOQmBHtx0VNcmrrfJGQ9cRnJaS/mR5jzohaUuU/sA=;
 b=0cbkh/4htdYxsjwjSUI78cN4zzXZlCyxMWGVwLdGi5ACbPrAeL5BAndxctspf36fdGtK9f
 Xe/JV06VNKycwCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38FCF13867;
 Mon, 25 Aug 2025 11:27:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I+OpB5JIrGgkAgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 25 Aug 2025 11:27:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 25 Aug 2025 13:27:04 +0200
MIME-Version: 1.0
Message-Id: <20250825-whitelist_file_attr-v1-1-60c6d36fdb39@suse.com>
X-B4-Tracking: v=1; b=H4sIAIdIrGgC/x3MQQqAIBBA0avErBPUirKrREjYmANhoVJBePek5
 Vv8/0LEQBhhrF4IeFGkwxeIugLjFr8ho7UYJJcdH2THbkcJd4pJW9pRLykFpoQStm/lYBsDpTw
 DWnr+6zTn/AGuA+lqZQAAAA==
X-Change-ID: 20250825-whitelist_file_attr-9191f7428f3c
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756121234; l=998;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=7C2jGLqmVwIow7EMw9MS3efc1kiv015/zVvUvSKmDjA=;
 b=yHbN7B5AEpCpe1k5gBK2fWyBvX8MV5XPnwWDJW+kxxWIk19kN32S788RVOYZL4KMbmgYZgTpV
 0O1D3R9wlYxDf5xJ8YA7bx2MVDR898OU2Z99JkAPcalmcBzrAziS/NC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc: whitelist file_setattr/file_getattr
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/conf.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/conf.py b/doc/conf.py
index cadfeb2b3d74c63741a28a3df5f8e1fd8a8d5582..ccf0f40ff3023a25c817b9a098e8d520e5a1b9b3 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -71,6 +71,8 @@ def generate_syscalls_stats(_):
         'fadvise64': f'{ltp_syscalls_path}/fadvise',
         'fanotify_init': f'{ltp_syscalls_path}/fanotify',
         'fanotify_mark': f'{ltp_syscalls_path}/fanotify',
+        'file_getattr': f'{ltp_syscalls_path}/file_attr',
+        'file_setattr': f'{ltp_syscalls_path}/file_attr',
         'futex': f'{ltp_syscalls_path}/futex',
         'getdents64': f'{ltp_syscalls_path}/gettdents',
         'inotify_add_watch': f'{ltp_syscalls_path}/inotify',

---
base-commit: 212cdcea9c25a6c150420588563dd2dbbf3868ae
change-id: 20250825-whitelist_file_attr-9191f7428f3c

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
