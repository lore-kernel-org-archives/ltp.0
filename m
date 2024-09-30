Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54985CF6497
	for <ltp@archiver.kernel.org>; Mon, 30 Sep 2024 11:34:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B30753C564D
	for <ltp@archiver.kernel.org>; Mon, 30 Sep 2024 13:34:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BE0D3C00C7
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 13:34:36 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B8B711A008BA
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 13:34:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E582E21A36;
 Mon, 30 Sep 2024 11:34:34 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D732A136CB;
 Mon, 30 Sep 2024 11:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zJt8NMqM+mYbVgAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 30 Sep 2024 11:34:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 6FF1CA0845; Mon, 30 Sep 2024 13:34:34 +0200 (CEST)
Date: Mon, 30 Sep 2024 13:34:34 +0200
From: Jan Kara <jack@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20240930113434.hhkro4bofhvapwm7@quack3>
References: <20240805201241.27286-1-jack@suse.cz>
 <Zvp6L+oFnfASaoHl@t14s>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zvp6L+oFnfASaoHl@t14s>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: E582E21A36
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
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
Cc: Christian Brauner <brauner@kernel.org>, Ted Tso <tytso@mit.edu>,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 30-09-24 12:15:11, Jan Stancek wrote:
> On Mon, Aug 05, 2024 at 10:12:41PM +0200, Jan Kara wrote:
> > When the filesystem is mounted with errors=remount-ro, we were setting
> > SB_RDONLY flag to stop all filesystem modifications. We knew this misses
> > proper locking (sb->s_umount) and does not go through proper filesystem
> > remount procedure but it has been the way this worked since early ext2
> > days and it was good enough for catastrophic situation damage
> > mitigation. Recently, syzbot has found a way (see link) to trigger
> > warnings in filesystem freezing because the code got confused by
> > SB_RDONLY changing under its hands. Since these days we set
> > EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
> > filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
> > stop doing that.
> > 
> > Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google.com
> > Reported-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> > fs/ext4/super.c | 9 +++++----
> > 1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > Note that this patch introduces fstests failure with generic/459 test because
> > it assumes that either freezing succeeds or 'ro' is among mount options. But
> > we fail the freeze with EFSCORRUPTED. This needs fixing in the test but at this
> > point I'm not sure how exactly.
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index e72145c4ae5a..93c016b186c0 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
> > 
> > 	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> > 	/*
> > -	 * Make sure updated value of ->s_mount_flags will be visible before
> > -	 * ->s_flags update
> > +	 * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
> > +	 * modifications. We don't set SB_RDONLY because that requires
> > +	 * sb->s_umount semaphore and setting it without proper remount
> > +	 * procedure is confusing code such as freeze_super() leading to
> > +	 * deadlocks and other problems.
> > 	 */
> > -	smp_wmb();
> > -	sb->s_flags |= SB_RDONLY;
> 
> Hi,
> 
> shouldn't the SB_RDONLY still be set (in __ext4_remount()) for the case
> when user triggers the abort with mount(.., "abort")? Because now we seem
> to always hit the condition that returns EROFS to user-space.

Thanks for report! I agree returning EROFS from the mount although
'aborting' succeeded is confusing and is mostly an unintended side effect
that after aborting the fs further changes to mount state are forbidden but
the testcase additionally wants to remount the fs read-only.

I don't think forcibly setting SB_RDONLY in this case is good because it
would still bypass all VFS checks for read-only remount and thus possibly
causing undesirable surprises (similar to those d3476f3dad4a ("ext4: don't
set SB_RDONLY after filesystem errors") tried to fix). At this point I'm
undecided whether __ext4_remount() should just return success after
aborting the filesystem, ignoring all other mount options, or whether we
should follow more the old behavior where we still reflect other mount
options (mostly resulting in cleanup of lazy itable initialization thread,
mmpd thread and similar).  I'm more leaning towards option 1) but I could
be convinced otherwise. Ted, what do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
