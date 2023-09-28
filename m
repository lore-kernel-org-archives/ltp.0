Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB08E82CB7
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 01:08:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F13D3CE17F
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 03:08:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24C283CDC29
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 03:08:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 02746602FA4
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 03:08:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 373E21F38C;
 Thu, 28 Sep 2023 01:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1695863304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TNaibEPawLC3ZYCkK1ahLG6t7F8rmCA3+y0GNA14FhQ=;
 b=mxaCE1TdBjoxxNI31cp6PtZFAHXbCSEib04d3OSG0ABaaTpMZ+TJijHsBbZhRm/Nyi6cs2
 8xtg8tl9FHOgwHkQZb3v2X+nRk9z2sDbUHn2kIbYn9IkY1ZIjYrmGz2ur94vv0qZszVUYF
 J+Yxugf7ZEkfUOO1Xq4zhayjPtVl5ew=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 310E61377D;
 Thu, 28 Sep 2023 01:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Vqh5OwbSFGXdeQAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 28 Sep 2023 01:08:22 +0000
To: ltp@lists.linux.it
Date: Wed, 27 Sep 2023 21:08:08 -0400
Message-Id: <20230928010808.15862-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] getcwd01: Only check buffer NULL on glibc
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/getcwd/getcwd01.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index 65d827873..6769eb6f4 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd01.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
@@ -34,10 +34,13 @@ static struct t_case {
 	int exp_err;
 } tcases[] = {
 	{(void *)-1, PATH_MAX, EFAULT},
-	{NULL, (size_t)-1, ENOMEM},
 	{buffer, 0, EINVAL},
 	{buffer, 1, ERANGE},
+/* musl and uclibc-ng will allocate memory before syscall if buf == NULL */
+#ifdef __GLIBC__
+	{NULL, (size_t)-1, ENOMEM},
 	{NULL, 1, ERANGE}
+#endif
 };
 
 static void verify_getcwd(unsigned int n)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
