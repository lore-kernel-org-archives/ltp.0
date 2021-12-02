Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A091C433EF
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 01:59:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EE6F3C8F3B
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 02:59:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 943123C6529
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 02:59:09 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 67BE2200085
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 02:59:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638410347; i=@fujitsu.com;
 bh=0i/3LerwgMwuoYOofhiL4vV4PRllxku6YcwBhnO2n2Y=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=MMfSUk0lBjAjxWa8+wvNavAjallDqDjK7i1s+eGpFV1U5vOyZQtw6w6eiULO1eo5d
 YYmXmbr0LeJJ/d26Vm/fQVL7MCD5/XGCCiPSgbKnxI7+DEZ93YfxxVnxMpEw8AHUd0
 Grt3y0pXyuzkUG9/RJiudZ1/b79iAZ716qH9B6b0MeCRaEIw3Gp05MM5p3bkl7+VpG
 Z3XQ8dlN1/ApWncdnpFieMjkqnIU3DqpOj6Qotmt5PFKuEkOqdBjquKo1sjhOPWl6O
 anuYiAAUBnstxBUlfsZJLZKgaEQEaYT7PpsJVLqBv7lpGJRqoRYnRimWgnTePD/TDM
 YoldMDFkHW0wQ==
Received: from [100.113.7.129] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 08/BD-32390-A6828A16;
 Thu, 02 Dec 2021 01:59:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRWlGSWpSXmKPExsViZ8ORqJulsSL
 R4N8vEYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNePdnX3MBUs0Ki68+8PewLhQsYuRi0NI4Cyj
 RMPThcwQzk4mieaVq1khnN2MEhNuzAfKcHKwCWhKPOtcAGaLCEhIdDS8ZQexmQXUJZZP+sUEY
 gsL2Ess3b8KzGYRUJH49GMqC4jNK+AhMedqK1i9hICCxJSH75kh4oISJ2c+YYGYIyFx8MULZo
 gaRYlLHd8YIewKiVmz2pggbDWJq+c2MU9g5J+FpH0WkvYFjEyrGC2SijLTM0pyEzNzdA0NDHQ
 NDY11zXQtzPUSq3ST9FJLdZNT80qKEoGSeonlxXrFlbnJOSl6eaklmxiBIZlSyBa+g/HM6w96
 hxglOZiURHlfsaxIFOJLyk+pzEgszogvKs1JLT7EKMPBoSTB668GlBMsSk1PrUjLzAHGB0xag
 oNHSYS3TxUozVtckJhbnJkOkTrFqCglzlsO0icAksgozYNrg8XkJUZZKWFeRgYGBiGegtSi3M
 wSVPlXjOIcjErCvH9ApvBk5pXATX8FtJgJaPHhWctBFpckIqSkGpjqtzU0X5kU1HCN63uQzVH
 r6tcLfnVZPn65+arjD2b+/otaqe+vvFfdkX5r6SM1xxmyN82iZ/16zvvzLNtGTUfOA2+Pzcqe
 N09WMqh1R6RyU93r1bL/mDZsNDIGJrHF7wqy66fx3Jju9eTn7y+XmK4ev9jLoBudfKtpUmzYf
 9GJt3War8y6yXiv6MADr1C/qyxPWEUFnykVz24ONr5v9iJ56s32dquemHMcW3xdH6pOLZ9bmr
 Z606+9C47OlS/mqv5ynC9/QXUK/9HQTM6Hs0wP7PSRaVP/c0Et6fvlc30TxL5ebOyoPfE0frZ
 nuOy8jYFuUVxvgy9Kf7ruFDTD/522844Iwbllf8xnPNnnX12jxFKckWioxVxUnAgA3MFDSEQD
 AAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-245.messagelabs.com!1638410346!289839!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1698 invoked from network); 2 Dec 2021 01:59:06 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-4.tower-245.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 2 Dec 2021 01:59:06 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id D5E5D1009E5
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 01:59:05 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id CA9DF100252
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 01:59:05 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 2 Dec 2021 01:58:44 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 2 Dec 2021 09:58:53 +0800
Message-ID: <1638410334-2279-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED 1/2] syscalls/shmctl: make make check happy
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c |  8 ++++----
 testcases/kernel/syscalls/ipc/shmctl/shmctl03.c |  3 +--
 testcases/kernel/syscalls/ipc/shmctl/shmctl04.c | 13 +++++++------
 testcases/kernel/syscalls/ipc/shmctl/shmctl08.c |  6 +++---
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index 789fc8c72..e631b7b21 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -118,7 +118,7 @@ static void check_nattch(int exp_nattch, const char *msg)
 	}
 
 	tst_res(TFAIL, "%s shm_nattcg=%li expected %i",
-	        msg, (long)ds1.shm_nattch, exp_nattch);
+		msg, (long)ds1.shm_nattch, exp_nattch);
 }
 
 static void verify_shmstat_attach(void)
