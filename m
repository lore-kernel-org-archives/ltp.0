Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF00C6FD1F
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 09:21:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32F5C3CC91F
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 11:21:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 400673C068C
 for <ltp@lists.linux.it>; Fri, 29 Mar 2024 16:47:29 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 237656012B0
 for <ltp@lists.linux.it>; Fri, 29 Mar 2024 16:47:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=PZ6a6naYSlC8X9rHqP
 KhauOJll4iiM72cSCMt1a7jn0=; b=UTKOuTyW9RIp5eGGYe6p5qLKPjU5OQx/aB
 zZzyp89Xuh4jII0lVu1j4Zo4kMri4uMF2CjDaUSiDP6em1aZPVKmDd34A7U1QSvi
 b8f5PHJ0fvyJEoOWcCPe5VAjtSYdopSzZie3KtZFp6lZGT+I9vi5k39ByVPn8Fxb
 /tHhDvef8=
Received: from yang-Virtual-Machine.mshome.net (unknown [124.232.34.235])
 by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3_06F4gZmUshgBw--.21932S2;
 Fri, 29 Mar 2024 23:47:18 +0800 (CST)
From: yangfeng <yangfeng59949@163.com>
To: ltp@lists.linux.it
Date: Fri, 29 Mar 2024 23:47:15 +0800
Message-Id: <20240329154715.7130-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3_06F4gZmUshgBw--.21932S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyfCF4xCFyUtw1kGr1DAwb_yoW3KrX_Jr
 45CFZ7urs8KFn5t3y8A340krs5Kw40q34Iqr43JFy5GrZ5ZryDAFWDt3y0y34DWr43W3ya
 yrnYgF1jqw17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0kOz3UUUUU==
X-Originating-IP: [124.232.34.235]
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiZQqweGXAk1aSNAAAsh
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 02 Apr 2024 11:21:16 +0200
Subject: [LTP] [PATCH] sctp: bugfix for
 utils/sctp/func_tests/test_1_to_1_events.c
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
Cc: yangfeng <yangfeng@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: yangfeng <yangfeng@kylinos.cn>

event not initialized to 0 causes "Got a notification,
expecting a datamsg" issues

Signed-off-by: yangfeng <yangfeng@kylinos.cn>
---
 utils/sctp/func_tests/test_1_to_1_events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/utils/sctp/func_tests/test_1_to_1_events.c b/utils/sctp/func_tests/test_1_to_1_events.c
index 447845ff3..889d2ff33 100644
--- a/utils/sctp/func_tests/test_1_to_1_events.c
+++ b/utils/sctp/func_tests/test_1_to_1_events.c
@@ -96,6 +96,7 @@ main(void)
 	/* Create the client socket.  */
 	clt_sk = test_socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);

+	memset(&event, 0, sizeof(struct sctp_event_subscribe));
 	event.sctp_data_io_event = 1;
 	event.sctp_association_event = 1;
 	event.sctp_shutdown_event = 1;
--
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
