Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A456EC4706C
	for <ltp@archiver.kernel.org>; Fri, 12 Jan 2024 13:39:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 470AA3CE3E2
	for <ltp@archiver.kernel.org>; Fri, 12 Jan 2024 14:39:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 894F33CB3DC
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 14:39:17 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E60CE6010FB
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 14:39:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705066754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RX87THILn2xf52gVAHhi4Kw03+OazeaXPwO3GJwr2dM=;
 b=Fb09omwQNpFgVq+HxRoIig+glEY0EuMq8C38Qbz82R98NgLHTQxNRJXqaCABQgqzMiz0W+
 30sCwj3TF/K0H7rHvpt7VVPnzS0vPy53JgfAC3YYrm42kGkUCv9/MxMo0W6aBYbF7d4aJx
 F7PmyBL2NTI72S6hnuRr5bSdeCmwrT4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-WUdGcllBPa2euqKE8EHbTA-1; Fri,
 12 Jan 2024 08:39:12 -0500
X-MC-Unique: WUdGcllBPa2euqKE8EHbTA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F7841C2B67B
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 13:39:12 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3D4D2166B5D
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 13:39:11 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 12 Jan 2024 14:33:26 +0100
Message-Id: <427788e09f3109fa5e48581058597d6998a08fa5.1705066390.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] irqbalance01: fix out-of-bounds write in
 collect_irq_info()
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

Parse code first counts and allocates memory only for numbered IRQs,
and then proceeds to parse all columns. Problem is in second part,
which can advance "row" counter even for lines which are not parsed
(IRQs not matching [0-9]*). This eventually leads to "row" counter
being too large and going over bounds of irq_ids[]:
  ==2953075== Invalid write of size 4
  ==2953075==    at 0x1005B7A: collect_irq_info (irqbalance01.c:169)
  ==2953075==    by 0x1005D51: setup (irqbalance01.c:294)
  ==2953075==    by 0x1011BBB: do_test_setup (tst_test.c:1354)
  ==2953075==    by 0x1011BBB: testrun (tst_test.c:1479)
  ==2953075==    by 0x1011BBB: fork_testrun (tst_test.c:1627)
  ==2953075==    by 0x10136C1: tst_run_tcases (tst_test.c:1723)
  ==2953075==    by 0x10053A7: main (tst_test.h:402)

Reported issue is for s390x, but it can be reproduced also on x86_64
if you shuffle around lines of /proc/interrupts.

To fix, only advance "row" variable when line is recognized as being
numbered IRQ.

Closes: https://github.com/linux-test-project/ltp/issues/1118
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/irq/irqbalance01.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/irq/irqbalance01.c b/testcases/kernel/irq/irqbalance01.c
index a3d29aec2f5c..96bbec6a8f37 100644
--- a/testcases/kernel/irq/irqbalance01.c
+++ b/testcases/kernel/irq/irqbalance01.c
@@ -93,7 +93,7 @@ static void collect_irq_info(void)
 	char path[PATH_MAX];
 	size_t row, col, len;
 	long acc;
-	unsigned int cpu_total, bit;
+	unsigned int cpu_total, bit, row_parsed;
 
 	nr_cpus = 0;
 	nr_irqs = 0;
@@ -136,7 +136,7 @@ static void collect_irq_info(void)
 
 	c = first_row;
 	acc = -1;
-	row = col = 0;
+	row = col = row_parsed = 0;
 	/* Parse columns containing IRQ counts and IRQ IDs into acc. Ignore
 	 * everything else.
 	 */
@@ -154,7 +154,9 @@ static void collect_irq_info(void)
 			if (acc != -1)
 				tst_brk(TBROK, "Unexpected EOL");
 			col = 0;
-			row++;
+			if (row_parsed)
+				row++;
+			row_parsed = 0;
 			break;
 		case '0' ... '9':
 			if (acc == -1)
@@ -168,6 +170,7 @@ static void collect_irq_info(void)
 				tst_brk(TBROK, "Unexpected ':'");
 			irq_ids[row] = acc;
 			acc = -1;
+			row_parsed = 1;
 			break;
 		default:
 			acc = -1;
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
