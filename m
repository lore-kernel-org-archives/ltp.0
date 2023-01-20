Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C941DC38159
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 06:13:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F9AC3CB448
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 07:13:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58EDC3C4D1C
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 07:12:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9C26B200DE2
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 07:12:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CABFA5D801;
 Fri, 20 Jan 2023 06:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1674195175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9BNSy1jksOiQ6SLta5fCCdla84StWQ/nYrZpVNoy3jg=;
 b=OwKa1TJ10FUmiMW5ZogGLrF+lxqmvF7SchnFDwIHJL3PKyLy6UNxNZ/3DO4XUB9NIPmwWD
 Up7Rp1M545lnvfs1jKqrT1/cndfH6KQ6uQl8/4EoOwIekX0PO2WlF7hsrisMaGicLQwAL0
 HG2G/t9wm/FtDff7ObhKflXQqTFbHGM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B53F13251;
 Fri, 20 Jan 2023 06:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zL+mAecwymMrTQAAMHmgww
 (envelope-from <wegao@suse.com>); Fri, 20 Jan 2023 06:12:55 +0000
To: ltp@lists.linux.it
Date: Fri, 20 Jan 2023 01:12:47 -0500
Message-Id: <20230120061247.8361-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] io_uring02.c: Check EOPNOTSUPP errno
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add check for errno == EOPNOTSUPP and quit with TCONF instead of TBROK

Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/tst_safe_io_uring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/tst_safe_io_uring.c b/lib/tst_safe_io_uring.c
index f300fd38c..923c3e43d 100644
--- a/lib/tst_safe_io_uring.c
+++ b/lib/tst_safe_io_uring.c
@@ -15,6 +15,10 @@ int safe_io_uring_init(const char *file, const int lineno,
 	uring->fd = io_uring_setup(entries, params);
 
 	if (uring->fd == -1) {
+		if (errno == EOPNOTSUPP) {
+			tst_brk(TCONF,
+				"io_uring_setup() is not supported");
+		}
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"io_uring_setup() failed");
 		return uring->fd;
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
