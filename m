Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FB5C636CC
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 07:16:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3ECB3CC203
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 08:16:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88C5B3CB14B
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 08:16:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 036BF1A0099B
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 08:16:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0AF5420649;
 Tue,  7 Feb 2023 07:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1675754197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUtVd7nUgJDjzK1RF75dWDwJVMd8svseeYcYvqoGXS4=;
 b=tOcDcPdYxCLd19jZbH8KiWIxnTTK7JA95XJHE0OS8n/H9zWMjvUumZduJWrJlT3u+6YCLT
 7lj4lIRl9hLbBScZLAynAaeQSsKz/vGu1e989G97zXHVAxu6D1RYK2N4NpHUkXuX61X7Ln
 QC7KM5qCykgRZZUrtPzaxPAni7TZIhk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46C8413A8C;
 Tue,  7 Feb 2023 07:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ElJrCNT64WN+TQAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 07 Feb 2023 07:16:36 +0000
To: ltp@lists.linux.it
Date: Tue,  7 Feb 2023 02:16:18 -0500
Message-Id: <20230207071618.26259-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230129183930.2045-1-wegao@suse.com>
References: <20230129183930.2045-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ioctl01.c:Test also struct termios
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

ATM we're testing just legacy struct termio in ioctl01.c,
we also need test struct termios.

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/ioctl/ioctl01.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index ccc48cdb2..1be38e79d 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -32,26 +32,28 @@ static int fd, fd_file;
 static int bfd = -1;
 
 static struct termio termio;
+static struct termios termios;
 
 static struct tcase {
 	int *fd;
 	int request;
 	struct termio *s_tio;
+	struct termios *s_tios;
 	int error;
 } tcases[] = {
 	/* file descriptor is invalid */
-	{&bfd, TCGETA, &termio, EBADF},
+	{&bfd, TCGETA, &termio, &termios, EBADF},
 	/* termio address is invalid */
-	{&fd, TCGETA, (struct termio *)-1, EFAULT},
+	{&fd, TCGETA, (struct termio *)-1, (struct termios *)-1, EFAULT},
 	/* command is invalid */
 	/* This errno value was changed from EINVAL to ENOTTY
 	 * by kernel commit 07d106d0 and bbb63c51
 	 */
-	{&fd, INVAL_IOCTL, &termio, ENOTTY},
+	{&fd, INVAL_IOCTL, &termio, &termios, ENOTTY},
 	/* file descriptor is for a regular file */
-	{&fd_file, TCGETA, &termio, ENOTTY},
+	{&fd_file, TCGETA, &termio, &termios, ENOTTY},
 	/* termio is NULL */
-	{&fd, TCGETA, NULL, EFAULT}
+	{&fd, TCGETA, NULL, NULL, EFAULT}
 };
 
 static char *device;
@@ -60,6 +62,9 @@ static void verify_ioctl(unsigned int i)
 {
 	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
 		     tcases[i].error);
+
+	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tios),
+		     tcases[i].error);
 }
 
 static void setup(void)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
