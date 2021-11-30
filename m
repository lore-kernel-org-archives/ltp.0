Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105BDC433F5
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 10:49:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3882F3C6BD8
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 11:49:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75A973C4E59
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:49:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D51491000D4A
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:49:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D82821709
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638269357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8fu4pfyMtYIoVAPfpuMtwye1sOyyFvFXUwjGkbNLV2Y=;
 b=SDsKYz6rnZAVtPeFGRrNzMKBrBGPzWQF6BpYP74yHVgPCeor8Wzknaj1CtltZ3tpl5LEi/
 0mU0TDvhuXlmKELq9ovXSsghGYjekld04A0lWpzLYQ/it5VUqMjBI+AzPfN7Fou8yg6XEg
 FBydIWD1kRltT68wiML3Y6TidvvNhGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638269357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8fu4pfyMtYIoVAPfpuMtwye1sOyyFvFXUwjGkbNLV2Y=;
 b=QgUdnul0gHFSuaNbzPk+rF/bbucya092djwN1hZdr/bdKtXe5Ev/xXmCZNdCS2X5A0rWlc
 7OBAvb+QM1l4TGAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A08B13C44
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:49:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RKtpFK0BpmHAQAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:49:17 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Nov 2021 11:50:27 +0100
Message-Id: <20211130105027.1071-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130105027.1071-1-chrubis@suse.cz>
References: <20211130105027.1071-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] sparse: Do not report static inline functions
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

Since these are part of the library API and can be prefixed with tst_

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 tools/sparse/sparse-ltp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
index 2f32bfa38..b1677d336 100644
--- a/tools/sparse/sparse-ltp.c
+++ b/tools/sparse/sparse-ltp.c
@@ -98,7 +98,7 @@ static void check_symbol_visibility(const struct symbol *const sym)
 	if (!(mod & MOD_TOPLEVEL))
 		return;
 
-	if (has_lib_prefix && (mod & MOD_STATIC)) {
+	if (has_lib_prefix && (mod & MOD_STATIC) && !(mod & MOD_INLINE)) {
 		warning(sym->pos,
 			"LTP-003: Symbol '%s' has the LTP public library prefix, but is static (private).",
 			name);
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
