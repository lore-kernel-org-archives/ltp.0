Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BDFC27C79
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 15:24:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D4E03D0DD6
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 17:24:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CD293D0D8A
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 17:24:19 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=jack@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6235914098AB
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 17:24:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B01D521A20;
 Wed, 19 Jun 2024 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718810656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJ+UYFD/N7qm9nO59jHP1L8zunVg8bgGBkSW5rkBCpE=;
 b=F3i361WtkEjU+H+ilI6YVXHdA85TftedojuS6LUaCp4KNYVnn5LIznNVqaTdwnyZ7Js1cc
 c+u9UQXPDdGvRD/Q5UgyvKjuucSJ126K45QdoNkhWClvGEN2ngp/EWGdcDHn2azr4uF8LC
 By5YaCQFkyFjqCdllSF4ewiMt2KQ2wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718810656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJ+UYFD/N7qm9nO59jHP1L8zunVg8bgGBkSW5rkBCpE=;
 b=D2jQGQgIJ/3hj3FNZn6UisJAU4ikRVT1uATuGVBs7YWKiUJFd8gVLXoycWazMmbp2RLYNO
 mSYmKIUNK+qrORBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718810656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJ+UYFD/N7qm9nO59jHP1L8zunVg8bgGBkSW5rkBCpE=;
 b=F3i361WtkEjU+H+ilI6YVXHdA85TftedojuS6LUaCp4KNYVnn5LIznNVqaTdwnyZ7Js1cc
 c+u9UQXPDdGvRD/Q5UgyvKjuucSJ126K45QdoNkhWClvGEN2ngp/EWGdcDHn2azr4uF8LC
 By5YaCQFkyFjqCdllSF4ewiMt2KQ2wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718810656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJ+UYFD/N7qm9nO59jHP1L8zunVg8bgGBkSW5rkBCpE=;
 b=D2jQGQgIJ/3hj3FNZn6UisJAU4ikRVT1uATuGVBs7YWKiUJFd8gVLXoycWazMmbp2RLYNO
 mSYmKIUNK+qrORBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97A7613668;
 Wed, 19 Jun 2024 15:24:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FSf9JCD4cmbSIgAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 19 Jun 2024 15:24:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id F0473A0887; Wed, 19 Jun 2024 17:24:11 +0200 (CEST)
Date: Wed, 19 Jun 2024 17:24:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <20240619152411.gf7bzkrlwsdrci5t@quack3>
References: <20240617161828.6718-1-jack@suse.cz>
 <20240617162303.1596-1-jack@suse.cz>
 <20240618-modular-galaabend-c0dba5521bc4@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240618-modular-galaabend-c0dba5521bc4@brauner>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,gmail.com,arm.com,suse.de,ZenIV.linux.org.uk,lists.linux.it];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] fsnotify: Do not generate events for O_PATH
 file descriptors
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
Cc: linux-nfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
 NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it,
 Al Viro <viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue 18-06-24 16:28:01, Christian Brauner wrote:
> On Mon, 17 Jun 2024 18:23:00 +0200, Jan Kara wrote:
> > Currently we will not generate FS_OPEN events for O_PATH file
> > descriptors but we will generate FS_CLOSE events for them. This is
> > asymmetry is confusing. Arguably no fsnotify events should be generated
> > for O_PATH file descriptors as they cannot be used to access or modify
> > file content, they are just convenient handles to file objects like
> > paths. So fix the asymmetry by stopping to generate FS_CLOSE for O_PATH
> > file descriptors.
> > 
> > [...]
> 
> I added a Cc stable to the first patch because this seems like a bugfix
> per the mail discussion.

Yes, makes sense. Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
