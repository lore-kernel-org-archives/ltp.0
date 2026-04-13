Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1284F34C43
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 11:51:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13F2D3E2E11
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 13:51:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6CEC3C0E57
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 13:51:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 104C5600066
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 13:51:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5859E6A890;
 Mon, 13 Apr 2026 11:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776081082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IIGwurMdJ+wnbaSyidhp9V2CT+NgPBztg4JMRVsez9U=;
 b=rcR3fPx+sWSV2IqkG6R1tsMV/SVkL9iLCg33d/RjjF71/Ccc/d/S6MXd0gGC5d05PMoY7S
 Y26PwPcChnCfoGHz3Oofb24T5JOeldWY8dG154+c0H0Z1YDFD48l5rR/A9r/xeNFJKkyeo
 K9mPHakTcPfPPV1wfr+r9QIDksfqlco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776081082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IIGwurMdJ+wnbaSyidhp9V2CT+NgPBztg4JMRVsez9U=;
 b=3tXTaO7izxPGNKo0JjdE8KqU9/Of9FVWt5omFHJB+SVYqtdMHFxcBNeHILFdwKDloJiC1j
 D+lpztT3q1zJQgCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="B/k3sXGi";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=caW+Oidd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776081080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IIGwurMdJ+wnbaSyidhp9V2CT+NgPBztg4JMRVsez9U=;
 b=B/k3sXGiwy6+In1i3ytJLypKHUwnpB3hK4xvkw3xvKJiVmkFHOPsSeDW5efZber6xEZFqL
 eo7XcEwYUjaMEQ8NVDw+ojOrT9i6+JugneW3x7cHCRi85+2iiqup7+TYKMz1+fmp+JzuEV
 VEIbd4IO2Oe/NSttH8XNVYw0RGlK8RM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776081080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IIGwurMdJ+wnbaSyidhp9V2CT+NgPBztg4JMRVsez9U=;
 b=caW+Oiddq/GbUE+d9iqpxVI3g4ttTEuMJGron2VKms/lJ+lBsrF2F4CIe0mUO13iHJqhmt
 wi8I2msOkJBK9nCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 495CA4AE84;
 Mon, 13 Apr 2026 11:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bsTlELjY3GknYAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 13 Apr 2026 11:51:20 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 13 Apr 2026 13:51:29 +0200
Message-ID: <20260413115129.30239-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 5859E6A890
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: Treat kernel ntfs3 as a separate FS
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
Cc: Matt Ochs <mochs@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The RW NTFS support for Linux kernel was added back in 2021 in a form of
ntfs3 driver. The old RO NTFS functionality was retained though, hence
if we mount a filesystem with type "ntfs" we read it read-only. On the
top of that there is NTFS fuse implementation as well.

Historically we ignored the kernel NTFS filesystem and went for FUSE
since there is not much we can do with read-only filesystem and the code
stayed like that even after kernel RW support was added. At that point
we should have enabled both kernel NTFS driver and fuse NTFS driver and
treat them as a different filesystem in order to maximize the coverage.

Meanwhile this even caused failures, which is how this issue finaly
surfaced with a fuse based NTFS not being skipped properly because the
test library got confused with having both kernel and fuse NTFS
available.

This patch finally fixes all of that by splitting the fuse and kernel
NTFS support into two separate filesystems (as seen by the test
library).

The kernel RW filesystem is called ntfs3 while the fuse based one is
callled just ntfs. For that to happen we need to:

- add new ntfs3 fs to the whitelist
- map ntfs3 to ntfs for mkfs
- jump directly to fuse for ntfs fs in the fs support check
  (we jump directly to fuse in the safe_mount() already)

As a side effect we fixed file_attr05 test to be properly skipped on
fuse NTFS.

Reported-by: Matt Ochs <mochs@nvidia.com>
Tested-by: Matt Ochs <mochs@nvidia.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_mkfs.c               | 3 +++
 lib/tst_supported_fs_types.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index c619a373d..961ffc091 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -50,6 +50,9 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 		return;
 	}
 
+	if (!strcmp(fs_type, "ntfs3"))
+		fs_type = "ntfs";
+
 	snprintf(mkfs, sizeof(mkfs), "mkfs.%s", fs_type);
 
 	if (fs_opts) {
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 0c8c8dc50..d3020fc48 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -30,6 +30,7 @@ static const char *const fs_type_whitelist[] = {
 	"vfat",
 	"exfat",
 	"ntfs",
+	"ntfs3",
 	"tmpfs",
 	NULL
 };
@@ -51,6 +52,9 @@ static int has_mkfs(const char *fs_type)
 		return 1;
 	}
 
+	if (!strcmp(fs_type, "ntfs3"))
+		fs_type = "ntfs";
+
 	sprintf(buf, "mkfs.%s >/dev/null 2>&1", fs_type);
 
 	ret = tst_system(buf);
@@ -87,6 +91,9 @@ static enum tst_fs_impl has_kernel_support(const char *fs_type)
 	char template[PATH_MAX];
 	int ret;
 
+	if (!strcmp(fs_type, "ntfs"))
+		goto check_fuse;
+
 	snprintf(template, sizeof(template), "%s/mountXXXXXX", tmpdir);
 	if (!mkdtemp(template))
 		tst_brk(TBROK | TERRNO, "mkdtemp(%s) failed", template);
@@ -102,6 +109,7 @@ static enum tst_fs_impl has_kernel_support(const char *fs_type)
 
 	SAFE_RMDIR(template);
 
+check_fuse:
 	if (tst_fs_in_skiplist(fs_type, fs_type_fuse_blacklist)) {
 		tst_res(TINFO, "Skipping %s because of FUSE blacklist", fs_type);
 		return TST_FS_UNSUPPORTED;
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
