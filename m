Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4E3C54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 09:35:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F61F3C58A4
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:35:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6C383C5502
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:34:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9F7CA10006B7
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:34:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D75871F78A;
 Tue, 27 May 2025 09:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748338482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xQxU12si+ljAUuRV+fp5+49xC3l2OnOKgRuZ0GJZe60=;
 b=AOpDU6oMgRZsXx1Glv+0YnnxruplaCHKb+KMlxivutka/BA9ooADmsQkWDnCBDWzyYT7Bq
 SELnzsfo8QxPnRYvrLG6+KQ7KS8ywFDB9b5Y49ujY06oZZPKghpjSWqMB5RbVFYKoyttSB
 5fIBZUY6dNe/RT0vyjCygDwc3UbsdwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748338482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xQxU12si+ljAUuRV+fp5+49xC3l2OnOKgRuZ0GJZe60=;
 b=rKzGg2HkGzUacFu8npWR/szyI1mTGHT5TrJAe9TvhLtvWrMjVJ7tQH3WGaPFO/eaCQ8f3q
 S7/3CPeQjfKtD8AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748338481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xQxU12si+ljAUuRV+fp5+49xC3l2OnOKgRuZ0GJZe60=;
 b=kwq3TZ+UA7Qc9RF2S3ZFb7UX/Qx+GyLx0kvxgeMZyusb5fBAstnlxV9UVwG8V6kruV11RH
 xiaKnypXAECJP1B+prXM6wFuM3KaFKoFb9TitTqy6o278Ukhm8ZWZ/FuiL2t5rzdYvaAcb
 7DzoKXyLODpiBiWI9aXrlPQe1oGlOP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748338481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xQxU12si+ljAUuRV+fp5+49xC3l2OnOKgRuZ0GJZe60=;
 b=ZCVxSxZaWtIOEdQQkyslGdo+KP16jz2JGd02oJzFSJgzg4iGbKTk7+Eia+c0Zey2jFylnD
 tNDdAGjxPj+BfaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3E8C136E0;
 Tue, 27 May 2025 09:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QAiHKjGHNWghWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 27 May 2025 09:34:41 +0000
Date: Tue, 27 May 2025 11:34:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250527093436.GC173684@pevik>
References: <20250526143429.22997-1-chrubis@suse.cz>
 <20250526155132.GA151544@pevik>
 <CAEemH2eyj5k5tUAQyo+b-JXKF5-GcLzQA5SXbP7xpqU1xU73NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eyj5k5tUAQyo+b-JXKF5-GcLzQA5SXbP7xpqU1xU73NQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] lib: LTP_SINGLE_FS_TYPE and
 LTP_FORCE_SINGLE_FS_TYPE
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

Hi Li, Cyril,

> Petr Vorel <pvorel@suse.cz> wrote:

> > > -     skip_fuse = tst_fs_in_skiplist("fuse", skiplist);
> > >       only_fs = getenv("LTP_SINGLE_FS_TYPE");
> > > +     force_only_fs = getenv("LTP_FORCE_SINGLE_FS_TYPE");
> > > +
> > > +     if (only_fs && force_only_fs) {
> > > +             tst_brk(TBROK,
> > > +                     "Only one of LTP_SINGLE_FS_TYPE and LTP_FORCE_SINGLE_FS_TYPE can be set");
> > > +             return NULL;
> > > +     }
> > > +
> > > +     skip_fuse = tst_fs_in_skiplist("fuse", skiplist);

> > >       if (only_fs) {
> > >               tst_res(TINFO, "WARNING: testing only %s", only_fs);
> > > -             if (tst_fs_is_supported(only_fs))
> > > +             if (fs_could_be_used(only_fs, skiplist, skip_fuse))
> > >                       fs_types[0] = only_fs;

> One more thing I'm a bit hesitant about, do we need to explicitly set
> fs_types[1] to NULL here?

Although it looks reasonable, I suppose it's not needed because array is static,
therefore members are NULL, right?

static const char *fs_types[ARRAY_SIZE(fs_type_whitelist)];

Also I tested it on statmount02.c, which has:

	.all_filesystems = 1,
	.skip_filesystems = (const char *const []) {
		"fuse",
		"btrfs",
		NULL
	},

and it works as expected:

# LTP_SINGLE_FS_TYPE=ntfs ./statmount02
...
tst_test.c:1953: TINFO: LTP version: 20250130-278-gada0e52d26
...
tst_supported_fs_types.c:190: TINFO: WARNING: testing only ntfs
tst_supported_fs_types.c:132: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:62: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:163: TINFO: Skipping FUSE based ntfs as requested by the test
tst_test.c:1917: TCONF: There are no supported filesystems

# LTP_FORCE_SINGLE_FS_TYPE=ntfs ./statmount02
...
tst_test.c:1953: TINFO: LTP version: 20250130-278-gada0e52d26
...
tst_supported_fs_types.c:197: TINFO: WARNING: force testing only ntfs
tst_test.c:1888: TINFO: === Testing on ntfs ===
tst_test.c:1217: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
statmount02.c:51: TINFO: Mounting /dev/loop0 to /tmp/LTP_sta2GSo2A/mntpoint fstyp=ntfs flags=1
statmount02.c:51: TINFO: Trying FUSE...
statmount02.c:35: TPASS: statmount(sx_mount->data.stx_mnt_id, STATMOUNT_SB_BASIC, st_mount, sizeof(struct statmount), 0) passed
statmount02.c:41: TPASS: st_mount->mask == STATMOUNT_SB_BASIC (1)
statmount02.c:42: TPASS: st_mount->size == sizeof(struct statmount) (512)
statmount02.c:43: TPASS: st_mount->sb_dev_major == sx_mount->data.stx_dev_major (7)
statmount02.c:44: TPASS: st_mount->sb_dev_minor == sx_mount->data.stx_dev_minor (0)
statmount02.c:45: TPASS: st_mount->sb_magic == sf_mount->f_type (1702057286)
statmount02.c:46: TFAIL: st_mount->sb_flags (0) != MS_RDONLY (1)
statmount02.c:60: TINFO: Umounting /tmp/LTP_sta2GSo2A/mntpoint

Kind regards,
Petr

> > >               return fs_types;
> > >       }

> > > -     for (i = 0; fs_type_whitelist[i]; i++) {
> > > -             if (tst_fs_in_skiplist(fs_type_whitelist[i], skiplist)) {
> > > -                     tst_res(TINFO, "Skipping %s as requested by the test",
> > > -                             fs_type_whitelist[i]);
> > > -                     continue;
> > > -             }
> > > -
> > > -             sup = tst_fs_is_supported(fs_type_whitelist[i]);
> > > -
> > > -             if (skip_fuse && sup == TST_FS_FUSE) {
> > > -                     tst_res(TINFO,
> > > -                             "Skipping FUSE based %s as requested by the test",
> > > -                             fs_type_whitelist[i]);
> > > -                     continue;
> > > -             }
> > > +     if (force_only_fs) {
> > > +             tst_res(TINFO, "WARNING: force testing only %s", force_only_fs);
> > > +             fs_types[0] = force_only_fs;

> fs_type[1] = NULL; ?

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
