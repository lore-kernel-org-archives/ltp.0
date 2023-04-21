Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA3AC77B71
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 14:58:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B37C3CBF32
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 16:58:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 031CE3CBEAD
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 16:57:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DE954200AF5
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 16:57:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6566C1FDE4;
 Fri, 21 Apr 2023 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682089067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dw94zVREPyws1es7fnyYHlEEvfch4Fkr8kOrOGuLwrE=;
 b=D3Pvcq3zpV6vOeLqqfs4JTumn0v6oSiBKz2j12tV/k8RX99SSQrW+bJHkH5qxJu5CXNgJP
 Mr+YTupZdTOuz8xZ5IKmKDWYvCo7GWvTz1kFOkFXfo7NQkp++TLLdwCYWbg70JdkCJP2Fe
 KtWnUpA2RcuRD2Ne+0SROjkNR3xuOt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682089067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dw94zVREPyws1es7fnyYHlEEvfch4Fkr8kOrOGuLwrE=;
 b=hQgzaZ+8ZEdNV/4CYUNcRhAv0Y3UgXtJXPNCRMv6qnqJ2ac+OgMcv3JP/XL3tmNKNoMZVl
 IxficG5bOanEqADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EC701390E;
 Fri, 21 Apr 2023 14:57:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EMmLDmukQmRfDAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 21 Apr 2023 14:57:47 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: nstange@suse.de,
	ltp@lists.linux.it
Date: Fri, 21 Apr 2023 16:57:44 +0200
Message-Id: <20230421145746.5704-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421145746.5704-1-mdoucha@suse.cz>
References: <20230421145746.5704-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] KVM: Fix infinite loop in ptr2hex()
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

Contrary to the C standard, (x >> 64) is equivalent to (x >> 0) on x86.
This can cause infinite loop in ptr2hex() if the highest nibble
in the second argument is non-zero. Use temporary variable to avoid
bit-shifting by large values.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/lib_guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/kvm/lib_guest.c b/testcases/kernel/kvm/lib_guest.c
index d237293fc..d3b2ac3d5 100644
--- a/testcases/kernel/kvm/lib_guest.c
+++ b/testcases/kernel/kvm/lib_guest.c
@@ -82,7 +82,7 @@ char *ptr2hex(char *dest, uintptr_t val)
 	uintptr_t tmp;
 	char *ret = dest;
 
-	for (i = 4; val >> i; i += 4)
+	for (i = 4, tmp = val >> 4; tmp; i += 4, tmp >>= 4)
 		;
 
 	do {
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
