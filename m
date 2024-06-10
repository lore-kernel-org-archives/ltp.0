Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A90C27C55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 11:56:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B89613D0B2B
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 13:56:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C11113D0B1E
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 10:56:36 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 44D1F20096C
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 10:56:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+z+Yu
 pvG3z76aV5xcuw30gT66Ld+Bu8kDQKU75NV47Y=; b=PW3gjCCGn/4go/Vv2omAx
 QaU8PvHY3mDeKc+j6039u9VFqXC6U5cTTMqjWwZm0SMtep2XFFVTL+y+i4vrrOT/
 kX4xGFNHOAXkb8zJSYZz4kGMDlyXixJwERFlLaF8p/uZH/FsESOolquMlEN68ZSV
 vbv+TFAqJEseRke2UrD1Co=
Received: from localhost.localdomain (unknown [120.244.62.148])
 by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDnL6O3v2ZmfW1wCA--.13218S2;
 Mon, 10 Jun 2024 16:56:25 +0800 (CST)
From: Jiwei Sun <sjiwei@163.com>
To: ltp@lists.linux.it,
	sunjw10@lenovo.com
Date: Mon, 10 Jun 2024 16:56:22 +0800
Message-Id: <20240610085622.87076-1-sjiwei@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: _____wDnL6O3v2ZmfW1wCA--.13218S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw43Ar17WFyfWrW3Kry3urg_yoW8GFW8pa
 1xGa42yr48Jrn5Jw1UCa1kurW8GFZ7WrZ8Kay7Zw18Zry3ZF17ZryavF1jq347XrsYvrWF
 9r9Ygr13ZF1FyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6GQgUUUUU=
X-Originating-IP: [120.244.62.148]
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiWwX5mWV4JY65qwABsb
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 10 Jun 2024 13:56:18 +0200
Subject: [LTP] [PATCH] genload: fix memory corruption in hogvm
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
Cc: ahuang12@lenovo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Jiwei Sun <sunjw10@lenovo.com>

With the following command for doing memory stress test,

  ./genload -v --vm 10 --vm-chunks 4 --vm-bytes 1073741824

Some memory corruption issue was triggered,

  malloc(): corrupted top size

The root cause of the issue is that allocated memory for ptr is less
than what is actually needed.

Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
---
 tools/genload/genload.c | 2 +-
 tools/genload/stress.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/genload/genload.c b/tools/genload/genload.c
index 7f56d5272..9712e7828 100644
--- a/tools/genload/genload.c
+++ b/tools/genload/genload.c
@@ -642,7 +642,7 @@ int hogvm(long long forks, long long chunks, long long bytes)
 			usleep(backoff);
 
 			while (1) {
-				ptr = (char **)malloc(chunks * 2);
+				ptr = (char **)malloc(chunks * 2 * sizeof(char *));
 				for (j = 0; chunks == 0 || j < chunks; j++) {
 					if ((ptr[j] =
 					     (char *)malloc(bytes *
diff --git a/tools/genload/stress.c b/tools/genload/stress.c
index 7f56d5272..9712e7828 100644
--- a/tools/genload/stress.c
+++ b/tools/genload/stress.c
@@ -642,7 +642,7 @@ int hogvm(long long forks, long long chunks, long long bytes)
 			usleep(backoff);
 
 			while (1) {
-				ptr = (char **)malloc(chunks * 2);
+				ptr = (char **)malloc(chunks * 2 * sizeof(char *));
 				for (j = 0; chunks == 0 || j < chunks; j++) {
 					if ((ptr[j] =
 					     (char *)malloc(bytes *
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
