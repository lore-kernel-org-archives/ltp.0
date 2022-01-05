Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E03C433EF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 09:23:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 460E63C9116
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 10:23:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CA2C3C0F5C
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 10:23:27 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 36C071A00CC6
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 10:23:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641374605; i=@fujitsu.com;
 bh=4EBT+EnjU2VC1WeVPNr+hLMZtGgVOXaDqvebl8t+zkM=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=yx9jFAXt7XWYZjwuNy7e1d96LT4cfqFNBTyzJKRR5sOtxMFDj5yOlZS5B1ifoKH0o
 5p8iCbz5I4EJqKz4PpRpbQjgf7XNAS4K7OlTlQ1GkvVpdzArWiNRNa6QW2VKQGVdVp
 O+MvIXxZb9JYmVqHMk/gWEtnR627sqX0LTR2k2tWucnMjm+9cP+EPUpfJVwTVVYG0S
 6Xg8b5Dwc9hnC9wLL9ZCSrlnDlqZRjWZesJQS8pe6tK8+Vb2QFY8bLSbN9mP61auAq
 rcm7Nd6YSb3reN1hfL072GTYMD5Xmcd+eto+nXxeLpbKxm2eT1a0OQSvPfJjyoCM8t
 hzprJT7hS5eAQ==
Received: from [100.115.37.206] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id 13/2B-27579-D8365D16;
 Wed, 05 Jan 2022 09:23:25 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRWlGSWpSXmKPExsViZ8ORqNuTfDX
 RYGejqcWK7zsYHRg99v1exxrAGMWamZeUX5HAmtG05y1LwV32iosHtjA2MJ5m62Lk4hASOMso
 sbR7CTuEs5NJ4ufGNUwQzm5GiaPfuoDKODnYBDQlnnUuYAaxRQQkJDoa3rKD2MwC6hLLJ/1iA
 rGFBdwk/lw6AGazCKhI/FjUzNLFyMHBK+Ah8f1VLkhYQkBBYsrD92BjeAUEJU7OfMICMUZC4u
 CLF8wQNYoSlzq+MULYFRKzZrUxQdhqElfPbWKewMg/C0n7LCTtCxiZVjFaJRVlpmeU5CZm5ug
 aGhjoGhqa6hpb6loY6SVW6SbqpZbqlqcWl+gCueXFeqnFxXrFlbnJOSl6eaklmxiBQZlSrB60
 g/Hbip96hxglOZiURHlbVa4mCvEl5adUZiQWZ8QXleakFh9ilOHgUJLglU8CygkWpaanVqRl5
 gAjBCYtwcGjJMIrCowSId7igsTc4sx0iNQpRkUpcd61IH0CIImM0jy4NlhUXmKUlRLmZWRgYB
 DiKUgtys0sQZV/xSjOwagkzLsOZApPZl4J3PRXQIuZgBafk7sMsrgkESEl1cA0wf5Jp/r8thD
 NFWezBO6+ZHh12+TR+jvZCzLUvDUEVR98ec689snrG59TGRRfbNgkVOKsmVbRpOmS+6JXlekj
 k+5WFqtaDuPNSW8b9awybO6cmf5tTeTy90FmxTFpc2dL/fL+75dRv9hz+/NpoYmKwW0zy6ecY
 Kw0OrZEiv1JhOoPWdNHoaarcjOitv2siVVz/PZe3n/R+cfT/Lw1Mg5zrxGeo8wnZ2Z6NjWwyu
 9zya1j/s91c7xYZ5sbW8UKHMjv9F2RrpW+7S3fzWtnPzl3bhPTd/3nuiF8o88ix33h4rnl7Ow
 3bSV4eD7ulI1pvs9nFf3JI+7T2tVPEjIuZ1zp1PB5FBb06FSFfdj/XCWW4oxEQy3mouJEAKI0
 rbpFAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-571.messagelabs.com!1641374604!10941!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25241 invoked from network); 5 Jan 2022 09:23:24 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-12.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 5 Jan 2022 09:23:24 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 7C160100189
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 09:23:24 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 6FFB7100184
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 09:23:24 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 5 Jan 2022 09:23:02 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 5 Jan 2022 17:23:29 +0800
Message-ID: <1641374609-2143-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/tst_test.c: adjust the tst_kconfig_check position
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

Since tst_kconfig_check is front of parse_opts, then running
test_kconfig01 -h can not get the print_help info.

Fix this by moving tst_kconfig_check behind parse_opts.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 lib/tst_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 23fc0ebf4..9fea7263a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1016,9 +1016,6 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->tconf_msg)
 		tst_brk(TCONF, "%s", tst_test->tconf_msg);
 
-	if (tst_test->needs_kconfigs)
-		tst_kconfig_check(tst_test->needs_kconfigs);
-
 	assert_test_fn();
 
 	TCID = tid = get_tid(argv);
@@ -1028,6 +1025,9 @@ static void do_setup(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
+	if (tst_test->needs_kconfigs)
+		tst_kconfig_check(tst_test->needs_kconfigs);
+
 	if (tst_test->needs_root && geteuid() != 0)
 		tst_brk(TCONF, "Test needs to be run as root");
 
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
