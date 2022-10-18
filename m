Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DB0C4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 15:25:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 622B73CB0BB
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 17:25:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CA543CB077
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 17:25:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5A29A10009FF
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 17:25:33 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4191122BE8;
 Tue, 18 Oct 2022 15:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1666106733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OuLu5jpeC9yTJy31FzXQMTDvZUnYh3abmMXodHdCBh8=;
 b=c/pU7VsqkyEaXt3WuqW3kF8WBQWVXvhUJ1Ty1Gg77WQkmbUpqDpkvGQA/g3JOA5unjvyfN
 NxvA/Wgatu1KirCMyVsTyqdW2zIUhvfPYggT/X4I2ILmg0YR3CxJULhOUVPxNEKdoAtkYI
 n8OSEBu2pmbocwAivMlv2S8/nsTYn7g=
Received: from g78.suse.cz (unknown [10.100.228.202])
 by relay2.suse.de (Postfix) with ESMTP id 846532C141;
 Tue, 18 Oct 2022 15:25:32 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 18 Oct 2022 16:25:26 +0100
Message-Id: <20221018152527.4636-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] ptrace07: Fix compilation when not on x86
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Strictly cpuid.h should not be included on non-x86, but this means
each test author has to remember not to include it. Instead we can set
a blank macro to allow compilation.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

This time I created a PR to check if compilation succeeds:
https://github.com/linux-test-project/ltp/pull/984

 include/lapi/cpuid.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/cpuid.h b/include/lapi/cpuid.h
index cd0567f92..20e977093 100644
--- a/include/lapi/cpuid.h
+++ b/include/lapi/cpuid.h
@@ -16,11 +16,15 @@
  * have __cpuid_count().
  */
 #ifndef __cpuid_count
+#  if defined(__i386__) || defined(__x86_64__)
 #define __cpuid_count(level, count, a, b, c, d) ({			\
 	__asm__ __volatile__ ("cpuid\n\t"				\
 			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
 			      : "0" (level), "2" (count));		\
 })
+#  else
+#define __cpuid_count(level, count, a, b, c, d)
+#  endif
 #endif
 
 #endif /* LAPI_CPUID_H__ */
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
