Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44928CEE347
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1763488657; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=p63TiTz4/+Ai+Oyhbk1qnKNcqINnxayhhbflOGGP6FQ=;
 b=QvvGL0wGi3uSdQC5jTF5f19dqe41WC0V8qIPbJUPRl7BEH7OtgX48lJF2qbqcBb+vGVeR
 bNL9jIaAMjfKBXlFb16Irf61+6hvyJ7P1ZDHSR9//9lW3KJ43ZqAl1BN3ScTxyqzHcFT6qf
 lz2/qZDRS7buoKYp/utst8LTYYMzjUQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96C643CF735
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 18:57:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8B4A3CDF19
 for <ltp@lists.linux.it>; Mon, 17 Nov 2025 04:40:31 +0100 (CET)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5409F200089
 for <ltp@lists.linux.it>; Mon, 17 Nov 2025 04:40:31 +0100 (CET)
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-295592eb5dbso4200055ad.0
 for <ltp@lists.linux.it>; Sun, 16 Nov 2025 19:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1763350830; x=1763955630; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pkL6q9iOuTZhT66k91w3h6fjmbki3J6c/DZyo7EbGvw=;
 b=YBL1meZccrm1XoKb/6FLore5/HVhCM8E1zGI+gfKXeRanEIkPPgEzs/2mMCMvI0rC+
 9L3nA1h79zIi8B2DfAPtQhKPMkns3YMgipu3RxdtCXaP8WWjSABdISmq3xyiXejQBWts
 lvrUL+w9F3+/UaFb4dbkXuxXJ9jk9/zjAotS+p+9tL85TiRLqVfbvRGOkbejRG156GMf
 +XE4AkKUPNWayFAffVvzw9sPe3yrRBX6taN0D6NH5lroVVFaVnUpeucKl3au+NcQjCB5
 yHtXK7LSwM90zWZBACH2zE4BFGSE7OVw4hN4rZ0kt70snq4cI1oz+krCkNhMtGusT/pg
 IayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763350830; x=1763955630;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pkL6q9iOuTZhT66k91w3h6fjmbki3J6c/DZyo7EbGvw=;
 b=aqt6g9sZVaWnTsaYxZB6NSk8U5K2uhJTekeBtg2ohLFJnGH7V5IWbtUAsEtVSF77tW
 NA3ThawROONRmCfU3IjkghW+bOLOXN9hisV/nwc6LI4pIUb0paNSBbrnXMeDJEZbWE3u
 2xzYVXeTpBBB31nLPbeezf6niMFraCuZ+fcgVaO+Ne23aCFrkvsy3zBGgB71S/MaETQZ
 xyc5aBGzknwzrXxXNaNTyi2Ll2yp4SWyVGKWrg77XO0GARes+BRRZNyuCHh0VKMOO2Cn
 JTDeuL3swyyDlRRv3NT6yqkRN2+W8DdA3tKJ04jHWSpQmmFEtuGFCso1yyRsHdTnRcRK
 pGtw==
X-Gm-Message-State: AOJu0Yxa1GbkPsIAeI4RxbA8epi1TIoziUKTuyNurTukET1IX3nDA5Fh
 ASJJFSF3RsdGu1yEcK4ODrGnA8VzFbf6vgLvJzjhvQ30MoQz2YS8jgk2af4WhRAzs10pOJ4yhOh
 Bn7foB9T0fimaegggwBPWq6MJImC7wboORiWc3M7LXL7Vcojv8fCbONw3ZEA6TyyfXyBXKlgben
 RKwYtiGyyYMcCEIIKSVhIhZc/ugA==
X-Google-Smtp-Source: AGHT+IHEP+Na+apSQ3Jzg1PjVM0Tdqk9iG3/7lioQWcw1gODPZUYhoaAyaZEYJSV0jyskLBhGKiZUFO84w==
X-Received: from plpg11.prod.google.com ([2002:a17:902:934b:b0:298:1181:af51])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f0e:b0:24c:965a:f94d
 with SMTP id d9443c01a7336-2986a741b6cmr117855755ad.46.1763350829376; Sun, 16
 Nov 2025 19:40:29 -0800 (PST)
Date: Mon, 17 Nov 2025 11:40:23 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117034023.415246-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 18 Nov 2025 18:56:53 +0100
Subject: [LTP] [PATCH] Ignore cve-2022-2590_64bit CVE for Kernel versions
 below 5.16+
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>,
 Kodanda Rami Reddy V <quic_kreddyv@quicinc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Kodanda Rami Reddy V <quic_kreddyv@quicinc.com>

CVE 2022-2590_64bit is applicable only for kernel versions 5.16 onwards.
Add kernel version check to skip/Ignore the test case.
Test Module: vts_ltp_test_arm_64
Test Case: cve.cve-2022-2590_64bit#cve.cve-2022-2590_64bit
GBUG: 418679607

Change-Id: Ibbb18a168b727725faab2beb6841640e034fc468
---
 testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
index 2c7ad00f2..0651ae122 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
@@ -19,6 +19,7 @@
 #include <stdbool.h>
 #include <pwd.h>
 
+#include "tst_kvercmp.h"
 #include "tst_test.h"
 
 #define TMP_DIR "tmp_dirtyc0w_shmem"
@@ -41,6 +42,9 @@ static void sighandler(int sig)
 
 static void setup(void)
 {
+	if (tst_kvercmp(5, 16, 0) < 0) {
+		tst_brk(TCONF, "Test requires kernel 5.16.0 or newer for CVE-2022-2590 fix");
+	}
 	struct passwd *pw;
 
 	umask(0);
@@ -99,7 +103,9 @@ static void dirtyc0w_shmem_test(void)
 
 static void cleanup(void)
 {
-	SAFE_UMOUNT(TMP_DIR);
+	if (tst_kvercmp(5, 16, 0) >= 0) {
+		SAFE_UMOUNT(TMP_DIR);
+	}
 }
 
 static struct tst_test test = {
-- 
2.52.0.rc1.455.g30608eb744-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
