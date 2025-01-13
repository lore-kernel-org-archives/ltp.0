Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0595DC02184
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 22:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736805933; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=2Rbdig/vGNiBnzRtFsmQybxqyTul8OtG9wdz1XP4CWc=;
 b=FpSMYqmNPGGcYBJBm0GJqu3UlIaAJ4KIgznwRHsBP5feJftw2EEkwwGP2poAFYhKbtwwD
 f5f+xkMR1um/HOJ+IXiMfIToxykEpiLrLRS7QSLrpRd74RevwyJPZivgfJgwyEDgKrrlwQd
 u3Wr7ZVSnAz1/+GYjDYE0fM84zjW/Ss=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF5493C79BD
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 23:05:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABD093C0B87
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 23:05:10 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4D9FA1BEF88E
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 23:05:10 +0100 (CET)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ab2b29dfc65so744395866b.1
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 14:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736805909; x=1737410709; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ybBrHrhNZ1gPOjADMg6uV6TmZ+InLG10UoLHOBD3DXI=;
 b=ClF7KzYn/Y4yBMm9FEvjog8n/mng/GCqoIcTcp73rqfKCh8GvLWKgbRMRkWNMmfZi8
 3dcEuayq1i3Ix6byV8UVG3o27hRj5Kxb7N8njH3fKnps+MdSZKe7LOZ6YUkV/6gx23lk
 zkZbGl+YeAIbEou1UJsbWuYXBymags7JAZjJepbj8XkgQ8P9AWY3xk+kiWF6NoOxFkkL
 mdM1EkIzcpNmnH31IBMPCVN34gmXFct29lF41nRVKic3eoD5FPsPtqJ8Y/HitPJMq46T
 SJJKQZJ75JGj9CyDpMC7D9tyGQwXde5jsCLrM24UIPu5daPUwtOZHOsCxr15kt1uKjgB
 bV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736805909; x=1737410709;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ybBrHrhNZ1gPOjADMg6uV6TmZ+InLG10UoLHOBD3DXI=;
 b=M1s2cdikWJ0wNxbCL31HfSyjrrgftf75iT3f0zBUp53ONDoOnmD+4//xybMCaBfC+W
 WCaQ9oCaKnV7rb9DJ8qXHcnYLGmVWjqoZWf2LInPOAohYf277xiYGuI5Jiokj4A6XxwN
 2Mf6A1VjNiMyXq+dZUvseeFN3DBt5P14MpbYYd6laqXD9Go1A+0JqZFucti5sh2vh6FN
 9ot+/Vi39TffWPS43DtIA1pniI6LPqtG6eU1o2fVaM5TvuVTisTq0ZygzBoC7TIsOkly
 c7rnnD74GIoQbCsofXHWzx6GCAAoJu+E1i8oi4UUfOLq6R/LVpY8c0qm6o7BjKNbJr22
 wOXQ==
X-Gm-Message-State: AOJu0YwMW9ut6hlPeZPI2o91Xz5qtE5PmtFUAvsPQvKc7GtKVFvLDEKg
 zwfg7dz3FtJb7c8VhO+TpwS2K0gocM7OUP//nGlSx8hMYfUN679ZjiC13wppHVynXzMTEDHHwxL
 A
X-Gm-Gg: ASbGnctIKo4Z7Tg0DN4aHZnTqaYdq4dl7SnLXolXvwtdsoc5WdR8fWASwbn06zvlN4R
 FP1skr0UxV+kwvR1N9JnWU3T0eGhz1QL0WNvtqrluLLFlhpCjufv0YiBoGKHlrseH0ElROyj5PP
 kpiE38NCNge8ICe/j0XUp+53FkR0WAD1KvgNdyQ/HuSDSceG3eCHcAzmWwqJHHD7i1btiabnZiK
 f8gqwO152CyefUpv8yT3vf9X/FPH62TAYC4EY7ySA==
X-Google-Smtp-Source: AGHT+IFeTI817g+Ih3jvWojF5cnDNU3jXGzsIKNx2RWPi9sNUWYLPbrzJr6iY/yQ8vJYT8wlLLPWUA==
X-Received: by 2002:a17:907:2da6:b0:aac:2297:377d with SMTP id
 a640c23a62f3a-ab2abdc09eemr2142783866b.52.1736805909440; 
 Mon, 13 Jan 2025 14:05:09 -0800 (PST)
