Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C75CA0FF9
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 14:20:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0980E3CD18E
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 16:20:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 981073CCDE8
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 16:19:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2E4D5600799
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 16:19:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1FFA33AE5;
 Fri, 29 Aug 2025 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756477179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gVsSBn19MoVBUVq1535i+rnbuJ1oCaXj73evZA/dAHc=;
 b=Cn+zsUiymAeHuMsLRzAQ0sD0YYG8L+5pVxzyAh871rcQJbh24rTLIw0GsxrHYbKZTx7gIy
 o/t+kHnIKepPYfsHHXLer6ESEWTwa4o8R8MLEQi2b85pQ8pBgKuFTv6RHHcwLDszPdqOQx
 V6mFcLIr8cAB3bsTaanu6yYjCsQCDaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756477179;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gVsSBn19MoVBUVq1535i+rnbuJ1oCaXj73evZA/dAHc=;
 b=+IQp3hd9UsSOIhgkkHvgih4LbWzRP0H6CJGCLvFcsVUsjBBZDJxh7U9+Q42YgvW69EcMCc
 Mp0ADLzInvrg0MCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Cn+zsUiy;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+IQp3hd9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756477179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gVsSBn19MoVBUVq1535i+rnbuJ1oCaXj73evZA/dAHc=;
 b=Cn+zsUiymAeHuMsLRzAQ0sD0YYG8L+5pVxzyAh871rcQJbh24rTLIw0GsxrHYbKZTx7gIy
 o/t+kHnIKepPYfsHHXLer6ESEWTwa4o8R8MLEQi2b85pQ8pBgKuFTv6RHHcwLDszPdqOQx
 V6mFcLIr8cAB3bsTaanu6yYjCsQCDaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756477179;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gVsSBn19MoVBUVq1535i+rnbuJ1oCaXj73evZA/dAHc=;
 b=+IQp3hd9UsSOIhgkkHvgih4LbWzRP0H6CJGCLvFcsVUsjBBZDJxh7U9+Q42YgvW69EcMCc
 Mp0ADLzInvrg0MCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9D2D13A3E;
 Fri, 29 Aug 2025 14:19:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S9lvKfu2sWhnEQAAD6G6ig
 (envelope-from <jack@suse.cz>); Fri, 29 Aug 2025 14:19:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 5AE5FA099C; Fri, 29 Aug 2025 16:19:39 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 29 Aug 2025 16:19:32 +0200
Message-ID: <20250829141932.31997-1-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: C1FFA33AE5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_THREE(0.00)[3]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_LAST(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ioctl09: Use proper device for partitioning
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test occasionally fails because loop0p2 partition never gets
created. This happens because the uses parted(8) to modify partitions in
the backing file (test.img) while the loop device with this file as a
backing is already setup. Thus the page cache of loop0 can cache old
version of the partition table which is then used by the partitioning
code. Fix the problem by calling parted against the loop device
directly.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 testcases/kernel/syscalls/ioctl/ioctl09.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
index 4e61f3bc9ba6..f363b8d01ff5 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl09.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
@@ -64,7 +64,7 @@ static void verify_ioctl(void)
 					      "mklabel", "msdos", "mkpart",
 					      "primary", "ext4", "1M", "10M",
 					      NULL};
-	const char *const cmd_parted_new[] = {"parted", "-s", "test.img",
+	const char *const cmd_parted_new[] = {"parted", "-s", dev_path,
 					      "mklabel", "msdos", "mkpart",
 					      "primary", "ext4", "1M", "10M",
 					      "mkpart", "primary", "ext4",
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
