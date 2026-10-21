Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71684606A905
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 03:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nz2XLkyY
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 126953EA623
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 05:18:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15C233E2620
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 05:18:23 +0200 (CEST)
Received: from mta0.migadu.com (out-31.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::1f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 982F22003A6
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 05:18:23 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=IfRuHjUcbGf2pgyAUBh3ufz6ouNU2bGDARooThX8u4k=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792552702; v=1; x=1793157502;
 b=nz2XLkyY+ZxQOKHKu1qFsw3ymvuxYiTuLXvbEXruHdPlciEIoGgC8NKRuDY5JyI6IExE33tV
 5ZbpVcAsEx3E+ev6rYhn3wK9cRDvETwGHpa9WjN5Ze1o3UG3hAAVJ1X/JI2eul1Js3eDKKCDpdX
 0v19ltE0Wut19XYKhj0ynJlc=
X-Envelope-To: ltp@lists.linux.it
Received: by mta11.migadu.com with ESMTPS id 1145be5184c6d6a6;
 Wed, 21 Oct 2026 03:18:22 +0000
X-Mizu-Trace-ID: 1145be5184c6d6a6
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Wed, 21 Oct 2026 11:18:16 +0800
Message-ID: <20261021031816.166499-2-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021031816.166499-1-li.wang@linux.dev>
References: <20261021031816.166499-1-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] sys_hwmon01: always report a result
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Xiaochen Shen <shenxiaochen@open-hieco.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On machines where the hwmon devices expose no checkable attributes
(e.g. a VM or a laptop where hwmon0 is just 'ACAD' with nothing but
a name attribute), every *_SILENT assertion skips silently and the
test finishes without reporting a single result, which the library
turns into:

    tst_test.c:1730: TBROK: Test haven't reported results!

Fix this by using the new tst_sysfs_cnt_*() helpers to count the
attributes that actually exist and get validated, then reporting a
TPASS summary at the end, or TCONF when hwmon devices are present
but expose nothing we can check.

While at it, fix a preexisting off-by-one in the inN channel loop:
probe in0..in31 so that all channel types probe exactly MAX_CHANNELS
indices.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang (Hieco) <li.wang@linux.dev>
Cc: Xiaochen Shen <shenxiaochen@open-hieco.net>
---

Notes:
    v4:
        - no change.
    v3:
        - move the counter into the sysfs library as
          tst_sysfs_cnt_reset()/tst_sysfs_cnt_get(), drop the CHECK_*
          wrapper macros and the extra existence probe (Cyril)
    v2:
        - rename attr_exists() to sysfs_attr_exists() (Xiaochen)
        - flatten the final result reporting with an early return (Xiaochen)
        - fix a preexisting off-by-one in the inN channel loop (Xiaochen)

 .../kernel/sysfs/class/hwmon/sys_hwmon01.c    | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c b/testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c
index 1bb574c23..482bd7a23 100644
--- a/testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c
+++ b/testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c
@@ -131,7 +131,7 @@ static void check_hwmon_device(const char *hwmon)
 					PATH_CLASS_HWMON "/%s/update_interval", hwmon);
 
 	/* inN channels are numbered from 0, per the hwmon ABI */
-	for (i = 0; i <= MAX_CHANNELS; i++)
+	for (i = 0; i < MAX_CHANNELS; i++)
 		check_in_channel(hwmon, i);
 
 	for (i = 1; i <= MAX_CHANNELS; i++) {
@@ -147,7 +147,9 @@ static void do_test(void)
 {
 	DIR *d;
 	struct dirent *ent;
-	int found = 0;
+	int devices = 0;
+
+	tst_sysfs_cnt_reset();
 
 	if (!tst_sysfs_exists(PATH_CLASS_HWMON))
 		tst_brk(TCONF, PATH_CLASS_HWMON ": not present");
@@ -158,14 +160,25 @@ static void do_test(void)
 		if (strncmp(ent->d_name, "hwmon", 5))
 			continue;
 
-		found = 1;
+		devices++;
 		check_hwmon_device(ent->d_name);
 	}
 
 	SAFE_CLOSEDIR(d);
 
-	if (!found)
+	if (!devices) {
 		tst_res(TCONF, "No hwmon device found");
+		return;
+	}
+
+	if (!tst_sysfs_cnt_get()) {
+		tst_res(TCONF, "%d hwmon devices present, but no checkable attributes",
+				devices);
+		return;
+	}
+
+	tst_res(TPASS, "Validated %u attributes on %d hwmon devices",
+			tst_sysfs_cnt_get(), devices);
 }
 
 static struct tst_test test = {
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
