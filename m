Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D221606A332
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QlwEVb74
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20BF43CDCC8
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 23:51:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76F433CC88F
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 23:50:56 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0BEED600047
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 23:50:56 +0100 (CET)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b565211890so194970a12.1
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 14:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793832655; x=1794437455; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ce/IBAzZ6yyrSRaBzrnEMiFaRc+Qz6tbxmoYtrpuv0o=;
 b=QlwEVb74C/lRsw39t1vKizd0wFy6pXFKU3N6J8TeaJaOvnUTcd7VsGbyfS6TgjRa5Q
 GzdZrx8kUAvofL2tXSytSZD8TbgR8ECkcX/NCHIj3EeQSyMi6a6aJVcu7GFC3NXROx1P
 n7V45uLRNvlq5ghsJWbMmZrw592rsLdFHilU8v5WM5miA0TyON1WZOc8V4hAzOUlySLf
 PQ+fik951zHQsFi0zWBnmVKvmkhM4X7lY/OP7BeCMqkp9OxVSbG03zE+Gx4qQpjKaD2g
 u4kYaUtH6WlLytpTde8NdGAlUIYGDk1wbkSJSXAG4CiKLZQanCo4PRdM4SCcvfV/GEg2
 sRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793832655; x=1794437455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ce/IBAzZ6yyrSRaBzrnEMiFaRc+Qz6tbxmoYtrpuv0o=;
 b=wGAHezEfMWuPJHPK05qLKCye7X2SZHUr4SBtwLXRys6MY0q5uw7zRk2UzexOMYKrqR
 bHT14cwIwdEGSAUOcg9CjkXpoj0HTCP/WT7rRkUKtNop6Ct8tA4LNUgBVOOhWCffD/kP
 DrPUOFIorS/25hkXS+758UyJt5UAJZVLHVMe2kaYsF9eY/d5fmj1pYxxUvjjKi3JZj53
 jsd3lZZ3t2YnTCLifcOTWirFhedkTWdx5e2qLirOi/vNE5qjQGVnAXkQX7ilEx6P4wJL
 InspvjMwvRcLgpr1J0sOhuHiNRzQBmpWFkwBBJFFc/I/95m9ru8EO2+K7c8yKsIMTEaP
 KwOA==
X-Gm-Message-State: APuU4Z8ZXJYxJn3h6tsw6ez4xqTHD9t/PMnv60CpR8Kmp3meBHIFEqAu
 iGOKu4wwV6eikY/AlUKAqRey/rIUcYaOj3NyJOUh87bJ0bFb2gwfrQ7MoE+D1+cxED2NJoIhZ9c
 cIGyY
X-Gm-Gg: AYBFou2jLS2XB8Iczple18QuGLvuynto+7J5ACtUN7jGICHc2OARGLUYZdD8l7uT1i8
 m3/rjDVcs+zF7ICMsCN65bNWch8M2zvTJbQMQpdBFwpIXfxHfgvtzKPN+mm2ZDGb2G7TYYzozYN
 a8OTDb+PEL6g9kFgNKeVWilnZVijNy/6KuAUkAdmhmes7YaDV+RlxHi7pcWVNTnkFY3WXPGrdWu
 A9cTh+diwWih10uxfRIDcgcov4QskfBPdFK3Ri3jsI5KnKUUlq417FURxuXCSN01LIUlT1S+Kuh
 HE0m86iWOIk67yRwA/Wqo8hM1w4oL3GIiR5Hkxr18FW1qLU8FP9F8DkJM3EcG8mbAXmlpsafhu5
 nesKu3iO9vWDDKVmbKHRqL1dHbv0/GKCMWnKOxZoXHnK93HGBHvgPyHBVpaQxKz9QryaaNPaYUW
 1CfgqbNlPA7HbXjoggnXZfUjLDquXz4yc6cUbrXoegrFqPPHpW6Cz5iCbeH6tzx+e4HLXU3zXhI
 9U3qB4fYVYY0GIo4w4HU0ERGDBOvNjkn7XCCPxFFFa3UvnBXbqZw3S0g9MZJMe/wh/U69r1GBU0
 MUP1Z9aSVR8VfmiNNfGJIZ7Ciif9DQyH9fKdKOMFV8icjAnZlY339dsuCydq8Y2A
X-Received: by 2002:a17:906:8f81:b0:c25:2ded:ad36 with SMTP id
 a640c23a62f3a-c4ca742df74mr1906788166b.0.1793832655442; 
 Wed, 04 Nov 2026 14:50:55 -0800 (PST)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e44650bsm116722866b.43.2026.11.04.14.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:50:55 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Wed,  4 Nov 2026 23:50:50 +0100
Message-ID: <20261104225051.402911-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104225051.402911-1-anders.roxell@linaro.org>
References: <20261104225051.402911-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] openposix: Install the .args files
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

run-tests.sh reads the arguments for a test from a .args file next to
it, but make install does not copy the .args files. So on an installed
system the two mqueues_multi_send_rev tests run without the number of
threads and fail with a usage message.

Install the .args files together with the tests.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/open_posix_testsuite/scripts/generate-makefiles.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
index 1c12a456cc41..19c781ba8054 100755
--- a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
+++ b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
@@ -182,6 +182,7 @@ install: \$(INSTALL_DIR) run.sh
 				\$(INSTALL_DIR)/\$\$file;	\\
 		fi;						\\
 	done
+	\$(if \$(wildcard \$(srcdir)/*.args),install -m 00644 \$(wildcard \$(srcdir)/*.args) \$(INSTALL_DIR)/)
 	@if [ -d speculative ]; then \$(MAKE) -C speculative install; fi
 
 .PHONY: test
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
