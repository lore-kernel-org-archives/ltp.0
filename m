Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D405C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 14:43:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DDEA3C8D67
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 15:43:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7F423C104E
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 15:43:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3CF50600820
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 15:43:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C95BB1F3C5;
 Tue, 14 Dec 2021 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639492993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0vcuqOO8IAwjMI/w/Rp7T4ttDxFyZrzlwLO/9wRq1o=;
 b=0+quHdpj2huByGT4h7/MnRKesoW3K6cCNvjxwd4V6s4tGIhsMwstg0GKHJulzawKGmShQS
 72Rn22ALqCo72O1DQzJyBS/bGZkAXqrdksob31nSPHoGX22R5zWclM4bKyOj+6burkUCQ9
 4U4S+nTfkmFwpbBDDvUzPCPtSHwUdlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639492993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0vcuqOO8IAwjMI/w/Rp7T4ttDxFyZrzlwLO/9wRq1o=;
 b=/NiefbbNrn1C23fs+Lpsqnd7ERxxv2eBhXi3JS0NPlmfo/98sVHUlueO7KiUXimb5NvZPx
 6S6TQ3t58GStvoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97BE113EA2;
 Tue, 14 Dec 2021 14:43:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2I1JI4GtuGEkTwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Dec 2021 14:43:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 Dec 2021 15:43:09 +0100
Message-Id: <20211214144309.6704-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214144309.6704-1-pvorel@suse.cz>
References: <20211214144309.6704-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] lib: Add support for debugging .all_filesystems
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

with LTP_SINGLE_FS_TYPE environment variable tests only that
filesystem instead of all supported filesystems.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* rename variable to LTP_SINGLE_FS_TYPE
* print help in -h

 doc/user-guide.txt           | 2 ++
 lib/tst_supported_fs_types.c | 9 +++++++++
 lib/tst_test.c               | 1 +
 3 files changed, 12 insertions(+)

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index 6a9fb33005..244392a6a3 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -15,6 +15,8 @@ For running LTP network tests see `testcases/network/README.md`.
                           'n' or '0': never colorize.
 | 'LTP_DEV'             | Path to the block device to be used
                           (C: '.needs_device = 1', shell: 'TST_NEEDS_DEVICE=1').
+| 'LTP_SINGLE_FS_TYPE'  | Testing only specified filesystem instead all
+                          supported (for tests with '.all_filesystems').
 | 'LTP_DEV_FS_TYPE'     | Filesystem used for testing (default: 'ext2').
 | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
                           slow machines to avoid unexpected timeout).
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index fc072cadfd..23e5ce8775 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -139,8 +139,17 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
 	unsigned int i, j = 0;
 	int skip_fuse;
 	enum tst_fs_impl sup;
+	const char *only_fs;
 
 	skip_fuse = tst_fs_in_skiplist("fuse", skiplist);
+	only_fs = getenv("LTP_SINGLE_FS_TYPE");
+
+	if (only_fs) {
+		tst_res(TINFO, "WARNING: testing only %s", only_fs);
+		if (tst_fs_is_supported(only_fs))
+			fs_types[0] = only_fs;
+		return fs_types;
+	}
 
 	for (i = 0; fs_type_whitelist[i]; i++) {
 		if (tst_fs_in_skiplist(fs_type_whitelist[i], skiplist)) {
diff --git a/lib/tst_test.c b/lib/tst_test.c
index f92ff858e9..ce2b8239d7 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -483,6 +483,7 @@ static void print_help(void)
 	fprintf(stderr, "LTP_COLORIZE_OUTPUT  Force colorized output behaviour (y/1 always, n/0: never)\n");
 	fprintf(stderr, "LTP_DEV              Path to the block device to be used (for .needs_device)\n");
 	fprintf(stderr, "LTP_DEV_FS_TYPE      Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
+	fprintf(stderr, "LTP_SINGLE_FS_TYPE   Testing only specified filesystem instead all supported (for .all_filesystems)\n");
 	fprintf(stderr, "LTP_TIMEOUT_MUL      Multiply timeout (must be number >= 1)\n");
 	fprintf(stderr, "LTP_VIRT_OVERRIDE    Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm\n");
 	fprintf(stderr, "TMPDIR               Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
