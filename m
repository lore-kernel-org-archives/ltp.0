Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AF5C3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 12:21:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C1273D1B59
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 14:21:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23E733D1B59
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 14:21:35 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 134FD1A02382
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 14:21:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 846B621A90;
 Wed, 24 Jul 2024 12:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721823693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cBamXcu8aWWvlwPnUSKN55xy45roPAsDJRDEFf5nGFw=;
 b=Rtdi0I8lECmIxRiW0X+KXi5FL6uP8TkyI9ZSPu4+EhnoF6siH8fgnVyKJukn0LMGEDyLDL
 lrnnTcWtlXftBTlttVSMA/+pOPkZjFd/8i6TywPJPy6CHyGbMnWMYGn84cjG8LFAT3fn3d
 aZymdA5dA1deLb0LMNNNvVePC5AvRY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721823693;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cBamXcu8aWWvlwPnUSKN55xy45roPAsDJRDEFf5nGFw=;
 b=LphXISZAPy6iOq1nO2QCeT+AdQb7N8OjcJSOVQBkLYG16vXb0+ALLkf+NTdbBHY18CbyqK
 eKNn8WuPaBW5obBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721823692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cBamXcu8aWWvlwPnUSKN55xy45roPAsDJRDEFf5nGFw=;
 b=2/yrJnxhXVxLl6EpHwxny6XmBGaJr/eIPJvqJJV2Oj2YscUsnjd7olZrv22gOf/tBY+JWq
 bK2OOE661TUbTOnMmj1W1JJiWAJFlElL0Z/0Ly5Xn7XpSNiLFOrATEe82TjJD0MNe1xeoY
 wvFAWDuwr/TSPFvIUKgNPoDleiQAF/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721823692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cBamXcu8aWWvlwPnUSKN55xy45roPAsDJRDEFf5nGFw=;
 b=e2svJq0Dg/RjutF9n8cWJ0YCIgCs4HqAn9HfDbrFlPyRLve9FayL91iufOBSZUd5miktk1
 Xviy5hyIj0ox7aCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 671DB13411;
 Wed, 24 Jul 2024 12:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z2oKGMzxoGYBBAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jul 2024 12:21:32 +0000
Date: Wed, 24 Jul 2024 14:20:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZqDxq_Rd6fF8AjBN@yuki>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-4-33075bbc117f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240723-ioctl_ficlone-v2-4-33075bbc117f@suse.com>
X-Spamd-Result: default: False [-0.60 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/7] Add ioctl_ficlone03 test
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
Pushed with a small fix, thanks.

The immutable file has to be on the MNTPOINT as well as th source for
the immutable file, otherwise we get EOPNOTSUPP instead of EPERM since
the check for supported filesystems kicks in first:

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
index be069836a..406b64cca 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
@@ -37,7 +37,7 @@ static struct tcase {
        {&wo_file, &rw_file, EBADF, "write-only source"},
        {&rw_file, &dir_fd, EISDIR, "source is a directory"},
        {&dir_fd, &rw_file, EISDIR, "destination is a directory"},
-       {&rw_file, &immut_fd, EPERM, "destination is immutable"},
+       {&mnt_file, &immut_fd, EPERM, "destination is immutable"},
        {&rw_file, &mnt_file, EXDEV, "destination is on a different mount"},
        {&mnt_file, &rw_file, EXDEV, "source is on a different mount"},
 };
@@ -72,7 +72,7 @@ static void setup(void)
        dir_fd = SAFE_OPEN("mydir", O_DIRECTORY, 0640);

        attr = FS_IMMUTABLE_FL;
-       immut_fd = SAFE_OPEN("immutable", O_CREAT | O_RDWR, 0640);
+       immut_fd = SAFE_OPEN(MNTPOINT"/immutable", O_CREAT | O_RDWR, 0640);
        SAFE_IOCTL(immut_fd, FS_IOC_SETFLAGS, &attr);

        mnt_file = SAFE_OPEN(MNTPOINT"/file", O_CREAT | O_RDWR, 0640);


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
