Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C32C77B75
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 09:15:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 334883CD722
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 11:15:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C9093C0238
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:15:17 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A3E70200740
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1683623715; i=@fujitsu.com;
 bh=UYiLI2jWT9HymaowsBvi64I3g5Z5Q94bU0ZUWgnVsxU=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
 b=eR1dLosMqv960og2BTUKYzHxO48sIqIE3YBZ6Y9f1B1QurtSHJRfFTzu14ULgIZnQ
 clFVr9/UkumzsoVuGn7FLglKfefaw4wrP0hfSiQdUsPOZBbuAA95o85XBKO9gtyYrl
 EVnN0qnntvO9f+3xn84uLnF53Qk3lad3g/ElGjqGTJCVpyKa2ADlsfSghJvXxKycVi
 I3wst/DVdzvt2CXGQX9W8k43/PI2fZEaRr6D7+YhjS2oO3dMXUcx8xfQ4xwBXMShXy
 kM0tHr99kNL4163Km/K/WaZWyz8l7WQGbr8Qw6Kl/urrRXFTXutEVbz3e5NstECNoD
 AWbJ13CvoA/ig==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeJIrShJLcpLzFFi42Kxs+FI0lXmj0o
 xuH9ZwGLtnj/MFiu+72B0YPLYtKqTzWPf73WsAUxRrJl5SfkVCawZy4/lFFwTqeif/JK5gfGU
 YBcjF4eQwEZGiea589ghnGlMEmendgE5nBxsApoSzzoXMIPYIgJiEtc3vGIFsZkFbCVeHt/KC
 GILC7hKND2bClbDIqAqMfnEC7A4r4CnxJo1bWC2hICCxJSH78FqOAW8JOa2vQCzhYBq3nRNYo
 WoUZO4em4T8wRGngWMDKsYzYtTi8pSi3QNDfWSijLTM0pyEzNz9BKrdBP1Ukt18/KLSjJ0DfU
 Sy4v1UouL9Yorc5NzUvTyUks2MQIDJaU4cf0Oxq27/uodYpTkYFIS5e3aF5kixJeUn1KZkVic
 EV9UmpNafIhRhoNDSYL3AU9UipBgUWp6akVaZg4waGHSEhw8SiK8J1iA0rzFBYm5xZnpEKlTj
 Locm/Z1HWAWYsnLz0uVEuct5wUqEgApyijNgxsBi6BLjLJSwryMDAwMQjwFqUW5mSWo8q8YxT
 kYlYR5J4JM4cnMK4Hb9AroCCagI/wvh4McUZKIkJJqYCrPmDe3bMmczku7d7NtnCjxddcntkm
 f3j8OmjpzmY3O8ntzG7aW1W+/d2qrRorWmY6fs63VAz3yFy0PrpOWnzA7LHXO04xlazpLD/c9
 n/Vjp7Fyg0JueA6DyY65np9bpY7OEOmYxNi16/+Vax/8Vx3MLFArXSkwc3ut7YE7Ww1mt7xlW
 6UXbMh5PDjaLvTFCcUJ8Zklnx9x3q8yFQhZUnS85VEE37ps5rRHFke7dvQlCx/l+6LvON0kXz
 Vrwrmr+9qm93BcMRB7fKf71bx7MefKZZZsuM/ds2RrQMPF/b/UPRqWLVMTU55rcSfa7BZXHN8
 3zmMHEt+EZS5YlFHANYHfJMhFapYxV9P5y5O8LMOUWIozEg21mIuKEwGHFlVsGwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-728.messagelabs.com!1683623714!585026!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20631 invoked from network); 9 May 2023 09:15:15 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-14.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 May 2023 09:15:15 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id B1A021B1;
 Tue,  9 May 2023 10:15:14 +0100 (BST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id B68ED7B;
 Tue,  9 May 2023 10:15:13 +0100 (BST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  9 May 2023 17:14:05 +0800
Message-Id: <1683623648-22778-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 4/7] syscalls/statx01: Relax mnt_id test condition
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Before this patch, we test stx_mnt_id only when glibc's statx struct has
this member. Now, if glibc miss this filed, we will use __spare2[0], see
url[1]. If glibc miss statx struct, we will use ltp owner definition.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa2fcf4f

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/statx/statx01.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index f9c2748d2..08b26f77b 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -49,20 +49,25 @@
 
 static int file_fd = -1;
 
-#ifdef HAVE_STRUCT_STATX_STX_MNT_ID
 static void test_mnt_id(struct statx *buf)
 {
 	FILE *file;
 	char line[PATH_MAX];
 	int pid, flag = 0;
 	unsigned int line_mjr, line_mnr;
-	uint64_t mnt_id;
+	uint64_t mnt_id, stx_mnt_id;
 
 	if (!(buf->stx_mask & STATX_MNT_ID)) {
 		tst_res(TCONF, "stx_mnt_id is not supported until linux 5.8");
 		return;
 	}
 
+#if defined(HAVE_STRUCT_STATX) && !defined(HAVE_STRUCT_STATX_STX_MNT_ID)
+	stx_mnt_id = buf->__spare2[0];
+#else
+	stx_mnt_id = buf->stx_mnt_id;
+#endif
+
 	file = SAFE_FOPEN("/proc/self/mountinfo", "r");
 
 	while (fgets(line, sizeof(line), file)) {
@@ -70,12 +75,12 @@ static void test_mnt_id(struct statx *buf)
 			continue;
 
 		if (line_mjr == buf->stx_dev_major && line_mnr == buf->stx_dev_minor) {
-			if (buf->stx_mnt_id == mnt_id) {
+			if (stx_mnt_id == mnt_id) {
 				flag = 1;
 				break;
 			}
 			tst_res(TINFO, "%s doesn't contain %"PRIu64" %d:%d",
-				line, (uint64_t)buf->stx_mnt_id, buf->stx_dev_major, buf->stx_dev_minor);
+				line, (uint64_t)stx_mnt_id, buf->stx_dev_major, buf->stx_dev_minor);
 		}
 	}
 
@@ -88,13 +93,12 @@ static void test_mnt_id(struct statx *buf)
 	else
 		tst_res(TFAIL,
 			"statx.stx_mnt_id(%"PRIu64") doesn't exist in /proc/self/mountinfo",
-			(uint64_t)buf->stx_mnt_id);
+			(uint64_t)stx_mnt_id);
 
 	pid = getpid();
 	snprintf(line, PATH_MAX, "/proc/%d/fdinfo/%d", pid, file_fd);
-	TST_ASSERT_FILE_INT(line, "mnt_id:", buf->stx_mnt_id);
+	TST_ASSERT_FILE_INT(line, "mnt_id:", stx_mnt_id);
 }
-#endif
 
 static void test_normal_file(void)
 {
@@ -147,11 +151,7 @@ static void test_normal_file(void)
 		tst_res(TFAIL, "stx_nlink(%u) is different from expected(1)",
 			buff.stx_nlink);
 
-#ifdef HAVE_STRUCT_STATX_STX_MNT_ID
 	test_mnt_id(&buff);
-#else
-	tst_res(TCONF, "stx_mnt_id is not defined in struct statx");
-#endif
 }
 
 static void test_device_file(void)
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
