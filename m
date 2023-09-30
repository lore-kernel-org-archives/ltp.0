Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0C9E7734C
	for <ltp@archiver.kernel.org>; Sat, 30 Sep 2023 00:05:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C96B3CF20F
	for <ltp@archiver.kernel.org>; Sat, 30 Sep 2023 02:05:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27DC03CB9C8
 for <ltp@lists.linux.it>; Sat, 30 Sep 2023 02:05:23 +0200 (CEST)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 99613605628
 for <ltp@lists.linux.it>; Sat, 30 Sep 2023 02:05:22 +0200 (CEST)
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-565ece76be4so17457980a12.2
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 17:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696032321; x=1696637121; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CAUP9HhMDmKoa2/0PQH3WirlHHe0IcUq5/TExvAg294=;
 b=Pdpqayc95QC8t22qzycVHS9QKsLA7uCP5094uL5CK1O58YpxtV18W+03RliwJ083SP
 7Xy5FOcMHQqaoZvYwKqC36weM8XS30mO6ZHsOOmFuJha1dLDA5sOe32wnDOuk516TxNJ
 V85jAVllk83fa+vLcDvGekmKyH5vByT/kRaklO0XMfl3I4r/AhWGdLZgoo4azcy5xACu
 K+8tspKhniiWU8GFLOzmisfglU3MK3dU7Jr0r7w6bvQcVvgK/Yf9y6CCBsasZjzWgT6d
 1UTSOQZJ2oI33o5k6mut7k7Z5ZLlm9u8Sf4+tIslgggxRrkPFvBED09w/Q6sc114Fya9
 iOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696032321; x=1696637121;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CAUP9HhMDmKoa2/0PQH3WirlHHe0IcUq5/TExvAg294=;
 b=GHvtL/GG2YaV+J4ZILrdb+/vYVb7SQdzop5oqPRxAo/A2N6jCI4YWBwyu4uW/Z9gqm
 dwXvVaBA9TdL60hIo2h2IOs0kyqmeeMtoU/aE2TP/zv4qfWKita8ZwwpFBBlRh6h6O5U
 kXOZ7zHtbnlo+ATq5fDKXsr2/O5RNIejnPCB6MIqf3aWhgAyhgx0YUzOH0vL1zdZ72L2
 tFGy8iBFbv1Wng/mexMpvFXqG6m1NwPRu9V9Yqc/aRa0J1DcTT8CG7BW8tIwW2JHaaQi
 jWveVaNYM0Gqr0jKVtXqoVNNV8LM1GXmy0Ls+HNfiZdl0gP+jaigxITpDqVeNp04B2NU
 VuwQ==
X-Gm-Message-State: AOJu0YzW42EkoyS8QcY7ZLfSQuCcScvs2p3u1IWI8RLFhYeeq9+W4kfY
 wmhPJpwDNmF8etlV2MJm2f0ZSV7nO8rLc8dwsPIUppyq/eLMzwsbn87UAYSSPgNFdbZxCfFqLYz
 Hhh3ivF5POzjHPMIInqhhfHNUuoTS+N3ihQQZk18+jM87heRQwfCs/DTO
X-Google-Smtp-Source: AGHT+IHZjl4iT8RWCsy3Ekl0P24AIRASRO9Tmqs0OMIT6rUez7WuZacIfRT+40X1H8ySpvaDvfFU+2xtBgo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:bf46:0:b0:578:9125:922d with SMTP id
 i6-20020a63bf46000000b005789125922dmr85143pgo.10.1696032320829; Fri, 29 Sep
 2023 17:05:20 -0700 (PDT)
Date: Sat, 30 Sep 2023 00:05:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230930000516.4063681-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getpgid01: On Android, pgid(1) is 0 instead of 1
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Android's init does not call setpgid(0, 0) so it does not have pgid=1.
0 is functionally equivalent, since pgid 0 means the pgid is the same as
the process pid.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/getpgid/getpgid01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getpgid/getpgid01.c b/testcases/kernel/syscalls/getpgid/getpgid01.c
index 479fe5dcb..8640f2c93 100644
--- a/testcases/kernel/syscalls/getpgid/getpgid01.c
+++ b/testcases/kernel/syscalls/getpgid/getpgid01.c
@@ -37,7 +37,7 @@ static void run(void)
 		TST_EXP_EQ_LI(TST_RET, pgid);
 
 		TST_EXP_PID(getpgid(1));
-		TST_EXP_EQ_LI(TST_RET, 1);
+		TST_EXP_EXPR(TST_RET == 1 || TST_RET == 0, "getpgid(1) == 1 or 0");
 	}
 
 	tst_reap_children();
-- 
2.42.0.582.g8ccd20d70d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
