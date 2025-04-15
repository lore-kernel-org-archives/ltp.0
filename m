Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30A1C369A2
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 13:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744638036; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=DZ0N6n9H/EQxNJmvMBpSi5NP58c+EhfWUhjM5x+YBZM=;
 b=IZS9+A6+RNiSjA9MNwH/AJjXCbvQDryT2BOCuXnoiESG1Cf69KDtv2XFeSdLqNDQ4EjHI
 ZNQiI1PdL5gOZa9enhieFHDYDKzNRUxXVmkgHa6SqQFj3+/xrDPXXaSCXPGiu2Fo8+SAk5P
 augFmSjcEpGNr/pLzMrmX+PtChtYNGQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C9763CB6F7
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 15:40:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A96FF3CB724
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 15:39:57 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E0E121A00ECF
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 15:39:56 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c14016868so3992306f8f.1
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744637996; x=1745242796; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FKBWJQkN93N3CC5VAs3E+bXb4YNwaX9vfDMDLHCfg8=;
 b=LdjuD1RFIy2upFNEsvhM3xuQmTvJWBRuAce82IYjeGQ9XiF3LmTzG6VAnrRtYJAmVs
 +O5JaPlxY++l06w4U4UytiBSt3t6gOYSse+ukvjd+PUTrFHOozJiVDsBP4rh6u5DsP5J
 rFy1yenRwnGwiQlE3ZzZaKI5Rxq5O3oHAgkDf3gtK8DMDCu9lyXa6Dz66TBhjiS5XaZJ
 AhfpuEPDL/cu5KJnXxsRDmT0W6wChaj+G+dArr0NMBJKcWNfJlIthK69Q3lwYyQDfMEA
 sud5olclw+CPRPU6VdP+ZXYAMVNZ6IDQuiZCTGF3DVJnXgu+H4EAcq3rKqM4Xj3H/kYF
 hLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744637996; x=1745242796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FKBWJQkN93N3CC5VAs3E+bXb4YNwaX9vfDMDLHCfg8=;
 b=sQkbvwQl4bhcFeEweIc6FyzUB/QK3FGe2SjNIfm/+0AVKIbvZkCrRQcV+XyBB8VKLG
 Pb7JGYdYowtifbnnL9K6GIkbHJSdwbFHQDkbzKYzIuH2J+80nFIxJUtJrP5phtITlEbt
 dbZXdUn8YN28YLFgZQmm4vf+OUlWeND37yXLz8GIgUT9j+JVnXyjsOm9rVrfkTpauGlW
 rIqUe8c0eUbgMFT1qK+P9cQ/nXDBu6tIQqcsUiZ+NedCdxx7hN20li02j9QWyABdhPSp
 XenDlWfbyUYXYQx/p6szrEKFBfbeewjleNx9L1F49pzWPq1AaJH6jURbWGnsKU63tEhU
 A18Q==
X-Gm-Message-State: AOJu0YwO1ASjKxswsWBhYL0Tcq0YU9zVIA6/E8x6xZVnaACAAvK0NT0b
 KSEJQxeM2OcM2oVn4xP9aAaQ+6Dy7PgZKfiOQE5V4Rmgkl5ZZtYch45le1mWsFJE9fjSMGSUkNR
 QPQ==
X-Gm-Gg: ASbGncvdPxRpeK2fmrhOFXHJGvunhVC/K2/gmwQfwYYK1mjP1eMRUhzirZS6eZL/1iT
 YmASs9A6bm7bEs6jKQ+ahmYzggjxtpeP5768/mCcdzkdX3mJWiL0t+q/IIzsCturJDHDiIzstJI
 B263yj27ychgwYdoCg1eO7kVfH0Q5MA3l86mGvdkiW1cRqc+Ph5tha00SFpeb/KvEHG1juLLv+V
 uyPeNropHoTieYXZxqcAiXW2JsoO0TztE68NWihbvoTt/iFxrEk8aaBnrFpaNq+L8aUQWly9xRR
 BfO4+nZozriBigjO5paYVm+ItTRKPg==
X-Google-Smtp-Source: AGHT+IG+d9yiqdO9WvLbmZBN0hUvfvnO2c6bSezOum9exDdfZXjCiQfYx2801zMebNw0lJa4wUKZHg==
X-Received: by 2002:a05:6000:4202:b0:391:4835:d8a8 with SMTP id
 ffacd0b85a97d-39ea51ee38amr9609454f8f.1.1744637996059; 
 Mon, 14 Apr 2025 06:39:56 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-306dd11e666sm11254316a91.15.2025.04.14.06.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 06:39:55 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 14 Apr 2025 21:39:19 -0400
Message-ID: <20250415013944.173030-2-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415013944.173030-1-wegao@suse.com>
References: <20250410054956.5071-1-wegao@suse.com>
 <20250415013944.173030-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 1/2] tst_safe_macros.h: Add SAFE_STATVFS
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

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_safe_macros.h |  6 ++++++
 lib/tst_safe_macros.c     | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 3b02f86c7..19504beb5 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -12,6 +12,7 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/stat.h>
+#include <sys/statvfs.h>
 #include <sys/vfs.h>
 #include <sys/sysinfo.h>
 #include <sys/uio.h>
@@ -503,4 +504,9 @@ char *safe_ptsname(const char *const file, const int lineno, int masterfd);
 #define SAFE_PTSNAME(masterfd) \
 	safe_ptsname(__FILE__, __LINE__, (masterfd))
 
+int safe_statvfs(const char *file, const int lineno,
+                              const char *path, struct statvfs *buf);
+#define SAFE_STATVFS(path, buf) \
+	safe_statvfs(__FILE__, __LINE__, (path), (buf))
+
 #endif /* TST_SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index ba095a621..cdc8c7dd3 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -810,3 +810,22 @@ char *safe_ptsname(const char *const file, const int lineno, int masterfd)
 
 	return name;
 }
+
+int safe_statvfs(const char *file, const int lineno,
+                              const char *path, struct statvfs *buf)
+{
+	int rval;
+
+	rval = statvfs(path, buf);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"statvfs(%s,%p) failed", path, buf);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid statvfs(%s,%p) return value %d", path, buf,
+			rval);
+	}
+
+	return rval;
+}
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
