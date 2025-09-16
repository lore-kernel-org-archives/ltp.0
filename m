Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B85CAC598
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 11:34:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A56763CDB49
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 13:34:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E24BA3CD983
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 13:34:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1525460067F
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 13:34:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C912C21FF4;
 Tue, 16 Sep 2025 11:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758022464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5fhBm9oRUq/7LCO1SyruLQVKq17cgO0pzPjr5cDTj58=;
 b=ZzV0iWwcoKjp7+Gy1ZV+BpXEIOt5ZcdiWXAkNVrrekCNUoUQRtlMWthaTgG7AW5SIYMyIJ
 317AnruR+qSDy65As8tGZpkm2ppMAo3fk3XAgCYhiVjvAYtctBlrf/ePO229N07lFi7kvd
 jbMC1jeu8KtHWZtmS2+giDlaxuporkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758022464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5fhBm9oRUq/7LCO1SyruLQVKq17cgO0pzPjr5cDTj58=;
 b=ulsCkgJdSXAE7/HZLZpLAjWF5RNEZoJwYRIavxhpzDtXVvVaeb9qbezCibJRGcaUUyXi9W
 rs5q+ynr7jQYN+Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758022464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5fhBm9oRUq/7LCO1SyruLQVKq17cgO0pzPjr5cDTj58=;
 b=ZzV0iWwcoKjp7+Gy1ZV+BpXEIOt5ZcdiWXAkNVrrekCNUoUQRtlMWthaTgG7AW5SIYMyIJ
 317AnruR+qSDy65As8tGZpkm2ppMAo3fk3XAgCYhiVjvAYtctBlrf/ePO229N07lFi7kvd
 jbMC1jeu8KtHWZtmS2+giDlaxuporkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758022464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5fhBm9oRUq/7LCO1SyruLQVKq17cgO0pzPjr5cDTj58=;
 b=ulsCkgJdSXAE7/HZLZpLAjWF5RNEZoJwYRIavxhpzDtXVvVaeb9qbezCibJRGcaUUyXi9W
 rs5q+ynr7jQYN+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB54613ACD;
 Tue, 16 Sep 2025 11:34:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kIS3LUBLyWgyZgAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 16 Sep 2025 11:34:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 777E6A0A56; Tue, 16 Sep 2025 13:34:16 +0200 (CEST)
Date: Tue, 16 Sep 2025 13:34:16 +0200
From: Jan Kara <jack@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <h3ov4pformuvguwsxtziqui2alarqno37kdru4bjsppeok4sth@yb4iposv7okd>
References: <CA+G9fYuFdesVkgGOow7+uQpw-QA6hdqBBUye8CKMxGAiwHagOA@mail.gmail.com>
 <arfepejkmgi63wepbkfhl2jjbhleh5degel7i3o7htgwjsayqg@z3pjoszloxni>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arfepejkmgi63wepbkfhl2jjbhleh5degel7i3o7htgwjsayqg@z3pjoszloxni>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[20];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.it,lists.linaro.org,lists.linux.dev,kernel.org,suse.cz,arndb.de,linaro.org,zeniv.linux.org.uk,gmail.com,oracle.com,samsung.com];
 RCVD_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next-20250915: LTP chdir01 df01_sh stat04
 tst_device.c:97: TBROK: Could not stat loop device 0
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Ben Copeland <benjamin.copeland@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org, LTP List <ltp@lists.linux.it>,
 Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue 16-09-25 13:04:42, Jan Kara wrote:
> On Tue 16-09-25 12:57:26, Naresh Kamboju wrote:
> > The following LTP chdir01 df01_sh and stat04 tests failed on the rock-pi-4b
> > qemu-arm64 on the Linux next-20250915 tag build.
> > 
> > First seen on next-20250915
> > Good: next-20250912
> > Bad: next-20250915
> > 
> > Regression Analysis:
> > - New regression? yes
> > - Reproducibility? yes
> > 
> > * rk3399-rock-pi-4b, ltp-smoke
> > * qemu-arm64, ltp-smoke
> > * qemu-arm64-compat, ltp-smoke
> >  - chdir01
> >   - df01_sh
> >   - stat04
> > 
> > Test regression: next-20250915: LTP chdir01 df01_sh stat04
> > tst_device.c:97: TBROK: Could not stat loop device 0
> 
> This is really strange. Those failing tests all start to complain that
> /dev/loop0 doesn't exist (open gets ENOENT)... The fact that this is
> limited to only a few archs suggests it's some race somewhere but I don't
> see any relevant changes in linux-block in last three days...

Ha, Mark Brown tracked this [1] to changes in VFS tree in
extensible_ioctl_valid(). More discussion there I guess.

[1] https://lore.kernel.org/all/02da33e3-6583-4344-892f-a9784b9c5b1b@sirena.org.uk

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
