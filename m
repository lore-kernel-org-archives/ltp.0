Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E494C7EE23
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 13:35:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E1D13CDD10
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 15:35:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D5743CB059
 for <ltp@lists.linux.it>; Fri, 26 May 2023 15:34:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7A5DC200B91
 for <ltp@lists.linux.it>; Fri, 26 May 2023 15:34:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6140E1F86C;
 Fri, 26 May 2023 13:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685108076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WlrwmwIpuJrWjQl0RRKh1sNre1DeS5wNs00FlGUq5gM=;
 b=ZFfx1VGoGiU8X92mK1BIQ71Km7DJ9A4L/L77eI9ilfWJpjXKzkahmrDT5AughBb2gqGu1T
 gMpmxyUWvTGJ8Qk6fCCy3AQJiQOiUESg8ZfOPl/zqjwPiCMosz/zuv2fPa19Yhl3fJ5Aww
 FnBvw6P/aDiIgGQCJLV2P1eUpkfKfPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685108076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WlrwmwIpuJrWjQl0RRKh1sNre1DeS5wNs00FlGUq5gM=;
 b=cKF+kJ5NYi00vgavX3akcVovDEXwEUiHvsaoqrNem56+O64ZtRcoTPQ/K5xW23uhODaMb4
 X726Vgp+jE8IgLBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BC6E13A89;
 Fri, 26 May 2023 13:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UIvHEWy1cGTMZQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 26 May 2023 13:34:36 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 26 May 2023 15:34:29 +0200
Message-Id: <20230526133435.7369-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230526133435.7369-1-mdoucha@suse.cz>
References: <20230526133435.7369-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/7] KVM: Add VMSAVE/VMLOAD intercept constants
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
Cc: Nicolai Stange <nstange@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
Acked-by: Petr Vorel <pvorel@suse.cz>
---

Changes since v1: None

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
