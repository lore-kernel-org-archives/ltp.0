Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3798DC4345F
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 12:18:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E6D03CFA23
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 14:18:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AC3B3CF9FB
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 14:17:49 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B4F9E200963
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 14:17:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E263334FE5;
 Mon, 15 Apr 2024 12:17:47 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAC6F1386E;
 Mon, 15 Apr 2024 12:17:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8M5xMOsaHWYJeQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Apr 2024 12:17:47 +0000
Date: Mon, 15 Apr 2024 14:17:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240415121742.GA525356@pevik>
References: <20240118073215.10026-1-wegao@suse.com>
 <20240331021720.9527-1-wegao@suse.com>
 <20240403092827.GA419563@pevik> <Zhz+z3qoMiwxCssg@wegao.93.165.106>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zhz+z3qoMiwxCssg@wegao.93.165.106>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: E263334FE5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl_fiemap01: New test for fiemap ioctl()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Wed, Apr 03, 2024 at 11:28:27AM +0200, Petr Vorel wrote:
> > Hi Wei,

> > > +static struct tst_test test = {
> > > +	.mount_device = 1,
> > > +	.mntpoint = TMPDIR,
> > > +	.all_filesystems = 1,
> > > +	.skip_filesystems = (const char *const[]) {
> > > +		"exfat", "vfat", "fuse", "ntfs", "tmpfs", NULL

> > Why do you whitelist fuse? Which filesystem under fuse does not work?
> I will remove fuse in next patch.

> But i find fs_type_whitelist not contain "fuse", so this will lead 

lib/tst_supported_fs_types.c contains:

skip_fuse = tst_fs_in_skiplist("fuse", skiplist);

=> please use it.

Kind regards,
Petr

> func tst_get_supported_fs_type can not handle "fuse" filesystem, 
> means add/remove "fuse" into skip_filesystems will not take any effect. 
> Correct me if i have any misunderstanding.

> static const char *const fs_type_whitelist[] = {
>         "ext2",
>         "ext3",
>         "ext4",
>         "xfs",
>         "btrfs",
>         "bcachefs",
>         "vfat",
>         "exfat",
>         "ntfs",
>         "tmpfs",
>         NULL
> };


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
