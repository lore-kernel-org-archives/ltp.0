Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4E6C3DA45
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 12:29:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53C7B3D3856
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 14:29:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 339CD3D3824
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 14:29:27 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 933F41A01115
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 14:29:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F17871F82B;
 Wed, 10 Jul 2024 12:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720614565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4tPhyT9XkP/43ggHqa+QMNbILz45q0TFsjSXlJ8IVM8=;
 b=rmtCZdk74cBAjWRgdYFeEZQblUrjEbtnTiKH5m9NEQp39m1WlDBy5eazE/kbPXdGBhQzyO
 +Lg0mopSWAswKe+tDRZffJ7FwNr6Xg9EU9UfebQe0BE3Hx5l7ELJM41k4ZeJQxASWdb8d/
 zPPaZcrwmmmscz5jEyks5g/kq2GbVyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720614565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4tPhyT9XkP/43ggHqa+QMNbILz45q0TFsjSXlJ8IVM8=;
 b=pnHu2AobFULhe4HZ9GTkO1IAVBtCFCvQqeSlbyJklZNyjFY761EzBY38rP1ie6ki/jQYAz
 IocJ9vcjJe8l/oBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720614564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4tPhyT9XkP/43ggHqa+QMNbILz45q0TFsjSXlJ8IVM8=;
 b=BaFtbWtFdA3Xpa62Ina//2BtdpFwTHZWq8KZBJgIM7Lwpzcm2Nqzbd8M98exlSg5K7FuHv
 zR1oIJgqHEChNipHeZdfJUNPcGrqPm77/GEdN3WmM0IipH1HAGbRTOmjcOO+5ZwDzLvTuJ
 v7MpYGbKoX+rdxUE6YGzpJF15uYbw5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720614564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4tPhyT9XkP/43ggHqa+QMNbILz45q0TFsjSXlJ8IVM8=;
 b=O1neoQn6eDpOu09L+GjS+qnkN1ELp5rvhnJkXC/mlwG2qea0uURevkcx9d/yTIlv8SPf9d
 I66/OT8Wp+gz6xDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4F701369A;
 Wed, 10 Jul 2024 12:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FpkTM6R+jmaGEwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Jul 2024 12:29:24 +0000
Date: Wed, 10 Jul 2024 14:29:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zo5-mKHmFV_Uhl3-@yuki>
References: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
 <20240709-stat04-v2-1-2693a473a2ab@suse.com>
 <20240709211302.GA214763@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240709211302.GA214763@pevik>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.990]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_THREE(0.00)[4]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] Add stat04 test
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
> PATH_MAX is 4096, right? Is it really needed to test the length?

Contrary to the popular belief PATH_MAX is a limit for lenght of a
single filesytem path component, i.e. directory or a file name. And yes
I've seen bugreports for LTP where people pointed TMPDIR to a deep
enough filesystem path for this to matter.

Anyways I've proposed to allocate the paths instead with asprintf().

> > +
> > +	/* change st_blksize / st_dev */
> > +	SAFE_STAT(".", &sb);
> > +	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
> > +
> > +	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
> > +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> > +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
> 
> Isn't symlink filesystem related? Shouldn't this be run on all_filesystems?

Hmm, I was assuming that symlink was a generic funcionality, but
thinking about it the symlink data has to be stored in the filesystem so
I suppose that there is some filesystem specific code to be tested after
all.

I guess that this could stil be implemented but we would have to add
support for multiple devices. I can have a look later on, but I wouldn't
block this patch because of that.

> > +
> > +	SAFE_TOUCH(FILENAME, 0777, NULL);
> > +
> > +	/* change st_nlink */
> > +	SAFE_LINK(FILENAME, "linked_file");
> > +
> > +	/* change st_uid and st_gid */
> > +	SAFE_CHOWN(FILENAME, 1000, 1000);
> > +
> > +	/* change st_size */
> > +	fd = SAFE_OPEN(FILENAME, O_WRONLY, 0777);
> > +	tst_fill_fd(fd, 'a', TST_KB, 500);
> > +	SAFE_CLOSE(fd);
> > +
> > +	/* change st_atime / st_mtime / st_ctime */
> > +	usleep(1001000);
> > +
> > +	memset(file_path, 0, PATH_MAX);
> > +	snprintf(file_path, PATH_MAX, "%s/%s", tmpdir, FILENAME);
> > +
> > +	memset(symb_path, 0, PATH_MAX);
> > +	snprintf(symb_path, PATH_MAX, "%s/%s", tmpdir, SYMBNAME);
> > +
> > +	SAFE_SYMLINK(file_path, symb_path);
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	free(tmpdir);
> nit: I know that tst_get_tmpdir() is first thing in setup(), but I would still
> guard it with if (tmpdir) (code may change later).
> 
> > +
> > +	SAFE_UNLINK(SYMBNAME);
> nit: Ideally this would be guarded by flag that SAFE_SYMLINK(file_path,
> symb_path) got executed.

I do not think that we need to unlink the symlink, it should be removed
by the test library when the temorary directory is removed. Or is there
a problem with that?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
