Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D7606A329
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=utll3F40
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 316703EAC2C
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 22:10:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7F993E9EB7
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 22:09:41 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 267821400DC4
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 22:09:40 +0100 (CET)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c50537f731eso88900966b.1
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 13:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795640978; x=1796245778; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=80jQFiVkaTNjHC+edv0PHjSyBWCTyi4nWu3EuvmDCQo=;
 b=utll3F40CMXqsPmLjd12Baqerp/4RoATxqH18D/9HiLXrO/7WgGLuN5H/rZND+L/nS
 38TI+hg/VtlFDp/5ES95wUOatDI3UpMVzAVs2RUiWRsfnxYvhwws5+7aIUE6Q/Da3bIe
 jelCNfMFQrwAPr1bR6tE8zYbqSUjIyFQA8Cr3zOmLlOliA3r4WLWObOTL+lB0qt+ae53
 hYWZe2kefdGRY00z/Avuoi6h7UwWSd3nGm1AA8xL71vR9VVL4e1/WBHSuffadKIWjRB8
 kKDRjTU+m1vuDQndEcJQdW6qZQAyKV81kJUul/vQww303FSrK8rtCWjnd9Jq5aubzZnP
 VVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795640978; x=1796245778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=80jQFiVkaTNjHC+edv0PHjSyBWCTyi4nWu3EuvmDCQo=;
 b=ROQ7HdFcAZswTEhi5Aep1QvgoXmSS5CUzu5234hWsW1JOPZ/zrZ02SEKoLWWBNYCJe
 0jfk38YidLS0pOyhAJNWaRKlEJKiNsZ9ABhp/v0smgs28gzsPD6i6s983UevFpIpfZKH
 ig2mUXjBK0FjV0pE1RX+G7QYykPVUJD7KpWHrFAvDz8lgOovqSJ32gYJJJkjT93LAakH
 KD4B3IvFdMSKGAPpbQqjSFftCi1JBkXtg2Nvy5JFUp1OlZVsIB6XpkFyG/4P1JZ0VIoT
 a7WJbSsBru1aldGPMNJuaKZFSehEX9SPFfyXW4EFDu6Olwy7pG8vUkB90ciERgXIHCKe
 uN8w==
X-Gm-Message-State: APuU4Z/dmGR+OL+HZsFzHc2LLbS0ftupAFyqCkIPh8lr+VEqIdWOagAK
 hf20GAvzg04mpNKQfl5UWWeH2/HEpXeUaD9MpkNcowJBINGjr2UYZnjU0NZpdsgrjWp8cfhYuPv
 QX+Vl
X-Gm-Gg: AZFdTZdj9XTqBXmAxegV1ifoYVhBFeFogFY3pAFa4MpcQrxv3D6GEOXhb/pz/VWPySl
 BZfjXTiiIq0+jGdejVpjLaTeYN3ZpRqezXZnUDxGplw8VJXbGRCNxeCogzE+wUyilikFKq7VuZw
 pCIhle4ODBFQLIOM1nMO1oRiUpa1sIYB010g+/2ckzV/xujpm5atgOsgj3vkfEphADfa7P4hpbu
 vsUP59IGP/CoykvBZbXoqWSlOzyCWyfcEPlh3Vs+vs3qc5EbPtVsng9njDVzS2Ntf+gZsjdd5XW
 F3N/Y4D7EI6CQZlfVRq2Y4oVRv/a2SHLKJllB2AZjScIgQ5kgHdX1tCzHT973U7XAfTozfyAxIN
 PM0lEg+3iF407/XDiPH86IICjJNRuwBuDtd11AfzWKIhIFl6yVgU2zfDhsuJ2TxU3CTDesx6Ej6
 L4qPYYfYoDcwkSK3eB6sT+Vxk1Li1ElB2aiHjbHUPbU9ZTdEnVR7RChYITqx2cfeEC6QbLV+rOf
 s7q8ZyPJJGoxy4QGyXbsnBultTXM4ytVqEMvJXarKGsKzz7mtJWULuSiU57weLkDHfwuMrim9o0
 FiyIAbbvmvuZk1r0w5P6DtSoVyKDhkggFGgxmShbVwZl/Vcnd0oWRdwsFmbjQOj4
X-Received: by 2002:a17:906:fcb7:b0:c50:d900:8536 with SMTP id
 a640c23a62f3a-c513a3a33dcmr1538756566b.1.1795640978578; 
 Wed, 25 Nov 2026 13:09:38 -0800 (PST)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6872asm672506166b.13.2026.11.25.13.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 13:09:38 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Wed, 25 Nov 2026 22:09:32 +0100
Message-ID: <20261125210933.2913177-4-anders.roxell@linaro.org>
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] openposix: Rebuild run.sh when the Makefile
 changes
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

run.sh has no prerequisites, so it keeps an old list of tests after
tests are added or removed. Only make clean fixes it.

Make run.sh depend on the Makefile that lists the tests.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/open_posix_testsuite/scripts/generate-makefiles.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
index 1c12a456cc41..b9df91e14b62 100755
--- a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
+++ b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
@@ -200,7 +200,7 @@ EOF
 
 	if ! grep -q '^run.sh' "$makefile.3"; then
 		cat >> "$makefile.3" <<EOF
-run.sh:
+run.sh: Makefile
 	@echo '#!/bin/sh' > \$@
 	@echo "\$(top_srcdir)/bin/run-tests.sh \$(subdir) \$(INSTALL_TARGETS)" >> \$@
 	@chmod +x run.sh
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
