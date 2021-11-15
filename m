Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3233C433F5
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 21:26:41 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491CC61BE3
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 21:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 491CC61BE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6EC83C871E
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 22:26:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 539B33C708C
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 22:26:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6C7B9600973
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 22:26:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 81A092170C;
 Mon, 15 Nov 2021 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637011587;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RIpISZM3Q4aQS4wDIT1b4W1D2mBknEGSZlwMt5K2VH8=;
 b=lm9ZldTT0ytxBO7IQDFr85VOMZIxpXAEe711lkdHzGO4AZxb54dbWrZFJCovp81OqNJER/
 uzMgSLNStiA5SIwBN/2qyE7WRzHegEgDg0aOmQfUL7Yhl0WQgyzK/dy5x9n+e4k3chiUgD
 4XZOhAewulQ8dFyEhk3Gc2dIZ+eho/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637011587;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RIpISZM3Q4aQS4wDIT1b4W1D2mBknEGSZlwMt5K2VH8=;
 b=EUQMg2d5mgAKL/Mlws3D6trb7w+7EvH+yOi5xl7rkutw7YRMzPzQ60dgLOAREOG2/8QGrS
 7Ao7sgIwIlsxl2Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CED8D13AE9;
 Mon, 15 Nov 2021 21:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iaD4KILQkmE0IwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 15 Nov 2021 21:26:26 +0000
Date: Mon, 15 Nov 2021 22:26:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <YZLQgDMTKBBlY8fN@pevik>
References: <20211029211732.386127-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/9] Test the new fanotify FAN_FS_ERROR event
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
Cc: kernel@collabora.com, khazhy@google.com, repnop@google.com, jack@suse.com,
 linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Gabriel, all,

I merged Matthew's v3 FAN_REPORT_PIDFD, which is for 5.15 kernel.

Could you please rebase your changes on the top of current master?
Unfortunately that means to rename fanotify21.c in all commits.

Also please: s/REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL/REQUIRE_MARK_TYPE_SUPPORTED_BY_KERNEL/

and other changes:

diff --git testcases/kernel/syscalls/fanotify/fanotify21.c testcases/kernel/syscalls/fanotify/fanotify21.c
index 7f0154da5..44882097b 100644
--- testcases/kernel/syscalls/fanotify/fanotify21.c
+++ testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -131,7 +131,7 @@ int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
 	if (memcmp(&fid->fsid, &ex->fid->fsid, sizeof(fid->fsid))) {
 		tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
 			ex->name, FSID_VAL_MEMBER(fid->fsid, 0),
-			FSID_VAL_MEMBER(ex->fid->fsid, 0));
+			ex->fid->fsid.val[0]);
 
 		return 1;
 	}
@@ -298,7 +298,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
-	.all_filesystems = 0,
 	.needs_root = 1,
 	.dev_fs_type = "ext4",
 	.needs_cmds = (const char *[]) {

Thanks!

Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
