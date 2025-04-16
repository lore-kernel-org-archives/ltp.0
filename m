Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F404C369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 03:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744774353; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=7429yWDiEikTB7NTrXFl41LSJ8ReeRNmLWExRgUdHZM=;
 b=E8UzJO++j6d81PJBRK+bwbsu+aNFVc3bo9M4OwORbkVfK8z9ynBJf4myGfvdpsAVdfrAr
 kpoqRXrcA2qVY5RK0pj6SPOihrkLOS/5CRd44nn8W7yFsZTM9CVGPm4JzoL+I2YAKg901Gc
 GuSCQWWF0PI0IXRACRr9wim8/tRJhjI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75EE43CB947
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 05:32:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86CF63CB596
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 05:32:12 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 158BC200274
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 05:32:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744774329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J75Yq8obAzooAwujh62Fr9oQmKc/ahHCL5Fbqq9p1+M=;
 b=ZgFQ5XolygssXv/q27Oyx68fRni+p/6rcAfWulIucArRUqERlT60dvGVtYGQ0aYbZZPxYx
 62VXM7/PSF7HLL+luqnewq0EzgGV91f9skWNa7sMyEFA+txr7pg/hFciRZnnzRsoPVJUnP
 KvleCPOECLNTUVSw6+mb0rMif7dSayg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-z1gE8EjDPTStAHU7Exm0KQ-1; Tue,
 15 Apr 2025 23:32:07 -0400
X-MC-Unique: z1gE8EjDPTStAHU7Exm0KQ-1
X-Mimecast-MFC-AGG-ID: z1gE8EjDPTStAHU7Exm0KQ_1744774326
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E22B19560B8
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 03:32:06 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3C781828A9E
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 03:32:04 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 16 Apr 2025 11:31:58 +0800
Message-ID: <20250416033200.62867-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EWUlzN7cfapOWBcgXoilDGMxnXpQQibr8UA_bTW_fgc_1744774326
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED 1/2] ci: improve package manager support in
 fedora.sh
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Enhance Fedora CI script to support multiple versions of DNF. Prefer
`dnf5` if available, which supports the `--skip-unavailable` option.

Fallback to `dnf` or `yum` based on availability.

This improves compatibility with newer Fedora versions (e.g. Fedora 42+)
and prevents failures when unsupported options are passed to older DNF/YUM
versions.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 ci/fedora.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ci/fedora.sh b/ci/fedora.sh
index bef5bcd2b..2b0701d08 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -2,7 +2,13 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2018-2021 Petr Vorel <pvorel@suse.cz>
 
-yum="yum -y install --skip-broken"
+if command -v dnf5 >/dev/null 2>&1; then
+	yum="dnf5 -y install --skip-broken --skip-unavailable"
+elif command -v dnf >/dev/null 2>&1; then
+	yum="dnf -y install --skip-broken"
+else
+	yum="yum -y install --skip-broken"
+fi
 
 $yum \
 	autoconf \
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
