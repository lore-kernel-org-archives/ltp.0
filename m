Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C220C5DF81
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787579863; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=noiBSbllkeq1P7txlmL0t3wkKHJP2IfF8nn3rmMOMgY=;
 b=m9MNf5ZNIC2ME6tizSvvGeEvZiwG0Qe2bXrMNuhbGDvwhETdEpi2YK8jFVWLUEklWZOP/
 q0+O/sMyNXRuV8ehzJJSln5ICZ+sf3XtdAgb6I1NSjrFE1tc+mqzMfd1mim5vmqbhxeelE2
 A/Lk5r5xalFxCD7Pm8LylRWsMV69kI8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BF0A3D064C
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 15:57:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 673363C5751
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 15:57:24 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CD29320076B
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 15:57:23 +0200 (CEST)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a374bea882so6682695a12.1
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787579843; x=1788184643; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z2Tmj+KevuwMW6l2icjIJ76ppX6H0UnKJdye7k9w6cY=;
 b=S+j9Vrm3HwFfB8uo6rnwl/tVjOsYQFiZIBXFT8QgeoYgR6W3cb8TZ/wU60kFB+l+6Q
 aBieF8lfmJElrVrTNsj87+DthEZuO+tMffGVs6kM3q4DTpznGr1A/jz8axtUYaIrfQ3s
 yeAOHhig81id2AprWkknkw7gX05URPxqqZu0lrWV2fnmx7YjzL7BH9zRKAbk4rCymVZ6
 6T2M8gnqPZaJ3Xy0wUD9Qg52GdVQXBcL0BgJNdS5rYGBbcXemoTpl51FjE55y8Dk32Qp
 YQaLO1GZy+rmnNVbhr5rbwCfxyxW/gDiXHKVk3y5ELXZbi6GxCshjNaT2gzI1S716Y1J
 ZKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787579843; x=1788184643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z2Tmj+KevuwMW6l2icjIJ76ppX6H0UnKJdye7k9w6cY=;
 b=DxlmziU5OBQxc2BUjvdZVJXqIfxSKmt/NIhEDjUycu6nJJRDhhhJgwWixka7Wcjeav
 3IUcinPYQKBsMK8wecFxkaGgYbUnDsSqmO7q88JfLPpmJetfH3A/PiQpTxLWAeUghMkk
 J9UzPrLqSVe1mo8bp4/M7HDs93YXydm+53Wggt9Qo22uHnUvNEMnpHjE2vRP3Q8S2DE/
 tNAKSCCfbT+j3yVk+TJUseLp0yTj7KFkT9HL9P5/IiOoUCJGzNOVz7h/uy74rcN/Mmhx
 YwAZashdQsJJZKadn/StftMGoX0xfdrr85nb+UjNFt/oyNXqciFmq/AFKW/mWBgJO0m3
 WTSA==
X-Gm-Message-State: AFuF++n+18XShRgay6u9XQOwnC1KL5+rT/xdhtFC9TEWQQ1BgPiYZwk0
 XGBw/a0PQnQpRtyEGavsZD8IiS6BmMV43s7RDtZ4ajnNfF2vLYD/JmYjfhIOhxlrEXv6PTclPx8
 wmMonkvE=
X-Gm-Gg: AR+sD11GiXxOSuAZ9jiE2RmZ4XmAjDPRRrhBaLsA5ycrN9of5uIC276MM3Vf3cUfp9O
 dqZ9LWXwnROP5cC3/q3Lgbpmyw8xJyNKxqMgVjLVubjEW7OHVlwu0/oveOIkYSJNyypiOb+NBHq
 H5sgLjn6UKQINqlWZW3XQyiriKYpnQq3OWYeryQwW2L+T/wD7TjU+uKbi9FaKIUcUONI0AWbSZ4
 4kpsi3gMHsRmNQnUqClFBeY5qgcivxDIiB0nE0ZnxV/WUVPZX8rS2NXbIs850G2qwCqPXgPvxHd
 ceoSV6h+aPD095k1CvaeHxsjyJp6BDhvmSBQowNkNhXPqZQmu4DcYzf7jddKJBZPfPpwvlreROh
 WuNIwDQjhSFgGId8FhV3u8cyjuTjJe/E1TIFMJGYHnGD8chhz5nKwgj6P6im4hynE9zC6mu2xz6
 h7gRYChllzVm9U+hG77VImnz0c8GM61jDUvd5ibe/fFJaYIg==
X-Received: by 2002:a05:6402:5406:b0:698:c13e:179a with SMTP id
 4fb4d7f45d1cf-6a42f1bcdb3mr28768404a12.10.1787579843140; 
 Mon, 24 Aug 2026 06:57:23 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59dfff20asm9570788a12.3.2026.08.24.06.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:57:22 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 24 Aug 2026 15:57:21 +0200
Message-ID: <20260824135722.200152-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824103832.4058-1-linuxtestproject.agent@gmail.com>
References: <20260824103832.4058-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] landlock04: Fix false TFAIL in _test_truncate()
 deny path
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

commit 8643b01a68cf converted an intentionally-unchecked open() call
(used only to get an fd for the ftruncate() sub-test) into
TST_EXP_FD_OR_FAIL(), wrongly asserting it must fail with EACCES on
the deny path. Its outcome depends on other granted rights and isn't
guaranteed, causing a false TFAIL when it succeeded.

landlock_tester.h:257: TFAIL: open(FILE_TRUNCATE, O_WRONLY, PERM_MODE) invalid retval 4: SUCCESS (0)

Restore the unchecked open() on the deny path, keep SAFE_OPEN() on the
pass path, and only treat EACCES as an expected reason to skip the
ftruncate() sub-test.

 Also fix SAFE_CLOSE(TST_RET) to SAFE_CLOSE(fd) for consistency.

Fixes: 8643b01a68cf ("tree: Use TST_EXP_PASS_OR_FAIL() and TST_EXP_FD_OR_FAIL()")
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/landlock/landlock_tester.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock_tester.h b/testcases/kernel/syscalls/landlock/landlock_tester.h
index f44721245144..904e43d7f930 100644
--- a/testcases/kernel/syscalls/landlock/landlock_tester.h
+++ b/testcases/kernel/syscalls/landlock/landlock_tester.h
@@ -254,7 +254,14 @@ static void _test_truncate(const int exp_err)
 	tst_res(TINFO, "Test truncating file");
 
 	TST_EXP_PASS_OR_FAIL(truncate(FILE_TRUNCATE, 10), exp_err);
-	fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY, PERM_MODE), exp_err);
+
+	if (!exp_err) {
+		fd = SAFE_OPEN(FILE_TRUNCATE, O_WRONLY, PERM_MODE);
+	} else {
+		fd = open(FILE_TRUNCATE, O_WRONLY, PERM_MODE);
+		if (fd == -1 && errno != EACCES)
+			 tst_res(TFAIL | TERRNO, "open(%s, O_WRONLY) failed unexpectedly", FILE_TRUNCATE);
+	}
 	if (fd != -1) {
 		TST_EXP_PASS_OR_FAIL(ftruncate(fd, 10), exp_err);
 		SAFE_CLOSE(fd);
@@ -262,7 +269,7 @@ static void _test_truncate(const int exp_err)
 
 	fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);
 	if (fd != -1)
-		SAFE_CLOSE(TST_RET);
+		SAFE_CLOSE(fd);
 }
 
 static void tester_run_fs_rules(const int rules, const int result)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
