Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1A7C9832F
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 08:36:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 653123E9FA4
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 10:36:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 116243E58ED
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 10:36:12 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9DDAB100061D
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 10:36:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7M
 lR0SWH9jWPZ+wXu8uO3Ygn0axgbk3fIvKLBSh6jzk=; b=fiURCn5taZLG3z/QTS
 z/joXOWcVEMqVzZs7Rl09ziM91hvTp47oHovB3g2KT7GnKosNSe+trg+Q2rcHuyW
 cf5NqCueYX/oCyDbqZ8AOOQ2a6UGxSOJMGg3eJ4l6stOnvAikp7tvS5/LBAFGlHT
 r/3wPa8FR5R84WHeVfFfBiAyw=
Received: from zhangyang.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wC3rwf0Jrpqr2vkBA--.23002S2; 
 Mon, 28 Sep 2026 16:36:04 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: ltp@lists.linux.it
Date: Mon, 28 Sep 2026 16:36:03 +0800
Message-Id: <20260928083603.682527-1-gaoshanliukou@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CM-TRANSID: _____wC3rwf0Jrpqr2vkBA--.23002S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4fCr43Wr4DGw4fXrWfuFg_yoWktFgE93
 Wrurn7WrWkAa4UCFn7Cr4fCr4ktayUKF47Ga9xJFn7Ja1xWF98GryDJFWrGa1rWw13WFWx
 X39YgFyYvwn0kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1rWrtUUUUU==
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/xtbC5RUQA2q6JvUJwwAA3q
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open_posix_testsuite/sched_yield: Fix
 sched_setscheduler() check
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
Cc: "yang.zhang" <zhangyang01@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: "yang.zhang" <zhangyang01@kylinos.cn>

POSIX specifies that sched_setscheduler() returns the former scheduling
policy on success and -1 on failure.  Treating every nonzero return value
as an error incorrectly rejects valid previous policies.

Check explicitly for -1.

Signed-off-by: yang.zhang <zhangyang01@kylinos.cn>
---
 .../conformance/interfaces/sched_yield/1-1.c                    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c
index 922b1aa1f..9c5189af9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c
@@ -82,7 +82,7 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	/* get in FIFO */
 	sp.sched_priority = sched_get_priority_min(SCHED_FIFO);
 	rc = sched_setscheduler(getpid(), SCHED_FIFO, &sp);
-	if (rc) {
+	if (rc == -1) {
 		ERR_LOG("sched_setscheduler", rc);
 		return status;
 	}
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
