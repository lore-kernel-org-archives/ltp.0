Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD26CD6B6DA
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 21:45:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBA7C3CB84A
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 22:45:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19C753CB82E
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 22:45:40 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C7961401621
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 22:45:39 +0100 (CET)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e983487a1so216631b3a.2
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 14:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730324738; x=1730929538; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IwxdamKoPXHMYBufKE0uXZ2rAgMGlzo/iT1xeBZIOio=;
 b=JJ87+SILcG8F5HN1ot0lFx30IOzuolkkyRYkgxtuOYqg/Acxi2g1fJcsTgNbJYl3wT
 ZtaF4xQEhzMgqAMXPrYm9bsUgmN9E02aeOPe4ODVSxr3ohuWbpqhiJgaRpJWYGPlPU4o
 hfECEGe58su5+Ce9jKrX+typOp3rxq+t5xDnL9gtgpBEsY/seGJWnjqBX2kxGvt9uTRF
 AvZiibrHz24p9cVchy2HbbVBedu2IOkAy30Lf03WN6BnXa1AemRISLK704TsPLMwnWNS
 aaWi6h7aKwZPB8gJZAIQ0jnAHZCkwIa30FAnQDmd96C9cftkFvPWioX8uzoRGQq9iEFl
 voSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730324738; x=1730929538;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IwxdamKoPXHMYBufKE0uXZ2rAgMGlzo/iT1xeBZIOio=;
 b=fKzQ1zcTAoSGubaS10cwEABGqKWj0sTvPlUC9aWE4n90wN74M/n1NXIqwuIyPoukZx
 4QfdEDn3SB48jbbqzI0E30PFxb7ylZisZqYnR4xDNz6YYdAP1nnub7zJ6M+uhGMozs+n
 L9pGvnX8iv7kiDF4J0e0/6n+KEUxl6SdgUxjTrQ2QC7LLQm2mE9zRg0j26vEC9A/ehiz
 BnnXJZtF54Fi+hX7t9lPNlGQlYKI884bNoHAImxn4bf52zX1atcMbyHEyxtiNJfx9Ic7
 0QuOipS3vb6giS1HtA6SE8HnV676oLOEaMYhTfX+a2IvNAj6KhE0RavfuwY43kyodusz
 x3ZA==
X-Gm-Message-State: AOJu0YxIw5WLFeSALZWahnbCZrR/C0YzyRXvPndpGXAA3ZssudLvNjOd
 Hbqg8RIuqFZ4QP3zf3FYHNX9pDRq0fZHSTHP2uamzDXixT60vQG7sWEIneKR
X-Google-Smtp-Source: AGHT+IHDZx6RFLSlNAMrOGRiQuc+UFoB+M7sPe4darhQ6J522BxEFgxyDu86Hh2y7clQdpsWikF7JQ==
X-Received: by 2002:a05:6a20:6d06:b0:1d9:db56:39bf with SMTP id
 adf61e73a8af0-1db91e8271dmr971000637.49.1730324737663; 
 Wed, 30 Oct 2024 14:45:37 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::35b3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb699sm93586b3a.167.2024.10.30.14.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 14:45:37 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 30 Oct 2024 14:45:34 -0700
Message-ID: <20241030214534.539684-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sched_attr: Do not define for glibc >= 2.41
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
Cc: Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

glibc 2.41+ has added [1] definitions for sched_setattr and sched_getattr functions
and struct sched_attr. Therefore, it needs to be checked for here as well before
defining sched_attr

Define sched_attr conditionally on SCHED_ATTR_SIZE_VER0

Fixes builds with glibc/trunk

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=21571ca0d70302909cf72707b2a7736cf12190a0;hp=298bc488fdc047da37482f4003023cb9adef78f8

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 include/lapi/sched.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 26fdb628d..e1c7ff011 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -15,6 +15,8 @@
 #include "lapi/syscalls.h"
 #include "lapi/sched.h"
 
+/* sched_attr is not defined in glibc < 2.41 */
+#ifndef SCHED_ATTR_SIZE_VER0
 struct sched_attr {
 	uint32_t size;
 
@@ -44,6 +46,7 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
 {
 	return syscall(__NR_sched_getattr, pid, attr, size, flags);
 }
+#endif
 
 #ifndef HAVE_CLONE3
 struct clone_args {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
