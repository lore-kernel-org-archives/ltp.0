Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F9CC77B7D
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 15:36:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F06103CDCE4
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 17:36:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55A3A3CB2D4
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:36:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EB53C600A5B
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:36:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0895F22685;
 Wed, 17 May 2023 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684337803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wonqR9rR+qEFPvOSRDxaynCF97AHkWD17TL16QXRFlY=;
 b=xWXtNaqiCxaE6uEc9nXY27ba/FT0ExMCQFnQsihLQauks4QV0vsWHqrDTST8bK9daIp3fn
 yiE6Nyk0FCs60LsD1wmtOcsJVQxzsi8yCsbIdX4rZl6mSaKCQEQQ8J4ElGLjsGFN0VYN+T
 fFLY1OoDtS1Q/Ldu5emGD7HpuUFVUrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684337803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wonqR9rR+qEFPvOSRDxaynCF97AHkWD17TL16QXRFlY=;
 b=KhIJ8U9WPsdzDTynh+IZInOQmORNdJMkGumRmmrVPWUm3qYQMGkz7MbAEXdBc/mRWC4dkT
 1thLspLgNranTzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECAA913478;
 Wed, 17 May 2023 15:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2G7fOIr0ZGSTCgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 17 May 2023 15:36:42 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Nicolai Stange <nstange@suse.de>,
	ltp@lists.linux.it
Date: Wed, 17 May 2023 17:36:36 +0200
Message-Id: <20230517153642.26919-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230517153642.26919-1-mdoucha@suse.cz>
References: <20230517153642.26919-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/7] KVM: Add VMSAVE/VMLOAD intercept constants
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/include/kvm_x86_svm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/kvm/include/kvm_x86_svm.h b/testcases/kernel/kvm/include/kvm_x86_svm.h
index 965d1e716..3eb832849 100644
--- a/testcases/kernel/kvm/include/kvm_x86_svm.h
+++ b/testcases/kernel/kvm/include/kvm_x86_svm.h
@@ -37,10 +37,15 @@
 /* SVM event intercept IDs */
 #define SVM_INTERCEPT_HLT 0x78
 #define SVM_INTERCEPT_VMRUN 0x80
+#define SVM_INTERCEPT_VMLOAD 0x82
+#define SVM_INTERCEPT_VMSAVE 0x83
 #define SVM_INTERCEPT_MAX 0x95
 
 /* SVM vmrun exit codes */
 #define SVM_EXIT_HLT 0x78
+#define SVM_EXIT_VMRUN 0x80
+#define SVM_EXIT_VMLOAD 0x82
+#define SVM_EXIT_VMSAVE 0x83
 #define SVM_EXIT_AVIC_NOACCEL 0x402
 #define SVM_EXIT_INVALID ((uint64_t)-1)
 
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
