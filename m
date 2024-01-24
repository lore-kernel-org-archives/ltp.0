Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA3DC46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 21:32:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E396F3CFB48
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 22:32:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9C4B3CE1FB
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 22:32:36 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8B12A1A0434D
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 22:32:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24A472208A;
 Wed, 24 Jan 2024 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706131954;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IKAPTbygAg3N66rq9PTfeiB3VaRzSNIRAilIMr1UjIc=;
 b=DwDxmHgrskxmoyDo0V7FXj7CIU9DDWL/WLSkUS2otWICxEwyDvtj3/OA8qgaOdEjOJtNkw
 JJXn/fkfXPuKzvpL9uhvORTlK8TuIj7p/zU2Ues+5raZqffLtTrj94Xj+dAiti0sZvb+fu
 jkHBhTsQj8eM70HsPtvrwq9c9B+MkHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706131954;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IKAPTbygAg3N66rq9PTfeiB3VaRzSNIRAilIMr1UjIc=;
 b=I01wXHBdssrZauT//zqhCjZ5yuFuy0j5uK4rbGqFWRUQ8ko6U+K5Qp/W0G298Qpfd0xkXX
 K5LF/4iZcrB4YOAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706131954;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IKAPTbygAg3N66rq9PTfeiB3VaRzSNIRAilIMr1UjIc=;
 b=DwDxmHgrskxmoyDo0V7FXj7CIU9DDWL/WLSkUS2otWICxEwyDvtj3/OA8qgaOdEjOJtNkw
 JJXn/fkfXPuKzvpL9uhvORTlK8TuIj7p/zU2Ues+5raZqffLtTrj94Xj+dAiti0sZvb+fu
 jkHBhTsQj8eM70HsPtvrwq9c9B+MkHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706131954;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IKAPTbygAg3N66rq9PTfeiB3VaRzSNIRAilIMr1UjIc=;
 b=I01wXHBdssrZauT//zqhCjZ5yuFuy0j5uK4rbGqFWRUQ8ko6U+K5Qp/W0G298Qpfd0xkXX
 K5LF/4iZcrB4YOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C48F113786;
 Wed, 24 Jan 2024 21:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WDIVLvGBsWVZewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 21:32:33 +0000
Date: Wed, 24 Jan 2024 22:32:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Message-ID: <20240124213232.GA356523@pevik>
References: <20240124200032.GA343522@pevik>
 <20240124205149.GA268968@fedora-laptop>
 <20240124210738.GA352616@pevik>
 <5ykyohhnlc7nkbz7usc5sqmluyl7wgyhc6frqmbo5kk4vhuu3c@kgzze4c35gsv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5ykyohhnlc7nkbz7usc5sqmluyl7wgyhc6frqmbo5kk4vhuu3c@kgzze4c35gsv>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,lists.linux.it];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.00)[87.21%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] bcachefs fails to mount loop device on kernel
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
Cc: linux-bcachefs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
 Thomas Bertschinger <tahbertschinger@gmail.com>, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Wed, Jan 24, 2024 at 10:07:38PM +0100, Petr Vorel wrote:
> > > On Wed, Jan 24, 2024 at 09:00:32PM +0100, Petr Vorel wrote:
> > > > Hi all,

> > > > bcachefs fails to mount loop device on kernel on both 6.7 and 6.8.0-rc1.
> > > > Is mounting loop even supported?

> > > > [...]

> > > > bcachefs mount /dev/loop0 /mnt
> > > > => Unknown command mount

> > > What version of the bcachefs CLI tool are you using? Is it distribution
> > > provided or did you build it yourself?

> > Official openSUSE Tumbleweed package:

> > $ rpm -qf $(which bcachefs)
> > bcachefs-tools-1.4.0-1.1.x86_64

> Sounds like Suse isn't building with our Rust code - but, that's about
> to become mandatory...

Indeed NO_RUST=1. Thank you both for a quick info!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
