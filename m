Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE44D3B7EA
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 16:01:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22B713D02FC
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 17:01:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9E343CE710
 for <ltp@lists.linux.it>; Fri,  5 Dec 2025 04:00:26 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3B5C610005D5
 for <ltp@lists.linux.it>; Fri,  5 Dec 2025 04:00:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8c
 odGuIDJ5vWiVLXHzSD6+LW3mT47hbLiiyQdgB+6LE=; b=iLUzG3H4eVcPcNlcYW
 MW++7OAQFZ6whwCcFDjv96boh6hnhweKBeyqYmfLQEda3d8Z/IUz3Eb6WmNimP79
 7kN0ABWWqr61wBzUOHoVYooP14+5LEdZzLOoQmtVCX3Ct/mbLRjG7W9ZjEoRhQjj
 Zppzb/n/r5JSmvA7yWQvlw12s=
Received: from localhost (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wDn9+zFSjJpI2BDFA--.1905S2; 
 Fri, 05 Dec 2025 11:00:22 +0800 (CST)
From: simplemessager@163.com
To: ltp@lists.linux.it
Date: Fri,  5 Dec 2025 11:00:21 +0800
Message-ID: <20251205030021.48813-1-simplemessager@163.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-CM-TRANSID: _____wDn9+zFSjJpI2BDFA--.1905S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr13Jw4fKFyfAF47GF47XFb_yoW8Ar45pw
 1xJr45Zw48trsYv347Jw1kWr95uas5GFW7KwsIkF1kurZFq345JrWvqr9rWryruFZ8Xa90
 9a18JF4xCw4DJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDL05UUUUU=
X-Originating-IP: [36.111.64.84]
X-CM-SenderInfo: hvlp1z5hph22hdjh2qqrwthudrp/xtbCzgaqQmkySsaqzAAA3R
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 09 Dec 2025 17:01:25 +0100
Subject: [LTP] [PATCH 1/1] Skip wqueue testcases when KEY_NOTIFICATIONS not
 enabled.
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

From: Mingyu Li <limy83@chinatelecom.cn>

Skip wqueue testcases when KEY_NOTIFICATIONS not enabled.

wqueue testcases relys on both CONFIG_WATCH_QUEUE
and CONFIG_KEY_NOTIFICATIONS. keyctl will return EOPNOTSUPP
when CONFIG_KEY_NOTIFICATIONS is not enabled and the wqueue
testcases will failed when timeout. So we should skip
testcases when we got EOPNOTSUPP from keyctl.

Reported-by: Meng Yang <yangm50@chinatelecom.cn>
Signed-off-by: Mingyu Li <limy83@chinatelecom.cn>
---
 testcases/kernel/watchqueue/common.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/watchqueue/common.h b/testcases/kernel/watchqueue/common.h
index 92e8f079c..e9100ab52 100644
--- a/testcases/kernel/watchqueue/common.h
+++ b/testcases/kernel/watchqueue/common.h
@@ -85,8 +85,26 @@ static inline key_serial_t wqueue_add_key(int fd)
 	if (key == -1)
 		tst_brk(TBROK, "add_key error: %s", tst_strerrno(errno));
 
-	keyctl(KEYCTL_WATCH_KEY, key, fd, 0x01);
-	keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, 0x02);
+	TEST(keyctl(KEYCTL_WATCH_KEY, key, fd, 0x01));
+	if (TST_RET) {
+		switch (TST_ERR) {
+		case EOPNOTSUPP:
+			tst_brk(TCONF | TTERRNO, "CONFIG_KEY_NOTIFICATION is not set!");
+			break;
+		default:
+			tst_res(TINFO, "CONFIG_KEY_NOTIFICATION is set.");
+		}
+	}
+	TEST(keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, 0x02));
+	if (TST_RET) {
+		switch (TST_ERR) {
+		case EOPNOTSUPP:
+			tst_brk(TCONF | TTERRNO, "CONFIG_KEY_NOTIFICATION is not set!");
+			break;
+		default:
+			tst_res(TINFO, "CONFIG_KEY_NOTIFICATION is set.");
+		}
+	}
 
 	return key;
 }
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
