Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEF7C4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 02:13:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 081F53CBE79
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 03:13:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B8693C32DD
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 03:13:18 +0100 (CET)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3BE7C10006CA
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 03:13:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1670897596; i=@fujitsu.com;
 bh=Bi0cockvg0/XU7xZrEuGuvfes7yJVpFJ9AmkdAMU4E8=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=p8UJ0u4hfjTsX+WQqkb2bJcuXw7XOT+q6NMeZEa8WUtCBgme9zZ/jM2/VSQKKbmUX
 MwoUa4dVHDNOF5AcJG/qMw2YOeMYWc72oYbazOPQ0cCdJzM5kYIPAQ2WFkGMQTN05+
 CXXB3StV2yTW3zZWk+/7GeZhUjw50sAqEzP0qkFM9xqoDAigyCYZGO2klXl9OaMn6/
 YKtLI/UlvkhJRa8rvgEAlu1+1U8FT4E6Gbb8JvPN2bqqs9HV7AlLkA85SVV2TJZ8Au
 8GohNUCWjaazGIK+S21NwoTJD8o3kPI7cr1H/L8RVBa8SmffwU4EifGzvtNTZ77ACQ
 fFC+mz+/TtFtg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRWlGSWpSXmKPExsViZ8MxSXf3/en
 JBn/2SVqs+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBn/1p1jLzjKU3Hw1XLGBsb7XF2MnBxCAmcZ
 Jdbf4+ti5AKyDzBJHFlwjQkisYdR4ldjCYjNJqAp8axzATOILSIgIdHR8JYdxGYWUJdYPukXW
 L2wQJTE7P4PrCA2i4CqxO7F29hAbF4BD4kH8w+B1UsIKEhMefieGSIuKHFy5hMWiDkSEgdfvG
 CGqFGUuNTxjRHCrpCYNauNCcJWk7h6bhPzBEb+WUjaZyFpX8DItIrRrDi1qCy1SNdQL6koMz2
 jJDcxM0cvsUo3US+1VDcvv6gkAyiVWF6sl1pcrFdcmZuck6KXl1qyiREYiinFyew7GN8s+aN3
 iFGSg0lJlLc4d3qyEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQne73eAcoJFqempFWmZOcC4gElLc
 PAoifAuvAGU5i0uSMwtzkyHSJ1iVJQS5226B5QQAElklObBtcFi8RKjrJQwLyMDA4MQT0FqUW
 5mCar8K0ZxDkYlYd6LIFN4MvNK4Ka/AlrMBLQ46uVUkMUliQgpqQamyU/yl8cs2Loy2uqW1nk
 Jvg0/Z646dIf9R+fcl75XHySFJtpsNUlsTck/ZtAXsFncbaHfy6oX/7p+V768qPS6Pr9XP5Ot
 xSTJ7HBy21Gdv1qc3T7PLavkog7wdAv7xy+w8LihHqDQVrf4/LcLjwXeXL86U6Qi9MPTted+N
 IVk7zv88Bur9NPZ2TteWSx7mf7a9dH39bmL/z14dyD1SMbeOL/EokNyJg+eOJ8suRMU8knEYa
 uSbZCU4bzalMcrnRsvrdicvmjT/r9vWYLP7p3EX8S+LrDU6o1j/8Q7oZMn6nhWClz5l/lMgHf
 DRanTb/7ckAxqLdFS9LrQf9Q7Y2c12664bB6PXu26VutNAgYuSizFGYmGWsxFxYkAtXj4QEAD
 AAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-745.messagelabs.com!1670897595!217427!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10373 invoked from network); 13 Dec 2022 02:13:15 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-3.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Dec 2022 02:13:15 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id D91CC1000E7
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 02:13:14 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id CCF0D1000D2
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 02:13:14 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 13 Dec 2022 02:13:12 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 13 Dec 2022 11:14:18 +0800
Message-ID: <1670901258-1995-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/statx01: Add exit condition when parsing
 /proc/self/mountinfo
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

When using user filesystem such as overlayfs, the current parsing way can't
work well.

63 66 8:3 / /sysroot rw,relatime - ext4 /dev/sda3 rw,seclabel
43 66 8:3 /ostree/deploy/rhivos/var /var rw,relatime shared:3 - ext4 /dev/sda3 rw,seclabel

So add the exit condition for statx.mnt_id check so it can skip the
underflying filesystem and parse the correct user fileystem's mnt_id.

Fixes: #1001
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v1-v2: change the fail message
 testcases/kernel/syscalls/statx/statx01.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index 60b50958b..e9677475a 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -68,7 +68,8 @@ static void test_mnt_id(struct statx *buf)
 		if (sscanf(line, "%"SCNu64" %*d %d:%d", &mnt_id, &line_mjr, &line_mnr) != 3)
 			continue;
 
-		if (line_mjr == buf->stx_dev_major && line_mnr == buf->stx_dev_minor)
+		if (line_mjr == buf->stx_dev_major && line_mnr == buf->stx_dev_minor &&
+				mnt_id == buf->stx_mnt_id)
 			break;
 	}
 
@@ -80,8 +81,8 @@ static void test_mnt_id(struct statx *buf)
 			mnt_id);
 	else
 		tst_res(TFAIL,
-			"statx.stx_mnt_id(%"PRIu64") is different from mount_id(%"PRIu64") in /proc/self/mountinfo",
-			(uint64_t)buf->stx_mnt_id, mnt_id);
+			"statx.stx_mnt_id(%"PRIu64") doesn't exist in /proc/self/mountinfo",
+			(uint64_t)buf->stx_mnt_id);
 
 	pid = getpid();
 	snprintf(line, PATH_MAX, "/proc/%d/fdinfo/%d", pid, file_fd);
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
