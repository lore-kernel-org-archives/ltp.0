Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588CDC43334
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 12:50:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FB9A3C9FEA
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 14:50:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 095BF3C941D
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 14:49:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1099A200766
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 14:49:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1BCE2201AA;
 Mon, 25 Jul 2022 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658753395;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pzaKYbxnlOPuPs+8xkxfDJttz+LEOvY00s5ZGhJ5feE=;
 b=hn/B+e9vmXpYj1rDBBHCcNV0hxXPRgiSXyFAaX8W3wEf11CyJPxAPUclj3Igl8pSmfPzyR
 5DEpW9mBPCUlT00J5dycOcAy+JV1Xm8y8PNqbLDLnSCBM5cKiFP4p9DpozFuGHwxhfa+yh
 3s6Asejn7bw9TR14WbNqGK+GRKYxO7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658753395;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pzaKYbxnlOPuPs+8xkxfDJttz+LEOvY00s5ZGhJ5feE=;
 b=zsuh3lalmdnJ0Li2BhxbM2iCZsRWeuIYpv1SW+A6ly/Bu8Fk0ySz+rWRb4Tzmuh+zgocyg
 SvJkTLk/SfU6fcAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C705113ABB;
 Mon, 25 Jul 2022 12:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wLXALXKR3mJQagAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Jul 2022 12:49:54 +0000
Date: Mon, 25 Jul 2022 14:49:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Matthew Bobrowski <repnop@google.com>
Message-ID: <Yt6Rcd3NAO1bKwwD@pevik>
References: <20220719095853.3373732-1-amir73il@gmail.com>
 <20220719095853.3373732-2-amir73il@gmail.com>
 <YtcpBkevcBF6iycz@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YtcpBkevcBF6iycz@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/fanotify14: Encode the expected
 errno in test case
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, Jul 19, 2022 at 11:58:52AM +0200, Amir Goldstein wrote:
> > So we can add test cases for errors other than EINVAL.

> Just one optional nit. We can probably remove the comments which are
> directly above the existing `if (errno == EINVAL)` checks as they're
> specific to one expected errno value, but this is no longer the case
> with ENOTDIR now in some fanotify_init/fanotify_mark cases.

@Amir, I can remove it in this commit before merge (see diff below),
but don't you want to keep this info somewhere?
Or feel free to post new version.

BTW I tested both commits on various kernels and it works as expected
(failing only on 5.17.3 (openSUSE) 5.18.5, (Debian), old kernels TCONF
as expected.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

> Feel free to add RVB tags.

@Matthew FYI adding it with correct form in the email reply help us maintainers
to get it added automatically via LTP patchwork instance.

Kind regards,
Petr

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index c99e19706..ce7e4c54c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -84,11 +84,6 @@ static void do_test(unsigned int number)
 
 	fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY);
 	if (fanotify_fd < 0) {
-		/*
-		 * EINVAL is to be returned to the calling process when
-		 * an invalid notification class is specified in
-		 * conjunction with FAN_REPORT_FID.
-		 */
 		if (errno == tc->expected_errno) {
 			tst_res(TPASS,
 				"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
@@ -121,12 +116,6 @@ static void do_test(unsigned int number)
 	ret = fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
 				tc->mask, AT_FDCWD, FILE1);
 	if (ret < 0) {
-		/*
-		 * EINVAL is to be returned to the calling process when
-		 * attempting to use INODE_EVENTS without FAN_REPORT_FID
-		 * specified on the notification group, or using
-		 * INODE_EVENTS with mark type FAN_MARK_MOUNT.
-		 */
 		if (errno == tc->expected_errno) {
 			tst_res(TPASS,
 				"ret=%d, fanotify_mark(%d, FAN_MARK_ADD | %x, "

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
