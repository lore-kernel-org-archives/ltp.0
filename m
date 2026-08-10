Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719BAC5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 02:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786330742; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WZhOfn7gqxC8ULvhuWcEk7I8X00nQ4VKozRI6Ol9/Es=;
 b=KUdQSLTWxqCJtdsueW3afEjl0nAzgrRRSWgVeXg3HfEhjLbbD1lM36oodK5d0Z5fnAk1k
 5Uewzsi/gw7F4WphvFqhUsOgC2+sOaglU6dM5ueR70OxF7j6/fcx/ML5of3XK/G7UzxtcuB
 80qTdcH3TPqTA98iCXk6/I0lPzypywo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B23303CB2B0
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 04:59:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40D033CAE4B
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 04:58:24 +0200 (CEST)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com
 [IPv6:2607:f8b0:4864:20::646])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A56591A000B5
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 04:58:23 +0200 (CEST)
Received: by mail-pl1-x646.google.com with SMTP id
 d9443c01a7336-2ccd1958e8fso22452485ad.2
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 19:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786330702; x=1786935502; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/7jupJu5KUr0eEciw3hzEgac7YhbPwkRZQEk4EGced0=;
 b=DMjZmwPDgEeCpUCtQ8AyPVqPEC0JXQLqy5nwTkn/krWZfmLCAB9jsUVhC+AZGGp0K8
 WuL4kiy+niHQVKM9HV4JIUNhynKf23dD/sds6qVIGVreGNYUn95GikHrIh/qvUQVAFkx
 qTU3Dnk2LM7k6gFp1c4M/7qw7n+6LRLF7HQPVgWr/Gj9xY98/9FS1iBjzG9nPN5i1HcB
 YwQb8DxA60aWBZedv6BVUxqjy9VCT5js1ZU3KCaF71MMXUG30QMIqxM8wKQ31EXLQIn8
 97iTPk5kA8k0RiWzLO1rjnoRGFysyj35Rua45bWG2BRZsAewFBtkqMoB8MuAxT2wv/ed
 sLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786330702; x=1786935502;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/7jupJu5KUr0eEciw3hzEgac7YhbPwkRZQEk4EGced0=;
 b=NAANkFiyj3PC+j+v19c/lzxy7AGDOUvtzAtQ/Ad5UZS+RTqk5eekw5Tgn2MTGbCun1
 HLWIHsj5vyPxvFMfaDWsDuUcNGnrv6Jb+ksNrPbiKSYyAcuQPn2T1++ANi6d23PB9XiQ
 eqVPSm/Pxl1NReFW0HzW7Zogux+iEz35zLO4zqgZ1TqRPwHHZHkPRfk/ZAl433sOXnts
 Y7p7ZbNbvN304PTN8INAedN9PBC95I4KjkwBc0KIyGDoIZDjq1FOzVnVT9NVhp6SNsAG
 gYd9wA4ArjEwQM7iE/DuU39kDT+WvCFqEgRslHwPDIMIC7rF64wQKenJPoQL6BRC5ifQ
 m4NA==
X-Gm-Message-State: AOJu0YxKCLjJx2ejnIThCrnOsVGewH6bKo+R/r9w+Tk1/ZvGgD77PRHC
 1KVlkyfnOZGQcsJiR+n5bvlFTFn/Eq0HNFfJXXnGxmpi84yr9F0a2UX3ODCRZI7DA340i27p1rN
 nlKtu1eR9sifE11WfQwhV6lu6iOFVLtP8ZvBgpYarExilJJw/Lx4qoR2kqEEO9oR6lgO+VnYSia
 imyNH1RaQCwL4roG/tE6uY2J69NA==
X-Received: from plsk9.prod.google.com ([2002:a17:902:ba89:b0:2bc:ac01:8af8])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a83:b0:2cc:307c:51fc
 with SMTP id d9443c01a7336-2d106e81d72mr294558545ad.21.1786330701609; Sun, 09
 Aug 2026 19:58:21 -0700 (PDT)
Date: Mon, 10 Aug 2026 02:58:16 +0000
In-Reply-To: <20260810025817.1665141-1-wakel@google.com>
Mime-Version: 1.0
References: <20260807234935.3248935-1-wakel@google.com>
 <20260810025817.1665141-1-wakel@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810025817.1665141-2-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 1/2] lib: Fix overflow in backoff polling and
 timeout multiplication
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: wakel@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Prevent integer overflow in TST_RETRY_FN_EXP_BACKOFF() when the delay
doubles. By using 'unsigned long long' for delay variables, we ensure
the doubled delay is safely represented without wrapping to 0 (which
causes an infinite loop). The loop will naturally terminate when the
64-bit delay exceeds 'tst_max_delay_' (capped at UINT_MAX).

Also fix potential overflow in tst_multiply_timeout() when the
multiplied timeout exceeds UINT_MAX. Perform the calculation in double
precision and cap the result at UINT_MAX.

Signed-off-by: Wake Liu <wakel@google.com>
---
 include/tst_common.h |  4 +++-
 lib/tst_test.c       | 11 +++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/tst_common.h b/include/tst_common.h
index e1f7c7907..058060fa4 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -26,6 +26,8 @@
 #define LTP_ALIGN(x, a)    __LTP_ALIGN_MASK(x, (typeof(x))(a) - 1)
 #define __LTP_ALIGN_MASK(x, mask)  (((x) + (mask)) & ~(mask))
 
+unsigned int tst_multiply_timeout(unsigned int timeout);
+
 /**
  * TST_RETRY_FUNC() - Repeatedly retry a function with an increasing delay.
  * @FUNC - The function which will be retried
@@ -42,7 +44,7 @@
 	TST_RETRY_FN_EXP_BACKOFF(FUNC, ECHCK, 1)
 
 #define TST_RETRY_FN_EXP_BACKOFF(FUNC, ECHCK, MAX_DELAY)	\
-({	unsigned int tst_delay_, tst_max_delay_;			\
+({	unsigned long long tst_delay_, tst_max_delay_;			\
 	typeof(FUNC) tst_ret_;						\
 	tst_delay_ = 1;							\
 	tst_max_delay_ = tst_multiply_timeout(MAX_DELAY * 1000000);	\
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 5c3607016..80463e7c6 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1855,10 +1855,17 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
 	if (timeout < 1)
 		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);
 
+	double t = timeout;
+
 	if (tst_has_slow_kconfig())
-		timeout *= 4;
+		t *= 4;
+
+	t *= timeout_mul;
+
+	if (t > (double)UINT_MAX)
+		return UINT_MAX;
 
-	return timeout * timeout_mul;
+	return t;
 }
 
 static void set_overall_timeout(void)
-- 
2.55.0.654.g21b8a5bc05-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
