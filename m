Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85414CD8C9D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 07:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780904683; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=aMbLb06pvLu18re/f2tqIFgqdOKH0YUvkHJTGCUfOxc=;
 b=jk+YmiEn/enuC3aDNduB0XLSHa9wqJcBvEhLMa7+N7x1Umptk8hvpYfJV8S4JQ8gNftN7
 x0yGf9WLBb8rNcupYVv0jJVChn4afkcL4Tm4894iSPlsQ4J13CeQkg7vgYjyFbYn8ccRPdj
 1h8z3FtZlTBIyHWPRSlMU+9gnD1K9v4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB97B3E2FC0
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:44:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1341E3C22A5
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 09:44:23 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5CF2E100018C
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 09:44:23 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490b2b037d2so34680215e9.3
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 00:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780904663; x=1781509463; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tXw0Y0sItuPtOOGShKNJAc7VIE5fT0XfmwFQz4m70CY=;
 b=B5X4nw/+SMw+99xgvoTql2UeyLHFFd5+RrtYkwvMq2X1fkjaxeth6MEHuFepWjyk+4
 dTRiu55TmcnG3ZGz8SAMf7y9Sde6gweEq7zvFUlZrqdM7UH4eGsRIXy1RH6cuU1e5+Dh
 8Y5W6Ni8P+4+t4krEm6v5abRGuQAFM9re5D56gAxaC3W1OvOL291y1aJSp/eUDYqG1GL
 qJW96u51eNkgkLJruGk0PmpNphNTTyncx9TzuBRebysydksyphLFQ3tkB63tVwybPowj
 CoIaP+H0DnoahRyhAl9dEtVoO6E5qk1i8xvVW24k6OCF0whnjDcoQ6YNNRJ3Tw0gfrEA
 4bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780904663; x=1781509463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXw0Y0sItuPtOOGShKNJAc7VIE5fT0XfmwFQz4m70CY=;
 b=E8u/uLcE+U38jNrcw9YKnSP6cFYp+Ze3LnZ1hKH54rrEXdU9CDFQ9j0BFGQHRjko8M
 2vXkYzVO4sVrEANF1H3W7yW/jCJ2xr3d+uQxHtitlGlx8Lb5L+BucnBKNkWN9aW4R+KH
 bLEjn9p84brgZDyqmY8pYcqtxq7oEiOQoLmGwAmoUMfexmohQRAn5U4GC8sajBKBDzht
 YszAW2byMNmHA6TcdY5VIQaIP5jBumi6pUCO0biM3xIFiJK6b1Cr3jtvSrMYeEJR8Z2o
 Z41efHB7suyIbuxs5gjIjEISq2tifnR+RI32xeSF/D6pNXAWPHDaG/o9q3E4Yau77hnQ
 VgUg==
X-Gm-Message-State: AOJu0Yw6n8k41ZgCGbcs9xJp339LEMrB8eolHOIRjeASvwopVfX4Q7+d
 XXiZzqZ2dPRrjNV6h0DUF2bF2cGqmsO9k5doITkJO2mcVCWe4ZQgYTjAgiNCGgo+zLUyOKiUL3e
 gzt4=
X-Gm-Gg: Acq92OFGN0i/7fJqcKxE6jS7PWN+0bTzom7JtO4+2LdXHgTPBeO/8Itx2fh57HoLje1
 Q00H/Go5aDzOJx+7XvGYTm8yNzDsksMO+AH/L+tK9J2zuZoN0fahe5VDhPoG+pP5r3H98RuWwKj
 9FDTMChcmd1ajf2QdD4zhjOK3tksOMU99roUW1KwAYzX75DiS8jSpAmrNK2bOz/EiQTz9ZLQwLM
 fGCuVWKH73JFnDYC6l7VyK4cez2/5TT1kwNNOZJoMQhNy7fNKaeFrP5xkDDhxiqbaUoimSxbf1A
 bVxFvr47Nz55DXn8DIWVdnW2kOQD9H81RPA/YeQfU2R/DULR6npbf5CuucMC4JsoskZBnWcoGgi
 fteeF26PYn7uhhbnscg9m114pGWjxZpheE8jjPSSXe+VBpsIMSq/M/ZIFhpYsDswZ3f2O3qWqjN
 IWKCO6N1n+eFHhJEAGnea/5g==
X-Received: by 2002:a05:600c:1d12:b0:490:7227:100 with SMTP id
 5b1f17b1804b1-490c26049a0mr237439695e9.18.1780904662820; 
 Mon, 08 Jun 2026 00:44:22 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4601f3444fesm50901425f8f.20.2026.06.08.00.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 00:44:22 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 07:44:15 +0000
Message-ID: <20260608074419.1276-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] ksm: Fix sysfs path concatenation in ksm_test.h
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The check() function in ksm_test.h was concatenating PATH_MM_KSM and
the relative path (e.g. "run") directly without a directory separator:

    snprintf(fullpath, BUFSIZ, PATH_MM_KSM "%s", path);

This resulted in invalid paths like "/sys/kernel/mm/ksmrun", causing
the tests to fail with TBROK (Failed to open FILE '/sys/kernel/mm/ksmrun').

Fix this by adding the missing slash between PATH_MM_KSM and the subpath.

Fixes: 40a366b53adc ("lib: Introduce tst_path_defs.h to consolidate system paths")
Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/mem/ksm/ksm_test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/ksm/ksm_test.h b/testcases/kernel/mem/ksm/ksm_test.h
index d04aa8e2b..d3f61edfb 100644
--- a/testcases/kernel/mem/ksm/ksm_test.h
+++ b/testcases/kernel/mem/ksm/ksm_test.h
@@ -13,7 +13,7 @@ static inline void check(char *path, long int value)
 	char fullpath[BUFSIZ];
 	long actual_val;
 
-	snprintf(fullpath, BUFSIZ, PATH_MM_KSM "%s", path);
+	snprintf(fullpath, BUFSIZ, PATH_MM_KSM "/%s", path);
 	SAFE_FILE_SCANF(fullpath, "%ld", &actual_val);
 
 	if (actual_val != value)
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
