Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C791C433EF
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 12:41:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2D033CA9F2
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:41:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 249E03CA9D8
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9285B600D72
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 170BE21C73;
 Thu, 12 May 2022 12:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652358976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qp/VySc6G+mhOmtMMDvl6j08OanqrOe+mboRVO+kMDA=;
 b=kfJdjrkG4tljAVbdz1za81oiaCKgeulwuZFQ5vpJacefW0z+zm+UcFehAvj4cRcbV1xN9R
 pYq5QfX1ahPSYqOHm8fEzDsDr5NYJYHqm7z5/t8BQnXDDmAUGWJ/isA6qgBBcr5SpvE8WP
 tSVB2rZK6Jn4KGwpB6McwZfQwp143dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652358976;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qp/VySc6G+mhOmtMMDvl6j08OanqrOe+mboRVO+kMDA=;
 b=Wj1fGkJT4D8RjiveJKCnroi1gYmd1yGTcFNOUmXTmJNutAO0U3UJtHnRjoYdg1j+NHRArp
 3U+Q/Sjmp1ggI/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01DD013ABE;
 Thu, 12 May 2022 12:36:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 63fNOj//fGJgGgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 12:36:15 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 May 2022 14:38:13 +0200
Message-Id: <20220512123816.24399-27-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512123816.24399-1-chrubis@suse.cz>
References: <20220512123816.24399-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 26/29] ltp-aiodio/dio_read: Convert to runtime
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

And cap the runtime on 30 minutes by default.

CC: Andrea Cervesato <andrea.cervesato@suse.de>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/io/ltp-aiodio/dio_read.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_read.c b/testcases/kernel/io/ltp-aiodio/dio_read.c
index f6ed59782..d28d474db 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_read.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_read.c
@@ -51,6 +51,9 @@ static void do_buffered_writes(int fd, char *bufptr, long long fsize, long long
 			tst_brk(TBROK, "pwrite: wrote %lld bytes out of %lld", w, wsize);
 
 		SAFE_FSYNC(fd);
+
+		if (!tst_remaining_runtime())
+			return;
 	}
 }
 
@@ -75,6 +78,11 @@ static int do_direct_reads(char *filename, char *bufptr, long long fsize, long l
 				goto exit;
 			}
 
+			if (!tst_remaining_runtime()) {
+				tst_res(TINFO, "Test out of runtime, exitting");
+				goto exit;
+			}
+
 			w = pread(fd, bufptr, rsize, offset);
 			if (w < 0)
 				tst_brk(TBROK, "pread: %s", tst_strerrno(-w));
@@ -170,6 +178,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
+	.max_runtime = 1800,
 	.options = (struct tst_option[]) {
 		{"n:", &str_numchildren, "Number of threads (default 8)"},
 		{"w:", &str_writesize, "Size of writing blocks (default 32M)"},
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
