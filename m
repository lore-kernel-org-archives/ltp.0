Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EF6C4332F
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 06:16:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3791D3CBAC6
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 07:16:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 229663C6C93
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 07:16:00 +0100 (CET)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C7D6F2001AB
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 07:15:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1671430558; i=@fujitsu.com;
 bh=+kUalfNZfhX5xvR3MaGpwkOtr35YeFrK5rPeuo5pKl0=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=QAQbgfvpFCX/XsyKg4rhuLsl8YuBuMpqgqmJHtwKMxQTNNeeqfhKWML5YiOvLM4pw
 82GkvB6bs66qkjXkSm21Mzi/WbXGHzEGEdiWQt5Y/3uKRMn483E1evYE5Q0Hxzn6Np
 F0UIfCu93EwQy+uR8aTKHlj/SXj3zkSoj/Ts0g4wVLjexHxTcX5zV0XUSQs45GtQmu
 Ef3Vh7a1PBQ2QYtq5W3pQOff5iUHogJrPBXv17avLoWCLFnyWCGGugaLitv78oszvD
 PyPeGAy/2GsNhSBHHo+ENCTOv1yBZZVy9evwOgFc7jhhqOBYO11ur8XKnoMktfnz60
 U2tPbHU/jzfaQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRWlGSWpSXmKPExsViZ8ORqDuPcUG
 ywaIjHBaTDqdabN6zjsVixfcdjA7MHvt+r2P1eL/vKlsAUxRrZl5SfkUCa8at49eZC+ayVKzf
 eJC5gfEccxcjF4eQwBZGiee/XzF1MXICOcuZJNZ84oRI7GGU2H5oESNIgk1AU+JZ5wJmEFtEQ
 EKio+EtexcjBwezQIjEp9uOIGFhAWOJFefvg81hEVCVeL10L1g5r4CHxNaJHWBjJAQUJKY8fA
 8VF5Q4OfMJC4jNDDTy4IsXzBA1ihKXOr5B1VdIzJrVxgRhq0lcPbeJeQIj/ywk7bOQtC9gZFr
 FaF6cWlSWWqRraKqXVJSZnlGSm5iZo5dYpZuol1qqm5dfVJKha6iXWF6sl1pcrFdcmZuck6KX
 l1qyiREYqCnFCdw7GB8t+6N3iFGSg0lJlJfn3/xkIb6k/JTKjMTijPii0pzU4kOMMhwcShK8M
 34D5QSLUtNTK9Iyc4BRA5OW4OBREuH9/BcozVtckJhbnJkOkTrFqCglzlvFsCBZSAAkkVGaB9
 cGi9RLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5z4GM58nMK4Gb/gpoMRPQ4kOX5oIsLkl
 ESEk1MK3/e3hXZlttP7tz4VnG69VMb3rbTryv/3v8gbUW34WmgwE5n/rSja4LPKuZc+tX39Ww
 uldMd20K7NdVcOU+u/c6LTY4XmfVUd7Jn1kTm/6eO370uMLRyavZKsp7OrNvTzrQsX/hRQkve
 eYDqieebOmYNu3rjLJFvBclai35T2W+61ix4F88e7qI2hmXar3voga7pOLqPPZ8q875q2/daX
 Ni6nwbzbcb1z1TFGIXOvno/2Whu55iwlV79qQzK60r2bGS84nm7uNpn9byhW3ZZSscb3RNnTP
 +BCP7rijRdZOT4qKig7UvSx0N4hKf7L2C+UnnEcsvFbOX3Gwtz0zkDSjWF7tbumL+rqz0aRfv
 WCqxFGckGmoxFxUnAgB/2a0XTwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-745.messagelabs.com!1671430557!258595!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29646 invoked from network); 19 Dec 2022 06:15:58 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-12.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 19 Dec 2022 06:15:58 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 8D94E10018D;
 Mon, 19 Dec 2022 06:15:57 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 80DC9100188;
 Mon, 19 Dec 2022 06:15:57 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 19 Dec 2022 06:15:55 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 19 Dec 2022 15:16:26 +0800
Message-ID: <1671434187-2038-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_kvercmp: Add rhel9 support
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
 lib/tst_kvercmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index a01b4332b..552920fac 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -140,6 +140,9 @@ const char *tst_kvcmp_distname(const char *kver)
 	if (strstr(kver, ".el8"))
 		return "RHEL8";
 
+	if (strstr(kver, ".el9"))
+		return "RHEL9";
+
 	if (access(OSRELEASE_PATH, F_OK) != -1) {
 		SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s", distname);
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
