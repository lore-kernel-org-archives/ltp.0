Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696B3C433EF
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 08:59:23 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E85A611EF
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 08:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E85A611EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14F2F3C7324
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 09:59:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 542443C4B8F
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 09:59:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5178E1001296
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 09:59:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 837661FD33;
 Fri,  5 Nov 2021 08:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636102748;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7vTQRd+FsseWzqLlxM7LU6kApFmHFBdkT696eVDN5rg=;
 b=UZCwcikeHe+hKrDIuu0KUBIrM88LJMxb2qcI28Owy6IwsSuaDWxZ2YQ0crX1ucR9oj/ssK
 7fVjr1WmJ09aR9YK6AettzzhWyvTGpbhOIpLvctMIJEhIqsycR/Qo9JD9Eb9uU+dPWg8c7
 hyd5tJzXNVt7Dq3ink3tPV0d8DLV6Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636102748;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7vTQRd+FsseWzqLlxM7LU6kApFmHFBdkT696eVDN5rg=;
 b=irvOcv58cHch10vX6ODxoZIzRjNhIfYtToaOHS53fKMk/eUWmNU0ULvzj8xalopoGbzNab
 l8+Uaqj9lz9yYJDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25D9013FBA;
 Fri,  5 Nov 2021 08:59:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0rrqBlzyhGHlVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 Nov 2021 08:59:08 +0000
Date: Fri, 5 Nov 2021 09:59:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YYTyWs4UPEL0eqjR@pevik>
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-4-krisman@collabora.com>
 <CAOQ4uxiwodQm_9+XVY-cWhV6aWKkqTosBfZ0HyAQTVNijJrwuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiwodQm_9+XVY-cWhV6aWKkqTosBfZ0HyAQTVNijJrwuQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/9] syscalls/fanotify21: Introduce
 FAN_FS_ERROR test
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>,
 Gabriel Krisman Bertazi <krisman@collabora.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> > +static struct tst_test test = {
> > +       .test = do_test,
> > +       .tcnt = ARRAY_SIZE(testcases),
> > +       .setup = setup,
> > +       .cleanup = cleanup,
> > +       .mount_device = 1,
> > +       .mntpoint = MOUNT_PATH,
> > +       .all_filesystems = 0,

> That's probably redundant and the default value anyway.
> If you want to stress out that this test cannot be run on other filesystems
> maybe add a comment why that is above dev_fs_type.

Yes, good catch. Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
