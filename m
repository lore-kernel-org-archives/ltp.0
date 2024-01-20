Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F44C47258
	for <ltp@archiver.kernel.org>; Sat, 20 Jan 2024 04:35:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FC723CFAA6
	for <ltp@archiver.kernel.org>; Sat, 20 Jan 2024 05:35:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66D363CE2D9
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 05:34:21 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 93DC41011BC9
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 05:34:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705725259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/YN7mwSm6kGZn1HPdrh18451K7aV951VH9CNM86f5E=;
 b=VXHJYHnbCkXSRatkmKPN6d+UablL3YpIiXR+oZ/ttqLn08BzZ1tOXF2gaQD9R/bm5ro+H5
 GtzmY6Y7A0U6QTuo6Lta+F+oeWscuwW5WFhIeJz0dQfM8BZpASF2hmkYu50Iob/ef8CWzK
 JJeVKAbSbFtEowDCo/u8rGzwmUgpXco=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-rfvU5qlFMuSooAJy8l7hIw-1; Fri, 19 Jan 2024 23:34:16 -0500
X-MC-Unique: rfvU5qlFMuSooAJy8l7hIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EF7983B82A
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 04:34:16 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7338B2026D66
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 04:34:15 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sat, 20 Jan 2024 12:34:11 +0800
Message-Id: <20240120043412.2544860-1-liwang@redhat.com>
In-Reply-To: <CAEemH2ceuoj+a2PK2pNStXYnsBcXM+g8JWkdd3Jj077xi+nm3A@mail.gmail.com>
References: <CAEemH2ceuoj+a2PK2pNStXYnsBcXM+g8JWkdd3Jj077xi+nm3A@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] libswap: add known swap supported fs check
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

This introduce an enhancement to the library's is_swap_supported
function to check for filesystem compatibility before attempting
to create and enable a swap file.  A list of supported filesystems
is added (ext2, ext3, ext4, xfs, vfat, exfat, ntfs), and a check
against this list is performed to ensure that the swap operations
are only attempted on known compatible filesystems.

If the make_swapfile function fails, the error handling is now
more descriptive: it distinguishes between failures due to the
filesystem not supporting swap files and other types of failures.
Similarly, when attempting to enable the swap file with swapon,
the patch ensures that clearer error messages are provided in
cases where the operation is not supported by the filesystem.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 libs/libltpswap/libswap.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index d014325e5..5f9622aca 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -12,6 +12,17 @@
 #include "libswap.h"
 #include "lapi/syscalls.h"
 
+static const char *const swap_supported_fs[] = {
+	"ext2",
+	"ext3",
+	"ext4",
+	"xfs",
+	"vfat",
+	"exfat",
+	"ntfs",
+	NULL
+};
+
 /*
  * Make a swap file
  */
@@ -39,23 +50,31 @@ int make_swapfile(const char *swapfile, int safe)
  */
 void is_swap_supported(const char *filename)
 {
+	int i, sw_support = 0;
 	int fibmap = tst_fibmap(filename);
 	long fs_type = tst_fs_type(filename);
 	const char *fstype = tst_fs_type_name(fs_type);
 
-	int ret = make_swapfile(filename, 1);
-	if (ret != 0) {
-		if (fibmap == 1)
-			tst_brk(TCONF, "mkswap on %s not supported", fstype);
-		else
-			tst_brk(TFAIL, "mkswap on %s failed", fstype);
+	for (i = 0; swap_supported_fs[i]; i++) {
+		if (!strcmp(fstype, swap_supported_fs[i])) {
+			sw_support = 1;
+			break;
+		}
 	}
 
+       int ret = make_swapfile(filename, 1);
+       if (ret != 0) {
+               if (fibmap == 1 && sw_support == 0)
+                       tst_brk(TCONF, "mkswap on %s not supported", fstype);
+               else
+                       tst_brk(TFAIL, "mkswap on %s failed", fstype);
+       }
+
 	TEST(tst_syscall(__NR_swapon, filename, 0));
 	if (TST_RET == -1) {
 		if (errno == EPERM)
 			tst_brk(TCONF, "Permission denied for swapon()");
-		else if (fibmap == 1 && errno == EINVAL)
+		else if (fibmap == 1 && errno == EINVAL && sw_support == 0)
 			tst_brk(TCONF, "Swapfile on %s not implemented", fstype);
 		else
 			tst_brk(TFAIL | TTERRNO, "swapon() on %s failed", fstype);
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
