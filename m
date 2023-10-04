Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4446CE7B604
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 12:46:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81DE73CDB80
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 14:46:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01E703CBDCE
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 14:46:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7C20D1A00FCF
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 14:46:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 472BE1F74D;
 Wed,  4 Oct 2023 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696423590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeItCfmREetMZWOyX+YlTVpWpRrFsfEO9h9NMi+hFF4=;
 b=NjygP4OoL0voA6n/laTXMpQgECPb+aGqkdWHZoxcFzzc/u0oWpperwPsHd1LAUSc6PkNVh
 6kD8ppsSz+vYxbMr5oTc0AWj0G+cIZ52sfYWKgGBsA2u9PqFSFswuroWw56kZXI7dQT4OI
 TaJJ2M5ttQUDL3yH1OXxpzGOpmzP3J8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696423590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeItCfmREetMZWOyX+YlTVpWpRrFsfEO9h9NMi+hFF4=;
 b=RUvomOcmVyLNb54amrb/byVARm9JdWj7NtSqY/lRUYoKIqa6p8etlnDwFVLnx10QIvI4t4
 nXkEpGm+0jy5ohDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 328D413A2E;
 Wed,  4 Oct 2023 12:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vdzuCqZeHWXdPAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 04 Oct 2023 12:46:30 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Oct 2023 14:47:11 +0200
Message-ID: <20231004124712.3833-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004124712.3833-1-chrubis@suse.cz>
References: <20231004124712.3833-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] syscalls/readahead01: Make use of tst_fd_iterate()
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

TODO: readahead() on /proc/self/maps seems to succeed is that to be
      expected?

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/readahead/readahead01.c   | 46 ++++++++-----------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index bdef7945d..28134d416 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -29,44 +29,38 @@
 #if defined(__NR_readahead)
 
 static void test_bad_fd(void)
-{
-	char tempname[PATH_MAX] = "readahead01_XXXXXX";
-	int fd;
-
-	tst_res(TINFO, "%s -1", __func__);
-	TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF);
-
-	tst_res(TINFO, "%s O_WRONLY", __func__);
-	fd = mkstemp(tempname);
-	if (fd == -1)
-		tst_res(TFAIL | TERRNO, "mkstemp failed");
-	SAFE_CLOSE(fd);
-	fd = SAFE_OPEN(tempname, O_WRONLY);
-	TST_EXP_FAIL(readahead(fd, 0, getpagesize()), EBADF);
-	SAFE_CLOSE(fd);
-	unlink(tempname);
-}
-
-static void test_invalid_fd(void)
 {
 	int fd[2];
 
-	tst_res(TINFO, "%s pipe", __func__);
+	TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF,
+	             "readahead() with fd = -1");
+
 	SAFE_PIPE(fd);
-	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
 	SAFE_CLOSE(fd[0]);
 	SAFE_CLOSE(fd[1]);
 
-	tst_res(TINFO, "%s socket", __func__);
-	fd[0] = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
-	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
-	SAFE_CLOSE(fd[0]);
+	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EBADF,
+	             "readahead() with invalid fd");
+}
+
+static void test_invalid_fd(struct tst_fd *fd)
+{
+	switch (fd->type) {
+	case TST_FD_FILE:
+	case TST_FD_PIPE_OUT:
+		return;
+	default:
+		break;
+	}
+
+	TST_EXP_FAIL(readahead(fd->fd, 0, getpagesize()), EINVAL,
+		     "readahead() on %s", tst_fd_desc(fd));
 }
 
 static void test_readahead(void)
 {
 	test_bad_fd();
-	test_invalid_fd();
+	tst_fd_iterate(test_invalid_fd);
 }
 
 static void setup(void)
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
