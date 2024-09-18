Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E15CCD181
	for <ltp@archiver.kernel.org>; Wed, 18 Sep 2024 07:31:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B218B3C2E66
	for <ltp@archiver.kernel.org>; Wed, 18 Sep 2024 09:31:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BCED3C0EBB
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 09:31:14 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4AAB51B60EEB
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 09:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726644671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EtD488ZmOH11CIAm/+YVWwW+mcFvNuB8muDVhYlYMbQ=;
 b=BSiy3c4hDIozMXrONyGMjD0IhB0KFLtILBs9LX3+DY1mSBqyh79T8jP3AAqwv1SqoCSlmt
 52GgLfDtmSqsVJU0GoAnwni9GBSL769W+0Ag/0nqbkVnMAIqly4l57QJ7Laf0Lj90KyGaa
 2W8V/ALFMTvX90WSP9pGSKk4kZSp0hs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-vTHuRmAhMCCi4_VUjvBDmw-1; Wed,
 18 Sep 2024 03:31:10 -0400
X-MC-Unique: vTHuRmAhMCCi4_VUjvBDmw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2A411955D53
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 07:31:08 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F70219560A3; Wed, 18 Sep 2024 07:31:06 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 18 Sep 2024 15:31:00 +0800
Message-ID: <20240918073101.13814-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: handle ENOENT errors when processes exit during
 PID scanning
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
Cc: Charles Mirabile <cmirabil@redhat.com>, Paul Bunyan <pbunyan@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

There is a race window between readdir() and fopen() in line 125~131 of lib
function get_used_pids. A process could terminate after its directory entry
is read but before its status file is opened.

When fopen() is called, the status file may no longer exist, resulting in an
error like:

  tag=msgstress01__with_dmesg_entry stime=1723563200
  ...
  tst_test.c:1617: TINFO: Timeout per run is 0h 03m 30s
  tst_pid.c:128: TBROK: Failed to open FILE '/proc/73429/status' for reading: ENOENT (2)

To resolve this, the file_lines_scanf() function is modified to handle ENOENT
errors gracefully when strict mode is not enabled. If fopen() fails due to
ENOENT, the function now returns 1 to skip the missing file instead of treating
it as a critical error.

Reported-by: Paul Bunyan <pbunyan@redhat.com>
Analysed-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/.tst_pid.c.swo  | Bin 0 -> 16384 bytes
 lib/safe_file_ops.c |   3 +++
 2 files changed, 3 insertions(+)
 create mode 100644 lib/.tst_pid.c.swo

diff --git a/lib/.tst_pid.c.swo b/lib/.tst_pid.c.swo
new file mode 100644
index 0000000000000000000000000000000000000000..956a03da5090a5af543e0dca7eab124d2a2f1d67
GIT binary patch
literal 16384
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
UrBuzo*8DK}mpY#Cz~34C2N*U}KL7v#

literal 0
HcmV?d00001

diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index 63ae2dbbe..4cf0d6e0f 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -182,6 +182,9 @@ int file_lines_scanf(const char *file, const int lineno,
 
 	fp = fopen(path, "r");
 	if (fp == NULL) {
+		if (strict == 0 && errno == ENOENT)
+			return 1;
+
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Failed to open FILE '%s' for reading", path);
 		return 1;
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
