Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5259606A31B
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Tm9x4WLh
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 391983E9BDD
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 14:35:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B90E93D25F8
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 14:34:47 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6FB0F14044CB
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 14:34:47 +0200 (CEST)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b402288af0so142218a12.0
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792758887; x=1793363687; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ce/IBAzZ6yyrSRaBzrnEMiFaRc+Qz6tbxmoYtrpuv0o=;
 b=Tm9x4WLhP6tYDwKPuxRBguQQOuiRcIRButaGFpOo0+g2pqAtGX6c8SPqaDoBqYd/VP
 t1+Q3sdYcEEQKnzfESoOxS7fuTaHCyCNF0QLa2vEX0Xxn5H+oToUJt8BEcED+BxtctUC
 FuuPcNXEum9vuwdqpuxz9LyGapvBW7VF3iHCSqx1oO26kOa9qEmHxKcpjUkrJL3cS5fn
 dmS41dp2CKL5WlBRYnqZeOySo8MdFv+XBBMHoI4VW3/cILEsjy8LvxXMKAtpwammuYsX
 OM+Bbrv3/7DFbowojvzQk4/04eK/HDXfaBx/VKxJHQm1il7vWOvuNepmoO/9y4fNAIS4
 SoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792758887; x=1793363687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ce/IBAzZ6yyrSRaBzrnEMiFaRc+Qz6tbxmoYtrpuv0o=;
 b=DU0MPZay682Auv0w1AD4Moe70JfpK8KyOFfCeumjo16R5hxobG00tOE8ygcBgF6iRc
 h+GAMjZLjTHRAweZ3yEBXdQCgDEiPj2ppfY8lpaTN6r0Xe4tni55pQingrqjsCCmVl1y
 c735GjfSpCOF9EH4zT6NRv5zzj9uviuhCyPtZgQ2Ylu1uVofxWV6sfekBSGIL0Ra/ZBg
 /mVz4poUX7PRkPt6z/prQlKfYxqyrfLrxsal6pjwAouN5IGJ1ianFGYvcz+M1Zka6wka
 BBdQmt4zuRMEHu0CsSrrVxrFFpjNzwhIrsqJvI+acrwNdarag9hQ7voLa6eqcftUBUKU
 FkRQ==
X-Gm-Message-State: AFq9FYICqRbzFNYjcXJ/BuxKMA1Q95KG+CF7zsoZxvChMcH0pRZq5ZhE
 KQqJgVqFuc3+TcJbmwwpf4U/45ydALY4Je/SXpu9AZE4XTu+30rVWVDd6ZoAtt40jJexvFI+8Cd
 HEeJH
X-Gm-Gg: AYBFou0fCORXq6yMo/UC1uZDmJCDw6c2TjsUxSp7Ntgr6WtSEPriE6M8okczUngURZs
 OzZEnbEsNOsblL0id9N1sXEAJrH03DSjajL/SrWrDAC+uzh8fVDYr/9xzzf2FAMomE6h70Oicmr
 mMLxn9JvA6RAmZJ7lAdhoE/qpwH0gSMFj1pKPEtYleSXDtbEtsAKqO65BEd4A1ihW9Sqgx+t5z0
 90aYkw1X8BF1woYjfIwcLl/Ya68q+zjCT7+ZOXG6RV/bI3gjoIjr1va2k0PemHcR8hdvBC8c3Jy
 wBqQPwX8s0sptCkXemOkUyHAjtqypettjUU5vQwKV18dYQfYJKMAU18vC2k7MjqfFv7V1Txu/93
 RLidV50oMBHBQMhH82IXW4TfmxjE9syCDIwcbzKhhgmDoupCcyW9dJQxKBkDqhY+/Kyy/sy/mN6
 5DzKYwnmVXP7BFghhWUZLsdd+ecOVeu8JxiJ+TUasp4qm4eNJOQpl0rBt4dTFnRZcvskGF2gZ4l
 D9uArSHN2EJHAeszVqZpMMEAK1u0pV6+S3ROjN4653ht4PitIgNRBOff/MjM2Rrj7sRpvAuAuPl
 a5MWwrm7vtA0XuA419n0gl5gHabmMkUsC+ZN
X-Received: by 2002:a17:906:81d3:b0:c34:db91:aa1e with SMTP id
 a640c23a62f3a-c46a925d2afmr281177866b.4.1792758886775; 
 Fri, 23 Oct 2026 05:34:46 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a904fd6dsm87130766b.27.2026.10.23.05.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 05:34:46 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Fri, 23 Oct 2026 14:34:35 +0200
Message-ID: <20261023123436.1274448-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023123436.1274448-1-anders.roxell@linaro.org>
References: <20261023123436.1274448-1-anders.roxell@linaro.org>
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
Subject: [LTP] [PATCH 1/2] openposix: Install the .args files
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
