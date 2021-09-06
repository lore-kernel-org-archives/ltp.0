Return-Path: <SRS0=3a48=N4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A70C433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 03:13:11 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5211160F3A
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 03:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5211160F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0B123C980D
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 05:13:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B4E83C2BB5
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 05:12:57 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0CF2F1400330
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 05:12:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1630897975; i=@fujitsu.com;
 bh=h6dG/GqYTVm0An5CG1+DmugLS4iMJluAi7LqG+tcJWE=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=aeNRMFHhFs6Tg6ZUKtYs6frLC2fBDOSjyQTgfTHeNVQFKWdpW6h6FaWqMTfsC2Quo
 ajHj3N8YShqe119+zkcweXRWgaLjhsLJDQJhsMIMrtJLnZnZTWz2AqfThrxYDb1edY
 Tsv4Sxnby6efEo8eMurVOZVMphikRv/CVTOr+IqwF50XkOJSE8V3x76lzbSS+dAnwR
 o/QAkt9Gix7Stw0edzKr0y7rAgXHPFbD7J3JRQdV6JQ3hRg1eQV75PBf14/b32W30d
 +NHrZYIixWXU+aGM4mrRf/5oxrfKZPZCtaZX5GQLGo7CKbayCpzwLqHLcY8rw+Xrqb
 bDlfeVHIX4Rfg==
Received: from [100.113.2.146] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-central-1.aws.symcld.net id DC/0B-29868-73785316;
 Mon, 06 Sep 2021 03:12:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRWlGSWpSXmKPExsViZ8MxVdes3TT
 RYPcZQ4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNeP7wjXMBW2sFY3nljE2MK5n6WLk4hASaGaS
 aO95xw7h7GaUeP9hC3MXIycHm4CmxLPOBWC2iICEREfDW3YQm1lAXWL5pF9MILawgLHEnc7tj
 CA2i4CKxKS+C0A2BwevgIfExxPVIGEJAQWJKQ/fg43hFRCUODnzCQvEGAmJgy9eMEPUKEpc6v
 jGCGFXSMya1cY0gZF3FpKWWUhaFjAyrWK0TCrKTM8oyU3MzNE1NDDQNTQ01jXUNTIy00us0k3
 USy3VTU7NKylKBMrqJZYX6xVX5ibnpOjlpZZsYgQGWEoh46MdjKdff9A7xCjJwaQkyqthZ5oo
 xJeUn1KZkVicEV9UmpNafIhRhoNDSYLXvgUoJ1iUmp5akZaZAwx2mLQEB4+SCO+aRqA0b3FBY
 m5xZjpE6hSjopQ479JWoIQASCKjNA+uDRZhlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ85
 q0AU3hycwrgZv+CmgxE9DitocmIItLEhFSUg1MKxq3SWjIblX8cPP8uaetT7dHTLhYn5kw4Yu
 dwQZB7b+dOQlGpVxa3AnLOPwvPQt75/9Xt3Dq9xRF83Cj7I0Pa84XtRgXyN5YnhSXYtW4fZl1
 rchq8dN3y7KtTj48LXX7gKh8mKHf/pk7te9t4wpw/sq46MVDNx6J7TP255jZvnm1skgmc23GP
 Mmmqw+DDF+s/Otw49sLz/P7uZ4/9vFhlrn8ap/+1+8s13j1/wtM3P397XrxU+V/T63m0kib0S
 3v3LXqnVnaTofmKbJn7ypar+IpyD0jcmnlx4++YYprKpgXmyyLmHdXymOibZj8S+Y+m47VS99
 e7rm4w/bet4BZL4ujoyPfu6r/2Opq+S9TVomlOCPRUIu5qDgRAE4TogkrAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-232.messagelabs.com!1630897974!237652!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3569 invoked from network); 6 Sep 2021 03:12:54 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
 by server-8.tower-232.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 6 Sep 2021 03:12:54 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1863CnMn023210
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Mon, 6 Sep 2021 04:12:54 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 6 Sep 2021 04:12:47 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 6 Sep 2021 11:12:38 +0800
Message-ID: <1630897958-2160-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] runtest/cve: Fix wrong cve tag
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
Message-ID: <20210906031238.qDttJVRHhb8UwsbYtOB2mgLJsAGXwpFUsJlGNHqXesQ@z>

can_bcm01 is designed to test cve-2021-3609 instead of cve-2021-6309.

Fixes: 027ea6171c40 ("Add test for CVE 2021-3609")
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/cve | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/cve b/runtest/cve
index 357b88feb..01211b5aa 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -67,7 +67,7 @@ cve-2020-14416 pty03
 cve-2020-25705 icmp_rate_limit01
 cve-2020-29373 io_uring02
 cve-2021-3444 bpf_prog05
-cve-2021-6309 can_bcm01
+cve-2021-3609 can_bcm01
 cve-2021-22555 setsockopt08 -i 100
 cve-2021-26708 vsock01
 # Tests below may cause kernel memory leak
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
