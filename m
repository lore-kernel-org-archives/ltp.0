Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27015CCD185
	for <ltp@archiver.kernel.org>; Wed, 18 Sep 2024 07:33:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7822B3C2E44
	for <ltp@archiver.kernel.org>; Wed, 18 Sep 2024 09:33:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BCB23C130D
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 09:33:10 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 794DF619574
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 09:33:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726644787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2b2BwM5dHNvbxFKwjM2c27oveCfaUOmu9/Cn6BwuhuQ=;
 b=Jk9kF0e0a0612Bhrc1IYex2liSp+AQ4lOzm5AQfEDAyLHW3s4lVAkWTehfDeIRJwPDeO1J
 IgiQguvlkcWFhiqdQnKCuu5A3aeciHUlWaUlABNCBBpDY0/lNM02WCUwVMfqJ5sfjw+jvS
 6KlvtGXRs1E26T3SjqkFxDqF+/lv0gw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-S4TTotmSPFyEFNqOPGICiA-1; Wed,
 18 Sep 2024 03:33:06 -0400
X-MC-Unique: S4TTotmSPFyEFNqOPGICiA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A4A81953963
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 07:33:05 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F773195605A; Wed, 18 Sep 2024 07:33:02 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 18 Sep 2024 15:32:57 +0800
Message-ID: <20240918073257.13930-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
 lib/safe_file_ops.c | 3 +++
 1 file changed, 3 insertions(+)

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
