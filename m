Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97740C47DAF
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 19:14:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 765953CFCC4
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 20:14:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0BED3CC959
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 20:14:02 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3CFDE1A00FA7
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 20:14:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E60191F797;
 Thu, 18 Jan 2024 19:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705605241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sZTnfsZlyLwwgbjxDKHuPnK7ruuAFM705So6Pui86fg=;
 b=u8sgDNS4JOMp7W4dbw2zhK+7p+S/bFhWSCXPCRRnaD3lMIj4yc0Bfq7L8EBLtQ8nNNQokl
 /z4nPALEuAac70nkmZw3VEgfF7h5wrqj4Xm/r4v7MWtViMS1E0PgOoGPpzCr/lxKdXTjpE
 5Df4EfgHUJ76ydLEvq7EBib0boUE1EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705605241;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sZTnfsZlyLwwgbjxDKHuPnK7ruuAFM705So6Pui86fg=;
 b=EeqemCRWSGPaMqS5Z6AUQ1xudsT4P5OAG1kRjqqa8NFxvSjvICEvN0lfdQqS7gTyeP72dB
 TJl+iucIXoRpsxCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705605240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sZTnfsZlyLwwgbjxDKHuPnK7ruuAFM705So6Pui86fg=;
 b=ifpRGIYx3KYeLFBCfXPtrTBXrcbbRz4YMnmCbamOCcVmeVXcSwdj0EXsg9exZtinqeWpyu
 dQa5Ee3//Okg7LGGMB34m3K4gcbbbTxvE5WRlZ16wtzfMPaNMA2YW3gWghNgrG/8JQ/Lug
 ZyehZ4bKiH2mNmnD+fcM7NpDhOv+n0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705605240;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sZTnfsZlyLwwgbjxDKHuPnK7ruuAFM705So6Pui86fg=;
 b=UnVFsQCctIaaU9itXq7o4ItLPkStVPHuPM9Ma9Flm+OLkZSFuybi+RB7NTPflpXVnEs8ig
 HAlhy2z0O5lqKEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 726AA1386D;
 Thu, 18 Jan 2024 19:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vpIYF3h4qWWadAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Jan 2024 19:14:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 18 Jan 2024 20:13:53 +0100
Message-ID: <20240118191353.2815915-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.84 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:email,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.06)[61.79%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] readahead01: Pass also on memfd secret
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
Cc: Dominique Leuenberger <dimstar@opensuse.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It fixes failure on 6.6 kernels:

TFAIL: readahead() on memfd secret succeeded

Fixes: ecf81d729 ("syscalls: readahead01: Make use of tst_fd")
Reported-by: Dominique Leuenberger <dimstar@opensuse.org>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I wonder if this is a bug or just changed functionality.

I also tested on 5.14 SLES and 5.10 Debian and both TCONF due ENOSYS:

tst_fd.c:260: TCONF: Skipping memfd secret: ENOSYS (38)

Kind regards,
Petr

 testcases/kernel/syscalls/readahead/readahead01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index e86a73e3e..a1f313605 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -51,6 +51,7 @@ static void test_invalid_fd(struct tst_fd *fd)
 	/* These succeed */
 	case TST_FD_FILE:
 	case TST_FD_MEMFD:
+	case TST_FD_MEMFD_SECRET:
 	case TST_FD_PROC_MAPS:
 		return;
 	default:
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
