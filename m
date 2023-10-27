Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB30C25B48
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 01:05:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7710F3CEC27
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 03:05:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A94E3C8711
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 03:05:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9B6FD1400DCC
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 03:05:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C5BDA1FDB5;
 Fri, 27 Oct 2023 01:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1698368732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sItCPJ5zMWuvmiLarWnJ1+jfZBV/S70wIu4jPZz9E6o=;
 b=JqUGxukO9tdY+n9p1LVS/YNUkG9MsHi0capEAGlUflT5AvK7ZYW8KpbuWQXqBfonUGN3Hk
 bWP8LCebz9TdLdrXyo88fIHPuaNdY8G9ibOzv0ujV6hFbeCJYSUpCtlcYWELj20JfSykhI
 ikMU2YjGFN4mxqry56u1YHm7yCV36+k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D4C8133F5;
 Fri, 27 Oct 2023 01:05:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AD4tAtwMO2VvdQAAMHmgww
 (envelope-from <wegao@suse.com>); Fri, 27 Oct 2023 01:05:32 +0000
To: ltp@lists.linux.it
Date: Thu, 26 Oct 2023 21:05:28 -0400
Message-Id: <20231027010528.12330-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231026144812.6786-1-wegao@suse.com>
References: <20231026144812.6786-1-wegao@suse.com>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.23 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.67)[82.94%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] pwritev201: Add check for RWF_APPEND
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
 .../kernel/syscalls/pwritev2/pwritev201.c     | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/pwritev2/pwritev201.c b/testcases/kernel/syscalls/pwritev2/pwritev201.c
index eba45b7d3..1494e2925 100644
--- a/testcases/kernel/syscalls/pwritev2/pwritev201.c
+++ b/testcases/kernel/syscalls/pwritev2/pwritev201.c
@@ -39,13 +39,15 @@ static struct tcase {
 	off_t write_off;
 	ssize_t size;
 	off_t exp_off;
+	int flag;
 } tcases[] = {
-	{0,     1, 0,          CHUNK, 0},
-	{CHUNK, 2, 0,          CHUNK, CHUNK},
-	{0,     1, CHUNK / 2,  CHUNK, 0},
-	{0,     1, -1,         CHUNK, CHUNK},
-	{0,     2, -1,         CHUNK, CHUNK},
-	{CHUNK, 1, -1,         CHUNK, CHUNK * 2},
+	{0,     1, 0,          CHUNK, 0, 0},
+	{CHUNK, 2, 0,          CHUNK, CHUNK, 0},
+	{0,     1, CHUNK / 2,  CHUNK, 0, 0},
+	{0,     1, -1,         CHUNK, CHUNK, 0},
+	{0,     2, -1,         CHUNK, CHUNK, 0},
+	{CHUNK, 1, -1,         CHUNK, CHUNK * 2, 0},
+	{CHUNK, 1, -1,         CHUNK, CHUNK * 3, RWF_APPEND},
 };
 
 static void verify_pwritev2(unsigned int n)
@@ -57,7 +59,7 @@ static void verify_pwritev2(unsigned int n)
 	SAFE_PWRITE(1, fd, initbuf, sizeof(initbuf), 0);
 	SAFE_LSEEK(fd, tc->seek_off, SEEK_SET);
 
-	TEST(pwritev2(fd, wr_iovec, tc->count, tc->write_off, 0));
+	TEST(pwritev2(fd, wr_iovec, tc->count, tc->write_off, tc->flag));
 	if (TST_RET < 0) {
 		tst_res(TFAIL | TTERRNO, "pwritev2() failed");
 		return;
@@ -76,7 +78,9 @@ static void verify_pwritev2(unsigned int n)
 
 	memset(preadbuf, 0, CHUNK);
 
-	if (tc->write_off != -1)
+	if (tc->flag == RWF_APPEND)
+		SAFE_PREAD(1, fd, preadbuf, tc->size, sizeof(initbuf));
+	else if (tc->write_off != -1)
 		SAFE_PREAD(1, fd, preadbuf, tc->size, tc->write_off);
 	else
 		SAFE_PREAD(1, fd, preadbuf, tc->size, tc->seek_off);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
