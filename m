Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975B1C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 10:19:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 925223CA37E
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 11:18:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34DBA3C9600
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 11:18:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 280C51000F39
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 11:18:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1A01C1F384;
 Fri,  4 Mar 2022 10:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646389127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q0BAXvJNLNJMWOz1cgFkW1oEIYm+eyEL8exrPP/sglo=;
 b=pgEOGgLULkBSqchy9AAFiHIjoqtzODaKgxhPqPAiCtTWdlWYXSqttmP5uvcq9LRaiS/YtR
 Tm1lYifsgM6KRGf6DtEIVZU6PWNv5F8aSdYbfugrzyRorf05PjHkrijFT+aGoiOQNWPeMq
 sLN3Bz809OwFVLRsQN9V0IrW9VaP6m4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646389127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q0BAXvJNLNJMWOz1cgFkW1oEIYm+eyEL8exrPP/sglo=;
 b=wJxGqoYfWTbFob5jHcX9Y2NkUQEfa9k4wQL1T1c9sdbeitSUTByYN9vsiGeHQXjO5ClHrt
 kI2bX12Z61+U6PCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04AFB13B2D;
 Fri,  4 Mar 2022 10:18:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id La2HO4bnIWKBGQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 04 Mar 2022 10:18:46 +0000
Date: Fri, 4 Mar 2022 11:21:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Message-ID: <YiHoEiZEvJ3yEFrU@yuki>
References: <20220304064026.82070-1-xiaoshoukui@ruijie.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220304064026.82070-1-xiaoshoukui@ruijie.com.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Add pty07 test for use-after-free in
 vt_ioctl()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with two minor changes, thanks.

- we do not use inline variable defintion since we are trying to be
  compatible with very old toolchains

- As the test has no CVE assigned the failure message cannot say
  "vunerable"

Full diff:

diff --git a/testcases/kernel/pty/pty07.c b/testcases/kernel/pty/pty07.c
index acd26f62e..462569c4a 100644
--- a/testcases/kernel/pty/pty07.c
+++ b/testcases/kernel/pty/pty07.c
@@ -42,9 +42,11 @@ static struct tst_fzsync_pair fzp;
 
 static void *open_close(void *unused)
 {
+	int i;
+
 	while (tst_fzsync_run_b(&fzp)) {
 		tst_fzsync_start_race_b(&fzp);
-		for (int i = test_tty_port; i < MAX_NR_CONSOLES; i++) {
+		for (i = test_tty_port; i < MAX_NR_CONSOLES; i++) {
 			ioctl(fd, VT_ACTIVATE, i);
 			ioctl(fd, VT_DISALLOCATE, i);
 		}
@@ -65,7 +67,7 @@ static void do_test(void)
 		ioctl(fd, VT_RESIZEX, &sz);
 		tst_fzsync_end_race_a(&fzp);
 		if (tst_taint_check()) {
-			tst_res(TFAIL, "Kernel is vulnerable");
+			tst_res(TFAIL, "Kernel is buggy");
 			break;
 		}
 	}

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
