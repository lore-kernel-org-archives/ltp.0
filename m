Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A778606A31E
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Btw2qgQ9
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DC1A3EA95D
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 22:10:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F1C23EA956
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 22:09:39 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 853C01A0034D
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 22:09:38 +0100 (CET)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c408e21e8acso94585466b.3
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 13:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795640978; x=1796245778; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S+hSPjO0WRNBrQuoF6ldx6aNfx0OgyZvFU+BqrrpeJ4=;
 b=Btw2qgQ9J/viz8nCKwYh+cJjJbWnRZBn1t2z2KiGOe6lf9CO5H0F3Bzr8BSsYpWQmA
 FNYeRICn2Kl1R95UwTjFDb4ouHyo3nRI/QzUMXCRobi4QYUafMRnVVlpGKVOQ1u03os8
 nBSXld17xUpsAH+KhP6MNZobmjjB0v5t/w4mOB5XGGneGrEUKCN0UJSdkQ4ILPqbGUHo
 qQbqQhzAKojEHgzdI2df7K8KEw5uXdsV0KmXWJeSJ0FLYdB6QEMExZ6FBANVybH54Mxs
 J/HZmMsISTCTeUlPycPLiHGitl3jYqhUn//cA72B5GswbUY8LuTyp7ak5gyvR6xdUHdS
 S2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795640978; x=1796245778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S+hSPjO0WRNBrQuoF6ldx6aNfx0OgyZvFU+BqrrpeJ4=;
 b=DRGLxGaB4KqVS5I0tSWdMHevZMWJ7+UC8dkcqeE2afKZ51UuI7cVIB94L6l8u28HCL
 p4j/AjRKxUHDAhxDkF1QOgoOfSfZjsCdlxOvUacIrku36uAjrUWgB1GTHmq6mv8zh4zW
 oLP4Hz3QTWjVHvRWNvypK3suACtxin4Pl2t5GuHH3jgJlOGYRtnCmtQgF1BvKimI0hrw
 0TkmbNSaVLXhhQIt5i+ntej8mfCnsajVOlmzxVqF8plge3oYEW3BQcDFd//lZ0EQ/Luy
 OWW7BKtOPG8uWRrN6m+VsS8hDOIKaDWiuRakFx+MKZJx17JWg3btcTCnr6r/P4oCuMD0
 xDWw==
X-Gm-Message-State: APuU4Z+aWsvs0gfgczE11+XC7MAx0LM1adlPdZclIkpDDSukO313YWHg
 yd+SdXr7ApjCjzwqSFL5zQhuvpzeKvQeoKQ7KfK/mAcLEMZjhT5etYdgETAvsvx2ij2MCbE6yAG
 9tliM
X-Gm-Gg: AZFdTZdXUl/tV2sjEc+4ZXBpaN6GgQ9IYOd7UiaXwwnYnlDlNLbBfBnoXHaP+nBVMYB
 wqTdPqlnRXVsR4Q0yaldy5E1WICZB1byjMrsJutL3xEUHUjiUa0/SYKvMMrUWaUq32/L24J1Wws
 1Pi4+ujrGKV8Sf/3nLxlol/yr5mxzrTrrCvkXJwux/4L3d4e/Stu//eTIjOzXQF9O9IkEyP0BRa
 t8nXehFFldxztCBb21C9ncz+qprsghrMDRf+Gba8RrtzCzmBxQZuPLH1mE7jQ9thFCf+cdmSY0K
 deMSLxHkbb6C05nwgtKen1/lGOzrydPZkwbVJNguAiZE1Ml62OfrgMBHTMltIsVmmjROLQM43qk
 IuXI66dubVWwNEhpXg5lpd97fuufYEZNzGDHfqC30O2N4YlV/immBnlc7g/LDZHsfCVplNXn8wZ
 3XfgTAhvDaWCSh5HtSDofOx5EZR5E5k9aOoVpa/US8ksuCrS9M3b7n6kMIJ1sUum2rtOkixbg9T
 Lkf2vPTbCZlW0CaJYhRu7l9IVno3+ih5en3sQaJzS/GOB0Q4/Rf23SF67/HRBlPqClwwC2qJG+A
 GCGST1IYwTbhqcDGSM5BATgNANK2jqj5mhwaWJ0spCxq+Qr1Y816JiuEinP2HMkGkuyqqE2ifQM
 lRME2L8GkSA==
X-Received: by 2002:a17:906:6042:b0:c3f:98d4:dfda with SMTP id
 a640c23a62f3a-c513a5f04b2mr1425041066b.3.1795640977822; 
 Wed, 25 Nov 2026 13:09:37 -0800 (PST)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ad026a4sm704085666b.2.2026.11.25.13.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 13:09:37 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Wed, 25 Nov 2026 22:09:31 +0100
Message-ID: <20261125210933.2913177-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125210933.2913177-1-anders.roxell@linaro.org>
References: <20261125210933.2913177-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] openposix: Remove the .args files
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Only the two mqueues_multi_send_rev tests used them, and they now use
one thread by default. Remove the files and the code in run-tests.sh
that reads them.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/open_posix_testsuite/bin/run-tests.sh                 | 2 +-
 .../stress/mqueues/mqueues_multi_send_rev_1.args                | 1 -
 .../stress/mqueues/mqueues_multi_send_rev_2.args                | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)
 delete mode 100644 testcases/open_posix_testsuite/stress/mqueues/mqueues_multi_send_rev_1.args
 delete mode 100644 testcases/open_posix_testsuite/stress/mqueues/mqueues_multi_send_rev_2.args

diff --git a/testcases/open_posix_testsuite/bin/run-tests.sh b/testcases/open_posix_testsuite/bin/run-tests.sh
index c2fddcf53733..a2b628273120 100755
--- a/testcases/open_posix_testsuite/bin/run-tests.sh
+++ b/testcases/open_posix_testsuite/bin/run-tests.sh
@@ -46,7 +46,7 @@ run_test() {
 
 	complog=$(basename $testname).log.$$
 
-	sh -c "$SCRIPT_DIR/t0 $TIMEOUT_VAL ./$1 $(cat ./$(echo "$1" | sed 's,\.[^\.]*,,').args 2>/dev/null)" > $complog 2>&1
+	sh -c "$SCRIPT_DIR/t0 $TIMEOUT_VAL ./$1" > $complog 2>&1
 
 	ret_code=$?
 
diff --git a/testcases/open_posix_testsuite/stress/mqueues/mqueues_multi_send_rev_1.args b/testcases/open_posix_testsuite/stress/mqueues/mqueues_multi_send_rev_1.args
deleted file mode 100644
index d00491fd7e5b..000000000000
--- a/testcases/open_posix_testsuite/stress/mqueues/mqueues_multi_send_rev_1.args
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/testcases/open_posix_testsuite/stress/mqueues/mqueues_multi_send_rev_2.args b/testcases/open_posix_testsuite/stress/mqueues/mqueues_multi_send_rev_2.args
deleted file mode 100644
index d00491fd7e5b..000000000000
--- a/testcases/open_posix_testsuite/stress/mqueues/mqueues_multi_send_rev_2.args
+++ /dev/null
@@ -1 +0,0 @@
-1
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
