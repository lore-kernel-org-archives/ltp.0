Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A44AC678D5
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 06:10:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C52E23CD9D7
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 07:10:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AE723C27D9
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 07:10:11 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EC9BF200A06
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 07:10:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1678169409; i=@fujitsu.com;
 bh=YQgLdsv1l7TWNBL8HBlsRYiq3ypx7XcsPm2tzJNcuPQ=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=IW3ow2ibdNZZdNTURuxfJxT3x5Si6Y/GtZyGVIrfbJ07UUjqLyI49GOfzoVq/m4Mr
 TkvM4qHlQp6Ff0rpIzgCcuokDHNHERJPtaSjJ49+3lz6bXAnXHBJTtLXtRuVecpJbL
 U3zb4PxnSbyb1+Clf9/nkAMHlKCF5+c4X7ug1/Ui+cmyB3Kay20DoTUqR1YunNH4iS
 9x9WhENviji6nmteqqFCheSbcT8Uo1jXEP0OMkLrqLZYbjU0nqsJMIFK2URmnjldxx
 Y0Ci/dkkOpDbGEwkTKL2V1x5lEW9kUES/A36m6VfFqomepPbaSPR7dg+Im0jykIHJR
 hSui8h5pD71fQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRWlGSWpSXmKPExsViZ8ORqOtwlS3
 FYOdqGYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNeP8JpOCaRwV+79sZW9g7GTvYuTiEBI4yygx
 f+pUFgjnIJPE17/TWCGcvYwSJ67dAnI4OdgENCWedS5gBrFFBCQkOhresoPYzALqEssn/WLqY
 uTgEBbwl1h6wBvEZBFQkbhxzx7E5BXwkHhxRhekWEJAQWLKw/dgQzgFVCWOdWxiAbGFgKo7O6
 +ALeIVEJQ4OfMJC8RwCYmDL14wQ/QqSbS1QtRICFRKtH74xQJhq0lcPbeJeQKj4Cwk7bOQtC9
 gZFrFaFqcWlSWWqRrrJdUlJmeUZKbmJmjl1ilm6iXWqpbnlpcomuol1herJdaXKxXXJmbnJOi
 l5dasokRGLQpxcx9Oxi/9v7VO8QoycGkJMp7PZ8tRYgvKT+lMiOxOCO+qDQntfgQowwHh5IEr
 9NloJxgUWp6akVaZg4wgmDSEhw8SiK8T84CpXmLCxJzizPTIVKnGBWlxHlvg/QJgCQySvPg2m
 BRe4lRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO9XkCk8mXklcNNfAS1mAlp8YT8LyOKSRIS
 UVAOT9QuHi9VvHU51Tdh+piblu+u1p92Paw/Uq587NMWLp3wDQyNXU+etGHvXbTbu4ulc345l
 fZPWmXfT9uaRlCWttyLKWK25tM4tUUpbfd6g9q2a2aV2ieVvP92unmvTfaRDnvnhzOM9iVJim
 9al7jMyOBfW7ix+Y1eQfoWm7vafr18sXFszo93g52Lu7jU8bP+tGpy8Pm655PfGi13+zNb1dX
 sK9e+HtCcahj2e+493e5Df9sZ1KyRzJXIWX2Hlb/WOSpsm+1SKw/egR8iJ/SJ/zq6et7G559C
 JrpN7sy+ccnr50PWPyofr4hNqfzNEadh1lt34y3Qz4dZ5S9YJ02vs3r//ctzxmXSFb4OEY4qr
 EktxRqKhFnNRcSIAjaObSFUDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-591.messagelabs.com!1678169408!333020!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.103.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25650 invoked from network); 7 Mar 2023 06:10:08 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-14.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 7 Mar 2023 06:10:08 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 1617510018D
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 06:10:08 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 099F3100043
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 06:10:08 +0000 (GMT)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 7 Mar 2023 06:10:06 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 7 Mar 2023 14:09:55 +0800
Message-ID: <1678169395-4584-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <87bkl67xxa.fsf@suse.de>
References: <87bkl67xxa.fsf@suse.de>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] containers/utsname04: don't use TST_EXP_EQ_LI for
 tst_clone
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

For old kernel(below 5.3) that doesn't support clone3, tst_clone returns
-2 instead of -1. So we can't use TST_EXP_EQ_LI api.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/containers/utsname/utsname04.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/utsname/utsname04.c b/testcases/kernel/containers/utsname/utsname04.c
index e8d636d0d..61cc066d8 100644
--- a/testcases/kernel/containers/utsname/utsname04.c
+++ b/testcases/kernel/containers/utsname/utsname04.c
@@ -29,7 +29,13 @@ static void run(void)
 	SAFE_SETRESUID(pw->pw_uid, pw->pw_uid, pw->pw_uid);
 
 	if (!str_op || !strcmp(str_op, "clone")) {
-		TST_EXP_EQ_LI(tst_clone(&cargs), -1);
+		TEST(tst_clone(&cargs));
+		if (TST_RET == -1)
+			tst_res(TPASS, "clone3() fails as expected");
+		else if (TST_RET == -2)
+			tst_res(TPASS, "clone() fails as expected");
+		else
+			tst_res(TFAIL, "tst_clone returns %ld", TST_RET);
 		TST_EXP_PASS(errno == EPERM);
 	} else {
 		if (!SAFE_FORK()) {
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
