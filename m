Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D12C63706
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 09:35:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 900293CC129
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 10:35:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 879813CC0D6
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 10:35:27 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8D1B610005C4
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 10:35:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1670405725; i=@fujitsu.com;
 bh=OvRJYU6gN5M9E1WD0BlcAKaT9EtxiNUTTMx8jlY+jFQ=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=Lrrqb3sa/HrUXsVHOLeJxtJVBZNAY+oo1kLUsoi6mURgXfhiwDGpdeiM70sh6pZ3k
 tAvvW4kCp65QeeGmkclhEfjn2oObqieBtkmwq6eMshi5yKl/XIfUPlsjZkyLkEewoR
 0xkqNikh0aKcKD/T3fsaB71i4dhlLlWUKBNipFLKV2hep/PCPD9mNYikthDCTOKqKn
 rSKASroyxXzOxfv0mM6l64c3IC7AJcp9kqzAs9/Vj4rRnF2yX1ml5tHeW/yJ89Cd+y
 qiweYIxa+XnZH+IA0Wmm2vzZhLQzNJYaG6l2Q4UuaMrFpraaEeulwYzYOTEC8aVU8J
 V/T5aPsWPg2WQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRWlGSWpSXmKPExsViZ8MxSTc2bkK
 ywdSTLBYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aSpT3sBT84Kq6sOcrYwHiVvYuRk0NI4Cyj
 xPFDCl2MXED2ASaJ1gmf2SGc3YwSrQfmsoFUsQloSjzrXMAMYosISEh0NLwF62YWUJdYPukXE
 4gtLBAu8ePTZLAaFgEViYXHG4BqODh4BTwkvq2uAwlLCChITHn4HqyEV0BQ4uTMJywQYyQkDr
 54wQxRoyhxqeMbI4RdITFrVhsThK0mcfXcJuYJjPyzkLTPQtK+gJFpFaNZcWpRWWqRrpGBXlJ
 RZnpGSW5iZo5eYpVuol5qqW55anGJrqFeYnmxXmpxsV5xZW5yTopeXmrJJkZgKKYUM07Zwdiz
 7I/eIUZJDiYlUd4X1f3JQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4p8dMSBYSLEpNT61Iy8wBx
 gVMWoKDR0mE93oUUJq3uCAxtzgzHSJ1ilFRSpy3A6RPACSRUZoH1waLxUuMslLCvIwMDAxCPA
 WpRbmZJajyrxjFORiVhHnvg4znycwrgZv+CmgxE9Die/97QRaXJCKkpBqYljAmaW04zlnT8aA
 m+rg2Y+iLY88MXkZdWvCqQjjGQI11/RpvoZL/iwxcbX9w7DgayDHnQMv7tgsr9zOob+hZ68Xj
 1ey68Mut5n7j0waXH3x96Lcy3zW27mnWsnNv9sv/uuLP65m39oxhzDPzPWZsfF+Nz6nZ+ZS9s
 ylmD+bRvJHw7Om1aZlFb2LNLy5Ki9i3oO0S77KraTKv5VVkQl1NKyzUL7fEMXv9N3S/c7xxf/
 W2G6xNss+uhD/oiA2c8LzSi+XP1u/bHK0sqtLPP9na8W9TnarHiw3XShx0msRdfm698iwiVeW
 AnnqgZUJJ254c3x2rnr0vs2BZ9+WCP8eH2bsW/5h7xG69/fGGr3fuKrEUZyQaajEXFScCAL30
 D4VAAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-587.messagelabs.com!1670405724!45787!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16742 invoked from network); 7 Dec 2022 09:35:25 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-8.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 7 Dec 2022 09:35:25 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id ADD4C1000E9
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 09:35:24 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id A08961000DC
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 09:35:24 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 7 Dec 2022 09:35:23 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 7 Dec 2022 18:36:16 +0800
Message-ID: <1670409376-1951-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/statx01: Add exit condition when parsing
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
 testcases/kernel/syscalls/statx/statx01.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index 60b50958b..931aa60c1 100644
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
 
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
