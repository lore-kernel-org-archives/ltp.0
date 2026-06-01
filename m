Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC96CD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 13:21:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EE183E56D7
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 15:21:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54E1B3E48BB
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:21:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE5EC100076B
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:21:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F92167B63
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780320060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6LSsxvtOsXr8lkQ55lORzBGLChi6aA94AoZeIogNZI=;
 b=vpnEmcq2LoC+redlqYVx31Nz+K38kqJqCycGT78M4vhKnTXnYmK+KfqtHeMjZPHTHnw9hn
 3ZrA0L7xyANEpoJYtqC3ze+AGNi9YEB18T7B9++jTNA4hRAmMCrAmEkbzTYZNyUj8Z2qan
 UXyhM28q6djLw4mJ2EM2FkTkKoO1yU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780320060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6LSsxvtOsXr8lkQ55lORzBGLChi6aA94AoZeIogNZI=;
 b=xVICkv6K73/NpuAjCjHHUvj/U13Lwi0TLK5iCxeQNBnt/wtBbXS8iVpKCqAC6sFtOO6scr
 FP2AxQP3lsIlrKCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vpnEmcq2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xVICkv6K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780320060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6LSsxvtOsXr8lkQ55lORzBGLChi6aA94AoZeIogNZI=;
 b=vpnEmcq2LoC+redlqYVx31Nz+K38kqJqCycGT78M4vhKnTXnYmK+KfqtHeMjZPHTHnw9hn
 3ZrA0L7xyANEpoJYtqC3ze+AGNi9YEB18T7B9++jTNA4hRAmMCrAmEkbzTYZNyUj8Z2qan
 UXyhM28q6djLw4mJ2EM2FkTkKoO1yU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780320060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6LSsxvtOsXr8lkQ55lORzBGLChi6aA94AoZeIogNZI=;
 b=xVICkv6K73/NpuAjCjHHUvj/U13Lwi0TLK5iCxeQNBnt/wtBbXS8iVpKCqAC6sFtOO6scr
 FP2AxQP3lsIlrKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17CAA779A8
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 13:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oFSSBTyHHWp2OwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 13:21:00 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  1 Jun 2026 15:20:46 +0200
Message-ID: <20260601132055.58728-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601132055.58728-1-mdoucha@suse.cz>
References: <20260601132055.58728-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2F92167B63
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/6] lapi/xfrm.h: Include system XFRM header
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

Also include <netinet/in.h> first to avoid redefinition issues with
IPv6 data structures.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: Replaced guard macro #define with #include <netinet/in.h>

 include/lapi/xfrm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/lapi/xfrm.h b/include/lapi/xfrm.h
index 48503b7ef..4d03cddc9 100644
--- a/include/lapi/xfrm.h
+++ b/include/lapi/xfrm.h
@@ -6,6 +6,9 @@
 #ifndef LAPI_XFRM_H__
 #define LAPI_XFRM_H__
 
+#include <netinet/in.h>
+#include <linux/xfrm.h>
+
 #ifndef XFRMNLGRP_NONE
 # define XFRMNLGRP_NONE 0
 #endif
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
