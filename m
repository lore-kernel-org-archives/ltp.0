Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F6CC64ED8
	for <ltp@archiver.kernel.org>; Sat, 25 Feb 2023 00:35:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EA4B3CBB91
	for <ltp@archiver.kernel.org>; Sat, 25 Feb 2023 01:35:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77D163CB036
 for <ltp@lists.linux.it>; Sat, 25 Feb 2023 01:34:50 +0100 (CET)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E026260057F
 for <ltp@lists.linux.it>; Sat, 25 Feb 2023 01:34:49 +0100 (CET)
Received: by mail-pf1-x44a.google.com with SMTP id
 be12-20020a056a001f0c00b00593e2189278so320593pfb.19
 for <ltp@lists.linux.it>; Fri, 24 Feb 2023 16:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nDM3B3vbEgaqkBqVTEB/KE433sy7DwludmUWeRToUv8=;
 b=DNLY3VJtlooRIKi9WTGRjAhmRHs/JJ2BexrUWRtTN27Zp7mzcmpojlL8FYMVXlanRV
 4dy+alxYH3iVMGWyFlVANhJrkzJJq6IcxGxSFItDGMwtVy2NQq2AP9+FKAIRXt8cORAz
 1Xg+/g1Egz5C4AieUGcNdWP2mScHGW0RLFdCkQlSMxR1RFBmnxmd/LMkmEFpIQAakMZ4
 MOl5y7UyK82wGXqa9Bx5iEpNoNatoqP89Dccr3Nuh26hNWV5PYXDUSk7UUzMhKQ3JGFv
 62UTLv2a7lh7pJP3OXUeXen4vFyPTbp6Ks/Zvjg35schFeoaWqKLus+ppCEnET6CLQIF
 6J5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nDM3B3vbEgaqkBqVTEB/KE433sy7DwludmUWeRToUv8=;
 b=22BSDV8FJYeDT+Cvl8i5QIjGw7VyIhsRt5LQtlgg8iMSgTne3sFS9cxVUDktFS57mN
 9QI/bUYxrDj08y4HFzF642V4Y324SJSLwaPARBnkp4SVbG2OGvLnu2cUyIxGX5UMioTE
 0QGY+CpnbU8+VQPzJcsVCQDu4XBl1xET+7UThTOuRWK5r4r2X+N/1EulwMX95iO6A1ab
 mC6UMOsvVx7ggINFmpVMCAMb0Dkcgihv9jy4v80GYI2iBKDR5eo10xKq81Jab13x/FeF
 GjMFxeA4Lzx0BkiFJlYBFtpCw+LMP870Ob0m3a4V2LbTF+BQb4wQuFsG1QHevuitBKL2
 fUOw==
X-Gm-Message-State: AO0yUKUwKv8Gm3TZ+mE5ZxaUBjDWUUCxBgGBOr6J3Udxg1O5H3WlT366
 JiH83fQJ8G8Y2g/yiut/bls5qLvQegNjsswgEicEYpvDd/ilaY73JivZgW9Xj+cwtq8M7/7jjKr
 I9tX6qN8mxxZruXKlv9PuV+wDNqpXywohXkJIxpCGZLcjtsrEaSG/M+An
X-Google-Smtp-Source: AK7set9qPAbP3hqkSSrAWMFwwAM+pIcmWfoi9zUUTlcOy5DditI80slOrbh14R8lo7NtDuD2CaoF/GRyces=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:7902:0:b0:502:fd12:83ce with SMTP id
 u2-20020a637902000000b00502fd1283cemr2166492pgc.5.1677285287805; Fri, 24 Feb
 2023 16:34:47 -0800 (PST)
Date: Sat, 25 Feb 2023 00:34:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230225003444.2368729-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] pcrypt_aead01: Should be related to CVE-2017-18075
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

Fix the association with the correct CVE.

CVE-2017-18075: pcrypt mishandles freeing instances.
CVE-2017-5754: Meltdown.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/crypto/pcrypt_aead01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/crypto/pcrypt_aead01.c b/testcases/kernel/crypto/pcrypt_aead01.c
index 5eefee4cb..3b4f5d8d1 100644
--- a/testcases/kernel/crypto/pcrypt_aead01.c
+++ b/testcases/kernel/crypto/pcrypt_aead01.c
@@ -7,7 +7,7 @@
  * Originally found by syzkaller:
  * https://groups.google.com/forum/#!topic/syzkaller-bugs/NKn_ivoPOpk
  *
- * Test for CVE-2017-5754 - pcrypt mishandles freeing instances.
+ * Test for CVE-2017-18075 - pcrypt mishandles freeing instances.
  *
  * The test works by adding and then removing pcrypt-AEAD instances.
  * See commit d76c68109f37 crypto: pcrypt - fix freeing pcrypt instances.
@@ -78,7 +78,7 @@ static struct tst_test test = {
 	.max_runtime = 300,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d76c68109f37"},
-		{"CVE", "2017-5754"},
+		{"CVE", "2017-18075"},
 		{}
 	}
 };
-- 
2.39.2.637.g21b0678d19-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
