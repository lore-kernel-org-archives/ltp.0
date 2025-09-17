Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C411CAC59A
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 14:26:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04FE23CDC80
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 16:26:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DEF13CDBCF
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 16:25:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6AB7C600467
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 16:25:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F2A05336F8;
 Wed, 17 Sep 2025 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758119150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXbFffUzDZSALWNb+3dCQGk8dfdZTFnl29hTgIS+Piw=;
 b=r8zvxm4qNoykVO6+jLTc+V5Owc4NDV59ll2/ECbxJ7yAGPfjxffUnipdu19TvBeUU830mE
 0hL+tjob0E7HdtmnG5SATQC9pDDUE877Nw20bYnIegHdrD5KtIUEYdIBzvbyJgsDD5ZccL
 HYP+K927Y673SRfM58Si1d0t6AGBf5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758119150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXbFffUzDZSALWNb+3dCQGk8dfdZTFnl29hTgIS+Piw=;
 b=Nx0gK1M9tCnLph4nI6KmzVlrt+c4kOEHunsuADbQ+oKK97xxWcLHVPakV+0QD23g1+917F
 f6T+f9qQh0pkIwAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758119149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXbFffUzDZSALWNb+3dCQGk8dfdZTFnl29hTgIS+Piw=;
 b=eXTRhZ+/8MorvzWOKZLnrp3DUcvl/bEgAMQOTrmZ421ZayIDuaRPCldWepWF5as6nJWzoG
 7d00it+hl0vnied+sBoprJf4fw7Gyzbn+R9NLe521wgaWnFuanbfTtRnfFTNv342uvevuh
 S7Ntfyl+Qj7pg5Ow15amCNy1eGQvUvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758119149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXbFffUzDZSALWNb+3dCQGk8dfdZTFnl29hTgIS+Piw=;
 b=gSe4r+KxsPxWPC7TwXyL0dnvCqIN/bY0mOqcg/Scm+1BU8uhOeR5y5bELus0qjQNx/9kPD
 O8y3ZyeAL/qcntCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4E8913A63;
 Wed, 17 Sep 2025 14:25:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OPxXMu3EymjLCQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 17 Sep 2025 14:25:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 17 Sep 2025 16:25:45 +0200
MIME-Version: 1.0
Message-Id: <20250917-open_tree_attr-v3-1-d78d4150b662@suse.com>
References: <20250917-open_tree_attr-v3-0-d78d4150b662@suse.com>
In-Reply-To: <20250917-open_tree_attr-v3-0-d78d4150b662@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758119149; l=1463;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Dhq/cBc6PX6ComRKaQAdb8sb1xRmOAb8S3xIte/tJO4=;
 b=5ylzQXmqdbniIF+sRZEeiQznla40Roi4ESiiwy8iKQqhfqd3azVXkn8x0dR83sMRZk7Y/V2bT
 nuBhAqdck5UC0iGSxiH1z+knrFEaTkNOl+PW/m7vKlUb8vwgUl961lm
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] Add open_tree_attr fallback
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

open_tree_attr syscall has been introduced in kernel 6.15 and it's
now defined in lapi/fsmount.h.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac           | 1 +
 include/lapi/fsmount.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/configure.ac b/configure.ac
index 62ae27d494474fe342b1cceeac7f4c21c0b1028c..2d4d527bcaa675dae5d712a96d266d17184b8a0d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -137,6 +137,7 @@ AC_CHECK_FUNCS_ONCE([ \
     move_mount \
     name_to_handle_at \
     open_tree \
+    open_tree_attr \
     openat \
     openat2 \
     pidfd_getfd \
diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 1783272a00a1a049031cacbb417239123450a0e4..451987ae637d040e08970b7ffcf015bae07a6f11 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -105,6 +105,14 @@ static inline int open_tree(int dirfd, const char *pathname, unsigned int flags)
 }
 #endif /* HAVE_OPEN_TREE */
 
+#ifndef HAVE_OPEN_TREE_ATTR
+static inline int open_tree_attr(int dirfd, const char *pathname, unsigned int flags,
+				 struct mount_attr *attr, size_t size)
+{
+	return tst_syscall(__NR_open_tree_attr, dirfd, pathname, flags, attr, size);
+}
+#endif /* HAVE_OPEN_TREE_ATTR */
+
 #ifndef HAVE_MOUNT_SETATTR
 static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned int flags,
 				struct mount_attr *attr, size_t size)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
