Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C1DC433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 08:08:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 336A53C23EA
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 09:08:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7734B3C21F1
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 09:08:21 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DD7C8600CEE
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 09:08:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638864500; i=@fujitsu.com;
 bh=Xxk8w2mR+TdootXMvFz2VQBBXwbOmfXc3pSGWWNClls=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=gvI5kXjpA8ZCtrkIt16T3WAWMr+d3dcWPMgIyaB13E0uyyIaSKbK5MshgIM/UiA2R
 QDKlG9/nLrwpdnAUQK///2sLy7vsLzEEXF9w8TQePHCwte4ncxC6fJdG+VV+AuReMW
 SHRZ3eMoyFcpotLvq3Q7FRinxKiLEaZKJmNih6j5Rmxj+7tWpx+MuWd1/F1EvSzT63
 z3hv77QdjUaJ98h6jMNYDg7eLcHgeSL/AkbaTZkhC2VNJBnLNH4vrD5WF7/OcVB9eJ
 suMYp5V9qjSVJF6oytsija2MCK/KnvdIchf0Jxh/tQ/NRj2jPOWTWpAkeMZtHbCjZv
 Z/X1IUHOedQ5Q==
Received: from [100.115.64.32] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-central-1.aws.ess.symcld.net id 8A/E8-24146-4761FA16;
 Tue, 07 Dec 2021 08:08:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRWlGSWpSXmKPExsViZ8ORqJsvtj7
 R4MBTM4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNePHkelsBZeEK952HGBpYLwg0MXIxSEkcJZR
 4suMmywQzk4miQ3LDrFDOLsZJdZ+vgeU4eRgE9CUeNa5gBnEFhGQkOhoeMsOYjMLqEssn/SLC
 cQWFnCV2NayFayeRUBF4uuaU0BxDg5eAQ+JPXuFQMISAgoSUx6+BxvDKeAp0XSiixHEFhJIlF
 hzfAsriM0rIChxcuYTFojxEhIHX7xghuhVlLjU8Y0Rwq6QmDWrjQnCVpO4em4T8wRGwVlI2mc
 haV/AyLSK0TapKDM9oyQ3MTNH19DAQNfQ0FTXzAJI6SVW6SbqpZbqJqfmlRQlAmX1EsuL9VKL
 i/WKK3OTc1L08lJLNjECQzml2IV7B+Odvp96hxglOZiURHlnCKxPFOJLyk+pzEgszogvKs1JL
 T7EKMPBoSTBqy4ClBMsSk1PrUjLzAHGFUxagoNHSYT3JEiat7ggMbc4Mx0idYpRUUqcNxAkIQ
 CSyCjNg2uDxfIlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8uqJAU3gy80rgpr8CWswEtDi
 mfzXI4pJEhJRUA9M8VhaVy1LdNyZceO581STK9kCN8v1q0aMRcn/7AqwyS92+7MjhjhJc3NDx
 W6zziJIla8Kih3NeLOJSqp+6njeZ68nqTfkbaua+W7zpwAKLsIW5x088Ed526MORWYVPYipuz
 VNLF5y37oYcw/dtaQ48067e44nfL/1chpXtu+5Lzj4JrvMFG+LcT7xVkbpsHMRV/mG3FWe1R7
 yPGcf26Ktqn98ERPFUz37S8+SI81nuTe6vcs/dPhPR/2xa5KqsizuyrPcerbv4eJFUhz67eUd
 8ncfDS7NK+wtf7zz3JaxJ/o3e5/17ly7MmJS5Q7Kw/ErgvrZTc7X3nSn/o/zk05+00sVm83JK
 g245PLXoyJZXYinOSDTUYi4qTgQAcrX/S2ADAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-545.messagelabs.com!1638864495!28488!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30915 invoked from network); 7 Dec 2021 08:08:15 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-3.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 7 Dec 2021 08:08:15 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 5C693100235
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 08:08:15 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 51774100227
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 08:08:15 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 7 Dec 2021 08:07:53 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 7 Dec 2021 16:08:03 +0800
Message-ID: <1638864483-2446-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1638864483-2446-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <Ya4DeVrCa1X8IFjk@yuki>
 <1638864483-2446-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] testcase: make use of needs_cmd version check
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl04.c | 11 +----------
 testcases/kernel/syscalls/statx/statx05.c       | 13 ++-----------
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index dab61cf4d..62c94d596 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -121,18 +121,9 @@ static void do_mount(const char *source, const char *target,
 
 static void setup(void)
 {
-	FILE *f;
 	const char *const fs_opts[] = {"-I 256", "-O quota,project", NULL};
-	int rc, major, minor, patch;
 
 	test_id = geteuid();
-	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
-	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
-	if (rc != 3)
-		tst_res(TWARN, "Unable parse version number");
-	else if (major * 10000 + minor * 100 + patch < 14300)
-		tst_brk(TCONF, "Test needs mkfs.ext4 >= 1.43 for quota,project option, test skipped");
-	pclose(f);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
 	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
 }
@@ -184,7 +175,7 @@ static struct tst_test test = {
 	.dev_fs_type = "ext4",
 	.mntpoint = MNTPOINT,
 	.needs_cmds = (const char *[]) {
-		"mkfs.ext4",
+		"mkfs.ext4 >= 1.43.0",
 		NULL
 	}
 };
diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index 86bd3ace1..bdee98c22 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -87,18 +87,9 @@ static void run(unsigned int i)
 
 static void setup(void)
 {
-	FILE *f;
 	char opt_bsize[32];
 	const char *const fs_opts[] = {"-O encrypt", opt_bsize, NULL};
-	int ret, rc, major, minor, patch;
-
-	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
-	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
-	if (rc != 3)
-		tst_res(TWARN, "Unable parse version number");
-	else if (major * 10000 + minor * 100 + patch < 14300)
-		tst_brk(TCONF, "Test needs mkfs.ext4 >= 1.43 for encrypt option, test skipped");
-	pclose(f);
+	int ret;
 
 	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", getpagesize());
 
@@ -132,7 +123,7 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.dev_fs_type = "ext4",
 	.needs_cmds = (const char *[]) {
-		"mkfs.ext4",
+		"mkfs.ext4 >= 1.43.0",
 		"e4crypt",
 		NULL
 	}
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
