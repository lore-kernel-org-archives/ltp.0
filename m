Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89597ECE57B
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 10:01:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D44E3C14EE
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 12:01:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 394413C1448
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:33 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5F13C10009FF
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 892F421BD9
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFDjnokV03nBh1ZklTpQbjocZsKEUjaZhBngYFv1IBM=;
 b=aUcJiRcd1vUvj23UtaU5ZmN1rb53AzH9oWYO5B2Sye5epQ5QUjWPbgLj66q4jxEdQP8fwx
 qz/veG5owjp/dJZw9gbRH81hLbRwdUpkiI6Pzbc7k9ec01ed4CDWRAymDXFhBuaV8jqbtJ
 6R3As0wbhFHShYkn5CBok+5QyGYT+vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876030;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFDjnokV03nBh1ZklTpQbjocZsKEUjaZhBngYFv1IBM=;
 b=L6GCir8n9hfcGBKpY7VLT7ONB6oUpfKX9AJ/2VRGUgp+Lud2kRYjZVipME4izK1HYCccqQ
 jNac3u5IcknzwkDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aUcJiRcd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L6GCir8n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFDjnokV03nBh1ZklTpQbjocZsKEUjaZhBngYFv1IBM=;
 b=aUcJiRcd1vUvj23UtaU5ZmN1rb53AzH9oWYO5B2Sye5epQ5QUjWPbgLj66q4jxEdQP8fwx
 qz/veG5owjp/dJZw9gbRH81hLbRwdUpkiI6Pzbc7k9ec01ed4CDWRAymDXFhBuaV8jqbtJ
 6R3As0wbhFHShYkn5CBok+5QyGYT+vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876030;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFDjnokV03nBh1ZklTpQbjocZsKEUjaZhBngYFv1IBM=;
 b=L6GCir8n9hfcGBKpY7VLT7ONB6oUpfKX9AJ/2VRGUgp+Lud2kRYjZVipME4izK1HYCccqQ
 jNac3u5IcknzwkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E56BC13312
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oGUxLT3H3mb+DgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 10:00:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 09 Sep 2024 12:00:25 +0200
MIME-Version: 1.0
Message-Id: <20240909-listmount_statmount-v4-3-39558204ddf0@suse.com>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
In-Reply-To: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725876026; l=3037;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Wdiz+a0pzRx9vbK90VgmiNGjhMd98Xg4dHCuTgeNbhI=;
 b=ksybPIxPMHZG6j++W0a+WFztaXBDNHHM/QHirhyaPzLr4XlLvk5SQ2viXgfllVleU13xEGCG2
 MBgXr+7HwwSDX9C4txGyBOPNgZAvQkis/0pP6Kpdi9Ol2y1GWn7oG9o
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 892F421BD9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,huawei.com:email];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 03/13] Add listmount/statmount fallback declarations
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac         |  4 +++
 include/lapi/mount.h | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/configure.ac b/configure.ac
index ebbf49e28..3dca7c646 100644
--- a/configure.ac
+++ b/configure.ac
@@ -114,6 +114,7 @@ AC_CHECK_FUNCS_ONCE([ \
     io_uring_register \
     io_uring_enter \
     kcmp \
+    listmount \
     mallinfo \
     mallinfo2 \
     mallopt \
@@ -143,6 +144,7 @@ AC_CHECK_FUNCS_ONCE([ \
     setns \
     sigpending \
     splice \
+    statmount \
     statx \
     stime \
     sync_file_range \
@@ -246,6 +248,8 @@ AC_CHECK_TYPES([struct mount_attr],,,[
 
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
