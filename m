Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248D4C32771
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 19:09:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4519B3CAE0D
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 21:09:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F015F3C1BAD
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 19:00:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 99FB560011C
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 18:59:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 591081F385;
 Mon, 26 Sep 2022 16:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1664211596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NPPr5voovfLIykOeXvcoWAF2TBTtX48oje7YCKdsAYE=;
 b=moeUaZUMqeiUWR9xyHvZRfvfnkQi4/DDDH/qPRkDDdC0utkf3p3ufR1cryAxLrq5pvoQ1L
 lUMNwjpTPMC4qg5r5zkzfcpOICzd37/XxM27qF0VaMZ+Ql7CtmgkIFNNExs0V7lsMWcYfU
 Op0e+wPqVK6t2Eo9mb1jGU2pVvRkNeA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55DBF13486;
 Mon, 26 Sep 2022 16:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HNrYBovaMWNPSwAAMHmgww
 (envelope-from <mpdesouza@suse.com>); Mon, 26 Sep 2022 16:59:55 +0000
To: ltp@lists.linux.it
Date: Mon, 26 Sep 2022 13:59:49 -0300
Message-Id: <20220926165949.23407-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 26 Sep 2022 21:09:39 +0200
Subject: [LTP] [PATCH] configure.ac: Fix redefinition of mount_attr by
 checking sys/mount.h
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
From: Marcos Paulo de Souza via ltp <ltp@lists.linux.it>
Reply-To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

mount_setattr and mount_attr are defined in sys/mount.h.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Tested on openSUSE Tumbleweed

 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 1deeffc0c..0e9895415 100644
--- a/configure.ac
+++ b/configure.ac
@@ -71,6 +71,7 @@ AC_CHECK_HEADERS_ONCE([ \
     sys/epoll.h \
     sys/fanotify.h \
     sys/inotify.h \
+    sys/mount.h \
     sys/pidfd.h
     sys/prctl.h \
     sys/shm.h \
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
