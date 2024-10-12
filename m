Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBD2CF256C
	for <ltp@archiver.kernel.org>; Sat, 12 Oct 2024 16:05:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0094E3C64B1
	for <ltp@archiver.kernel.org>; Sat, 12 Oct 2024 18:05:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F9C33C12D0
 for <ltp@lists.linux.it>; Sat, 12 Oct 2024 18:04:57 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0FF361016C39
 for <ltp@lists.linux.it>; Sat, 12 Oct 2024 18:04:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728749095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SXWvehxY6Oi2cCtYUwk8V3LSbwo39IyaLpPyolaBqVY=;
 b=hgXD2uXH0l2s4g85rcxxi7Kg6afIvp0YxxKwf5JdjwnjO9PDMT/5vaQQAKc1QSJfmGXVs3
 F1jr7uvjC6WJl/lGuSnTARiMbG/XhxrtfWxWg/Tciv/xPpDrFYAV3q8tQpu2CszS0B13GB
 0oisODoJH4plKRFezH81xPkkhxlolXE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-WXnyFSi1M9i2Uytn0Rs22Q-1; Sat,
 12 Oct 2024 12:04:53 -0400
X-MC-Unique: WXnyFSi1M9i2Uytn0Rs22Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1140195608A; Sat, 12 Oct 2024 16:04:51 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.226.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFF5719560A2; Sat, 12 Oct 2024 16:04:50 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it,
	andrea.cervesato@suse.com
Date: Sat, 12 Oct 2024 18:04:32 +0200
Message-ID: <c946f9e48cdf34a52c32f92531a21170307a6955.1728748940.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH COMMITTED] lib/tst_test.c: fix NULL ptr deref when
 "filesystems" is not defined
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

Fixes: 257394e4e356 ("Filter mkfs version in tst_fs")

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8d205a42f7c5..d942a91f17f3 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1425,10 +1425,10 @@ static void do_setup(int argc, char *argv[])
 		tdev.fs_type = default_fs_type();
 
 		if (!tst_test->all_filesystems && count_fs_descs() <= 1) {
-			if (tst_test->filesystems->mkfs_ver)
+			if (tst_test->filesystems && tst_test->filesystems->mkfs_ver)
 				tst_check_cmd(tst_test->filesystems->mkfs_ver, 1);
 
-			if (tst_test->filesystems->min_kver)
+			if (tst_test->filesystems && tst_test->filesystems->min_kver)
 				check_kver(tst_test->filesystems->min_kver, 1);
 
 			prepare_device(tst_test->filesystems);
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
