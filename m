Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1669BC6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 15:19:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C5CE3CABDD
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 17:19:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0EEE3CA900
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 17:19:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DAD13200C99
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 17:19:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4FDE35C2C8
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663082348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fR4CzkOJxumNP8axwiQJIojE1zvZsTFZ0BpHvJt9R08=;
 b=KHeiVujBIJmcPSiR9k9T1Vh35AY08Ihq03I1ID86zZTSIviEWEXfeYLJQ729GKcT00GvHt
 eBSsbD8q0CqFjwdzH6RjQ76hFOAzz6qFy7YQC9YCB4dvnOQsXsmdcrsaUUSea5dn/Bw3Od
 Q+J4tElbnBMN8svO8cBx//aSjwSPVK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663082348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fR4CzkOJxumNP8axwiQJIojE1zvZsTFZ0BpHvJt9R08=;
 b=zBkLMq/S8atFwtiSnWer1RlMu83QGpAHusipW3s/+d7uul+uNTYKeUuz/07K3Bj16+Day5
 eSDEv5jKsiInCmBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40FDB13AE9
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 15:19:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0PYQD2yfIGPtUQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 15:19:08 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 13 Sep 2022 17:19:07 +0200
Message-Id: <20220913151907.26763-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220913151907.26763-1-mdoucha@suse.cz>
References: <20220913151907.26763-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] dio_sparse: Fix child exit code
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

dio_sparse currently ignores all child failures because children never
exit with non-zero code. Fix child exit status.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/io/ltp-aiodio/common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
index 68465dc54..6265831af 100644
--- a/testcases/kernel/io/ltp-aiodio/common.h
+++ b/testcases/kernel/io/ltp-aiodio/common.h
@@ -78,9 +78,9 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
 			if (r > 0) {
 				bufoff = check_zero(buff, r);
 				if (bufoff) {
-					tst_res(TINFO, "non-zero read at offset %zu",
+					tst_brk(TBROK,
+						"non-zero read at offset %zu",
 						offset + (bufoff - buff));
-					break;
 				}
 				offset += r;
 			}
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
