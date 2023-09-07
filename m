Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4F9EE14D4
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 09:23:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 922113CC2F6
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 11:22:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC18A3CB65C
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 11:22:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AC02610007AD
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 11:22:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DB7F1F8AA;
 Thu,  7 Sep 2023 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694078566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHQGYLJPldZPKL7RINBVcEsCny+6adgwB/ZrAYhmB+Y=;
 b=LQxHvdO7WGLoUXWiL8IYuwxeTXpHrJZX7PWuLU4QPkvUqL5+L7tGpPWHKmb8OlMGZ9GSdr
 biDmuh8t+ocfLIa3gPURfM9iVZNuXVmRt2uUfCcYP4uIfetJLK9JEzx9HoWU6DjiN5Vo77
 /GzzskKHMYuj27Q6cs0Fq36sZTfsUSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694078566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHQGYLJPldZPKL7RINBVcEsCny+6adgwB/ZrAYhmB+Y=;
 b=bcisFzHkqZQuS4NXltc/zu7yo75dR8RDAqLWlkDWf/uoMDeXpSNIJUccFaiewKNubg4WFs
 SetcH1b7iMwGdkCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 392AA138F9;
 Thu,  7 Sep 2023 09:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MDz6DGaW+WSINgAAMHmgww
 (envelope-from <mkittler@suse.de>); Thu, 07 Sep 2023 09:22:46 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 Sep 2023 11:22:39 +0200
Message-ID: <20230907092239.15253-4-mkittler@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907092239.15253-1-mkittler@suse.de>
References: <20230907092239.15253-1-mkittler@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] Make checks for termio flags more strict
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

The checks for termio flags can actually use a `!=` check to
also fail when any unexpected flags are present.

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 testcases/kernel/syscalls/ioctl/ioctl02.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index 72a446f99..6b0924c65 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -224,24 +224,21 @@ static int chk_tty_parms(void)
 		}
 	}
 
-	if (!
-	    (termio.c_lflag
-	     & (ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {
+	if (termio.c_lflag != (ISIG | ICANON | XCASE | ECHO | ECHOE
+		 | NOFLSH)) {
 		tst_res(TINFO, "lflag has incorrect value. %o",
 			 termio.c_lflag);
 		flag++;
 	}
 
-	if (!
-	    (termio.c_iflag
-	     & (BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY
-		 | IXOFF))) {
+	if (termio.c_iflag != (BRKINT | IGNPAR | INPCK | ISTRIP
+		 | ICRNL | IUCLC | IXON | IXANY | IXOFF)) {
 		tst_res(TINFO, "iflag has incorrect value. %o",
 			 termio.c_iflag);
 		flag++;
 	}
 
-	if (!(termio.c_oflag & (OPOST | OLCUC | ONLCR | ONOCR))) {
+	if (termio.c_oflag != (OPOST | OLCUC | ONLCR | ONOCR)) {
 		tst_res(TINFO, "oflag has incorrect value. %o",
 			 termio.c_oflag);
 		flag++;
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
