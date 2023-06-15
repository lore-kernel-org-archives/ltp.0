Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C42FEB64D9
	for <ltp@archiver.kernel.org>; Thu, 15 Jun 2023 07:53:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAEC53CC5C2
	for <ltp@archiver.kernel.org>; Thu, 15 Jun 2023 09:53:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A26B53CB39B
 for <ltp@lists.linux.it>; Thu, 15 Jun 2023 09:53:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 76C3D14060B9
 for <ltp@lists.linux.it>; Thu, 15 Jun 2023 09:53:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686815596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0nuLMINj+4FZiHL3iTg9F+E+5MjmUOhHHWPDDvLwmnc=;
 b=ItnV0PYkpzYQoi1R3kx9UnujWesu0F6apQOcJjVLRJypojIGj3a6PgKiS7coRhCSXuPdjz
 XZzO15KhzkB82asYBHaFVqeMiacjTdWMqoSpgw6zFrtHhnFLv4MWQAPrFdlhwHMOTTrZj2
 dfrV5Hy5iFGodAPf7hSGGtsfJ2LMqfo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-d5KKVR49PuWs47h52cGGvQ-1; Thu, 15 Jun 2023 03:53:11 -0400
X-MC-Unique: d5KKVR49PuWs47h52cGGvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FE24299E764;
 Thu, 15 Jun 2023 07:53:11 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BE9C2166B37;
 Thu, 15 Jun 2023 07:53:09 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 15 Jun 2023 15:53:07 +0800
Message-Id: <20230615075307.157688-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_fill_fs: drop safe_macro from fill_flat_vec
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
Cc: Shizhao Chen <shichen@redhat.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP fs_fill is trying to spawn nCPUS thread to create corresponding
subdirectories and completely fill them. But in the invoke function
tst_fill_fs(, TST_FILL_BLOCKS) -> fill_flat_vec() which has SAFE_MACROs
to break the open behavior once fs is filled with ENOSPC return.

The failure like there aren't enough free inodes in the filesystem for
the tst_fs_fill test program to create it's set of "AOF" data files.

  4108	tst_test.c:1634: TINFO: === Testing on xfs ===
  4109	tst_test.c:1094: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
  4110	fs_fill.c:108: TINFO: Running 98 writer threads
  4111	tst_fill_fs.c:77: TBROK: openat(89</mnt/testarea/ltp-wGg0XNSHcr/LTP_fs_XLxrLh/mntpoint/thread84>, 'AOF', 101, 600): ENOSPC (28)
  4112	tst_fill_fs.c:77: TBROK: openat(87</mnt/testarea/ltp-wGg0XNSHcr/LTP_fs_XLxrLh/mntpoint/thread83>, 'AOF', 101, 600): ENOSPC (28)
  4113	tst_fill_fs.c:77: TWARN: openat(85</mnt/testarea/ltp-wGg0XNSHcr/LTP_fs_XLxrLh/mntpoint/thread82>, 'AOF', 101, 600): ENOSPC (28)
  4114	tst_fill_fs.c:77: TWARN: openat(3</mnt/testarea/ltp-wGg0XNSHcr/LTP_fs_XLxrLh/mntpoint/thread81>, 'AOF', 101, 600): ENOSPC (28)

This patch is just to convert the fill_flat_vec() to ignore ENOSPC like
fill_randome() in opening subdirectories.

Reported-by: Shizhao Chen <shichen@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_fill_fs.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
index b9d29755a..243eb279f 100644
--- a/lib/tst_fill_fs.c
+++ b/lib/tst_fill_fs.c
@@ -73,12 +73,29 @@ void fill_random(const char *path, int verbose)
 
 void fill_flat_vec(const char *path, int verbose)
 {
-	int dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY);
-	int fd = SAFE_OPENAT(dir, "AOF", O_WRONLY | O_CREAT, 0600);
+	int dir, fd;
 	struct iovec iov[512];
 	int iovcnt = ARRAY_SIZE(iov);
 	int retries = 3;
 
+	dir = open(path, O_PATH | O_DIRECTORY);
+	if (dir == -1) {
+		if (errno == ENOSPC) {
+			tst_res(TINFO | TERRNO, "open()");
+			return;
+		}
+		tst_brk(TBROK | TERRNO, "open(%s, %d) failed", path, O_PATH | O_DIRECTORY);
+	}
+
+	fd = openat(dir, "AOF", O_WRONLY | O_CREAT, 0600);
+	if (fd == -1) {
+		if (errno == ENOSPC) {
+			tst_res(TINFO | TERRNO, "openat()");
+			return;
+		}
+		tst_brk(TBROK | TERRNO, "openat(%s, %d, 0600) failed", dir, O_PATH | O_DIRECTORY);
+	}
+
 	SAFE_CLOSE(dir);
 
 	for (int i = 0; i < iovcnt; i++) {
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
