Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2FEC61DBD
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:13:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5571F3E5E1C
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 16:13:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C4BF3CD537
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:11:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 36A8B20005D
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:11:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E2D181FB79;
 Fri, 28 Aug 2026 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=oTNw0kuXYZHR2m7H5VrtR2zcxzVcvxgXVD73Gq9kKvbMZja57ZZilnXuH6lr26FWsiBF5I
 sO233lRZsnNQv8/H5T1aMRKToGPDGGZLLIjPOL4UxV3iLAUF9Pmrsyyz0nYSa0gIdban/y
 oaUXw+WHuiZrTUu9dZDZcW/X/HDRx1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=XWLxXiDQUnAqPHqHMDEDWTsZCXHtaBavDDABC7eFiRbgWdYjYaIF66w/cglDQ9zH2naBJ0
 PfRbVFmogfBSSeDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TlBCGYNx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="gpu/V7md"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=TlBCGYNxMR/LryPcny+iZYXsMDiuz1mSi/O/zhyX8uTPM1bYR+zZxpu5FGscgvT41Eq+VS
 OaaLQiP2GuCnPucbRDPVe+txm4DyoAu7PH6LPEBdBQVz/WWgUcpVbDb+gepdxRzu1PKwAA
 IIeOzS7BncvEnMKUEh26RXEPvRcXx9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=gpu/V7mdEZCIHdeMRzGSqTxd+D3+f4iH8++iWm1K/k2w6P4kIf6hlXFIyz+lgG+Swjcn4X
 HpULhS1Ww6pxFPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B015713686;
 Fri, 28 Aug 2026 14:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sDCCKSCXkWpoGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 14:11:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 16:11:37 +0200
MIME-Version: 1.0
Message-Id: <20260828-fchroot-v3-3-656a2b515726@suse.com>
References: <20260828-fchroot-v3-0-656a2b515726@suse.com>
In-Reply-To: <20260828-fchroot-v3-0-656a2b515726@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787926304; l=801;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=3EHGosZsiUsvPbtWv+YgPdQhXcWeCKJec/0bk4ipppw=;
 b=Sy75AdfDaWC3xl3RQM3GsySpWBJRtru3EAmZZal90oaAFfECTBWmndHTVExX4eP0TMZgN5zCo
 sckWlRFBAKUCUzu+gDTgturIaNid9IJ+CLlqKlwqhosvC23GNItZI2T
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E2D181FB79
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v3 03/15] lapi: fallback fchroot() parameters
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add to fcntl.h fallback definitions:

- FD_PIDFS_ROOT
- FD_NSFS_ROOT
- FD_FAILFS_ROOT

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/fcntl.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 6a9ef11ce..d70954ea7 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -144,6 +144,19 @@
 # endif
 #endif
 
+/* Roots of kernel internal pseudo filesystems, usable as fd sentinels */
+#ifndef FD_PIDFS_ROOT
+# define FD_PIDFS_ROOT		-10002
+#endif
+
+#ifndef FD_NSFS_ROOT
+# define FD_NSFS_ROOT		-10003
+#endif
+
+#ifndef FD_FAILFS_ROOT
+# define FD_FAILFS_ROOT		-10004
+#endif
+
 #ifndef FALLOC_FL_KEEP_SIZE
 # define FALLOC_FL_KEEP_SIZE 1
 #endif

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
