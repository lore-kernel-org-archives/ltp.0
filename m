Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99223C4167B
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 18:10:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9B8B3CCA78
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 19:10:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F6163CC0A4
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 19:10:10 +0100 (CET)
Received: from 66-220-144-179.mail-mxout.facebook.com
 (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5806F1A00689
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 19:10:09 +0100 (CET)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
 id AAA361067A2EE; Tue,  5 Dec 2023 10:09:54 -0800 (PST)
From: Stefan Roesch <shr@devkernel.io>
To: kernel-team@fb.com
Date: Tue,  5 Dec 2023 10:09:51 -0800
Message-Id: <20231205180952.3843711-2-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231205180952.3843711-1-shr@devkernel.io>
References: <20231205180952.3843711-1-shr@devkernel.io>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] mem: disable KSM smart scan for ksm tests
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
Cc: linux-mm@kvack.org, david@redhat.com, oliver.sang@intel.com,
 shr@devkernel.io, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This disables the "smart scan" KSM feature to make sure that the volatile
count remains at 0.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202311161132.13d8ce5a-oliver.sang@intel.com
---
 testcases/kernel/mem/ksm/ksm01.c | 2 ++
 testcases/kernel/mem/ksm/ksm02.c | 2 ++
 testcases/kernel/mem/ksm/ksm03.c | 2 ++
 testcases/kernel/mem/ksm/ksm04.c | 2 ++
 testcases/kernel/mem/ksm/ksm05.c | 2 ++
 testcases/kernel/mem/ksm/ksm06.c | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index bcd095865..e2d3d9e00 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -86,6 +86,8 @@ static struct tst_test test = {
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
 		{"/sys/kernel/mm/ksm/merge_across_nodes", "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
+		{"/sys/kernel/mm/ksm/smart_scan", "0",
+			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
 	.needs_kconfigs = (const char *const[]){
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index bce639dce..3707de95d 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -107,6 +107,8 @@ static struct tst_test test = {
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
 		{"/sys/kernel/mm/ksm/merge_across_nodes", "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
+		{"/sys/kernel/mm/ksm/smart_scan", "0",
+			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
 	.needs_kconfigs = (const char *const[]){
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 4a733269f..cff74700d 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -89,6 +89,8 @@ static struct tst_test test = {
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
 		{"/sys/kernel/mm/ksm/merge_across_nodes", "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
+		{"/sys/kernel/mm/ksm/smart_scan", "0",
+			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
 	.needs_kconfigs = (const char *const[]){
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 4f1f2f721..9935e32d7 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -109,6 +109,8 @@ static struct tst_test test = {
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
 		{"/sys/kernel/mm/ksm/merge_across_nodes", "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
+		{"/sys/kernel/mm/ksm/smart_scan", "0",
+			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
 	.needs_kconfigs = (const char *const[]){
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index 1f58c8325..61e740843 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -89,6 +89,8 @@ static struct tst_test test = {
 	.test_all = test_ksm,
 	.save_restore = (const struct tst_path_val[]) {
 		{"/sys/kernel/mm/ksm/run", "1", TST_SR_TBROK},
+		{"/sys/kernel/mm/ksm/smart_scan", "0",
+			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
 	.needs_kconfigs = (const char *const[]){
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 0b159e5c7..80fdf1e47 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -142,6 +142,8 @@ static struct tst_test test = {
 		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
 		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
 		{"/sys/kernel/mm/ksm/merge_across_nodes", NULL, TST_SR_TCONF},
+		{"/sys/kernel/mm/ksm/smart_scan", "0",
+			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
 	.needs_kconfigs = (const char *const[]){
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
