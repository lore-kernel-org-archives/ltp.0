Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A761CC4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 10:23:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FB123CBDA7
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 11:22:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8ED53CB892
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 01:35:56 +0100 (CET)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 397C010005C3
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 01:35:56 +0100 (CET)
Received: by mail-yb1-xb4a.google.com with SMTP id
 a5-20020a25af05000000b006e450a5e507so15076711ybh.22
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OZB3tG/HSV0aWHs2qFB93elsIC+SFLLq0VzJyihrXD0=;
 b=cJerF6xtVm6l1Gst2njJXR73xWXI1YlWj8EqTM2IiUuBtg0DHP/HBCIlIAv1nRrfBe
 2JPiX/lraBf1f7A2idtjZLIBi/N9PFKLgeHLM/eiCcuso5GP9z8C6jTUsvcfUR83Voem
 xXA/eZWnjIgma8FZSlXndmuadx2bsOj+eDZZ/I9HEQNo9FSJ65ZYGMV4NJ+ivmv0oUc5
 oSZc1/lMQnKpqIGw8SJ3bID6/Z1RBweAC2ZcgZrlMmbpsDw1afqQulwWIjO6fvUdlVxV
 +rZ4HowNTi1/uA0tpwiou6H+2AzVOJzRsHImZfYEMEJkDIrh4IalKvfhZ6hk+bvc63tv
 YGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OZB3tG/HSV0aWHs2qFB93elsIC+SFLLq0VzJyihrXD0=;
 b=KX3N6QeOlw55UnDHMWWRU3mk9rLmVd5IjXwKZ07s6ylZgHEJW6g/19hiUF3c8UQuev
 CvNMpCQBihRpNbFRktWaZYLg8+mbNgDEzwDpAE96PyEok0/V88bK+/eZo0febE9xiLbM
 PPsPqgln+mGv9gi/kGh+A6ACzjiomfsI1Cv47ZmFLOmAdEvZPx6ctTEoAGUcgB4pP+2S
 VvUX94yvkyZX+79PaqKSwxbn4D09kY/6SJWMnMR8OArvYavzZs4zC3Jq/rYKsuUCabhL
 FJ30h5nz5ZZTWPYQMGDsHiSGu18+xjrCwyYGjZJwHEPmgkQjepQ7PBOgzGq/hdc/UrRs
 w2Hg==
X-Gm-Message-State: ANoB5pmPEY2b5FevcLZY+i2HZDFYvjNn/Xe53kjbVH7kOjWwbqWfKtU+
 Dhz1v6v7vGXiKmAlr9YbiT/kp6RqWJNPuWW6f8NfVKSJOfYnIm3UnY997mnYL4q8vu8MiCScoKg
 iC9bkrze70phUIJkM9ENoSXtfLFhpdfrdR/RbcavIGYzUxgS7J3wVhywP1/da7rkm
X-Google-Smtp-Source: AA0mqf72jTAGqKbEW5ZA1XhgdtlOfymUpUS8yVhE1pF8sGos7+ibJOAJ9detvSI818v/oYTegRW2zO2SS93Hb48=
X-Received: from zijunzhao123.c.googlers.com
 ([fda3:e722:ac3:cc00:2b:7d90:c0a8:b5e])
 (user=zijunzhao job=sendgmr) by 2002:a25:7782:0:b0:705:fcdb:b10d with SMTP id
 s124-20020a257782000000b00705fcdbb10dmr10910578ybc.465.1670891754802; Mon, 12
 Dec 2022 16:35:54 -0800 (PST)
Date: Tue, 13 Dec 2022 00:35:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213003553.3693243-1-zijunzhao@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 13 Dec 2022 11:22:49 +0100
Subject: [LTP] [PATCH] signalfd01.c: put the right round bracket to the
 right place in tst_resm
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
From: zijunzhao via ltp <ltp@lists.linux.it>
Reply-To: zijunzhao <zijunzhao@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

---
 testcases/kernel/syscalls/signalfd/signalfd01.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
index 3df941785..c6a7c3a58 100644
--- a/testcases/kernel/syscalls/signalfd/signalfd01.c
+++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
@@ -249,8 +249,7 @@ void do_test2(int fd, uint32_t sig)
 		goto out;
 	} else {
 		tst_resm(TFAIL, "got unexpected signal: signal=%d : %s",
-			 fdsi.ssi_signo),
-			 strsignal(fdsi.ssi_signo);
+			 fdsi.ssi_signo, strsignal(fdsi.ssi_signo));
 		goto out;
 	}
 
-- 
2.39.0.rc1.256.g54fd8350bd-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
