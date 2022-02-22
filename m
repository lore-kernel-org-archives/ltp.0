Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5086FC433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 08:42:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EAFC3CA1B3
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 09:42:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 510143CA1B6
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:41:26 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2FE7C60087D
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645519283; i=@fujitsu.com;
 bh=4xT10v3OAdy/xh+HyUVrchbYIm5oAEbmDFmwgnN/4us=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=seH7Gj/XuSVRQjnFnjtTduIc+jWmKjWN4mrX3FYQXq1eVO43TgwafhnxbZ1EsBfym
 7Tk4+JKD1J7nDi6TQq5HARJl8jvbAWGm54f1zyhO95Mx1Y97mqz8rCp/itJqKfgXTA
 ezkfaOiOdEGCeCmC9aA7qusYFdKJ/u8J+WbBD/cNioxLIrDpAkLQKvkQ4Qs5jGQS5u
 Rhb+82B7uzWvu2XFxyD8O1bhLy2uXT7BMczBxiS2jQRS01uDcaXq3NhLi8cmsLkXbI
 DIAayCcohUCq5VDYoUbFrykiuLO2jjLP9kaYQCALOru6Z4ZLpP5fi6pDsxbeCdxxpd
 W5iJeARlh9yEQ==
Received: from [100.115.7.206] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-1.aws.ess.symcld.net id 95/23-00700-3B1A4126;
 Tue, 22 Feb 2022 08:41:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRWlGSWpSXmKPExsViZ8MxRXfTQpE
 kg8N/zS1WfN/B6MDose/3OtYAxijWzLyk/IoE1oyGxmUsBZM4KlreHWRsYOxn72Lk4hASaGKS
 OLxoKxuEs4dRYsbH04xdjJwcbAKaEs86FzCD2CICEhIdDW/ZQWxmAXWJ5ZN+MYHYwgIeEh2ru
 9lAbBYBVYmuOefAenmB4pvebACrlxBQkJjy8D3YHE4BT4kn8+6B2UJANU+O/WaGqBeUODnzCQ
 vEfAmJgy9eMEP0Kkpc6vjGCGFXSMya1cY0gZF/FpKWWUhaFjAyrWK0TCrKTM8oyU3MzNE1NDD
 QNTQ01TXUNbXUS6zSTdRLLdUtTy0u0TXUSywv1kstLtYrrsxNzknRy0st2cQIDMmUYkbrHYwd
 fT/1DjFKcjApifJ+nSKSJMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCd+k8oJxgUWp6akVaZg4wP
 mDSEhw8SiK8W2YDpXmLCxJzizPTIVKnGBWlxHnrFgAlBEASGaV5cG2wmLzEKCslzMvIwMAgxF
 OQWpSbWYIq/4pRnINRSZj3N8gUnsy8Erjpr4AWMwEtnpIlBLK4JBEhJdXAVHZF2+NB39Zjcq+
 efkuMMHaTTbs67c3jNd+Mrjd8m/x96eR95lopSoWLFxirWwZknmN4ci+DmcMkQj3b6Xh0limP
 5fJD3HZJMgutXsyt4GiocORPmXoqqvzgpwMlT2u6T2paCR0xfM2x6ObyE4Yn3tT/8ZbX7284F
 vtOM2x2QP0vlQ/tSUedM75bRu/+EWDQ8+1mdpWB7N4OzsRNs9c9S85krAo8c/XprH61HPH/fx
 9oLP+udfSR1/WWWLNtNiE2vukvtaqeMnHP5U+e9PzQ0hfTd5zIXKTZ9UteMmPZicrk7K8tD0M
 lK3JNup1+HY1af2pO1z675XO/Lbfmqp4yt3mXarPNfxa+y86XH0ydrsRSnJFoqMVcVJwIAD05
 0ZlEAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-587.messagelabs.com!1645519282!3153!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18656 invoked from network); 22 Feb 2022 08:41:22 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-14.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 22 Feb 2022 08:41:22 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 21M8fGWD022422
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:41:22 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Tue, 22 Feb 2022 08:41:14 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 22 Feb 2022 16:41:09 +0800
Message-ID: <1645519272-2733-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645519272-2733-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1645519272-2733-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/7] syscalls/fanotify21: Make use of
 SAFE_PIDFD_OPEN
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
 testcases/kernel/syscalls/fanotify/fanotify21.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index bd6429ab5..d5be3e270 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -23,7 +23,7 @@
 #include <string.h>
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
-#include "lapi/pidfd.h"
+#include "tst_safe_pidfd.h"
 
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"
@@ -124,12 +124,7 @@ static void do_setup(void)
 	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD,
 			   TEST_FILE);
 
-	pidfd = pidfd_open(getpid(), 0);
-	if (pidfd < 0) {
-		tst_brk(TBROK | TERRNO,
-			"pidfd=%d, pidfd_open(%d, 0) failed",
-			pidfd, getpid());
-	}
+	pidfd = SAFE_PIDFD_OPEN(getpid(), 0);
 
 	self_pidfd_fdinfo = read_pidfd_fdinfo(pidfd);
 	if (self_pidfd_fdinfo == NULL) {
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
