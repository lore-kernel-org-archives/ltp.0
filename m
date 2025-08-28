Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0C5C8303F
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 13:12:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F2743CCFFD
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 15:12:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E1913CCEEA
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 15:11:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 81A161400061
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 15:11:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 292142225F;
 Thu, 28 Aug 2025 13:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756386686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXbFffUzDZSALWNb+3dCQGk8dfdZTFnl29hTgIS+Piw=;
 b=J5Eblnx9h6VAdL/tM5EXJb10Ys/0DHISs3DsZQUQTFQ0JJHL16rBUii5zW2xmodkQtuw6n
 PNSsOxIU5vIkXeYYzma4Lh95DU1VKWgcjcPtXLM9bjCNHZtCySy27JfXoivoR/DgRfjAq5
 kUgFfWa+LEUx4HPxQN+hZu3VmJtKZWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756386686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXbFffUzDZSALWNb+3dCQGk8dfdZTFnl29hTgIS+Piw=;
 b=5J2bO2k4D158+VPBCk/FUR/2p6qnHekjzi4Cy3T+q9miiqpXEYbNii4JlOyHD6H3eSdPti
 3eTREhyhHplT6+CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J5Eblnx9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5J2bO2k4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756386686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXbFffUzDZSALWNb+3dCQGk8dfdZTFnl29hTgIS+Piw=;
 b=J5Eblnx9h6VAdL/tM5EXJb10Ys/0DHISs3DsZQUQTFQ0JJHL16rBUii5zW2xmodkQtuw6n
 PNSsOxIU5vIkXeYYzma4Lh95DU1VKWgcjcPtXLM9bjCNHZtCySy27JfXoivoR/DgRfjAq5
 kUgFfWa+LEUx4HPxQN+hZu3VmJtKZWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756386686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXbFffUzDZSALWNb+3dCQGk8dfdZTFnl29hTgIS+Piw=;
 b=5J2bO2k4D158+VPBCk/FUR/2p6qnHekjzi4Cy3T+q9miiqpXEYbNii4JlOyHD6H3eSdPti
 3eTREhyhHplT6+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 023DD1368B;
 Thu, 28 Aug 2025 13:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +LKxOX1VsGjfCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 28 Aug 2025 13:11:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 28 Aug 2025 15:11:24 +0200
MIME-Version: 1.0
Message-Id: <20250828-open_tree_attr-v1-1-f339a0e51e22@suse.com>
References: <20250828-open_tree_attr-v1-0-f339a0e51e22@suse.com>
In-Reply-To: <20250828-open_tree_attr-v1-0-f339a0e51e22@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756386685; l=1463;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Dhq/cBc6PX6ComRKaQAdb8sb1xRmOAb8S3xIte/tJO4=;
 b=JTQmThwIsUaDcdpwy9wZ1fYBVRula3P07ATPVbeS96MzG71kvE9UCjLhTPAkYOtaMR1OcBNXE
 QA8UB+Tdw8JBOBz8asgsUrnxFI+8tBZSsePhx6S8XkRK1SEti+uD3/b
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 292142225F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Add open_tree_attr fallback
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
