Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98E5E77188
	for <ltp@archiver.kernel.org>; Sun, 22 Dec 2024 07:51:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7307A3E57B8
	for <ltp@archiver.kernel.org>; Sun, 22 Dec 2024 08:51:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 999953E55EF
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 08:51:19 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 53EE5101B456
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 08:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734853876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XT72Gt7fBzbwW0EKFLk841YUVD+aOHg3wU2zTd7g16o=;
 b=EZrbcg69ZjIEqpVVP09z4/5KQdxr8N32YkHrhUsaFth/mUXrLdTUl10MPBjjWbBzxqA0jy
 MTontwbhGl1AxBqQIG0o/baGjkBJ9sjE9vIM60/DUZlL/gBMVfO+hLVCF+aK5IaoRXbLp5
 O0cE5V59uKeNe2m1EwQ1ogcXIzzs2Nc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-QDGTn6TCMLuGGoPbGEyY5A-1; Sun,
 22 Dec 2024 02:51:14 -0500
X-MC-Unique: QDGTn6TCMLuGGoPbGEyY5A-1
X-Mimecast-MFC-AGG-ID: QDGTn6TCMLuGGoPbGEyY5A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04EC819560B1
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 07:51:14 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C25761956053
 for <ltp@lists.linux.it>; Sun, 22 Dec 2024 07:51:12 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 22 Dec 2024 15:51:02 +0800
Message-ID: <20241222075102.14536-3-liwang@redhat.com>
In-Reply-To: <20241222075102.14536-1-liwang@redhat.com>
References: <20241222075102.14536-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T4aE-2rz1lde1-PlqVQRcYsh-o9q-5DdCRzo2U4Pd7w_1734853874
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] newlib_test: enable all tst_fuzzy_sync tests
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

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    This patch based on Peter's work:
    Message-ID: <20241210225753.381770-1-pvorel@suse.cz>
    
    CI: https://github.com/wangli5665/ltp/actions/runs/12452324779/

 lib/newlib_tests/runtest.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 66aaa9361..b00965b16 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -2,7 +2,7 @@
 # Copyright (c) 2021-2024 Petr Vorel <pvorel@suse.cz>
 
 # TODO "unknown failure, exit code": test_assert test08 tst_cgroup01 tst_cgroup02 tst_res_flags variant
-# TODO TFAIL: tst_fuzzy_sync01 tst_fuzzy_sync02 test_macros0[1-6] test23 test26
+# TODO TFAIL: test_macros0[1-6] test23 test26
 # TODO TBROK: test_exec_child test_kconfig01 test_kconfig02 tst_needs_cmds04 tst_needs_cmds05 test_runtime02 test01 test02 test03 test04 test06 test11 test13 test22 test25 tst_safe_fileops
 # TODO TWARN: test_guarded_buf test14 tst_capability01 tst_print_result
 LTP_C_API_TESTS="${LTP_C_API_TESTS:-
@@ -20,6 +20,8 @@ tst_bool_expr
 tst_capability02
 tst_device
 tst_expiration_timer
+tst_fuzzy_sync01
+tst_fuzzy_sync02
 tst_fuzzy_sync03
 tst_needs_cmds0[1-36-8]
 tst_res_hexd
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
