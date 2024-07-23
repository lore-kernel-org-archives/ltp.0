Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92AEC3DA49
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 07:16:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4474C3D1BFA
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 09:16:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 248873CC2E7
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:33 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 18CB41405142
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F136F21B85;
 Tue, 23 Jul 2024 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0PfdQUvAmokhpNeJRCaTzv2232uWZj9ec4h+3v4Dkg=;
 b=UW0ASR9tbya59mbosZC0Z/aD5lfypiq4X6KNo6LotzFuFeKameoTc4nTPCZ/apYUaCHrKH
 K4A55trifLWiA6cvnqWEvyZ21VnF+/rTznO0AsG6IP/T5+UmjC9OxQQtLjR2IkcsqoNRL7
 cB6UWFMZfCwD/JUfFv7qXe8l7y3p6O0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0PfdQUvAmokhpNeJRCaTzv2232uWZj9ec4h+3v4Dkg=;
 b=LK9ZpNHsG/NpfhMOI5u5/iMK0II8S2wwarNcZIpRs1b/yGwVw9EZjx1zesalQv5god7wK6
 I6cwAr4t5cRM7rAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IXpUbAfP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rz6WSES3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0PfdQUvAmokhpNeJRCaTzv2232uWZj9ec4h+3v4Dkg=;
 b=IXpUbAfPAmW7k+1tsZGn8mcgj6Wweu9gGsSy+PkDCZwSws8jBJReMMBDw1Myv5ffhq2ZtH
 JlVwwD43xCFKLSHIJlTpoCTpSQgaP7Cgjsi3yXuAVHEzMGHfMdCd2RM1e8N+NUuNgWn5WJ
 RBfGwoIp4zLhP1kEoKGDPWsO84mm9xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0PfdQUvAmokhpNeJRCaTzv2232uWZj9ec4h+3v4Dkg=;
 b=rz6WSES3RqEUUrmTr7O2EEV5u14dyuSr+XhefjG5aOFoxqhXxzMiZ3XMs0hrWynGMSZEB+
 yy07RDNcfRUZnSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D01CA1393E;
 Tue, 23 Jul 2024 07:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +L7lMJNYn2bKUQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 07:15:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 09:15:01 +0200
MIME-Version: 1.0
Message-Id: <20240723-ioctl_ficlone-v2-1-33075bbc117f@suse.com>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
In-Reply-To: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=7LyoIRebPvyoOjzD34A4RYBeDy7NetmqwcFHsluR40I=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn1h+5eJ+ifx9oFzKwxKQEHW1ZIYxAHSyj5w7/
 UG778D4iEOJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp9YfgAKCRDLzBqyILPm
 Rt9DC/4wNPp8nAg4LXoRhRmLGQOnJHeI8LiEcvfn6ZVXg2gJ1Dp0LnZOansItRnY1feW0Q1dSW9
 HjCltFyN/jpXoYerpozscUCW2sQVkrD/7IUO6CrxXc6EPn5FKieqcyrhHVyVbVzqAzKktx/jBe3
 /QVzggcJZBhOrHEnYAlAHHt+rwqWrmlgUudMNecgAQXyocK8H1RmEv1m9TtSeQTorAd9F46WmbA
 THR130u3gisgVTRGJhhaPUXj8f4elku03w81b0Fv/nh/3R+E/ovbxD9wkcXDsVVEk7HOi5WOt/3
 yg8LX+ETKbZYCyzIVvz58LZ+BM+P1rnSP4O9QFVXsnOG5zWjeSgLGPSbst7Fb6cbsIlInBtuL9J
 nbmLIAtH+xK2nHtKPnW3X6tyyPo4mydzeD0BiGbL2TEZKkKw28GMZ86E9P4VWLKScOVVdD63e+V
 jEyZp5XT0jRkoqlrGjOi7eGqeIQrXZLpkBd/vNGvME1HGvwJwKtS0M8uC0oGVtE9CYttw=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-3.31 / 50.00];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F136F21B85
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/7] Add fallback definitions for lapi/fs.h
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

This patch adds "struct file_clone_range" and FICLONERANGE fallback
definitions.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac      |  1 +
 include/lapi/fs.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/configure.ac b/configure.ac
index 1f8796c87..4d466f052 100644
--- a/configure.ac
+++ b/configure.ac
@@ -177,6 +177,7 @@ AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
 AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
 		struct fanotify_event_info_header, struct fanotify_event_info_pidfd],,,[#include <sys/fanotify.h>])
+AC_CHECK_TYPES([struct file_clone_range],,,[#include <linux/fs.h>])
 AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct file_handle],,,[
diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 635979b02..0e8d646d8 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -20,6 +20,15 @@
 #include <limits.h>
 #include "lapi/abisize.h"
 
+#ifndef HAVE_FILE_CLONE_RANGE
+struct file_clone_range {
+	int64_t src_fd;
+	uint64_t src_offset;
+	uint64_t src_length;
+	uint64_t dest_offset;
+};
+#endif
+
 #ifndef FS_IOC_GETFLAGS
 # define	FS_IOC_GETFLAGS	_IOR('f', 1, long)
 #endif
@@ -48,6 +57,14 @@
 # define FS_VERITY_FL	   0x00100000 /* Verity protected inode */
 #endif
 
+#ifndef FICLONE
+# define FICLONE		_IOW(0x94, 9, int)
+#endif
+
+#ifndef FICLONERANGE
+# define FICLONERANGE		_IOW(0x94, 13, struct file_clone_range)
+#endif
+
 /*
  * Helper function to get MAX_LFS_FILESIZE.
  * Missing PAGE_SHIFT on some libc prevents defining MAX_LFS_FILESIZE.

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
