Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E9DC77B7C
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 15:19:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F72F3CCABA
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 17:19:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 432B53C8E35
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 17:19:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 99693600D04
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 17:19:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7172C2118D
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750778362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtoredYYqh/hODYGYpDvcKhHoyjQZQJCTuOD1b+T1c0=;
 b=z7YogYiqDyArfnIbgvjfzBwAOMV4EJDChZU6vh1UzJN/bMqYwCdVUTFebirARD7vZZ2bSE
 O7pLW3Gxn5QOXBCFDtysKEU3HDNYDnqQ1mw8c/EJf/SuDC/EDMdc9kCSNnfIa0ghopJX49
 SKH1iWact309wBRecxAXf41aQI//M88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750778362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtoredYYqh/hODYGYpDvcKhHoyjQZQJCTuOD1b+T1c0=;
 b=1eTkEyy3YF8p76ebqqX7PvRMIsHhbCIWpGvkJcc1jt9mz2K9rrHjA9xekc56djUvyf/CuQ
 b1wSqTwoeCt/t2Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AKPnJYnP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gEC+8vA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750778361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtoredYYqh/hODYGYpDvcKhHoyjQZQJCTuOD1b+T1c0=;
 b=AKPnJYnPpCmzSv4V1OowbTjy0I+zKJhHjLXdE+CRkLODdTmBE25koyKqMWcN1qjQBu1xFH
 L42/jgQJ0GpZwQ54QifN72mjCYnyhsc1r5QiyCL7JWAUfeNEFyAu0KkIHGXq3OY0zI1hGK
 aeXl3Q3EeMz/72PU8wzitGZseWe9MrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750778361;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtoredYYqh/hODYGYpDvcKhHoyjQZQJCTuOD1b+T1c0=;
 b=gEC+8vA00K2POLZTTZaX1dju6hGfKDpBvYqhQA9QR63ERgF7d0Up0HlmNNW2ztxeD+FBhG
 V09CJ6IJ1/WBHRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E1AE13A96
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 15:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GGQ7FvnBWmh7DAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 15:19:21 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 24 Jun 2025 17:19:15 +0200
Message-ID: <20250624151918.32145-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624151918.32145-1-mdoucha@suse.cz>
References: <20250624151918.32145-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 7172C2118D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] open13: Add subtests for mmap() and ioctl()
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/open/open13.c | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/testcases/kernel/syscalls/open/open13.c b/testcases/kernel/syscalls/open/open13.c
index 88cba4640..e30e99ec3 100644
--- a/testcases/kernel/syscalls/open/open13.c
+++ b/testcases/kernel/syscalls/open/open13.c
@@ -17,6 +17,9 @@
 
 #include "config.h"
 
+#include <sys/ioctl.h>
+#include <linux/fs.h>
+
 #ifdef HAVE_SYS_XATTR_H
 #include <sys/types.h>
 #include <sys/xattr.h>
@@ -34,6 +37,8 @@ static int verify_read(int fd);
 static int verify_write(int fd);
 static int verify_fchmod(int fd);
 static int verify_fchown(int fd);
+static int verify_ioctl(int fd);
+static int verify_mmap(int fd);
 #ifdef HAVE_SYS_XATTR_H
 static int verify_fgetxattr(int fd);
 #endif
@@ -46,6 +51,8 @@ static const struct {
 	{verify_write, "write"},
 	{verify_fchmod, "fchmod"},
 	{verify_fchown, "fchown"},
+	{verify_ioctl, "ioctl"},
+	{verify_mmap, "mmap"},
 #ifdef HAVE_SYS_XATTR_H
 	{verify_fgetxattr, "fgetxattr"},
 #endif
@@ -91,6 +98,26 @@ static int verify_fchown(int fd)
 	return fchown(fd, 1000, 1000);
 }
 
+static int verify_ioctl(int fd)
+{
+	int arg;
+
+	return ioctl(fd, FIGETBSZ, &arg);
+}
+
+static int verify_mmap(int fd)
+{
+	void *ptr;
+
+	ptr = mmap(NULL, 1, PROT_READ, MAP_PRIVATE, fd, 0);
+
+	if (ptr == MAP_FAILED)
+		return -1;
+
+	SAFE_MUNMAP(ptr, 1);
+	return 0;
+}
+
 #ifdef HAVE_SYS_XATTR_H
 static int verify_fgetxattr(int fd)
 {
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
