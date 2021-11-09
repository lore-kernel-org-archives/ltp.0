Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421F8C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:05:18 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BFE611BD
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5BFE611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D3083C0823
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:05:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F28F93C03B1
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:05:04 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 73EE010044A6
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:05:04 +0100 (CET)
Received: by mail-pg1-x52f.google.com with SMTP id r80so7705492pgr.9
 for <ltp@lists.linux.it>; Tue, 09 Nov 2021 02:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=moIdc3syU3310KTw6bYHXbUZN+DgmzpG1mwyrMOXBec=;
 b=OOt+7U/zNMcy3AYamGXk5uHJIBQX1SDAPXQsGQXkpdmrHX6l9SXAgqzk4z3ZqEbjMz
 l7+wbsVKkMT57OPE5dv7s8hFYS7Y85KnAGnJ/LOLyCD4taF4GC4ub8rQm2jfie3/mOIv
 VOI7MAtmLP54Ut+GLvgI+WpH/QVAyUfZgRO+/Oq0DeYFmrFI0pDDpAOxCxv+H4lB+PQy
 gvjw82iJu3JfXQjRfuBy44ihv27m0+bsdgAw1MjhYXTTwvIAigCafb/Ppd6TlAPWF8AO
 E4ysHXCB+84KnoZF7PT7Vag3S8tD3Q3r0YSG0BRF8rXvANmYL5aFw153WvZm0lGwXMOL
 ERtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=moIdc3syU3310KTw6bYHXbUZN+DgmzpG1mwyrMOXBec=;
 b=VtpFfG1306nD38AkdhYrCF+xRC/HjAlxCc5WmQVRJ9RAGg5u0jaV0qmf01G11QrQXL
 kQ/5VvjpSWs0gLIKfGXV6OyO2FAkDH1+HnMROAgACfBQQdCr7CVp/4U4ZdQ48f8eNLt6
 b0GANyK+0novHUWaaUqMafB0ze9Pa/zexp/kwjMWTu5+n8ZZgLcNOVJVesriGA0xHMhb
 DhAwLTJfLCUUg5H1PemUVIaCgqqiFO6EwRg2TF3ySW8RwLKZFbR1iCQGzY0il0kKsA8J
 Wfi+WsbDxFvP46JG0Yo+WR4ahevx5YJVecmGM+Fs2klF/AlZZDYiwMy+W8oz0XrUqlKN
 m6IQ==
X-Gm-Message-State: AOAM533gCj6XAgifFytSu8RAYgoPv2gTWn4vjjkvIb7pYKiYf7QgXwzE
 6oaYxkROaQSL1ZxN3wUqh9Jf/1jL8VDnYA==
X-Google-Smtp-Source: ABdhPJxp7i+y5aayGmcUFBssA/nru/DHR8ykKt84Lb1Y2hKGtQtaT6wlG18rwUo2txdTZnxpHj8cKw==
X-Received: by 2002:a05:6a00:114c:b0:47b:b98b:2210 with SMTP id
 b12-20020a056a00114c00b0047bb98b2210mr88902258pfm.75.1636452302610; 
 Tue, 09 Nov 2021 02:05:02 -0800 (PST)
Received: from google.com ([2401:fa00:9:211:49d1:39e8:a7a5:de38])
 by smtp.gmail.com with ESMTPSA id i2sm3210188pfg.90.2021.11.09.02.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 02:05:02 -0800 (PST)
Date: Tue, 9 Nov 2021 21:04:51 +1100
To: ltp@lists.linux.it
Message-ID: <0671d89befb5b24fc3bac510c69811668c39cdf5.1636451496.git.repnop@google.com>
References: <cover.1636451496.git.repnop@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1636451496.git.repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] syscalls/fanotify: Add a helper macro which
 checks for the presence of specific fanotify initialization flag(s)
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: jack@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is a trivial macro that can be used throughout fanotify tests to
check whether the underlying running kernel supports the supplied
fanotify initialization flag(s).

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index a2be18338..e2db3c6f5 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -352,6 +352,11 @@ static inline void fanotify_init_flags_err_msg(const char *flags_str,
 		fanotify_init_flags_supported_on_fs(flags, fname)); \
 	} while (0)
 
+#define REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL(flags) do { \
+	fanotify_init_flags_err_msg(#flags, __FILE__, __LINE__, tst_brk_, \
+		fanotify_init_flags_supported_by_kernel(flags)); \
+	} while (0)
+
 static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
 {
 	int fd;
-- 
2.34.0.rc0.344.g81b53c2807-goog

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
