Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F044E7490C
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 18:36:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 226813CF17E
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 20:36:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61B113CB54C
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 20:35:55 +0200 (CEST)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8B38C60004C
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 20:35:55 +0200 (CEST)
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-565ece76be4so13556a12.2
 for <ltp@lists.linux.it>; Mon, 02 Oct 2023 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696271754; x=1696876554; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=E/fJZNZk4pxFnE3hn71ult4AiP+IkPxCLd5Z/kNpYbY=;
 b=hcPtKn/54GZBdS6nQvRBTH+zmFIImnARyTsVX65WuzEMmwKuqJVP0KbjsjoXMYAROl
 m/GLt//sa4hj0ac618rycRNxyFjWtW65VIbGi81KmApP/Av9m0gloukvniRH26uuFiwC
 cZH0G8Z+qLuE1sRUoFHkECSET5iMGO+Dh2ISiPAJ0XlCod1fALiNiYjE/EDoGRcLpCa6
 15IhvrOgtYRjuxNyOYS1XJnqD7hwH2606kP7o3kGIISydUvfrciEDB2nLYDJwTVzy7aV
 AkIaJzYfgzzVH38QypIBwBWnpRPkcDXvQs2B578c3OBI0UEeFLKZmn3Cp4xl4Z4QKOr1
 U2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696271754; x=1696876554;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E/fJZNZk4pxFnE3hn71ult4AiP+IkPxCLd5Z/kNpYbY=;
 b=ZaUkVaLMzHFt4m3JrSmEMYMZvSQ0gC06Y+4e7WKRc8q8SmVvwWqKuabC7hNr16O6JC
 nbRfTRaULuxKHNvrIylEfSNasqj7/cntpwLB0xOb0aG6CRxZqHQIhs0KP1JPo9F7Gz5R
 7jGv0ywwxXL+OclManB1xhnTeIgIjvoVAeaghzrHQXAISoqC5qg8Cv3zTk+9r2SyhTTK
 4Xz1HGjWMJswheEBVtU30eA0aWhUR/xFd0QeFaG/CJ4hR3rBHuHB/sAoQ2li7cWmnQUE
 2ptYyfjLOhZUVfw83IMaIiwlue6JCUwLhiUtbkNpn1qyILW6IbWT3Ur7mVv2kakP0KQV
 1FCQ==
X-Gm-Message-State: AOJu0YwuyZqU5OsMp/CxBecrNmDGX9GX3XCaU7JE6ExyfRaEds1hRvBs
 oFBuf5spBgvRZyNNKwPYAKB+WhxX4kv0M+0gS2H+ILLqLXCfMKe41CmcIX/n+kVNhaaSVw6HcJl
 AFQ/7Q/D4jlnGxn+aISuTMYl8KkWDHOyrx1NmTNVomS2rekwepIUYlXIF
X-Google-Smtp-Source: AGHT+IFkEugm8c1XLCCorRj/38pXaPXKDLkR7mNa1Bzf5I/hEcZoPGFzKyO49d9YsjN7NM2n9Rk+36J7idM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:790a:0:b0:585:79ef:9926 with SMTP id
 u10-20020a63790a000000b0058579ef9926mr186007pgc.7.1696271753695; Mon, 02 Oct
 2023 11:35:53 -0700 (PDT)
Date: Mon,  2 Oct 2023 18:35:50 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231002183550.1351704-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] getpgid01: On Android, pgid(1) is 0 instead of 1
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

From: Edward Liaw via ltp <ltp@lists.linux.it>

Android's init does not call setpgid(0, 0) so it does not have pgid=1.
0 is functionally equivalent, since pgid 0 means the pgid is the same as
the process pid.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/getpgid/getpgid01.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/getpgid/getpgid01.c b/testcases/kernel/syscalls/getpgid/getpgid01.c
index 479fe5dcb..5523101e7 100644
--- a/testcases/kernel/syscalls/getpgid/getpgid01.c
+++ b/testcases/kernel/syscalls/getpgid/getpgid01.c
@@ -37,7 +37,11 @@ static void run(void)
 		TST_EXP_EQ_LI(TST_RET, pgid);
 
 		TST_EXP_PID(getpgid(1));
+#ifndef __ANDROID__
 		TST_EXP_EQ_LI(TST_RET, 1);
+#else
+		TST_EXP_EQ_LI(TST_RET, 0);
+#endif
 	}
 
 	tst_reap_children();
-- 
2.42.0.582.g8ccd20d70d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
