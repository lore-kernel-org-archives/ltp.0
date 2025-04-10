Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12EDC3601E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 05:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744264257; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=xOycLD3lpmk1ivoFy2EHQ0k+pQLvkjq8aoHMihhRDBs=;
 b=RzOSH812lbjMXnLPhLtO0cUjFPMu+lc1FwZyYal05p+wFPqmz45j4VzObKSn0IIEkRIg5
 t5k9Kf2JjX+WqLgVfgN7GNMpgrfa9q7vIvtlSo5AlYxE55J6PtXpdRIAG8hk6PTnxjxRSvQ
 rqL0tWPRlGyOKLLwleStGCb55Uycdyk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A1103CB44E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 07:50:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A0FE3CB451
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 07:50:16 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B03AE1000778
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 07:50:15 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3965c995151so116768f8f.1
 for <ltp@lists.linux.it>; Wed, 09 Apr 2025 22:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744264214; x=1744869014; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGFxhlLC4nmIbmuOkyLY2+nKyKQaihAmT8+L1ruPjK8=;
 b=MVzKISP/FfPPI7a1F3Juh3mu3K+oXt1brWFXkWoZi4IEl6YUxZhX1YMvfFjX64HDbz
 tDGxz2LPq4pByl/0uIyUjPYLGRwPKQFYs1jAxGonfzJMtII8gefT9hiAfr8t6j8NFKAK
 scPEZZ8UelF41RcpDfBh8kLu/NcTrcVPi9Ky5JxTd08cyJ6/CnroJceaaptMdUVIi62Q
 xrq5w2hivvacEbGgEcJtnMdyOLta+ckpjTSA3Mn1qfDI/LG3LUjSMzRYhCDp4BPcp4hM
 Y7IV5NfuPOq3nLaZIaYS81X5nelJCuMeHnKN5BT1zvQXT2OalcNfzZGGqz2LtRcRrexP
 nBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744264214; x=1744869014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGFxhlLC4nmIbmuOkyLY2+nKyKQaihAmT8+L1ruPjK8=;
 b=GsdQBCzk6FJLlF2I7JFJ4dBorfv2bo/d8A5v3uuMQpfmAPJvMJjzeKSxqjJ7s5Z2GA
 vjJERKfxB10ogslLctTqdQiBDDOm9lu3vL9u8NoPImhSWJdTYn/b64wCvTDWO+CgSX6p
 EhbBSkr3hntGV1NpZO7Eqg7q/TI4gWrq5xkNNVS7VuBkist7ga13PiBr6bIcpseAE8Ul
 b7OQ+VtKkfgLsT8D6jeKIb74kHRJeifFp+kcr8+VjpMLrDPZl1Vf5xWPD6TTR1eNj9Gk
 AKSQaR9CEmQPXjrXYe1tTESz3AL4VNLfwyVCPJIP+f9i8ey97BTIEjB/7MS11x4KN29/
 Cs/g==
X-Gm-Message-State: AOJu0Ywq1Tt78iOvlQLyjkYRysPZAyGGuHbdPmLEMdU8IiRsU3YGT9NW
 PwSuJajC/fOcqPIjHRDBVVUb/XkUwmjLjTEfh+c0WTjbhFA57LvxpdW4VYCCHFllXsXPApyEBE+
 cKg==
X-Gm-Gg: ASbGncu034hOkQGIXEukC6mFBmBDRXGP4KiQm0R0VycZEzeKswSTwLgqj4ML6Orczkg
 w9INTLkGgn+hqzKeZ5lhNakI+rNm8KlIiqJ5sAkpuH81CQMwKHB9852VJl3iUFH80r+74pJwQG0
 erm+3MuIjltRz1RGpCi9M/5p/JVlTF+dtaH++A4rZ2AbM6KjHWwvWJ/HIYItw9aWpB5Cn+PFS7R
 rWtCzAifxnOFjs7yH324FExhzQuGp3v5L0YrFAUtX2aXrD5+NUy1wn2LsMr9obX/7cXoRJN39ce
 LtVbTncA0+BMgEK9qWtXfzs8DE2R4Q==
X-Google-Smtp-Source: AGHT+IFG4y4IpGmnLGlxdB/EQDtbK6HWGSAwJn8cB0R2tBu1jWB4+hkqKqMgOCrMUSU0yphUF+QNEw==
X-Received: by 2002:a05:6000:430d:b0:391:4231:414 with SMTP id
 ffacd0b85a97d-39d8f4e4344mr969575f8f.40.1744264214578; 
 Wed, 09 Apr 2025 22:50:14 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bb1e51f07sm2472041b3a.143.2025.04.09.22.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 22:50:14 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 10 Apr 2025 01:49:55 -0400
Message-Id: <20250410054956.5071-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250410054956.5071-1-wegao@suse.com>
References: <20241212085058.29551-1-wegao@suse.com>
 <20250410054956.5071-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/2] tst_safe_macros.h: Add SAFE_STATVFS
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
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
