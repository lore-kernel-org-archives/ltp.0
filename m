Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF68C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 15:21:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DE163CF4D7
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 16:21:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 902EA3CF4B2
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DF2931400E5D
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:04 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 721AD2210A;
 Thu, 14 Dec 2023 15:20:04 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A965134B0;
 Thu, 14 Dec 2023 15:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id eK6eAyQde2WpJwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 14 Dec 2023 15:20:04 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 16:19:48 +0100
Message-ID: <20231214151954.840244-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214151954.840244-1-pvorel@suse.cz>
References: <20231214151954.840244-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 721AD2210A
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 04/10] ioctl02: Rename option -D => -d
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

-D will be used for enabling debug info.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                           | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl02.c  | 2 +-
 testcases/kernel/syscalls/ioctl/test_ioctl | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index f723320c1..8216d86b0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -557,7 +557,7 @@ init_module01 init_module01
 init_module02 init_module02
 
 #Needs tty device.
-#ioctl02 ioctl02 -D /dev/tty0
+#ioctl02 ioctl02 -d /dev/tty0
 
 # Introducing ioctl tests for all /dev/tty* devices
 ioctl01      ioctl01
diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index ce0e6bdb8..9fbdd66a9 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -250,7 +250,7 @@ static struct tst_test test = {
 	.test_all = verify_ioctl,
 	.test_variants = 2,
 	.options = (struct tst_option[]) {
-		{"D:", &device, "Tty device. For example, /dev/tty[0-9]"},
+		{"d:", &device, "Tty device. For example, /dev/tty[0-9]"},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/ioctl/test_ioctl b/testcases/kernel/syscalls/ioctl/test_ioctl
index 43836a229..8549e5608 100755
--- a/testcases/kernel/syscalls/ioctl/test_ioctl
+++ b/testcases/kernel/syscalls/ioctl/test_ioctl
@@ -45,7 +45,7 @@ case "$device_no" in
         continue
     fi
     tst_resm TINFO "Testing ioctl02 with $tttype"
-    ioctl02 -D $tttype
+    ioctl02 -d $tttype
     RC=$?
     if  [ $RC -eq 0 ]
     then
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
