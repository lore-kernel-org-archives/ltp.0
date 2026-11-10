Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32F7606A326
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=oSCLb6te;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=MO9rAmB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794324378; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Ab6U1jfAHE7lMSP+C3yiz8WWpsUWlX3s9/pss/cqTss=;
 b=oSCLb6tePfNWcklzgW2kiN/ex5utHbHEFyDM3tV08XwGAKpKeuMSnvurK0qgAr/STDjAg
 sUXKwIe1NT10eTJ3yCIjcF+dwuSKLD1glTj1zjGvpxTYbRRei4mMUD2h6qzrNVZasCy4q3S
 edfaMtpECvzSuPLtOHeD0RcF46rTp9Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F2753EA187
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 16:26:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21F053CB306
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 16:26:00 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 933911400077
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 16:25:59 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa87so1424433f8f.3
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 07:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794324359; x=1794929159; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T7ierB4HBqMrbSFxGfjwE9yfWW+rxlt3GzT9JLvE88E=;
 b=MO9rAmB4qgNgRWn76ajYd36Qh4w05pMJXowHlM+Wh6uy6KxRBJPyFIyerbZA4w2RR+
 9GY392e5NpdUZPBvovcIz6GOWxzMMfpDLLCgW3I0r/SKuQAXp8fQ5c1jsxZZbJbS1tY2
 K7dUxSmZHBMGK4OaZUdBEKHDAA8WM6DCEs+k8G6VrhzgvsIuWCiMJO2j74cAjB39f7b/
 VIIkrWBxU/OY/h6OI2xx7jYHz1mihhD6WztFJoJbzzBazYqqGHv3LJKqvWDdQx+43Zvi
 qUF4dCdddsv+uF4ZtoFHNed4pgOiHmyx4QgPOWO2S1uddVEPG34vSrDLIYAmrNBuxyj0
 y3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794324359; x=1794929159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T7ierB4HBqMrbSFxGfjwE9yfWW+rxlt3GzT9JLvE88E=;
 b=li+YhOllRgaqB9kkRL37UhqmNgabXAVj+4M2UWIYMxC23cNNMne9ZV4+RZ3qst0uFP
 qAX+z+37hT0t2lviEVz3Ae7++EuTEAJeefg0TBD3JWBLhiZE+tGCG7BkxpTbbUoA/MZN
 ny65e//81NfbUVsJICDe0o2TJkYHENq0cMzanqFmSHA+Dl5I/GFdiOAb7DGyYs8eHZH/
 sqrnZsh29Gkt7rtdjDI7MXTUvRti0B74887hr5qCLMUbhgqbhcbv4gDhRebJW61JqRTS
 X6jjm6RTv2kqATD8OxnnperYJHtclENIA1JeOibl4zG7zrwFSuyq8EV0977bE3UvoLQO
 aU0g==
X-Gm-Message-State: APuU4Z89o1vLPy6yfqF5tko7rH0qps86F+rUNqGSdYGpag6lvMk3xHey
 V5q9+oIzLw46ouAFMGoUrT6zONeFvpETrJXQ0SNEMhYUDXIYU4AIqHyHVPbe2NVkTBRVBEZC8/a
 E51NQj70=
X-Gm-Gg: AYBFou3q4yS8DipEGqAAZCpA6IzYSbN0toAV8LL11ZmEaY/yekfyHFMwoPaqCnTy4Uj
 Frlm756vIc6X2FSf6z3KbWuFnRkIqEoHatS2WKSBs2LkFpfmNAFpApyqwGz0/+/XmUe5V8K1oXS
 1wleBAFGPpWGguRAqgBa9CCongTuPXBrLQLb3P7iO6dqGCPPm5B+AwgUTEt15+Ev27zlnpR6Uhj
 YFa+ub2Gcx6zF/1OX7pidjbfF3lMWJZG1Aqt6SE6De4CWjr5ev8xD42hTIjYVKas045pUNLd3xV
 OlW2ebryawb7tttJEZwiJ3f5bbFfAX42W+QJ3xlVRW5Kdeo6WngIdBhtgLRu079hyUOPJ+UmVgK
 v1glgh53QaGSz+9WVT11/68H1b1QV6tLGtSm8Dxv6+uy04VIc3UrRrb2lkoACYdgpYE1Bs95ukt
 xYgTnsIJFgAvDR8cbPsuGFNOQsmnTlsO2txagXPPNvBYk0ru9ZmNG6iMl9YQDYQMWl3LhW4IFPi
 lgLDkSmlumZafDnhf1CvoOYiuMVDJ2JnIc6eqNBpAsTdKIdSnT0GWgXQlVQYPSMithE/Icx0kJY
 2rzzkJjNCImjakp1kfNtnfjDvBwGMtQOjn29W8LpOgOmYQ==
X-Received: by 2002:adf:e007:0:10b0:490:9fe2:6a2d with SMTP id
 ffacd0b85a97d-4982fa5d089mr4139487f8f.26.1794324358668; 
 Tue, 10 Nov 2026 07:25:58 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4982eedfb36sm5855849f8f.0.2026.11.10.07.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:25:38 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 10 Nov 2026 16:25:30 +0100
Message-ID: <20261110152531.382231-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve/ghostlock.c: Print return value and attempt in
 TBROK message
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

The check after FUTEX_CMP_REQUEUE_PI breaks if the call did not fail
with EDEADLK, but the message only said "did not return -EDEADLK" and
TTERRNO appended errno, which is 0 when the call succeeds. The resulting
"SUCCESS (0)" reads like a return value of 0 and hides what the call
actually returned.

ghostlock.c:243: TBROK: FUTEX_CMP_REQUEUE_PI did not return -EDEADLK: SUCCESS (0)

Print TST_RET and the attempt number, so a TBROK here shows right away
whether the call succeeded (and how many waiters it moved) or failed
with another errno, and on which attempt it happened.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/cve/ghostlock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/cve/ghostlock.c b/testcases/cve/ghostlock.c
index 3afedf9ab5ad..b37d6e9ca4e1 100644
--- a/testcases/cve/ghostlock.c
+++ b/testcases/cve/ghostlock.c
@@ -240,7 +240,9 @@ static void run(void)
 		if (TST_ERR == ENOSYS)
 			tst_brk(TCONF, "FUTEX_CMP_REQUEUE_PI not supported");
 		if (TST_RET != -1 || TST_ERR != EDEADLK)
-			tst_brk(TBROK | TTERRNO, "FUTEX_CMP_REQUEUE_PI did not return -EDEADLK");
+			tst_brk(TBROK | TTERRNO,
+				"FUTEX_CMP_REQUEUE_PI returned %ld on attempt %d/%d, expected -EDEADLK",
+				TST_RET, i + 1, ATTEMPTS);
 
 		TST_CHECKPOINT_WAIT2(CP_SPRAYED, 18000);
 
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