@@ -170,14 +170,14 @@ static void check_ds(struct shmid_ds *ds, const char *desc)
 
 	if (ds->shm_segsz != SHM_SIZE) {
 		tst_res(TFAIL, "%s: shm_segsz=%zu, expected %i",
-		        desc, ds->shm_segsz, SHM_SIZE);
+			desc, ds->shm_segsz, SHM_SIZE);
 	} else {
 		tst_res(TPASS, "%s: shm_segsz=%i", desc, SHM_SIZE);
 	}
 
 	if (ds->shm_cpid != pid) {
 		tst_res(TFAIL, "%s: shm_cpid=%i, expected %i",
-		        desc, ds->shm_cpid, pid);
+			desc, ds->shm_cpid, pid);
 	} else {
 		tst_res(TPASS, "%s: shm_cpid=%i", desc, pid);
 	}
@@ -232,7 +232,7 @@ static int get_shm_idx_from_id(int shm_id)
 	struct shmid_ds dummy_ds;
 	int max_idx, i;
 
-	max_idx = SAFE_SHMCTL(shm_id, SHM_INFO, (void*)&dummy);
+	max_idx = SAFE_SHMCTL(shm_id, SHM_INFO, (void *)&dummy);
 
 	for (i = 0; i <= max_idx; i++) {
 		if (shmctl(i, SHM_STAT, &dummy_ds) == shm_id)
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
index 0f700a9bd..199ee4105 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
@@ -23,8 +23,7 @@ static void verify_ipcinfo(void)
 
 	if (TST_RET < 0) {
 		tst_res(TFAIL | TTERRNO,
-		        "shmctl(0, IPC_INFO, ...) returned %li",
-		        TST_RET);
+			"shmctl(0, IPC_INFO, ...) returned %li", TST_RET);
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index 724610ef0..b244026ce 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -69,7 +69,7 @@ static void parse_proc_sysvipc(struct shm_info *info)
 	 * size.
 	 */
 	while (fscanf(f, "%*i %i %*i %i %*i %*i %*i %*i %*i %*i %*i %*i %*i %*i %i %i",
-	              &shmid, &size, &rss, &swap) > 0) {
+			&shmid, &size, &rss, &swap) > 0) {
 		used_ids++;
 		shm_rss += rss/page_size;
 		shm_swp += swap/page_size;
@@ -80,28 +80,28 @@ static void parse_proc_sysvipc(struct shm_info *info)
 
 	if (info->used_ids != used_ids) {
 		tst_res(TFAIL, "used_ids = %i, expected %i",
-		        info->used_ids, used_ids);
+			info->used_ids, used_ids);
 	} else {
 		tst_res(TPASS, "used_ids = %i", used_ids);
 	}
 
 	if (info->shm_rss != shm_rss) {
 		tst_res(TFAIL, "shm_rss = %li, expected %li",
-		        info->shm_rss, shm_rss);
+			info->shm_rss, shm_rss);
 	} else {
 		tst_res(TPASS, "shm_rss = %li", shm_rss);
 	}
 
 	if (info->shm_swp != shm_swp) {
 		tst_res(TFAIL, "shm_swp = %li, expected %li",
-		        info->shm_swp, shm_swp);
+			info->shm_swp, shm_swp);
 	} else {
 		tst_res(TPASS, "shm_swp = %li", shm_swp);
 	}
 
 	if (info->shm_tot != shm_tot) {
 		tst_res(TFAIL, "shm_tot = %li, expected %li",
-		        info->shm_tot, shm_tot);
+			info->shm_tot, shm_tot);
 	} else {
 		tst_res(TPASS, "shm_tot = %li", shm_tot);
 	}
@@ -146,7 +146,7 @@ static void verify_shminfo(unsigned int n)
 		tst_res(TPASS, "Counted used = %i", cnt);
 	} else {
 		tst_res(TFAIL, "Counted used = %i, used_ids = %i",
-		        cnt, info.used_ids);
+			cnt, info.used_ids);
 	}
 
 	parse_proc_sysvipc(&info);
@@ -156,6 +156,7 @@ static void setup(void)
 {
 	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
 	struct shmid_ds temp_ds;
+
 	nobody_uid = ltpuser->pw_uid;
 	root_uid = 0;
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
index 88fcfe41f..bb2abca4c 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
@@ -44,7 +44,7 @@ static void check_mode(struct shmid_ds *ds, short exp_mode)
 	}
 
 	tst_res(TFAIL, "shm_perm.mode=%04o, expected %i",
-	        ds->shm_perm.mode, exp_mode);
+		ds->shm_perm.mode, exp_mode);
 }
 
 static void verify_shmset(void)
@@ -73,10 +73,10 @@ static void verify_shmset(void)
 
 	if (ds.shm_ctime <= old_ctime || ds.shm_ctime > old_ctime + 10) {
 		tst_res(TFAIL, "shm_ctime not updated old %li new %li",
-		        (long)old_ctime, (long)ds.shm_ctime);
+			(long)old_ctime, (long)ds.shm_ctime);
 	} else {
 		tst_res(TPASS, "shm_ctime updated correctly diff=%li",
-		        (long)(ds.shm_ctime - old_ctime));
+			(long)(ds.shm_ctime - old_ctime));
 	}
 
 	ds.shm_perm.mode = old_mode;
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
