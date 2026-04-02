Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99028D39407
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 09:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775123913; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=qT3qd/TaK9R+sYLNxDXbcCtF6Fz+Xb+skRsL3FMM7zU=;
 b=Ii1Crhmz3NL1tPzfkjzBSN7XlJj7448oxzkY/TuOMp2IyVsICzZe5fM8jnwmQZBz9oLmC
 xzQPwbrgtRPi3LnAZvmsISaPIbjWmVQEqq8QOsFgOGohkdp6EF7Ub8FCMNo581l36dBHdjv
 62USNRVtO6D1/QtLgumGK22Ogh0T1Gg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37FDD3E2A88
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 11:58:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98B023E1BFA
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 11:58:09 +0200 (CEST)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 12ACD1A010F8
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 11:58:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=/kMLdKsD2PwCg7Ty7tf6PZ0EVGKa5yHMAevqsKDPRZo=; b=J/nG90yq2XQM
 06geP/vut4XlrtkTieJUh+k6S1/0pPHeFGvWh9iJmU92vMmeSwKWe674LjpuBrfbxZy3XQLBmrja4
 nQZK7Cegl4KLv0gfFvs3OO0vlCgsRq6lADkOekpG3vhh1ut9n6k7bNaWpRTqvxKdJ8cM2E2G21uLl
 BfwFkAbHLpFkba532xNurwDbdnw2cUibvkdKEH9WeI7N08Ywq43ImCPLYfOFfXt+xVM4/jcvzLCIJ
 qjf6OwSAFoRawyT3U2wuljkZoeam34D4mj1XcD9NP8ERtInPnE6ulP7mGh+DERqiauAwTGDjz9jl1
 NZDlOy6o6OA6LPBnRMJ3/A==;
Received: from [130.117.225.5] (helo=dev010.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <vasileios.almpanis@virtuozzo.com>)
 id 1w8EmG-00EB3T-0i; Thu, 02 Apr 2026 11:58:04 +0200
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 09:57:39 +0000
Message-ID: <20260402095804.137387-1-vasileios.almpanis@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330102909.863484-2-vasileios.almpanis@virtuozzo.com>
References: <20260330102909.863484-2-vasileios.almpanis@virtuozzo.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] lib: scale checkpoint wait/wake timeouts with
 tst_multiply_timeout()
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
From: Vasileios Almpanis via ltp <ltp@lists.linux.it>
Reply-To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Apply tst_multiply_timeout() to millisecond timeouts in
tst_checkpoint_wait() and tst_checkpoint_wake() so checkpoint
delays respect LTP_TIMEOUT_MUL and slow-kernel scaling, consistent
with other LTP timeouts.

Declare tst_multiply_timeout() in this file instead of including
tst_test.h, which conflicts with the legacy test.h include used by
libltp.

v2:
- Dropped second patch of the series and applied tst_multiply_timeout
  directly in the checkpoint library to hide it from the tests.
- Reverted extra timeout argument from tst_checkpoint_wake.
- Dropped new defines with timeout
- Added tst_multiply_timeout inside tst_checkpoint_{wait/wake}

Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
---
 lib/tst_checkpoint.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index f2faf6563..33db08380 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -15,6 +15,8 @@
 
 #define DEFAULT_MSEC_TIMEOUT 10000
 
+unsigned int tst_multiply_timeout(unsigned int timeout);
+
 /*
  * Global futex array and size for checkpoint synchronization.
  *
@@ -37,6 +39,8 @@ int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout)
 		return -1;
 	}
 
+	msec_timeout = tst_multiply_timeout(msec_timeout);
+
 	timeout.tv_sec = msec_timeout/1000;
 	timeout.tv_nsec = (msec_timeout%1000) * 1000000;
 
@@ -61,6 +65,8 @@ int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
 		return -1;
 	}
 
+	msec_timeout = tst_multiply_timeout(msec_timeout);
+
 	for (;;) {
 		waked += syscall(SYS_futex, &tst_futexes[id], FUTEX_WAKE,
 				 INT_MAX, NULL);
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
