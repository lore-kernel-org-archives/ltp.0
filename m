Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A899C36008
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 18:42:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 390803C9DCA
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 19:42:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7A103C9C65
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 19:42:23 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A7D8F10008FF
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 19:42:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 645B31F391;
 Wed, 26 Mar 2025 18:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743014539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B9qLH0qpM4x0RyvH9l3nS9+y/Bxb/6gbHoq6XOzakpA=;
 b=aDaEq4wq9W0uSnAg92BHuG5G+GM2WB7iX3whuDAa46OK9fwbor3OSL5iWzP3L0czOsHr4x
 IgTaTAL50wobvR46x0UjQizVXmGAXCqrH9iAihvaQg8pPoPliKd4WSyZhh96F+oPMZLOnu
 v/RlBEtTDGeqDKZeio4JAQSFg8qM7BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743014539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B9qLH0qpM4x0RyvH9l3nS9+y/Bxb/6gbHoq6XOzakpA=;
 b=3kqJHdvbGSK/a67Ulvl+95Sey+QWdMkCUsBlhkZj5egLN/xjROclsCZANmcv5oVd0jlcSo
 K6uxe84DKP1Uc8DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743014539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B9qLH0qpM4x0RyvH9l3nS9+y/Bxb/6gbHoq6XOzakpA=;
 b=aDaEq4wq9W0uSnAg92BHuG5G+GM2WB7iX3whuDAa46OK9fwbor3OSL5iWzP3L0czOsHr4x
 IgTaTAL50wobvR46x0UjQizVXmGAXCqrH9iAihvaQg8pPoPliKd4WSyZhh96F+oPMZLOnu
 v/RlBEtTDGeqDKZeio4JAQSFg8qM7BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743014539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B9qLH0qpM4x0RyvH9l3nS9+y/Bxb/6gbHoq6XOzakpA=;
 b=3kqJHdvbGSK/a67Ulvl+95Sey+QWdMkCUsBlhkZj5egLN/xjROclsCZANmcv5oVd0jlcSo
 K6uxe84DKP1Uc8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2748A13927;
 Wed, 26 Mar 2025 18:42:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4TwoCItK5Gf6GQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 26 Mar 2025 18:42:19 +0000
Date: Wed, 26 Mar 2025 19:42:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Message-ID: <20250326184208.GA53635@pevik>
References: <20250326-fix_ioctl_ficlone03_32bit_bcachefs-v1-1-554a0315ebf5@suse.com>
 <20250326134749.GA45449@pevik>
 <7ry7netcdqchal5pyoa5qdiris5klyxg6pqnz3qj6toodfgyuw@zder35svbr7v>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7ry7netcdqchal5pyoa5qdiris5klyxg6pqnz3qj6toodfgyuw@zder35svbr7v>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_ficlone03: fix capabilities on immutable
 files
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
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Kent,

> On Wed, Mar 26, 2025 at 02:47:49PM +0100, Petr Vorel wrote:
> > Hi all,

> > [ Cc Kent and other filesystem folks to be sure we don't hide a bug ]

> I'm missing context here, and the original thread doesn't seem to be on
> lore?

I'm sorry, to put more info: this is an attempt to fix of LTP test
ioctl_ficlone03.c [1], which is failing on 32 bit compatibility mode:

# ./ioctl_ficlone03
tst_test.c:1833: TINFO: === Testing on bcachefs ===
..
ioctl_ficlone03.c:74: TBROK: ioctl .. failed: ENOTTY (25)
ioctl_ficlone03.c:89: TWARN: ioctl ..  failed: ENOTTY (25)
ioctl_ficlone03.c:91: TWARN: ioctl ..  failed: ENOTTY (25)
ioctl_ficlone03.c:98: TWARN: close(-1) failed: EBADF (9)

Original thread of this is on LTP ML [2].

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
[2] https://lore.kernel.org/ltp/20250326-fix_ioctl_ficlone03_32bit_bcachefs-v1-1-554a0315ebf5@suse.com/

> > > From: Andrea Cervesato <andrea.cervesato@suse.com>

> > > Make sure that capabilities requirements are satisfied when accessing
> > > immutable files. On OpenSUSE Tumbleweed 32bit bcachefs fails with the
> > > following error due to missing capabilities:

> > > tst_test.c:1833: TINFO: === Testing on bcachefs ===
> > > ..
> > > ioctl_ficlone03.c:74: TBROK: ioctl .. failed: ENOTTY (25)
> > > ioctl_ficlone03.c:89: TWARN: ioctl ..  failed: ENOTTY (25)
> > > ioctl_ficlone03.c:91: TWARN: ioctl ..  failed: ENOTTY (25)
> > > ioctl_ficlone03.c:98: TWARN: close(-1) failed: EBADF (9)

> > > Introduce CAP_LINUX_IMMUTABLE capability to make sure that test won't
> > > fail on other systems as well.

> > > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > > ---
> > >  testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)

> > > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > > index 6a9d270d9fb56f3a263f0aed976f62c4576e6a5f..6716423d9c96d9fc1d433f28e0ae1511b912ae2c 100644
> > > --- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > > +++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > > @@ -122,5 +122,9 @@ static struct tst_test test = {
> > >  	.bufs = (struct tst_buffers []) {
> > >  		{&clone_range, .size = sizeof(struct file_clone_range)},
> > >  		{},
> > > -	}
> > > +	},
> > > +	.caps = (struct tst_cap []) {
> > > +		TST_CAP(TST_CAP_REQ, CAP_LINUX_IMMUTABLE),
> > > +		{}
> > > +	},

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > LGTM, obviously it is CAP_LINUX_IMMUTABLE related.

> > This looks like fs/bcachefs/fs-ioctl.c

> > static int bch2_inode_flags_set(struct btree_trans *trans,
> > 				struct bch_inode_info *inode,
> > 				struct bch_inode_unpacked *bi,
> > 				void *p)
> > {
> > 	...
> > 	if (((newflags ^ oldflags) & (BCH_INODE_append|BCH_INODE_immutable)) &&
> > 	    !capable(CAP_LINUX_IMMUTABLE))
> > 		return -EPERM;


> > We don't test on vfat and exfat. If I try to do it fail the same way (bcachefs,
> > fat, exfat and ocfs2 use custom handler for FAT_IOCTL_SET_ATTRIBUTES).

> > I wonder why it does not fail for generic VFS fs/ioctl.c used by Btrfs and XFS:

> > /*
> >  * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
> >  * any invalid configurations.
> >  *
> >  * Note: must be called with inode lock held.
> >  */
> > static int fileattr_set_prepare(struct inode *inode,
> > 			      const struct fileattr *old_ma,
> > 			      struct fileattr *fa)
> > {
> > 	int err;

> > 	/*
> > 	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
> > 	 * the relevant capability.
> > 	 */
> > 	if ((fa->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
> > 	    !capable(CAP_LINUX_IMMUTABLE))
> > 		return -EPERM;


> > Kind regards,
> > Petr

> > >  };

> > > ---
> > > base-commit: 753bd13472d4be44eb70ff183b007fe9c5fffa07
> > > change-id: 20250326-fix_ioctl_ficlone03_32bit_bcachefs-2ec15bd6c0c6

> > > Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
