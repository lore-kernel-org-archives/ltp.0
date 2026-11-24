Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43374606A31E
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=aO9mnQOS;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=shopee.com header.i=@shopee.com header.a=rsa-sha256 header.s=shopee.com header.b=kuRSAlgc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795600886; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=f+bVLJsJomwE0cfTJ6eDtdEo63DEvFPinwm+eVxzXEM=;
 b=aO9mnQOSkfchlVliMp4XuQq5Z3sTgpLN0qRXehLgWIZqpYPll7shuEq/DJQNRxjphEqSg
 FaKYx2bb6V78hao81SYLcC2yZhF6pFZtBqedWG/+g/2HfG8/a001piDEiAySzsCv3p2TKQh
 96ZvBr6jLHGm9y1/VLmvYHcT3Vk/GAk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EAD83E92E2
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 11:01:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 944493C008D
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 07:18:38 +0100 (CET)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com
 [IPv6:2607:f8b0:4864:20::132f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ED23A2002C7
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 07:18:37 +0100 (CET)
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-385d8a00598so5884485eec.1
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 22:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shopee.com; s=shopee.com; t=1795501116; x=1796105916; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JFy1X2BKlOQk1Ob3J04PaDEKyPVXqfmBu2NeKbSthbQ=;
 b=kuRSAlgcjfh2mMdHoPsEDy98ZvOBS83XgDqpOtqZeOCq1DWNKuAn8PLJeIXEvIqlNj
 uNSu7j7lOemTW0qpG1dI5rhhAl8afkF25I6mannvB438OIyT0dJ5izVRwyI2EicOu/EP
 CmBbhvVufS/6NrNMu7rZS04DVudE0Kl2ensaeEgG9hK6j09FktrWt+HUD/KsSMZiQzgX
 /sUuXF5v3VXBqbknPF6ypxNBHpJ29naujUFLn31bC6qzcHr0vzvw5aB/A2Acbv4J9Nxe
 6wFp5x+2CHq1cckrm31tE6jj+ZglDXHxKnrcfpHTYyF7cBlBia8xFWlpFhp2u1Hs23uv
 aOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795501116; x=1796105916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JFy1X2BKlOQk1Ob3J04PaDEKyPVXqfmBu2NeKbSthbQ=;
 b=uWo9K4k65hB35hUzMVRCTTOpDxFI4Tg4dfVj4rrD9JhH8Vr5Bde6O5Q5dPGI78sVAp
 MxVom65L4jnOqBeduKcg7bZqo1VqVS6/pRIPYKPcNG+rb8JmE2Y+wGaanuIFGwJRtOa/
 b7q/tP4m3s4g8H8Xo2DXq3HRuJxx76K77TruvAuzGcUlhMEpQQDkEa3Y/mGHvka9Cg5I
 XK3TDDb6UOr1/8JghC4jwIg/doBmL4RK0xx/2Xwz1jYF+G3SvkHLBf1h/wFvbVsOdVrN
 dGHAR+DvNNWgbzhKcL9TnTwabQndDA949XycGp5jMt69ndGOwx6s2H6RWPWFtvgCDOBp
 Xl/Q==
X-Gm-Message-State: APuU4Z+YkuiAXiAUY2rU2gqJNR9YXlxHS8qufLWgQ7e8hpiYnTsB4MOj
 MOAdwpZtpuwnqZpWSQ7icpCPR9triCSjwuW+kqAD1kr3Prt0lwYI0u5igaC4OKRGAP0TwYvp6ug
 ULMfzx5Zh1TqAaow0Y1lPEUiWSp/mAz+BYbgyXqvuvg+97eB5+8HbD3XdZ4ktNT3FXOvd8YvTa3
 Iw3JwCqGKBn1bfdsDJEmYBB3zN8VGlMLdLramCfgdkLr6FzgY=
X-Gm-Gg: AZFdTZe3M++13nItiWiZS16XDScCoVcAy95W5vivlNyMVjhHZjLLQaMDtPfVxFn644v
 ZGKACj08GR0wAWD3z+4741t7BjbhAXWJHIn7v5JJP7W15GwePVB2/0GN6rgwNs8jblei+oxQOhh
 SdJQamY4+SLN3+vrJVSsrKeynNOgJJH3V420YH3rTquvTvisEL488KxlYFSBIGwPQqB/Xm1piYb
 yqu4wsZ8XerP1QFfZFA6t4CUGjb/gYLlFseQ7Wic7Rc+OBuhcXCe7mnHBPtKGZlt5oog48Cg6pK
 Yjie3pSjxuhiSBMmZRpVK4pNmtVT/tNcVYBcdSFRvPQwa+Z39F7QAM5Ap3TtEcfSIGD5kWRwn61
 18eIgdwtu4TpdqHXTm1q+EBPmhUjx9YuIpOHbT6/8VyzTUyoGiilzZCc5ugaY8OVEn2w4JLrTOv
 Le9Fp/mThwr8pu2ZurXiAnBy1EbGbG//iy9c3oRmk1EWCoakNjssQfYMakqdr/IzkoQsNng7ZGV
 jsEmNO3AkYH3RBgpiV1poKKmyQZ0Gw5/padhReggYvp2MyBxrAOhx7TqqlGNseqQDVOn466uw54
 DSX3kvNrWJ0p8p47Vipxrswb7of5QHm3sAUxZwhWTMMg
X-Received: by 2002:a05:7301:f02:b0:386:a3a1:6f24 with SMTP id
 5a478bee46e88-386a3a17d5fmr8784211eec.24.1795501116083; 
 Mon, 23 Nov 2026 22:18:36 -0800 (PST)
Received: from localhost.localdomain ([147.136.157.1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3856456e6c6sm37267500eec.2.2026.11.23.22.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 22:18:35 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 24 Nov 2026 14:18:14 +0800
Message-ID: <20261124061814.271452-1-jingxian.li@shopee.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 25 Nov 2026 11:01:06 +0100
Subject: [LTP] [PATCH] syscalls/inotify13: Add the linux-git tag for rename
 event fix
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: "jingxian.li via ltp" <ltp@lists.linux.it>
Reply-To: "jingxian.li" <jingxian.li@shopee.com>
Cc: Hungyu Lin <dennylin0707@gmail.com>, "jingxian.li" <jingxian.li@shopee.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

inotify13 fails when adjacent rename events with different cookies are
coalesced. This is fixed by kernel commit 581230d2ec3c ("inotify: do not
coalesce rename events").

Add the linux-git tag so that LTP prints the missing kernel fix hint
when the test fails.

Signed-off-by: jingxian.li <jingxian.li@shopee.com>
---
 testcases/kernel/syscalls/inotify/inotify13.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/inotify/inotify13.c b/testcases/kernel/syscalls/inotify/inotify13.c
index 9746d70ab..8d961dcb8 100644
--- a/testcases/kernel/syscalls/inotify/inotify13.c
+++ b/testcases/kernel/syscalls/inotify/inotify13.c
@@ -204,6 +204,10 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "581230d2ec3c0380917d1255792508851e7c4627"},
+		{}
+	},
 };
 
 #else
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