Received: from localhost ([177.95.18.53]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-723519d3c2bsm112945a34.14.2025.01.13.14.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 14:05:07 -0800 (PST)
Date: Mon, 13 Jan 2025 19:05:03 -0300
MIME-Version: 1.0
Message-Id: <20250113-tst_kconfig_stddef-v1-1-66c75790d127@suse.com>
X-B4-Tracking: v=1; b=H4sIAA6OhWcC/x3MQQqEMAxA0atI1hZsrS7mKiJS21SDTJWkDAPi3
 a0u3+L/EwSZUOBTncD4I6E9Fei6Ar+6tKCiUAymMV2jdauy5Gnze4q0TJJDwKg6a33bWxtMr6G
 EB2Ok/zsdxuLZCaqZXfLrs/o6ychwXTfmYpFcfQAAAA==
X-Change-ID: 20250113-tst_kconfig_stddef-544c3644d261
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=rbm@suse.com;
 h=from:subject:message-id; bh=6mK7yrhEgr+rn+6aTlohB4Fba8txDM7ScGsfUrTkBP8=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnhY4QjxE0Tz5c4JaCiiccShQ4mt+YeQB+skj5m
 AZ0TgRpsSGJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ4WOEAAKCRDJC4p8Y4ZY
 psusEACNEw0AhBqj/amrGJLB2NsakBfOaj3EeqLq64e4whI30qIlvyGzj6eJxTGlb6zmuwSwzob
 O1bfceukzjwZJP4II73bpTzf/iSCldf+VgGKjz3Ehdmo0u5RaWNgnMJAjpv6+Jf/a2qb+DuLw4F
 rpQywznL7tx3oB/tzdBdwYNTKHCoa3Sgj8JAguBtETEMgW+pJHPS1hGD6pFijAtERcfG6lZ03O8
 6r44vXCh112VtPSyou3tEOvHTyI/JJt8/eUrvS00TxDSaquru2Qt4H7cGbqEe2J7MQqS2rB1U1N
 ZeWXw+v8VkccfoLrOXAJmayxL1dw+jLo7RaXyVQZ2qh8q34cgpHIFvRObFATeSZbDzefFmiDDmo
 dBGXWHUkPkBksWLMCaUh3wm2X1z6GWxPfkB6RL3MADDrBDKnu14G8ruk42/UXAHmsLvzntn/PRJ
 v82uhGxPK6+u6/JNAIo/mmyOs7uKPekCvl9XQ4cBmNH8lPlK+o3hO7jTwiLTpHFC7pCCoUJV3B7
 KgKRKvy/JZa0G06hygQOSkfaq+ZOdKjXl0GEVjw2oiMIqFYq5ciGcB0t29I73R2PDH9CuctGg4q
 9Fj7BosXTvTJrqLMHdBpr0VoLCYvXWxP/EC/0QlWwVywrCGWot+31vg3qx6kvDHwc7/pOY/PmVX
 Bh7XAHLRZMt9GeQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/tst_kconfig: Include stddef.h
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Cc: "Ricardo B. Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Currently, if a test wants to make use of tst_kconfig.h it must also
include stddef.h due to the usage of size_t. While at it, fix a few minor
typos in comments.

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 include/tst_kconfig.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index 5377c00f39957fd93f316368865c8e44038f2e1e..b0608498d7e837e2c7b847fbef23334dcf2605c9 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -7,6 +7,7 @@
 #define TST_KCONFIG_H__
 
 #include <stdbool.h>
+#include <stddef.h>
 
 /**
  * Initialization helper macro for struct tst_kconfig_var. Requires <string.h>
@@ -29,7 +30,7 @@ struct tst_kconfig_var {
  * tst_kconfig_var structures.
  *
  * The path to the kernel config should be autodetected in most of the cases as
- * the code looks for know locations. It can be explicitely set/overrided with
+ * the code looks for know locations. It can be explicitly set/overridden with
  * the KCONFIG_PATH environment variable as well.
  *
  * The caller has to initialize the tst_kconfig_var structure. The id has to be
@@ -47,7 +48,7 @@ struct tst_kconfig_var {
  * In the case that match is set to 'v' the val pointer points to a newly
  * allocated string that holds the value.
  *
- * @param vars An array of caller initalized tst_kconfig_var structures.
+ * @param vars An array of caller initialized tst_kconfig_var structures.
  * @param vars_len Length of the vars array.
  */
 void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len);

---
base-commit: 7aea2cea9ad5d9e1586112a57948c7f85dc12970
change-id: 20250113-tst_kconfig_stddef-544c3644d261

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
