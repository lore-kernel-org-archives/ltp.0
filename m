Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EE5ECAAD3
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 14:19:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A97D93CAA04
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 16:19:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A1E83CA9C9
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DEF066018AD
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 233F01F8E8;
 Fri,  9 Sep 2022 14:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662733126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNQgUBRWsqtV3vQXwuFg2/KhGXIoZ7hKLl4tSVGILvU=;
 b=qSO0Fwrivv4HWoxv0YLh5XjxFCGDZ4K33zWLGPMsnnazzllSVFtZfCg0ylfhG96yWp/J27
 7wRSMhsF+U7SOjQ2Oy3ap5aRSRwBnx60FPKyP83TUM5HjTaRyyuKpAVFZ/WrYqc1LdsEqM
 avFABHm5CRAo3LKjvOTTSobR7vubZWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662733126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNQgUBRWsqtV3vQXwuFg2/KhGXIoZ7hKLl4tSVGILvU=;
 b=D5kJwWfL+MhWVnt+cuqQKfT6um3t8FQuEe64hcgJZDbSjbFDNee93KGBLPeY2nI4mrIPNx
 hYLrWnqHEU7mkkDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7049413A93;
 Fri,  9 Sep 2022 14:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mOZ9F0VLG2NmWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 14:18:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  9 Sep 2022 16:18:32 +0200
Message-Id: <20220909141840.18327-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909141840.18327-1-pvorel@suse.cz>
References: <20220909141840.18327-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 02/10] shell API/tests: Require root for
 format/mount tests
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

i.e. for TST_{FORMAT,MOUNT}_DEVICE=1.

Although the warning is quite obvious:
tst_device.c:101: TINFO: Not allowed to open /dev/loop-control. Are you root?: EACCES (13)
tst_device.c:140: TINFO: No free devices found
TBROK: Failed to acquire device

It's safer to expect root to get valid result.

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v4

 lib/newlib_tests/shell/tst_format_device.sh      | 1 +
 lib/newlib_tests/shell/tst_mount_device.sh       | 1 +
 lib/newlib_tests/shell/tst_mount_device_tmpfs.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/lib/newlib_tests/shell/tst_format_device.sh b/lib/newlib_tests/shell/tst_format_device.sh
index 73a919086..dbe4ea9e7 100755
--- a/lib/newlib_tests/shell/tst_format_device.sh
+++ b/lib/newlib_tests/shell/tst_format_device.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
 
 TST_FORMAT_DEVICE=1
+TST_NEEDS_ROOT=1
 TST_TESTFUNC=test
 TST_CNT=2
 TST_DEV_FS_OPTS="-b 1024"
diff --git a/lib/newlib_tests/shell/tst_mount_device.sh b/lib/newlib_tests/shell/tst_mount_device.sh
index 561f878d2..70f80f84a 100755
--- a/lib/newlib_tests/shell/tst_mount_device.sh
+++ b/lib/newlib_tests/shell/tst_mount_device.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
 
 TST_MOUNT_DEVICE=1
+TST_NEEDS_ROOT=1
 TST_FS_TYPE=ext4
 TST_TESTFUNC=test
 TST_CNT=3
diff --git a/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh b/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
index 36a78bc85..ed2ba8c50 100755
--- a/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
+++ b/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
 
 TST_MOUNT_DEVICE=1
+TST_NEEDS_ROOT=1
 TST_FS_TYPE=tmpfs
 TST_TESTFUNC=test
 
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
