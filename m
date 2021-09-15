Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6879C433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 09:50:46 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC6860724
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 09:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EDC6860724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40E3E3C8998
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 11:50:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D02553C1DF7
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 11:50:32 +0200 (CEST)
Received: from mail3.bemta25.messagelabs.com (mail3.bemta25.messagelabs.com
 [195.245.230.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 129A1600277
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 11:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1631699430; i=@fujitsu.com;
 bh=61EXlDU43GLwLHI+xBjnLwllM4PpH8qdWniReKppMTw=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=W4ddIMe4cOA0cv/0UvohhMCr1RTl5zZvjPVrIP21rH/E62bl8yIqXVyuzFuUSsgHz
 JzaG0xDwnVPdJ3cTSNmHYpRfR2R7SkozTwSzPbdJI7PlQjAAMZgmN7yIiMgrQYqlA8
 5JkPk8b2HBLVaioF46Qk29iKVN2eJ7o7dLxEnYfKDjaSGCcWh2cLxjMPtb/YHv7EK5
 sWlQzHgWFEl+AZn7ayS3wVnUHK1neBr0RSeV+HSOlPDGIm7sBCgxRsxTzGAgspy5Gi
 0/JKZyWkkNsvdRsLnkqBD3i0reKDin0pqADHyg4WWbAv7o9S+QKcjORDInFh2XYCwV
 +xXlRCqgL9dpQ==
Received: from [100.112.196.248] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 6D/C3-25352-5E1C1416;
 Wed, 15 Sep 2021 09:50:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRWlGSWpSXmKPExsViZ8MxRffpQcd
 Egw8dMhYrvu9gtPhx6waLA5PHvt/rWD3OLDjCHsAUxZqZl5RfkcCa8erpL7aCCcIVr772sTcw
 9gt2MXJxCAm8ZpRY8mkSI4Szn1Hi/NY9rF2MnBxsAhoS1x63M4PYIgISEh0Nb9lBbGYBC4lld
 /8zgdjCAq4SP28eYgOxWQRUJRp2PASyOTh4BdwkJuzOAQlLCChITHn4HmwMr4CgxMmZT1ggxk
 hIHHzxghmiRlFi/96NjBB2hcSMGdvYJjDyzkLSMgtJywJGplWMFklFmekZJbmJmTm6hgYGuoa
 GRrqGlha6hhZmeolVukl6qaW65anFJbqGeonlxXrFlbnJOSl6eaklmxiBIZdScGzXDsa3rz/o
 HWKU5GBSEuXNXuyYKMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCd+Y+oJxgUWp6akVaZg4w/GHSE
 hw8SiK8pw8ApXmLCxJzizPTIVKnGBWlxHmTQfoEQBIZpXlwbbCYu8QoKyXMy8jAwCDEU5BalJ
 tZgir/ilGcg1FJmFcCGMFCPJl5JXDTXwEtZgJafGS/A8jikkSElFQD04USi5VMurUPy6P2bn5
 0cWVd0aL3WmEhHfHnp6gYcS406Jp0UPu7/949U48cjRS0qLZJPFpSd2TB1w3GP45rNhziEc9J
 +WWU8dbjtjc/vziXwbcP/94e/sGWu0qB0+vA4t3b333wnLx6wuruvLitOfcUwgvirYvUrq4Pz
 LBy9qr13Vww6/TqmC3/l2b6nLzleURTao76Dq6uuh8anq9/Vn7ecUz67pbCdKtLPw7bzbBap6
 ZXvcXkdU253z/T1c911Lfv3KZsWLm/SaU65HUG/8HA9M7tvzwOTCk4+jZTefWF65lf/M6tL32
 7dP+8Tb75m5nnFTltP800uTjL/OrVqzncmhnuuQ9viDLrTd3pGaHEUpyRaKjFXFScCAADpPAt
 NAMAAA==
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-5.tower-285.messagelabs.com!1631699429!74627!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12545 invoked from network); 15 Sep 2021 09:50:29 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-5.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 15 Sep 2021 09:50:29 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 18F9oEsj027346
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
 Wed, 15 Sep 2021 10:50:21 +0100
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 15 Sep 2021 10:50:12 +0100
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 15 Sep 2021 05:50:02 -0400
Message-ID: <1631699402-17607-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] controllers/cpuacct: Fix deleting directories errors
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
Message-ID: <20210915095002.61tenhw3trfmRjcNxW6qjMYebYrCuYZBTyBXcKGeSyo@z>

To remove a directory hierarchy on a normal file system you can use rm command to
remove all files from each subdirectory and then remove the parent directories.
But a cgroup which doesn't have any children and is associated only with zombie processes
is considered empty and can not be removed by rm.
The following errors will be reported.

cpuacct 1 TINFO: removing created directories
rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cgroup.procs': Operation not permitted
rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpu.cfs_period_us': Operation not permitted
rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpu.stat': Operation not permitted
rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpuacct.usage_percpu_sys': Operation not permitted
rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpu.shares': Operation not permitted
rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpuacct.usage_percpu': Operation not permitted
rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpuacct.stat': Operation not permitted
rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpuacct.usage': Operation not permitted
rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/subgroup_1/cgroup.procs': Operation not permitted
rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/subgroup_1/cpu.cfs_period_us': Operation not permitted
rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/subgroup_1/cpu.stat': Operation not permitted
...

It's recommended to use rmdir command.

[1] http://blog.tinola.com/?e=21
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/cgroup-v2.rst#n237

Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 testcases/kernel/controllers/cpuacct/cpuacct.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index 99258c2..f526d0f 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -122,7 +122,10 @@ cleanup()
 
 	if [ "$testpath" ]; then
 		tst_res TINFO "removing created directories"
-		rm -rf $testpath
+		if [ -d "$testpath/subgroup_1" ]; then
+			rmdir $testpath/subgroup_*
+		fi
+			rmdir $testpath
 	fi
 
 	if [ "$mounted" -ne 1 ]; then
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
