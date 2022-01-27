Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8E8C433F5
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 09:24:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90A3C3C0CC6
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 10:24:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 741F73C0CC6
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:24:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CA7DB1A006A9
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:24:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E57FB210FD;
 Thu, 27 Jan 2022 09:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643275473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKlgxQ8ERMx0MUeBN1RkU3SJOw8+1S+DZNGI/zIa+8Q=;
 b=fZxexH0dNpOGUvJhWHGZV992h4BllZYmDZSpRl5UJRO9m76ISWTPHHwjhFg2aFBxtfb+Pq
 Y3XrbeQ9Zm7ZyfogxeGAaI8mNWWlM8q6BRvdqWfgQgh/mIIdsvYtw/Ht6ZKrlITBxPe0JE
 GrW5ypYvMSzZoff/ypzqZbIRKrlbfas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643275473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKlgxQ8ERMx0MUeBN1RkU3SJOw8+1S+DZNGI/zIa+8Q=;
 b=Smb/+LorHtg2U3+dnC5Sl0zi8bxKidO/cIEVFINrXJ0qh/RDTl5qy6vMYh3Xanx53SPsOO
 0VOw22ueh5ywg5BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B644C13F74;
 Thu, 27 Jan 2022 09:24:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kAqfKtFk8mHLHwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Jan 2022 09:24:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 27 Jan 2022 10:24:21 +0100
Message-Id: <20220127092431.25996-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127092431.25996-1-andrea.cervesato@suse.de>
References: <20220127092431.25996-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 01/11] Add KEYCTL_WATCH_KEY to lapi keyctl.h
 fallback
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

Added KEYCTL_WATCH_KEY keyctl syscall command that is required by
watch queue tests.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 include/lapi/keyctl.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index d899345c9..3be782494 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -140,6 +140,10 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_INVALIDATE 21
 #endif
 
+#ifndef KEYCTL_WATCH_KEY
+# define KEYCTL_WATCH_KEY 32
+#endif
+
 /* key permissions */
 #ifndef KEY_POS_VIEW
 # define KEY_POS_VIEW    0x01000000
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
