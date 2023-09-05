Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EE4C83F33
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 11:56:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28DD23CB8E2
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 13:56:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1095A3CB4B6
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 13:56:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 72EFD1000A62
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 13:56:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB59721991;
 Tue,  5 Sep 2023 11:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693914970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CSBbm0jdNnVSsMTj9vtdUB5ORt2qzvaxYBrFQG3bh5w=;
 b=1OYldTTBggssiWmKCSDn9kYxeuNYB8U+pLSaN+rmzNQU5wFyi3t+BZveQ6ykYCAZW4chwG
 jpUIyICCXA1XTPNgAlWPxHOjkTGN1YFpk8i/gsQwPpHgDk7yqSchKPsf9CHW5b8u+UkdzH
 QFYEMHHYfvDPuouVeTyJtbI2L9+F7Yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693914970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CSBbm0jdNnVSsMTj9vtdUB5ORt2qzvaxYBrFQG3bh5w=;
 b=F9DLE7SxYRrDmnJpFYSs12UPXqXJECxqbX8XR5rubPMBumziOi0AxuKeRO1DwrmYPQilw/
 yE5cGbGtpmXse9Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D629C13A1B;
 Tue,  5 Sep 2023 11:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6EU6M1oX92QlAwAAMHmgww
 (envelope-from <mkittler@suse.de>); Tue, 05 Sep 2023 11:56:10 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Tue,  5 Sep 2023 13:56:08 +0200
Message-ID: <20230905115608.31192-3-mkittler@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905115608.31192-1-mkittler@suse.de>
References: <20230905115608.31192-1-mkittler@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Use correct binary operand in ioctl02.c
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

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 testcases/kernel/syscalls/ioctl/ioctl02.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index 65a00821c..999128ed8 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -282,7 +282,7 @@ static int chk_tty_parms(void)
 
 	if (!
 	    (termio.c_lflag
-	     && (ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {
+	     & (ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {
 		tst_res(TINFO, "lflag has incorrect value. %o",
 			 termio.c_lflag);
 		flag++;
@@ -290,14 +290,14 @@ static int chk_tty_parms(void)
 
 	if (!
 	    (termio.c_iflag
-	     && (BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY
+	     & (BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY
 		 | IXOFF))) {
 		tst_res(TINFO, "iflag has incorrect value. %o",
 			 termio.c_iflag);
 		flag++;
 	}
 
-	if (!(termio.c_oflag && (OPOST | OLCUC | ONLCR | ONOCR))) {
+	if (!(termio.c_oflag & (OPOST | OLCUC | ONLCR | ONOCR))) {
 		tst_res(TINFO, "oflag has incorrect value. %o",
 			 termio.c_oflag);
 		flag++;
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
