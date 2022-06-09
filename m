Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB618C43334
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 21:44:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D58883C9231
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 23:44:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D9163C920B
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 23:42:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3555F600C7B
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 23:42:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D4B4A22091;
 Thu,  9 Jun 2022 21:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654810953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hrv4TBYgQiiDQzAMJuRcEJYK6Fsk+bBkGixpkqTdrg=;
 b=beFHBqPDfNmv747aSXkHCkv1rumqF8ZzGLOCggc1TQP6YWlWzjVR2mB/uTf04fMC7CWR6u
 l8LItaUc3nLgfWJS4V9igdNN3ktjW1O38YDftqJjikN3Icj5ELdwyjpsAJzEtkYsS/+dqI
 NJM+UhMOaMN7Ipl54WmI7rqIQfdt3c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654810953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hrv4TBYgQiiDQzAMJuRcEJYK6Fsk+bBkGixpkqTdrg=;
 b=sdF0lNGtPoLZUjeDpeuleInQvcctbpC9vXZmgVbZ+yCiyZYwz+UowM4ly0ZcU1o/xnn0ti
 A+SUpuIL+jS9CEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CD0E13A8C;
 Thu,  9 Jun 2022 21:42:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aAa2DUlpomIQDgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jun 2022 21:42:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jun 2022 23:42:21 +0200
Message-Id: <20220609214223.4608-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220609214223.4608-1-pvorel@suse.cz>
References: <20220609214223.4608-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/9] tst_device: Add clear command
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
Cc: linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
 "J . Bruce Fields" <bfields@fieldses.org>,
 Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trondmy@hammerspace.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

clearing block device will be needed for TST_ALL_FILESYSTEMS
implementation in shell API. Now we clear device during acquire,
but we will reuse this device for each tested filesystem, thus we need a
separate command for it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_device.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index d6b74a5ff..45f77a38b 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -18,8 +18,10 @@ static struct tst_test test = {
 
 static void print_help(void)
 {
-	fprintf(stderr, "\nUsage: tst_device acquire [size [filename]]\n");
-	fprintf(stderr, "   or: tst_device release /path/to/device\n\n");
+	fprintf(stderr, "\nUsage:\n");
+	fprintf(stderr, "tst_device acquire [size [filename]]\n");
+	fprintf(stderr, "tst_device release /path/to/device\n");
+	fprintf(stderr, "tst_device clear /path/to/device\n\n");
 }
 
 static int acquire_device(int argc, char *argv[])
@@ -72,6 +74,17 @@ static int release_device(int argc, char *argv[])
 	return tst_detach_device(argv[2]);
 }
 
+static int clear_device(int argc, char *argv[])
+{
+	if (argc != 3)
+		return 1;
+
+	if (tst_clear_device(argv[2]))
+		return 1;
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	/*
@@ -94,6 +107,9 @@ int main(int argc, char *argv[])
 	} else if (!strcmp(argv[1], "release")) {
 		if (release_device(argc, argv))
 			goto help;
+	} else if (!strcmp(argv[1], "clear")) {
+		if (clear_device(argc, argv))
+			goto help;
 	} else {
 		fprintf(stderr, "ERROR: Invalid COMMAND '%s'\n", argv[1]);
 		goto help;
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
