Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A00FCD4F54
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 11:47:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE45C3CA171
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 13:47:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 430FD3C71DC
 for <ltp@lists.linux.it>; Wed, 27 May 2026 13:47:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D98D8200ACF
 for <ltp@lists.linux.it>; Wed, 27 May 2026 13:47:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F6166AE21
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779882429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xl0gqyJG31jMZ6f60FBVOT51jDtHhL26uk5xA+kXOZ0=;
 b=Ng+TDLJp1X9PqH6zqaHOrSouagxK2xVosVz4sz+ozMfxpggrOKz1ypG/RbYvW6MnxDh4bK
 JL3yqAlHS6GHHOVXM8mLkdlkAZBNO7jQmeBYJ+FOe1ncNCtCnF3Oh98H9JRnJ+Qn4eQPJp
 dslpEQNdpeYFVUWCGFFes0Z1D0AqIvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779882429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xl0gqyJG31jMZ6f60FBVOT51jDtHhL26uk5xA+kXOZ0=;
 b=7ryPNTsdkzFmmY/2/xPObcwpGmIvGF1dPlvPRlgBhTZBPkp3mXT2HK4TeBiC7ACtFd0ILY
 6p5QjwpjcJFOboAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779882429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xl0gqyJG31jMZ6f60FBVOT51jDtHhL26uk5xA+kXOZ0=;
 b=Ng+TDLJp1X9PqH6zqaHOrSouagxK2xVosVz4sz+ozMfxpggrOKz1ypG/RbYvW6MnxDh4bK
 JL3yqAlHS6GHHOVXM8mLkdlkAZBNO7jQmeBYJ+FOe1ncNCtCnF3Oh98H9JRnJ+Qn4eQPJp
 dslpEQNdpeYFVUWCGFFes0Z1D0AqIvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779882429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xl0gqyJG31jMZ6f60FBVOT51jDtHhL26uk5xA+kXOZ0=;
 b=7ryPNTsdkzFmmY/2/xPObcwpGmIvGF1dPlvPRlgBhTZBPkp3mXT2HK4TeBiC7ACtFd0ILY
 6p5QjwpjcJFOboAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A6235A7FA
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:47:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zxYgB73ZFmptPQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:47:09 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 May 2026 13:47:00 +0200
Message-ID: <20260527114708.16896-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] lapi/xfrm.h: Include system XFRM header and force
 kernel IPv6 definition
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
 include/lapi/xfrm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/xfrm.h b/include/lapi/xfrm.h
index 48503b7ef..e89e90bc1 100644
--- a/include/lapi/xfrm.h
+++ b/include/lapi/xfrm.h
@@ -6,6 +6,10 @@
 #ifndef LAPI_XFRM_H__
 #define LAPI_XFRM_H__
 
+/* Force use of kernel IPv6 definitions to avoid redefinition errors */
+#define _UAPI_IPV6_H
+#include <linux/xfrm.h>
+
 #ifndef XFRMNLGRP_NONE
 # define XFRMNLGRP_NONE 0
 #endif
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
