Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6B5C47DDB
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 11:50:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A37E3CEE78
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 12:50:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 516093CEE78
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 12:49:01 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 83705600653
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 12:49:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706010539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LfJJlYSrcWE/qNTWfNYvmiLe03oI1oLwb0HH2kX6j4E=;
 b=IG1s3YfNrsGrRbfx0LminNMMh7tIwHb6rc5jQTH0xFThNYDeEiV113EvNjJ/t8z2us4jVG
 2sWxVxrg0AETg2kmayPE6N7PW4BLNMT8YZzlSOrYMXgu7MOkw4oj5BSDr/Jm8KcM9Mx7v1
 dXkQroFKwFRnOm3QkL9WGpFt5vSu+I8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-lc64sjx1NDe6aeNp_LYIaA-1; Tue,
 23 Jan 2024 06:48:55 -0500
X-MC-Unique: lc64sjx1NDe6aeNp_LYIaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4955B1C0419B;
 Tue, 23 Jan 2024 11:48:55 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2E7551D5;
 Tue, 23 Jan 2024 11:48:53 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 23 Jan 2024 19:48:40 +0800
Message-Id: <20240123114840.2610533-6-liwang@redhat.com>
In-Reply-To: <20240123114840.2610533-1-liwang@redhat.com>
References: <20240123114840.2610533-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH V3 5/5] libswap: Introduce file contiguity check
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch introduces a new function file_is_contiguous to the
libltpswap library to determine if a swap file is stored in a
contiguous block of disk space, which is a typical requirement
for swap files in Linux. The function performs a series of checks
using the fiemap structure to assess the contiguity of the file
and logs the result.

It is integrated into the is_swap_supported function to replace
the previous tst_fibmap check, providing a more reliable method
for verifying that a file suitable for swap is indeed contiguous.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 libs/libltpswap/libswap.c | 72 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 5 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index b253dbeec..8382ea23c 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -6,6 +6,8 @@
 
 #include <linux/fs.h>
 #include <errno.h>
+#include <linux/fiemap.h>
+#include <stdlib.h>
 
 #define TST_NO_DEFAULT_MAIN
 
@@ -69,6 +71,63 @@ static int prealloc_contiguous_file(const char *path, size_t bs, size_t bcount)
 	return 0;
 }
 
+static int file_is_contiguous(const char *filename)
+{
+	int fd, contiguous = 0;
+	struct fiemap *fiemap;
+
+	if (tst_fibmap(filename) == 0) {
+		contiguous = 1;
+		goto out;
+	}
+
+	if (tst_fs_type(filename) == TST_TMPFS_MAGIC) {
+		contiguous = 0;
+		goto out;
+	}
+
+	fd = SAFE_OPEN(filename, O_RDONLY);
+
+	fiemap = (struct fiemap *)SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent));
+	memset(fiemap, 0, sizeof(struct fiemap) + sizeof(struct fiemap_extent));
+
+	fiemap->fm_start = 0;
+	fiemap->fm_length = ~0;
+	fiemap->fm_flags = 0;
+	fiemap->fm_extent_count = 1;
+
+	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
+
+	/*
+	 * fiemap->fm_mapped_extents != 1:
+	 *   This checks if the file does not have exactly one extent. If there are more
+	 *   or zero extents, the file is not stored in a single contiguous block.
+	 *
+	 * fiemap->fm_extents[0].fe_logical != 0:
+	 *   This checks if the first extent does not start at the logical offset 0 of
+	 *   the file. If it doesn't, it indicates that the file's first block of data
+	 *   is not at the beginning of the file, which implies non-contiguity.
+	 *
+	 * (fiemap->fm_extents[0].fe_flags & FIEMAP_EXTENT_LAST) != FIEMAP_EXTENT_LAST:
+	 *   This checks if the first extent does not have the FIEMAP_EXTENT_LAST flag set.
+	 *   If the flag isn't set, it means that this extent is not the last one, suggesting
+	 *   that there are more extents and the file is not contiguous.
+	 */
+	if (fiemap->fm_mapped_extents != 1 ||
+		fiemap->fm_extents[0].fe_logical != 0 ||
+		(fiemap->fm_extents[0].fe_flags & FIEMAP_EXTENT_LAST) != FIEMAP_EXTENT_LAST) {
+
+		tst_res(TINFO, "File '%s' is not contiguous", filename);
+		contiguous = 0;
+	}
+
+	SAFE_CLOSE(fd);
+	free(fiemap);
+
+out:
+	return contiguous;
+}
+
 /*
  * Make a swap file
  */
@@ -99,10 +158,15 @@ int make_swapfile(const char *swapfile, int safe)
 void is_swap_supported(const char *filename)
 {
 	int i, sw_support = 0;
-	int fibmap = tst_fibmap(filename);
+	int ret = make_swapfile(filename, 1);
+	int fi_contiguous = file_is_contiguous(filename);
 	long fs_type = tst_fs_type(filename);
 	const char *fstype = tst_fs_type_name(fs_type);
 
+	if (fs_type == TST_BTRFS_MAGIC &&
+			tst_kvercmp(5, 0, 0) < 0)
+		tst_brk(TCONF, "Swapfile on Btrfs (kernel < 5.0) not implemented");
+
 	for (i = 0; swap_supported_fs[i]; i++) {
 		if (strstr(fstype, swap_supported_fs[i])) {
 			sw_support = 1;
@@ -110,10 +174,8 @@ void is_swap_supported(const char *filename)
 		}
 	}
 
-	int ret = make_swapfile(filename, 1);
-
 	if (ret != 0) {
-		if (fibmap == 1 && sw_support == 0)
+		if (fi_contiguous == 0 && sw_support == 0)
 			tst_brk(TCONF, "mkswap on %s not supported", fstype);
 		else
 			tst_brk(TFAIL, "mkswap on %s failed", fstype);
@@ -123,7 +185,7 @@ void is_swap_supported(const char *filename)
 	if (TST_RET == -1) {
 		if (errno == EPERM)
 			tst_brk(TCONF, "Permission denied for swapon()");
-		else if (fibmap == 1 && errno == EINVAL && sw_support == 0)
+		else if (errno == EINVAL && fi_contiguous == 0 && sw_support == 0)
 			tst_brk(TCONF, "Swapfile on %s not implemented", fstype);
 		else
 			tst_brk(TFAIL | TTERRNO, "swapon() on %s failed", fstype);
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
