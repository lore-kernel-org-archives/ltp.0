Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6635ECAAD4
	for <ltp@archiver.kernel.org>; Sat, 27 Aug 2022 00:29:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 943C13CA520
	for <ltp@archiver.kernel.org>; Sat, 27 Aug 2022 02:29:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D42C13C136F
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 02:28:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1067A600657
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 02:28:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BFF521F96A;
 Sat, 27 Aug 2022 00:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661560102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BiPrbC61jRbbbHVM4aWPbRDbZ7+fsYA0rYNJpsLJCCI=;
 b=I0NoaKubnuhpIAlj1KkFSRLGWorBaYGpx19TQ9kBYRVs6kN1BBrHQQqCYdKs1XcagfO8kC
 g7JZBi8MPqg4fghUNb4quEjNUh/htaj3dGnXPwBPsUbRNilTlYP1h4MIAZJl9MRj23boju
 E5I6w15ugD51nCzNeeUkEjJA3XHo+3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661560102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BiPrbC61jRbbbHVM4aWPbRDbZ7+fsYA0rYNJpsLJCCI=;
 b=wTCL109pNoi8fX6pcTp5csJiQ/FMORUntp/dFktYdATD3xx+rWm3T87BHEi67a8agqYo09
 ZBLrhzrsodO3DSDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7847F133A6;
 Sat, 27 Aug 2022 00:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CJsxHCZlCWNQCgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sat, 27 Aug 2022 00:28:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Sat, 27 Aug 2022 02:28:14 +0200
Message-Id: <20220827002815.19116-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827002815.19116-1-pvorel@suse.cz>
References: <20220827002815.19116-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/6] tst_device: Add support -f filesystem
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Joerg Vehlow <joerg.vehlow@aox-tech.de>, linux-fsdevel@vger.kernel.org,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Useful to get smaller minimal required size.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_device.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index b672202e2..a161fb069 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -19,19 +19,19 @@ static struct tst_test test = {
 static void print_help(void)
 {
 	fprintf(stderr, "\nUsage:\n");
-	fprintf(stderr, "tst_device [-s size [-d /path/to/device]] acquire\n");
+	fprintf(stderr, "tst_device [-f filesystem] [-s size [-d /path/to/device]] acquire\n");
 	fprintf(stderr, "tst_device -d /path/to/device release\n");
 	fprintf(stderr, "tst_device -h\n\n");
 }
 
-static int acquire_device(const char *device_path, unsigned int size)
+static int acquire_device(const char *device_path, unsigned int size, long f_type)
 {
 	const char *device;
 
 	if (device_path)
 		device = tst_acquire_loop_device(size, device_path);
 	else
-		device = tst_acquire_device__(size, TST_ALL_FILESYSTEMS);
+		device = tst_acquire_device__(size, f_type);
 
 	if (!device)
 		return 1;
@@ -66,6 +66,7 @@ int main(int argc, char *argv[])
 {
 	char *device_path = NULL;
 	unsigned int size = 0;
+	long f_type = TST_ALL_FILESYSTEMS;
 	int ret;
 
 	/*
@@ -79,7 +80,7 @@ int main(int argc, char *argv[])
 	 */
 	tst_test = &test;
 
-	while ((ret = getopt(argc, argv, "d:hs:"))) {
+	while ((ret = getopt(argc, argv, "d:f:hs:"))) {
 		if (ret < 0)
 			break;
 
@@ -87,6 +88,13 @@ int main(int argc, char *argv[])
 		case 'd':
 			device_path = optarg;
 			break;
+		case 'f':
+			f_type = tst_fs_name_type(optarg);
+			if (f_type == -1) {
+				fprintf(stderr, "ERROR: Unsupported filesystem '%s'", optarg);
+				return 1;
+			}
+			break;
 		case 'h':
 			print_help();
 			return 0;
@@ -104,7 +112,7 @@ int main(int argc, char *argv[])
 		goto help;
 
 	if (!strcmp(argv[optind], "acquire")) {
-		if (acquire_device(device_path, size))
+		if (acquire_device(device_path, size, f_type))
 			goto help;
 	} else if (!strcmp(argv[optind], "release")) {
 		if (release_device(device_path))
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
