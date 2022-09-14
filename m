Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867ECECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 13:43:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFF5A3CAC05
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 15:43:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BC1F3CA900
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 15:43:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 99CC02010B5
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 15:43:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B61F01FAB5
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663163014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtKpWnjf9Z322cXXR5LJc7U1zDNYAb9GG9skyGs04+s=;
 b=p8XqjN3hmOEDDZ8Nk5PdktNa/kepuaJveVfqB8CsCcaMY2karSrpPdg5hqWd9xYE5DjMTh
 jlaYuXsiIJi3zm/KxrpVygQ3T2rANlL4NICtgJEcpmcNnkZxV6NjeyaZPG+f/6wiw7JtH7
 pvBKQWoIYFeRsRiaw8j4odqLNsWt5i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663163014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtKpWnjf9Z322cXXR5LJc7U1zDNYAb9GG9skyGs04+s=;
 b=WwSjl49XSMUdV7jWgTpxFUw+eHQmw5wMHJa6sLpGBliG6R9itX1x4uvKlmZYEaMGunufYW
 jfbqp9gWN9n1icCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4FB913A90
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 13:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oKZfJ4baIWN1IgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 13:43:34 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 14 Sep 2022 15:43:33 +0200
Message-Id: <20220914134333.13562-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914134333.13562-1-mdoucha@suse.cz>
References: <20220914134333.13562-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] dio_sparse: Fix child exit code
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

Changes since v1:
- Use tst_res(TFAIL)+exit(1) instead of tst_brk()

 testcases/kernel/io/ltp-aiodio/common.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
index 68465dc54..3a604f8f7 100644
--- a/testcases/kernel/io/ltp-aiodio/common.h
+++ b/testcases/kernel/io/ltp-aiodio/common.h
@@ -78,9 +78,11 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
 			if (r > 0) {
 				bufoff = check_zero(buff, r);
 				if (bufoff) {
-					tst_res(TINFO, "non-zero read at offset %zu",
+					tst_res(TFAIL,
+						"non-zero read at offset %zu",
 						offset + (bufoff - buff));
-					break;
+					SAFE_CLOSE(fd);
+					exit(1);
 				}
 				offset += r;
 			}
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
