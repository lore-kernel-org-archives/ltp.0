Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CDBCCF9F8
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 09:22:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDF8C3CF711
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 10:22:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 032943CF59E
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 10:22:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 50F481A00145
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 10:22:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D3C11F7E5;
 Wed, 12 Nov 2025 09:22:37 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E4D03EA61;
 Wed, 12 Nov 2025 09:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XE/3Ed1RFGkqeQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Nov 2025 09:22:37 +0000
Date: Wed, 12 Nov 2025 10:22:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251112092236.GA80114@pevik>
References: <20250924084223.20597-1-wegao@suse.com>
 <20251101012320.24972-1-wegao@suse.com>
 <20251101012320.24972-2-wegao@suse.com>
 <20251111120600.GA50277@pevik>
 <aRQuc47d3PpTczVB@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRQuc47d3PpTczVB@autotest-wegao.qe.prg2.suse.org>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 6D3C11F7E5
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_filesystems01.c: Add test for
 .filesystems
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

> On Tue, Nov 11, 2025 at 01:06:00PM +0100, Petr Vorel wrote:
> > Hi Wei,

> > ...
> > > +static void do_test(void)
> > > +{
> > > +	long fs_type;
> > > +
> > > +	fs_type = tst_fs_type(MOUNT_POINT);
> > > +
> > > +	if (fs_type == TST_EXT234_MAGIC) {
> > > +		TST_EXP_PASS((check_inode_size(128)));
> > > +		TST_EXP_PASS((check_mkfs_size_opt(10240)));

> > very nit: I would personally add #define for 128 and 10240, but sure it's ok to
> > keep it hardcoded on 2 places.
> I thought also use #define but i found and can not replace it in
> "mkfs_opts = (const char *const []){"-I", "128", "-b", "1024", NULL}",
> so i keep hardcoded number here.

Thanks for info. Sure, no problem.

Cc Cyril in case it's worth to fix it in metaparse.c.

Kind regards,
Petr

> > Kind regards,
> > Petr

> > > +	}
> > > +
> > > +	if (fs_type == TST_XFS_MAGIC)
> > > +		TST_EXP_PASS((check_mnt_data("usrquota")));
> > > +}
> > > +
> > > +static struct tst_test test = {
> > > +	.test_all = do_test,
> > > +	.needs_root = 1,
> > > +	.mntpoint = MOUNT_POINT,
> > > +	.mount_device = 1,
> > > +	.needs_cmds = (const char *[]) {
> > > +		"tune2fs",
> > > +		"dumpe2fs",
> > > +		NULL
> > > +	},
> > > +	.filesystems = (struct tst_fs []) {
> > > +		{
> > > +			.type = "ext3",
> > > +			.mkfs_opts = (const char *const []){"-I", "128", "-b", "1024", NULL},
> > > +			.mkfs_size_opt = "10240",
> > > +		},
> > > +		{
> > > +			.type = "xfs",
> > > +			.mnt_data = "usrquota",
> > > +		},
> > > +		{}
> > > +	},
> > > +
> > > +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
