Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE166C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 06:25:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AE163C938A
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 07:25:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B68CD3C6AFE
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 07:25:18 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AB65F1401231
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 07:25:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641795917; i=@fujitsu.com;
 bh=xXS6wnhzMNkJ5S6TNTJOlhvCNUOnWPB2QdM8ekNKy+o=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=RejUu09FtY3ytBA7N7VJ0afJhfNSjm0F4RJCFg5w/43gRqzHY2RHPD+R/NRDws0yi
 6ra/cph4H97xN3V1M8nGSTqEVDTR3UhCyZftTZ2dj3sA3eSf2qCX3kTodpj1e6yJjp
 KSf+n5JKo9bKR9ONJiJoYAMsQxzQAI4S+RIzw+2G4Aki8EintQHGH7vMPo0CwqhImk
 qkQuHddD2ME9YegLbAW2eUbkxXFT1SNuQi2dhwHCdwuzNYdUkNjxhXaSKu+pp9RQxT
 OU+bRzg6WqGQ5gIPWBCayOcMZGklbfDjjcKLx+WV0w/0bxmlmX1RXeVNSghcHKVaA5
 GtBx2WIPFZW9Q==
Received: from [100.115.65.216] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-central-1.aws.ess.symcld.net id E1/64-06990-C41DBD16;
 Mon, 10 Jan 2022 06:25:16 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRWlGSWpSXmKPExsViZ8ORqOtz8Xa
 iwY/pqhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8apnZeYCz7xVDyZu42pgbGBu4uRi0NI4Cyj
 xN+edewQzk4miYftt9kgnD2MEv+n/QHKcHKwCWhKPOtcwAxiiwhISHQ0vAWLMwuoSyyf9IsJx
 BYWcJRY9X0qWJxFQFXi2JxzjCA2r4CHxOvNELaEgILElIfvweZwCnhK3J43nQXEFhJIlHj7o5
 cZol5Q4uTMJywQ8yUkDr54wQzRqyhxqeMb1JwKiVmz2pggbDWJq+c2MU9gFJyFpH0WkvYFjEy
 rGO2SijLTM0pyEzNzdA0NDHQNDU11zQ11DY2N9RKrdBP1Ukt1k1PzSooSgdJ6ieXFeqnFxXrF
 lbnJOSl6eaklmxiB4ZxS7N66g/Fy30+9Q4ySHExKorz7zt9OFOJLyk+pzEgszogvKs1JLT7EK
 MPBoSTBq3cAKCdYlJqeWpGWmQOMLZi0BAePkghvxDmgNG9xQWJucWY6ROoUoy5Hy6Mli5iFWP
 Ly81KlxHmPg8wXACnKKM2DGwGL80uMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHkPg0zhycw
 rgdv0CugIJqAjkjnAjihJREhJNTBZvZHYe2DX1rLSzN+s0/7IyN6Ye/dsm9il4upJMx6yNc3N
 +HhXXZjHxdo2U138dMT7cJHu1rPrQla9WmNuKxu3Wo3j8e3cx+9/lDFeYbsYz7Huf82vel5G0
 69yk2p63RQeVtf0zJ9dc5vnsdf0o+d3XfruG5JxUTCys0NIav5Pnfzdzl5T21p6mN9yu5SION
 rsvNpltH7nxmnGF+7OM5RiSoj0nPdpx71XaRfVzFsbLr1b33m17naqUOyDI4X//RctfCpaZHn
 h/4uby4oX7H8zL7j4K9OusM+hl5tvLLj5we6W1ZEiT/kJWXvzT5q57f89cWP8XMMI6ZKZsSUP
 WrolWZxKlou2K/Of3Xwjt8JViaU4I9FQi7moOBEAGu32Im4DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-545.messagelabs.com!1641795916!225347!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9993 invoked from network); 10 Jan 2022 06:25:16 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-3.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 10 Jan 2022 06:25:16 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id D3EEF1001A8
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 06:25:15 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id BC7591001A5
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 06:25:15 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 10 Jan 2022 06:09:48 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 10 Jan 2022 09:49:09 +0800
Message-ID: <1641779349-8424-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YdbQmTJK73804UYT@yuki>
 <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/4] sysctl/sysctl02.sh: Use kconfig shell api
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
 testcases/commands/sysctl/sysctl02.sh | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/testcases/commands/sysctl/sysctl02.sh b/testcases/commands/sysctl/sysctl02.sh
index 3964a9829..1c444268a 100755
--- a/testcases/commands/sysctl/sysctl02.sh
+++ b/testcases/commands/sysctl/sysctl02.sh
@@ -20,15 +20,14 @@ TST_CLEANUP=cleanup
 TST_CNT=4
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="sysctl"
+TST_NEEDS_KCONFIGS="CONFIG_SYSCTL=y, CONFIG_PROC_FS=y"
 sys_name="fs.file-max"
 sys_file="/proc/sys/fs/file-max"
-syms_file="/proc/kallsyms"
 
 . tst_test.sh
 
 setup()
 {
-	[ ! -f "$sys_file" ] && tst_brk TCONF "$sys_file not enabled"
 	orig_value=$(cat "$sys_file")
 }
 
@@ -61,17 +60,15 @@ sysctl_test_overflow()
 
 sysctl_test_zero()
 {
-	[ ! -f "$syms_file" ] && tst_brk TCONF "$syms_file not enabled"
+	tst_check_kconfigs "CONFIG_KALLSYMS=y" "CONFIG_KALLSYMS_ALL=y" "CONFIG_KASAN=y" \
+		|| tst_brk TCONF "kconfig doesn't meet test's requirement!"
+
 	ROD sysctl -w -q $sys_name=0
 
-	if grep -q kasan_report $syms_file; then
-		if dmesg | grep -q "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax"; then
-			tst_res TFAIL "$sys_file is set 0 and trigger a KASAN error"
-		else
-			tst_res TPASS "$sys_file is set 0 and doesn't trigger a KASAN error"
-		fi
+	if dmesg | grep -q "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax"; then
+		tst_res TFAIL "$sys_file is set 0 and trigger a KASAN error"
 	else
-		tst_res TCONF "kernel doesn't support KASAN"
+		tst_res TPASS "$sys_file is set 0 and doesn't trigger a KASAN error"
 	fi
 }
 
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
