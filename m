Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02069C25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 11:31:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5929B3D0981
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 13:31:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B50863D0981
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 13:30:42 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 176F8600160
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 13:30:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 660AA21A70;
 Wed,  5 Jun 2024 11:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717587040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TefIAyHzo141gEHkhXde1ysfnPexvZYOlRkNJRrcJeA=;
 b=rKcUsfhK+F8uIIDwuCx8DqAUrXA14x0DWaUbkaSpFUZRsv/Mp2Mq87lUFB6+nhoWNVIb3l
 Cl2a8oQ0dmI1pWvI/cgATFCLF4Hi/yBdPg9jfVGy/ihoMVvQXpy3VqD66LX7F3QmlftaY8
 3HOmz+RsgcyGESHaUX2EBbi7FaRdSNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717587040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TefIAyHzo141gEHkhXde1ysfnPexvZYOlRkNJRrcJeA=;
 b=f1x7DuBmR3OkDJJmmEexkSUi6wYhm/hOtTZ1KZeONwLiTnnz9pFkRGkSx1vT8/5S7ZQk0E
 oH01uPHZQO7FQnCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rKcUsfhK;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f1x7DuBm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717587040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TefIAyHzo141gEHkhXde1ysfnPexvZYOlRkNJRrcJeA=;
 b=rKcUsfhK+F8uIIDwuCx8DqAUrXA14x0DWaUbkaSpFUZRsv/Mp2Mq87lUFB6+nhoWNVIb3l
 Cl2a8oQ0dmI1pWvI/cgATFCLF4Hi/yBdPg9jfVGy/ihoMVvQXpy3VqD66LX7F3QmlftaY8
 3HOmz+RsgcyGESHaUX2EBbi7FaRdSNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717587040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TefIAyHzo141gEHkhXde1ysfnPexvZYOlRkNJRrcJeA=;
 b=f1x7DuBmR3OkDJJmmEexkSUi6wYhm/hOtTZ1KZeONwLiTnnz9pFkRGkSx1vT8/5S7ZQk0E
 oH01uPHZQO7FQnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5632D13A24;
 Wed,  5 Jun 2024 11:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NPf4E2BMYGbddAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 05 Jun 2024 11:30:40 +0000
Date: Wed, 5 Jun 2024 13:30:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZmBMWwO211DBrkI0@yuki>
References: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
 <ZmAdqhv-VCWqJ3yf@rei>
 <58dbd04d-95f7-4e56-9ea1-2ef0a87d7f18@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58dbd04d-95f7-4e56-9ea1-2ef0a87d7f18@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 660AA21A70
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix unlink09 test
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >> +	fd_immutable =3D SAFE_CREAT(TEST_EPERM_IMMUTABLE, 0600);
> >> +	TEST(ioctl(fd_immutable, FS_IOC_GETFLAGS, &attr));
> >> +
> >> +	if (TST_RET =3D=3D -1 && TST_ERR =3D=3D ENOTTY) {
> >> +		SAFE_CLOSE(fd_immutable);
> >> +		tst_brk(TCONF | TTERRNO, "Inode attributes not supported");
> >> +	}
> > I see one problem with this approach. If kernel accidentally removes a
> > support for immutable files for a certain filesystem this test will be
> > green. And the filesystems that miss this support are very unlikely to
> > gain it, e.g. will vfat get support for immutable files? That would be
> > an argument for explicit skiplist in the form of
> > tst_test->skip_filesystems.
> >
> That's a valid statement.=A0 For now I would like to fix the test first, =

> then we can fix this other problem with an another patch.

As long as you promise to fix the test properly later on I agree with
adding the temporary workaround with a test for immutable support.

Also I suppose that it would make sense to enable the test for
all_filesystems but we would have to move the EROFS to a separate test
first.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
