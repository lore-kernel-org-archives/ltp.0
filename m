Return-Path: <SRS0=3a48=N4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CD1C433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 08:36:05 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9056260E94
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 08:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9056260E94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACDB73C8A2F
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 10:36:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3697E3C2600
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 10:35:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4843360094C
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 10:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630917351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0Im5gi1247mzVKMctIZsXWB4fjuemamepxFzi7vtSSM=;
 b=eVYMA6PJ1kzfNl0a0fL9r5VwpkeNyPBRvFFZ7NzOeIovqIlNtnE2zKsJS/oWk+CdkxfxR6
 hbG+B2jj375C/FXF1WlKfXVA9rfZpqblzQIbQJKXpmNo29TLO1C7hi2zPnXQlWU+Lrw1+U
 FMouin1PxSRbQNJuPLjwbdzsLjOzW5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-QBwWWq_DMPStUq5ehIWiIQ-1; Mon, 06 Sep 2021 04:35:50 -0400
X-MC-Unique: QBwWWq_DMPStUq5ehIWiIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EBB4108C1E0
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 08:35:49 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.208.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26D4469FC2
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 08:35:47 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  6 Sep 2021 10:35:45 +0200
Message-ID: <77a5903b5ddf8b63c1acc6c24e4d3195590e8628.1630917312.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ftruncate04: require CONFIG_MANDATORY_FILE_LOCKING=y
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
Message-ID: <20210906083545.Ju7NitwepyNeW8jL3ezAyJVeyINwxw5CM_B4xa3Vlp0@z>

commit f7e33bdbd6d1 ("fs: remove mandatory file locking support")
removed mandatory file locking support, but mount option
is still allowed and produces no error. There's a warning
in dmesg but it's pr_warn_once() so we can't rely to always
find it there.

Make the test check also for CONFIG_MANDATORY_FILE_LOCKING=y.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ftruncate/ftruncate04.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate04.c b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
index ad5c7bbb90ef..c832ceaa659d 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -168,6 +168,10 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_MANDATORY_FILE_LOCKING=y",
+		NULL
+	},
 	.test_all = verify_ftruncate,
 	.setup = setup,
 	.needs_checkpoints = 1,
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
