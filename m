Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324DAC433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 11:00:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C52153C8CA7
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 12:00:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3245B3C80B1
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 12:00:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 742D260101B
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 12:00:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4268C210FB;
 Fri, 11 Mar 2022 11:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646996420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LBwUI214Y7k9CX/DIXRYIJMNMYetv8yWNlhA6F8P5Ps=;
 b=qtGOe+ysU9xa8cf1Hp0xqDVEz7sNKdfoVYroSxLSjnvwWLfV/oiY3G+XsnZwTybWoIsi4v
 POwEaaNjsMc3Uepev5YHKZWB1hezPDxrg3kpTU9r/0uBP6DIBg5djXFZHF9qGRucOyDwim
 P21GKo3N7tZRs+cfKoRomtr8CzGGo1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646996420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LBwUI214Y7k9CX/DIXRYIJMNMYetv8yWNlhA6F8P5Ps=;
 b=0Qdc/usELq1/xYhYBYHEAzelyfiteSS3+lQF8eWJ+EH01u9+fVIF8553zR0LiPbsYdblmS
 wP5Cq62g/WUq7GBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 167D313A85;
 Fri, 11 Mar 2022 11:00:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VsmtA8QrK2IjBQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 11 Mar 2022 11:00:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Mar 2022 12:00:15 +0100
Message-Id: <20220311110015.20951-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] nfs01_open_files: Fix pattern for deleted files
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
Cc: Neil Brown <neilb@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixes: 0989fe65f3 ("Corrected the export lines in nfs01 ...")

Reported-by: Neil Brown <neilb@suse.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs01_open_files.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs01_open_files.c b/testcases/network/nfs/nfs_stress/nfs01_open_files.c
index 9342f11ba9..c5627058dc 100644
--- a/testcases/network/nfs/nfs_stress/nfs01_open_files.c
+++ b/testcases/network/nfs/nfs_stress/nfs01_open_files.c
@@ -10,7 +10,8 @@
 #include <sys/stat.h>
 #include <unistd.h>
 
-#define TEMPLATE "ltpXXXXXX"
+#define TEMPLATE_PREFIX "ltp"
+#define TEMPLATE TEMPLATE_PREFIX "XXXXXX"
 
 int write_something(int);
 void delete_files(void);
@@ -101,7 +102,7 @@ void delete_files(void)
 
 	dirp = opendir(".");
 	for (entp = readdir(dirp); entp; entp = readdir(dirp))
-		if (!strncmp(entp->d_name, "apt", 3)) {
+		if (!strncmp(entp->d_name, TEMPLATE_PREFIX, 3)) {
 			if (stat(entp->d_name, &stat_buffer))
 				abortx("stat() failed for \"%s\", errno = %d",
 				       entp->d_name, errno);
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
