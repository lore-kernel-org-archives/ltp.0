Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2268EECAAD4
	for <ltp@archiver.kernel.org>; Sat, 27 Aug 2022 00:29:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C5F63CA502
	for <ltp@archiver.kernel.org>; Sat, 27 Aug 2022 02:29:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 712EA3CA4DB
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 02:28:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2CBA4200042
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 02:28:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7079533723;
 Sat, 27 Aug 2022 00:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661560102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uykqtwmkv+fLywCXyI1nNcmh4AHu6L98HBfpxVTzaP0=;
 b=PfHLWG8aA8uHGObo7YOtYpnbBL0QeAEiEecXXQ1wqIJTvpFLR/XcAdXzYKvbfkhiqAPGXn
 4r0DplKSguS07dci4K3zto1FtnnXwGjYBTWqbFmLoUXCxDuopPuVA2nhGplYuE90CQP/17
 gSGGu2wVH2LBNKSIcKaovlmQ3VtyjVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661560102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uykqtwmkv+fLywCXyI1nNcmh4AHu6L98HBfpxVTzaP0=;
 b=9BgtU/w+GKNCIESiC8SsCKgvAN+rlMfOMmYj9Co4ATZlxHL8yyK35koTroxrhpRUcZroYD
 xw+M0CfkmFxNvqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E91113ADC;
 Sat, 27 Aug 2022 00:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oLE+BiZlCWNQCgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sat, 27 Aug 2022 00:28:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Sat, 27 Aug 2022 02:28:13 +0200
Message-Id: <20220827002815.19116-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827002815.19116-1-pvorel@suse.cz>
References: <20220827002815.19116-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/6] tst_device: Use getopts
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

size and filesystems are passed by -s and -f flags.
That will help to pass used filesystem.

