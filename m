Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85003C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 13:07:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D076B3CF95B
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 14:07:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1F1E3CE101
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 14:07:18 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6BABA1002059
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 14:07:17 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 85ADC1F848;
 Tue, 30 Jan 2024 13:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706620034;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKAYt1fn1euZi5LszqMypWEMN9SWJen1x3IaJlfsFfk=;
 b=qycYkM6dqoCxCoFXXIWkQGT0AugIzYkG6SRB643Z9g2XWYQXGb5G0G4R1O2kosYlECwXcw
 JWvNkKPZS2psu4MJ/igrEL0T+zigTM463pSIU8mshhb/nRr2c27efwqrGzbKP0YdXFoI9X
 GyFwXyHHbMZDnD2KP+pCw7psv/imEw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706620034;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKAYt1fn1euZi5LszqMypWEMN9SWJen1x3IaJlfsFfk=;
 b=9bDwztMBNmNRp2vtWBpJ8BjOiMkdMdmXH2jmUEb1V+fDECK6G02mPg5D9yegw0XEW08RmH
 hgPLcC6ssB3CieCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706620034;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKAYt1fn1euZi5LszqMypWEMN9SWJen1x3IaJlfsFfk=;
 b=qycYkM6dqoCxCoFXXIWkQGT0AugIzYkG6SRB643Z9g2XWYQXGb5G0G4R1O2kosYlECwXcw
 JWvNkKPZS2psu4MJ/igrEL0T+zigTM463pSIU8mshhb/nRr2c27efwqrGzbKP0YdXFoI9X
 GyFwXyHHbMZDnD2KP+pCw7psv/imEw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706620034;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKAYt1fn1euZi5LszqMypWEMN9SWJen1x3IaJlfsFfk=;
 b=9bDwztMBNmNRp2vtWBpJ8BjOiMkdMdmXH2jmUEb1V+fDECK6G02mPg5D9yegw0XEW08RmH
 hgPLcC6ssB3CieCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EDF913212;
 Tue, 30 Jan 2024 13:07:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id c2UzFoL0uGUaJgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 13:07:14 +0000
Date: Tue, 30 Jan 2024 14:07:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240130130712.GB778733@pevik>
References: <20240125110510.751445-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240125110510.751445-1-amir73il@gmail.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qycYkM6d;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9bDwztMB
X-Spamd-Result: default: False [-1.72 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 FREEMAIL_TO(0.00)[gmail.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-2.21)[96.24%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 85ADC1F848
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: Test setting two marks on different
 filesystems
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

Hi Amir, Jan,

I was going to merge, but I suspect this does not work on TMPDIR on btrfs.

Tested on SLE 15-SP6 (kernel 6.4), on 15-SP4 (kernel 5.14), Tumbleweed (kernel
6.8.0-rc1), Alpine Linux (kernel 6.4) I get:

fanotify01.c:341: TFAIL: fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") failed: EXDEV (18)

for tests #3, #4 and #5 on all filesystems.

Testing on other on other filesystem it works: Debian kernel 5.10, 6.1 on ext4,
Alpine Linux kernel 6.4 on tmpfs, Tumbleweed kernel 6.8.0-rc1 on tmpfs.

Should be btrfs handled differently or skipped? (below)
Or test EXDEV for #3, #4 and #5? (not sure how handle just half of the tests on
btrfs differently).

Kind regards,
Petr

diff --git testcases/kernel/syscalls/fanotify/fanotify01.c testcases/kernel/syscalls/fanotify/fanotify01.c
index ba09f309d..97ade1829 100644
--- testcases/kernel/syscalls/fanotify/fanotify01.c
+++ testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -335,8 +335,15 @@ pass:
 	 * different filesystems are supported.
 	 * When tested fs has zero fsid (e.g. fuse) and events are reported
 	 * with fsid+fid, watching different filesystems is not supported.
+	 * Not supported on Btrfs.
 	 */
+	if (tst_fs_type(".") == TST_BTRFS_MAGIC) {
+		tst_res(TCONF, "skipped on Btrfs");
+		return;
+	}
+
 	ret = report_fid ? inode_mark_fid_xdev : 0;
+
 	TST_EXP_FD_OR_FAIL(fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_CLOSE_WRITE,
 					 AT_FDCWD, "."), ret);
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
