Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625B9C3DA49
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 09:24:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 951543D1CC2
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 11:24:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 255613D1C9A
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 11:23:55 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7F4A2613373
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 11:23:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C086D21BFB;
 Thu, 25 Jul 2024 09:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721899432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwxL6x9ojNMWLGfxd169k0V4S3vAdbUcoqM0qDs6LXc=;
 b=RlN3H0OsjOMA9F1KvaYcT4iAifT3S4p2xF5611Y2DbQkkycC8lwjq35lhRB06xecjzkBwV
 1qckJRXM8B7S5FUnR4exRO2gjGIS7axEME6KIqXKQHlGXaeP0GqE1W4Uaso+jxjDHaZmk7
 EoAje6Mum4b4KLwJ4wbrBYcdOvAFyRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721899432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwxL6x9ojNMWLGfxd169k0V4S3vAdbUcoqM0qDs6LXc=;
 b=rc1c8xrGm19gm385N40tZcXPhax68Gq7FFabDspAGOWriN/gTbJhsSkTvSki1wFbwB+Tff
 pFwgJXbVAVc1KSDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721899432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwxL6x9ojNMWLGfxd169k0V4S3vAdbUcoqM0qDs6LXc=;
 b=RlN3H0OsjOMA9F1KvaYcT4iAifT3S4p2xF5611Y2DbQkkycC8lwjq35lhRB06xecjzkBwV
 1qckJRXM8B7S5FUnR4exRO2gjGIS7axEME6KIqXKQHlGXaeP0GqE1W4Uaso+jxjDHaZmk7
 EoAje6Mum4b4KLwJ4wbrBYcdOvAFyRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721899432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwxL6x9ojNMWLGfxd169k0V4S3vAdbUcoqM0qDs6LXc=;
 b=rc1c8xrGm19gm385N40tZcXPhax68Gq7FFabDspAGOWriN/gTbJhsSkTvSki1wFbwB+Tff
 pFwgJXbVAVc1KSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B6D113874;
 Thu, 25 Jul 2024 09:23:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IKprOKcZombZNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 25 Jul 2024 09:23:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 25 Jul 2024 11:23:12 +0200
MIME-Version: 1.0
Message-Id: <20240725-landlock-v4-2-66f5a1c0c693@suse.com>
References: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
In-Reply-To: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=805;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=I5hW96VlmW8BZ5/r39V5osTTOpFT20UL1w7cD37/4bg=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmohmQTad9/C9aSD3/yHYy13oO1HS8g5i6NbsgM
 ISJc3g/MCCJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqIZkAAKCRDLzBqyILPm
 RpbUDACwOyhxsEXDpUqxLiX5OdnP+LscoyYlkY20MwjCehGVTfG4NaIGmv8h+H/xbZNnGK3r4Cq
 UvXK8/xLYY7uUA3JFcMYMU1pHGvWMHNZeramneopr9+byLMe1OaWYvcikoKgjyRxU3qY1fV9acB
 ZTE4lgkwEiPwS1kMn05/uNsXixrvPX7AAcLbBFpUu9Mcp+gci0X+HWWuTKu0giGXLgtGvUNsMY7
 ENB2fQHqd6AO9ENgp7lgnOoh3uXdThgvRu3hT8cwp6wp6kLRFVPBEIDAzLot/h5sr6G8mNMkVYp
 ietF7X8Wq3OmMqNUjdr29imiHtpa+58v2+2BoXBU9zdVHtyttSc31qI68gr+uwYP11BOOvDM+2F
 LtGASBPD6vTqt1hDovBS5p2T7dB3sxPsmPGAehmBIFu6pb9HeNEBbjUbwFCo57p9Hto/4IW57oH
 AYlraRGwY8kwNb2hruiNHEUGoDdsBvJSw8G4i7CmoVgs4MA/7uYsISH2y18zOqAsk2AX8=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/5] Add CAP_MKNOD fallback in lapi/capability.h
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
Cc: mic@digikod.net, gnoack@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/capability.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 2b593797c..0f317d6d7 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -44,14 +44,18 @@
 # define CAP_SYS_TIME         25
 #endif
 
-#ifndef CAP_AUDIT_READ
-# define CAP_AUDIT_READ       37
-#endif
-
 #ifndef CAP_SYS_RESOURCE
 # define CAP_SYS_RESOURCE     24
 #endif
 
+#ifndef CAP_MKNOD
+# define CAP_MKNOD            27
+#endif
+
+#ifndef CAP_AUDIT_READ
+# define CAP_AUDIT_READ       37
+#endif
+
 #ifndef CAP_BPF
 # define CAP_BPF              39
 #endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
