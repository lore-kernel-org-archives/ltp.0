Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566EFCEF147
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 09:43:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E01E03C1876
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 11:43:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D01E3C0CA7
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:23 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3192220829E
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6BF5D21B48;
 Tue,  8 Oct 2024 09:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jununNLpYpONAx6KT50zSiac4pWZ/Kcwz9ohgHUWtH0=;
 b=tKxiqE4j1Sv8xfHX6t2No8TDAhu1X58lG4a11GrBtFJU15aVdLAXr9EHi3w2Hi+afgydqN
 9cN2ODWHUwyLfArUoP+P8EIihnKEeEww12a37a6dgNFksuqD6JwCKQ3mC9mPnICbVSfCg0
 EWvNoYjF/yeeoh36J8Ro3f28zcH9/Bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jununNLpYpONAx6KT50zSiac4pWZ/Kcwz9ohgHUWtH0=;
 b=3SOexeg6kZUasIrybNB/zRwEL7LGywunfxkZN6wAOYmG//HKzi+VihuNQZ1JYL2BIgUJuW
 HbQ6kBCYH+QvalBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jununNLpYpONAx6KT50zSiac4pWZ/Kcwz9ohgHUWtH0=;
 b=tKxiqE4j1Sv8xfHX6t2No8TDAhu1X58lG4a11GrBtFJU15aVdLAXr9EHi3w2Hi+afgydqN
 9cN2ODWHUwyLfArUoP+P8EIihnKEeEww12a37a6dgNFksuqD6JwCKQ3mC9mPnICbVSfCg0
 EWvNoYjF/yeeoh36J8Ro3f28zcH9/Bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jununNLpYpONAx6KT50zSiac4pWZ/Kcwz9ohgHUWtH0=;
 b=3SOexeg6kZUasIrybNB/zRwEL7LGywunfxkZN6wAOYmG//HKzi+VihuNQZ1JYL2BIgUJuW
 HbQ6kBCYH+QvalBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 743811340C;
 Tue,  8 Oct 2024 09:42:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IMGtG3r+BGcZPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Oct 2024 09:42:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 11:41:57 +0200
MIME-Version: 1.0
Message-Id: <20241008-listmount_statmount-v5-4-66f4e1a9e7db@suse.com>
References: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
In-Reply-To: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728380526; l=2742;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=MSdfHG2ZKDafOZarXagqCsiLWeBYR9z3T0vypJt5uOs=;
 b=5GrVBOtWw76RQE05aL/MMDIBGKryXlhj1+FuB/2pXPvVfqnAomJpjJmxXqa6Y0IYD3h//cRGt
 w5cc61Cuz+hCj604okSWy+nzDJdNNtk5Pv3j/p/FucqGrmC3wyYIYxS
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 04/16] Add listmount/statmount fallback declarations
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac         |  2 ++
 include/lapi/mount.h | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/configure.ac b/configure.ac
index ebbf49e28..b4ab81e26 100644
--- a/configure.ac
+++ b/configure.ac
@@ -246,6 +246,8 @@ AC_CHECK_TYPES([struct mount_attr],,,[
 
 AC_CHECK_TYPES([struct cachestat_range],,,[#include <sys/mman.h>])
 AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
+AC_CHECK_TYPES([struct mnt_id_req],,,[#include <linux/mount.h>])
+AC_CHECK_TYPES([struct statmount],,,[#include <linux/mount.h>])
 
 # Tools knobs
 
diff --git a/include/lapi/mount.h b/include/lapi/mount.h
index c1af944fe..01a0fd2d6 100644
--- a/include/lapi/mount.h
+++ b/include/lapi/mount.h
@@ -2,12 +2,15 @@
 /*
  * Copyright (c) Linux Test Project, 2015-2022
  * Copyright (c) 2015 Cui Bixuan <cuibixuan@huawei.com>
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
 #ifndef LAPI_MOUNT_H__
 #define LAPI_MOUNT_H__
 
+#include <stdint.h>
 #include <sys/mount.h>
+#include "config.h"
 
 #ifndef MS_REC
 # define MS_REC 16384
@@ -37,4 +40,71 @@
 # define MS_NOSYMFOLLOW 256
 #endif
 
+#ifndef HAVE_STRUCT_MNT_ID_REQ
+struct mnt_id_req {
+	uint32_t size;
+	uint32_t spare;
+	uint64_t mnt_id;
+	uint64_t param;
+};
+#endif
+
+#ifndef HAVE_STRUCT_STATMOUNT
+struct statmount {
+	uint32_t size;
+	uint32_t __spare1;
+	uint64_t mask;
+	uint32_t sb_dev_major;
+	uint32_t sb_dev_minor;
+	uint64_t sb_magic;
+	uint32_t sb_flags;
+	uint32_t fs_type;
+	uint64_t mnt_id;
+	uint64_t mnt_parent_id;
+	uint32_t mnt_id_old;
+	uint32_t mnt_parent_id_old;
+	uint64_t mnt_attr;
+	uint64_t mnt_propagation;
+	uint64_t mnt_peer_group;
+	uint64_t mnt_master;
+	uint64_t propagate_from;
+	uint32_t mnt_root;
+	uint32_t mnt_point;
+	uint64_t __spare2[50];
+	char str[];
+};
+#endif
+
+#ifndef MNT_ID_REQ_SIZE_VER0
+# define MNT_ID_REQ_SIZE_VER0 24
+#endif
+
+#ifndef STATMOUNT_SB_BASIC
+# define STATMOUNT_SB_BASIC 0x00000001U
+#endif
+
+#ifndef STATMOUNT_MNT_BASIC
+# define STATMOUNT_MNT_BASIC 0x00000002U
+#endif
+
+#ifndef STATMOUNT_PROPAGATE_FROM
+# define STATMOUNT_PROPAGATE_FROM 0x00000004U
+#endif
+
+#ifndef STATMOUNT_MNT_ROOT
+# define STATMOUNT_MNT_ROOT 0x00000008U
+#endif
+
+#ifndef STATMOUNT_MNT_POINT
+# define STATMOUNT_MNT_POINT 0x00000010U
+#endif
+
+#ifndef STATMOUNT_FS_TYPE
+# define STATMOUNT_FS_TYPE 0x00000020U
+#endif
+
+#ifndef LSMT_ROOT
+# define LSMT_ROOT 0xffffffffffffffff
+#endif
+
 #endif /* LAPI_MOUNT_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