When it, add also -h.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_device.c        | 71 +++++++++++++++++++------------
 testcases/lib/tst_test.sh         |  2 +-
 testcases/misc/lvm/cleanup_lvm.sh |  2 +-
 testcases/misc/lvm/prepare_lvm.sh |  8 ++--
 4 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index b76abf52b..b672202e2 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -18,30 +18,18 @@ static struct tst_test test = {
 
 static void print_help(void)
 {
-	fprintf(stderr, "\nUsage: tst_device acquire [size [filename]]\n");
-	fprintf(stderr, "   or: tst_device release /path/to/device\n\n");
+	fprintf(stderr, "\nUsage:\n");
+	fprintf(stderr, "tst_device [-s size [-d /path/to/device]] acquire\n");
+	fprintf(stderr, "tst_device -d /path/to/device release\n");
+	fprintf(stderr, "tst_device -h\n\n");
 }
 
-static int acquire_device(int argc, char *argv[])
+static int acquire_device(const char *device_path, unsigned int size)
 {
-	unsigned int size = 0;
 	const char *device;
 
-	if (argc > 4)
-		return 1;
-
-	if (argc >= 3) {
-		size = atoi(argv[2]);
-
-		if (!size) {
-			fprintf(stderr, "ERROR: Invalid device size '%s'",
-				argv[2]);
-			return 1;
-		}
-	}
-
-	if (argc >= 4)
-		device = tst_acquire_loop_device(size, argv[3]);
+	if (device_path)
+		device = tst_acquire_loop_device(size, device_path);
 	else
 		device = tst_acquire_device__(size, TST_ALL_FILESYSTEMS);
 
@@ -58,10 +46,12 @@ static int acquire_device(int argc, char *argv[])
 	return 0;
 }
 
-static int release_device(int argc, char *argv[])
+static int release_device(const char *device_path)
 {
-	if (argc != 3)
+	if (!device_path) {
+		fprintf(stderr, "ERROR: Missing /path/to/device\n");
 		return 1;
+	}
 
 	/*
 	 * tst_acquire_[loop_]device() was called in a different process.
@@ -69,11 +59,15 @@ static int release_device(int argc, char *argv[])
 	 * and do nothing. Call tst_detach_device() directly to bypass
 	 * the check.
 	 */
-	return tst_detach_device(argv[2]);
+	return tst_detach_device(device_path);
 }
 
 int main(int argc, char *argv[])
 {
+	char *device_path = NULL;
+	unsigned int size = 0;
+	int ret;
+
 	/*
 	 * Force messages to be printed from the new library i.e. tst_test.c
 	 *
@@ -85,17 +79,38 @@ int main(int argc, char *argv[])
 	 */
 	tst_test = &test;
 
-	if (argc < 2)
+	while ((ret = getopt(argc, argv, "d:hs:"))) {
+		if (ret < 0)
+			break;
+
+		switch (ret) {
+		case 'd':
+			device_path = optarg;
+			break;
+		case 'h':
+			print_help();
+			return 0;
+		case 's':
+			size = atoi(optarg);
+			if (!size) {
+				fprintf(stderr, "ERROR: Invalid device size '%s'", optarg);
+				return 1;
+			}
+			break;
+		}
+	}
+
+	if (argc - optind < 1)
 		goto help;
 
-	if (!strcmp(argv[1], "acquire")) {
-		if (acquire_device(argc, argv))
+	if (!strcmp(argv[optind], "acquire")) {
+		if (acquire_device(device_path, size))
 			goto help;
-	} else if (!strcmp(argv[1], "release")) {
-		if (release_device(argc, argv))
+	} else if (!strcmp(argv[optind], "release")) {
+		if (release_device(device_path))
 			goto help;
 	} else {
-		fprintf(stderr, "ERROR: Invalid COMMAND '%s'\n", argv[1]);
+		fprintf(stderr, "ERROR: Invalid COMMAND '%s'\n", argv[optind]);
 		goto help;
 	}
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index b42e54ca1..7aea9ee5f 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -46,7 +46,7 @@ _tst_do_exit()
 	fi
 
 	if [ "$TST_NEEDS_DEVICE" = 1 -a "$TST_DEVICE_FLAG" = 1 ]; then
-		if ! tst_device release "$TST_DEVICE"; then
+		if ! tst_device -d "$TST_DEVICE" release; then
 			tst_res TWARN "Failed to release device '$TST_DEVICE'"
 		fi
 	fi
diff --git a/testcases/misc/lvm/cleanup_lvm.sh b/testcases/misc/lvm/cleanup_lvm.sh
index f05289f00..c876b4bbf 100755
--- a/testcases/misc/lvm/cleanup_lvm.sh
+++ b/testcases/misc/lvm/cleanup_lvm.sh
@@ -24,7 +24,7 @@ cleanup_lvm()
 	ROD vgremove -y ltp_test_vg2
 
 	for devname in $DEVLIST; do
-		ROD tst_device release $devname
+		ROD tst_device -d $devname release
 	done
 
 	rm -rf $LVM_DIR/ltp
diff --git a/testcases/misc/lvm/prepare_lvm.sh b/testcases/misc/lvm/prepare_lvm.sh
index d3ae4b23f..dbf1e3157 100755
--- a/testcases/misc/lvm/prepare_lvm.sh
+++ b/testcases/misc/lvm/prepare_lvm.sh
@@ -43,17 +43,17 @@ prepare_mounts()
 	FSNAME1=$1
 	FSNAME2=$2
 	shift 2
-	LVM_DEV1=`tst_device acquire 1040 "$LVM_IMGDIR/lvm_pv1.img"`
+	LVM_DEV1=`tst_device -s 1040 -d "$LVM_IMGDIR/lvm_pv1.img" acquire`
 	error_check
-	LVM_DEV2=`tst_device acquire 1040 "$LVM_IMGDIR/lvm_pv2.img"`
+	LVM_DEV2=`tst_device -s 1040 -d "$LVM_IMGDIR/lvm_pv2.img" acquire`
 	error_check
 
 	# DEVSIZE=($# * 1GB / 2) + 16MB. The extra 16MB is for LVM physical
 	# volume headers
 	DEVSIZE=$(( $# * 512 + 16 ))
-	LVM_DEV3=`tst_device acquire $DEVSIZE "$LVM_IMGDIR/lvm_pv3.img"`
+	LVM_DEV3=`tst_device -s $DEVSIZE -d "$LVM_IMGDIR/lvm_pv3.img" acquire`
 	error_check
-	LVM_DEV4=`tst_device acquire $DEVSIZE "$LVM_IMGDIR/lvm_pv4.img"`
+	LVM_DEV4=`tst_device -s $DEVSIZE -d "$LVM_IMGDIR/lvm_pv4.img" acquire`
 	error_check
 	ROD pvcreate $LVM_DEV1 $LVM_DEV2 $LVM_DEV3 $LVM_DEV4
 	ROD vgcreate ltp_test_vg1 $LVM_DEV1 $LVM_DEV2
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
