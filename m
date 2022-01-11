Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD67CC433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 06:10:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6342C3C93EA
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 07:10:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA8B43C93BA
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:10:22 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E233E200AEC
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:10:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641881420; i=@fujitsu.com;
 bh=pTByLWGSRiGA6Is5CSTFhMm9nGMJlYR8i5XujztQYTE=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=HJawqX+QaRtNBzdv2QfWg/kTwXGC6kGfV1szc3sZJNB1sILZMSDFG3t+MKabbiZuW
 BbcvTrSWMySx/eXQTnXnbfibVhccj/zzOX8rGiulXC8gX75JPeUbV/ODHek1q9V0yX
 l+dGn9WU7xgA8ZVXJxoUgSY7SbhQKuOFKBGReWKroTFgH0Jlv4EnDXMw7aNQEIfN6I
 pDU7oBLEzsJB+EV5odUZ4OqDYRRw59w1//vGKjijTUF7mfmZ4JvM2vwzoSgnTSs8I6
 6azQLvCMQhHi01H1CA+OPVahi09glLDoLrhBX5CLCVHixNyyxUAhgV8EUTFStR/eV8
 PwFxjrQqPBYHQ==
Received: from [100.115.1.129] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-1.aws.ess.symcld.net id C1/D2-11340-C4F1DD16;
 Tue, 11 Jan 2022 06:10:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRWlGSWpSXmKPExsViZ8MxSddH/m6
 iweOtqhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa0brv33MBdN5K6Yvvs7WwLiYu4uRi0NI4Cyj
 RPOcdywQzk4miasPHrFCOHsYJZbeX8fexcjJwSagKfGscwEziC0iICHR0fAWLM4soC6xfNIvJ
 hBbWMBR4tX6DUA2BweLgKrEn5f2IGFeAQ+JT9f/sYDYEgIKElMevgcbwyngKdF7aiIbiC0kkC
 gx/8BzJoh6QYmTM5+wQIyXkDj44gUzRK+ixKWOb4wQdoXErFltTBC2msTVc5uYJzAKzkLSPgt
 J+wJGplWMFklFmekZJbmJmTm6hgYGuoaGprqGukZ6iVW6iXqppbrlqcUluoZ6ieXFeqnFxXrF
 lbnJOSl6eaklmxiBAZxSzMi0g3FZ30+9Q4ySHExKory1kncThfiS8lMqMxKLM+KLSnNSiw8xy
 nBwKEnwzpAFygkWpaanVqRl5gCjCSYtwcGjJMKrJQ2U5i0uSMwtzkyHSJ1i1OVoebRkEbMQS1
 5+XqqUOO9nQaAiAZCijNI8uBGwyL7EKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZh3ohzQFJ7
 MvBK4Ta+AjmACOiKZ4zbIESWJCCmpBiaG8i2t/V+k78nYGU7QjuBh0rqxX7BS9ge72XXHP1ms
 SkIqXlaT2E1vBy0oENO239o8263W8N3kd6csTy19fWKO9PXPpRwPXrJsP+R/R2GNjLVQjr+xg
 HSr1ffYjJDzItwqM65Whs2b9mTJtM2R/zk5RfLlPA9YLTufW6y97Jlq5N2JoeJft36udj32JO
 lE1TLvRzYcZzPvnmT5cfPFO2+lw5tuH9XYkjk/Rfv8zScfr0+XurLKYfKHn+uWTV1tf2f7h2U
 q+yX9z+psZm38pjFBNO3hbp0CifXvX55abWPpI3lC+n990pWLc6ZM450gt9+6ZpasUOmutdkF
 yzcZbL/jdY6XZ4JH0Zv5C9YaOPwzVmIpzkg01GIuKk4EALioaD1nAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-585.messagelabs.com!1641881420!49528!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7978 invoked from network); 11 Jan 2022 06:10:20 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-13.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 11 Jan 2022 06:10:20 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id DB87B10044F
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:10:19 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 71229100456
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:10:19 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 06:10:16 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 11 Jan 2022 14:10:34 +0800
Message-ID: <1641881435-2351-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/5] sysctl/sysctl02.sh: Use kconfig shell api
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

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/commands/sysctl/sysctl02.sh | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/testcases/commands/sysctl/sysctl02.sh b/testcases/commands/sysctl/sysctl02.sh
index 3964a9829..367cd5743 100755
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
+	tst_check_kconfigs "CONFIG_KALLSYMS=y,CONFIG_KALLSYMS_ALL=y,CONFIG_KASAN=y" \
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
