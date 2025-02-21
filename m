Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AFAC021B3
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 10:35:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94B1E3C8112
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 11:35:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67D243C0430
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:35:31 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A34A21421714
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:35:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 085ED1F385;
 Fri, 21 Feb 2025 10:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740134129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pc1CBiJpO442zPCS+C8lmVqSnJbdMmfCJeWh15XOKSo=;
 b=oQOjsMD5+R0lrJoCgXdW0qr1Iw2uOos5ROl/xz9lin9f4hHHWE5ZtABrncxUM6/NtIdWlA
 ETfc7If5HI76A2TCNTi6cOAOdrnCu0jD9p0amUM0NL2VOr90oVKxyEkohePF38V+9o/LSC
 lI+E159ifqudSa9YIdfLHj60Mfgu/hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740134129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pc1CBiJpO442zPCS+C8lmVqSnJbdMmfCJeWh15XOKSo=;
 b=BtuNBSHXdmMp4qQOxWzX26bx5XtkfkJsqnEGGV8QLC1FDVr8NtkBSIMPLOEoueT9GVL5J0
 HcVRURQkFbeHE0AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oQOjsMD5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BtuNBSHX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740134129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pc1CBiJpO442zPCS+C8lmVqSnJbdMmfCJeWh15XOKSo=;
 b=oQOjsMD5+R0lrJoCgXdW0qr1Iw2uOos5ROl/xz9lin9f4hHHWE5ZtABrncxUM6/NtIdWlA
 ETfc7If5HI76A2TCNTi6cOAOdrnCu0jD9p0amUM0NL2VOr90oVKxyEkohePF38V+9o/LSC
 lI+E159ifqudSa9YIdfLHj60Mfgu/hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740134129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pc1CBiJpO442zPCS+C8lmVqSnJbdMmfCJeWh15XOKSo=;
 b=BtuNBSHXdmMp4qQOxWzX26bx5XtkfkJsqnEGGV8QLC1FDVr8NtkBSIMPLOEoueT9GVL5J0
 HcVRURQkFbeHE0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCBE813806;
 Fri, 21 Feb 2025 10:35:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4+W0NPBWuGc/PAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Feb 2025 10:35:28 +0000
Date: Fri, 21 Feb 2025 11:35:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250221103519.GA2764810@pevik>
References: <20240322112031.20939-1-wegao@suse.com>
 <20240605105919.10123-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240605105919.10123-1-wegao@suse.com>
X-Rspamd-Queue-Id: 085ED1F385
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] move_mount03: check allow to mount beneath top
 mount
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

merged with adding 6ac392815628f linux-git tag and formatting changes.
Thank you!

Kind regards,
Petr

+++ include/lapi/fsmount.h
@@ -114,14 +114,14 @@ static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned i
 }
 #endif /* HAVE_MOUNT_SETATTR */
 
-#ifndef MOVE_MOUNT_BENEATH
-#define MOVE_MOUNT_BENEATH 		0x00000200
-#endif /* MOVE_MOUNT_BENEATH */
-
 /*
  * New headers added in kernel after 5.2 release, create them for old userspace.
 */
 
+#ifndef MOVE_MOUNT_BENEATH
+# define MOVE_MOUNT_BENEATH 		0x00000200
+#endif
+
 #ifndef OPEN_TREE_CLONE
 
 /*
diff --git testcases/kernel/syscalls/move_mount/move_mount03.c testcases/kernel/syscalls/move_mount/move_mount03.c
index ad5c8b9ed5..a9429af7a0 100644
--- testcases/kernel/syscalls/move_mount/move_mount03.c
+++ testcases/kernel/syscalls/move_mount/move_mount03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test allow to mount beneath top mount feature added in kernel 6.5:
  * 6ac392815628 ("fs: allow to mount beneath top mount")
  *
@@ -14,9 +12,10 @@
  * https://github.com/brauner/move-mount-beneath
  *
  * See also:
- * https://lore.kernel.org/all/20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org/
- * https://lwn.net/Articles/930591/
- * https://github.com/brauner/move-mount-beneath
+ *
+ * - https://lore.kernel.org/all/20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org/
+ * - https://lwn.net/Articles/930591/
+ * - https://github.com/brauner/move-mount-beneath
  */
 
 /*
@@ -68,7 +67,6 @@
  *           --/mnt    /DIRA /DIRB
  *         Check content of /DIRB, you can see file A exist since
  *         current /DIRB mount source is already become /DIRA
- *
  */
 
 #include <stdio.h>
@@ -142,4 +140,8 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.setup = setup,
 	.cleanup = cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "6ac392815628f"},
+		{}
+	},
 };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
