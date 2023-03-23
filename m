Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA723C6FD1C
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 15:59:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C57A3CE2F7
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 16:59:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C4C43C0277
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 16:45:53 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 85EAA6009FB
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 16:45:52 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3A9F1B82035
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 15:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49F8C433D2;
 Thu, 23 Mar 2023 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679586349;
 bh=mthTcYlwRQAPG9WQnqr42YWJPry9/OJx+HMIH6pa8iI=;
 h=From:Date:Subject:To:Cc:From;
 b=bU2YJLFPh46FPOUYqRIU8xK+uTOcFezwRG2Vy2kUZoug/j7efTvEd55LsLe2OxJYk
 DmrBawWfgORQv+FYfHZM9zNDDvawSGQUViLPizraHicgzzkrCDKHEnA3cFzM5ITXQE
 wTyxdT/DPxzZndevGQr3prBm7iTdHF5EzPUkb8goE+wgcupImMLE4i8GWExzqrHPMn
 EVc5JpYnatfD4tzurhg7hh48N0OB2744azGmvFvv7F54Qd87aON48dhInfnQ4Cuj2K
 VqhFD0nE2uGlEl3JY1bxAUfy783lnRyAJlbGsBBzugBlsppL5YlbFQtjXmsRSjtMn7
 Bg3qQjU3jK64Q==
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Thu, 23 Mar 2023 10:45:37 -0500
MIME-Version: 1.0
Message-Id: <20230323-override-unpriv-userns-sysctl-v1-1-0b62c71acd43@kernel.org>
X-B4-Tracking: v=1; b=H4sIACB0HGQC/32OQQqDMBBFryKz7kBMFtZepXSRxLEOlFFmarCId
 2/sAbp88P7j72CkTAa3ZgelwsazVGgvDeQpypOQh8rgnQ8u+IBzIVUeCFdZlAuuNSCG9rH8fqH
 rrqnvQ+dH10JtpGiESaPk6az8HZ/+ojTy9vtzfxzHF3wS0UufAAAA
To: ltp@lists.linux.it
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=mthTcYlwRQAPG9WQnqr42YWJPry9/OJx+HMIH6pa8iI=;
 b=owEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBkHHQmtnuoFWV8jzcCv913iVi0mSwgwfBeIY1bIYRE
 A7z++GiJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxyQUCZBx0JgAKCRBTA5mu5fQxyS+iB/
 92dA1NIKiPTpq095R8PmMJx0WqIp9sX7WYjJJ/rIiZaIseLhtCC7vZ+bYQvP/1z4NzILCTG5IQKcNL
 0X4x5KGuCqowTts3pER61I9ZDhdRKWqQUC76U8qx3xRwyEtGm7DJepIaQJein6XcxKBSELTtgX30fb
 MAZrS+59Zs15uNsWrAxrbkoaDqwTiAzNbDaUfHC0S/OWJ19S1QHsxEECvjY1TkeoxTg8gUsXlIUsuT
 NWQkiqBkEw3Ia5+Use+zXw5wYurLspPrzN56AW7OxCMaK1SiFT9mSqeZr5fxqgE4qfuswVlM9Qi1UE
 jqqeXlk6WQINwmZja3kV3Plu9dKkhZ
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Mar 2023 16:59:45 +0100
Subject: [LTP] [PATCH] containers: override kernel.unprivileged_userns_clone
 sysctl where needed
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
Cc: "Seth Forshee \(DigitalOcean\)" <sforshee@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some distros have a kernel.unprivileged_userns_clone which when disabled
forbids users without CAP_SYS_ADMIN in the initial user namespace from
creating new user namespaces. When disabled the containers user07 and
user08 tests fail.

Update these tests to ensure that when this sysctl is present it is set
to allow unprivileged user namespace creation while the test is running.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 testcases/kernel/containers/userns/userns07.c | 4 ++++
 testcases/kernel/containers/userns/userns08.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/testcases/kernel/containers/userns/userns07.c b/testcases/kernel/containers/userns/userns07.c
index 40cc1e26c244..2c946a659278 100644
--- a/testcases/kernel/containers/userns/userns07.c
+++ b/testcases/kernel/containers/userns/userns07.c
@@ -88,4 +88,8 @@ static struct tst_test test = {
 		"CONFIG_USER_NS",
 		NULL,
 	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/kernel/unprivileged_userns_clone", "1", TST_SR_SKIP},
+		{}
+	},
 };
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index 2697d874b3a0..84f0ce9a92e1 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -136,6 +136,7 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP},
+		{"/proc/sys/kernel/unprivileged_userns_clone", "1", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {

---
base-commit: ce8a8edf1c5a917d0fd2f983c36b67e93de0a5c7
change-id: 20230323-override-unpriv-userns-sysctl-078b99372f01

Best regards,
-- 
Seth Forshee (DigitalOcean) <sforshee@kernel.org>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
