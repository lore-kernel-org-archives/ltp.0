Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BBAC19F2B
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 12:20:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9279A3C941D
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 14:20:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F05803C25DD
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:19:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 65436200078
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:19:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 04B4220FBB;
 Thu,  4 Aug 2022 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659615593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HknmkfiNljmA+5LF8RYrEd9ydnx73OpuzTH6yuR46Mo=;
 b=iUr022VMEt2JH+CH6+VABnBcC9VtUJ/SErz+thU+umZOCMOJPmCCLIVIXvXAUp/6wf/hI2
 AZzzJpj5ruGZdFB+PsqR69Q4unHndExeofootJ4y4s5f5U2sgFveRgMGyzfSliw4/owduC
 ZDKFT+KL/URcxQ9KC+nuZy0ec+3ULaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659615593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HknmkfiNljmA+5LF8RYrEd9ydnx73OpuzTH6yuR46Mo=;
 b=efdeYgRsGxG2nsDx7IDalWgpuIDgffOUPbYA/nqyvV/ojx0CvUgOnMn0JJpQPbXbCZLEmk
 nmlwpvxg9rE88VBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A953213A94;
 Thu,  4 Aug 2022 12:19:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +ERfJ2i562L2PQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Aug 2022 12:19:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Aug 2022 14:19:38 +0200
Message-Id: <20220804121946.19564-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804121946.19564-1-pvorel@suse.cz>
References: <20220804121946.19564-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 02/10] tst_device: Add clear command
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
Cc: automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

clearing block device will be needed for TST_ALL_FILESYSTEMS
implementation in shell API. Now we clear device during acquire,
but we will reuse this device for each tested filesystem, thus we need a
separate command for it.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
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
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
