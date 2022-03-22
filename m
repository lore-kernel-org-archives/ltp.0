Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4D0C433FE
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 09:47:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D8BC3C8813
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 10:47:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E177E3C72F7
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 10:47:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 46934600850
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 10:47:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75CD31F385;
 Tue, 22 Mar 2022 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647942428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KBucdGqyl41tHKzyT8zK5cwq+//QA4CS9vEYDJWrbKA=;
 b=bI4+p/k4/x8qzio510T4QMBIzFDVO5rcxaEImf2hRl/vVezlIRLlrNCVY5wZLAqlqTx2ME
 +AHSBl9Z6bleWKUhGnGFiwu/Id7s97tH7/2TQpez4y2onIjVNZyNZmNz32zDQYXpvzamib
 Lz7Fa7E581c0IyVcu+QX34OldhKzH6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647942428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KBucdGqyl41tHKzyT8zK5cwq+//QA4CS9vEYDJWrbKA=;
 b=Bb5L6kzDfqf1wUKuto7G7KVRbRvuIg+u8K54ka5hEwXR4NJLfBVI4VK7Z4elPfdjvKEMM+
 MVGw5r2pymvMJ9Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CB8212FC5;
 Tue, 22 Mar 2022 09:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MXU2ERybOWKUFQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 22 Mar 2022 09:47:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Mar 2022 10:47:03 +0100
Message-Id: <20220322094704.16935-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] nfs01_open_files: Fix st_size check
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

94c85d93e8 didn't update struct stat st_size check, but the problem was
hidden until dc836ec4cd (before code was not run).

Fixes: 94c85d93e8 ("nfs01: fix string overrrun")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs01_open_files.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs01_open_files.c b/testcases/network/nfs/nfs_stress/nfs01_open_files.c
index cc6a84d685..0a4732859e 100644
--- a/testcases/network/nfs/nfs_stress/nfs01_open_files.c
+++ b/testcases/network/nfs/nfs_stress/nfs01_open_files.c
@@ -13,6 +13,8 @@
 #define TEMPLATE_PREFIX "ltp"
 #define TEMPLATE_PREFIX_LEN (sizeof(TEMPLATE_PREFIX) - 1)
 #define TEMPLATE TEMPLATE_PREFIX "XXXXXX"
+#define MSG "I Love Linux!!!\n"
+#define MSG_LEN (sizeof(MSG) - 1)
 
 int write_something(int);
 void delete_files(void);
@@ -84,7 +86,7 @@ int main(int argc, char *argv[])
 int write_something(int fd)
 {
 	int rc;
-	const char msg[] = "I Love Linux!!!\n";
+	const char msg[] = MSG;
 	int msg_len = strlen(msg);
 
 	rc = write(fd, msg, msg_len);
@@ -107,9 +109,11 @@ void delete_files(void)
 			if (stat(entp->d_name, &stat_buffer))
 				abortx("stat() failed for \"%s\", errno = %d",
 				       entp->d_name, errno);
-			if (stat_buffer.st_size != 23)
-				abortx("wrong file size for \"%s\"",
-				       entp->d_name);
+
+			if (stat_buffer.st_size != MSG_LEN)
+				abortx("wrong file size for \"%s\": %d",
+				       entp->d_name, stat_buffer.st_size);
+
 			if (unlink(entp->d_name))
 				abortx("unlink failed for \"%s\"",
 				       entp->d_name);
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
