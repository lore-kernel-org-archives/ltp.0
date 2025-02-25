Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E246C021B6
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 11:45:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BA123C9B53
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 12:45:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F9DE3C9B21
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 12:44:31 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B7DD91413E50
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 12:44:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B959A1F457;
 Tue, 25 Feb 2025 11:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740483864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9vzfs5BMRNnZi6mFmUn/rrSlrjO4vtFLQEq0ombtzY=;
 b=JuZGQQOs5JouWE6t49K2rNXvW97QpRXeJ73BAZTPRXGWXL5ce985SMl29Dp+rSUcWbLzkG
 1ZHa5z8cZoTNDsxFYXCLLAn8WUl7XGdK1+iSotKWtP4Pc7xVNN0gv/40rLfXZNE3zzJ/3Z
 XK/j9ZtNSRataXnP7glTYLH6Yype64w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740483864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9vzfs5BMRNnZi6mFmUn/rrSlrjO4vtFLQEq0ombtzY=;
 b=JDyJyjxZCj4o7wQsBxAGh/SPEBnqWf9gaCgwGTShdzWlNvWyKjWtMbhlhGx0f4GxKCe6R1
 6No/fAya5Q4nlyBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JuZGQQOs;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JDyJyjxZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740483864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9vzfs5BMRNnZi6mFmUn/rrSlrjO4vtFLQEq0ombtzY=;
 b=JuZGQQOs5JouWE6t49K2rNXvW97QpRXeJ73BAZTPRXGWXL5ce985SMl29Dp+rSUcWbLzkG
 1ZHa5z8cZoTNDsxFYXCLLAn8WUl7XGdK1+iSotKWtP4Pc7xVNN0gv/40rLfXZNE3zzJ/3Z
 XK/j9ZtNSRataXnP7glTYLH6Yype64w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740483864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9vzfs5BMRNnZi6mFmUn/rrSlrjO4vtFLQEq0ombtzY=;
 b=JDyJyjxZCj4o7wQsBxAGh/SPEBnqWf9gaCgwGTShdzWlNvWyKjWtMbhlhGx0f4GxKCe6R1
 6No/fAya5Q4nlyBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8556913A61;
 Tue, 25 Feb 2025 11:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gJVwHxitvWe2QQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Feb 2025 11:44:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Feb 2025 12:44:18 +0100
Message-ID: <20250225114418.2940134-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250225114418.2940134-1-pvorel@suse.cz>
References: <20250225114418.2940134-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B959A1F457
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_HAS_CURRENCY(1.00)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] tst_supported_fs_types: Ignore empty
 $LTP_SINGLE_FS_TYPE value
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

Previously empty $LTP_SINGLE_FS_TYPE value caused no testing:

    # LTP_SINGLE_FS_TYPE= ./getdents02
    ...
    LTP_SINGLE_VARIANT= LTP_SINGLE_FS_TYPE= ./getdents02
    tst_kconfig.c:88: TINFO: Parsing kernel config '/boot/config-6.12.10-amd64'
    tst_test.c:1722: TINFO: Overall timeout per run is 0h 00m 30s
    tst_supported_fs_types.c:161: TINFO: WARNING: testing only
    tst_supported_fs_types.c:128: TINFO: Filesystem  is not supported
    tst_test.c:1861: TCONF: There are no supported filesystems

Now value is ignored:

    # LTP_SINGLE_FS_TYPE= ./getdents02
    ...
    tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
    tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
    tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
    tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports xfs
    tst_supported_fs_types.c:62: TINFO: mkfs.xfs does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
    tst_supported_fs_types.c:62: TINFO: mkfs.btrfs does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports bcachefs
    tst_supported_fs_types.c:62: TINFO: mkfs.bcachefs does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
    tst_supported_fs_types.c:62: TINFO: mkfs.vfat does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports exfat
    tst_supported_fs_types.c:62: TINFO: mkfs.exfat does exist
    tst_supported_fs_types.c:132: TINFO: FUSE does support ntfs
    tst_supported_fs_types.c:62: TINFO: mkfs.ntfs does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
    tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
    tst_test.c:1834: TINFO: === Testing on ext2 ===

Fixes: 1199657e91 ("lib: Add support for debugging .all_filesystems")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as v1.

 lib/tst_supported_fs_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index bbbb8df19f..5e51595d82 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -157,7 +157,7 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
 	skip_fuse = tst_fs_in_skiplist("fuse", skiplist);
 	only_fs = getenv("LTP_SINGLE_FS_TYPE");
 
-	if (only_fs) {
+	if (only_fs && only_fs[0] != '\0') {
 		tst_res(TINFO, "WARNING: testing only %s", only_fs);
 		if (tst_fs_is_supported(only_fs))
 			fs_types[0] = only_fs;
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
