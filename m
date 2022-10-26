Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABF4ECDFA1
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 20:49:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B61CC3CA7E1
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 22:49:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 992903C9D99
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 22:49:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3CCFD600079
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 22:49:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 76AD01FB0D;
 Wed, 26 Oct 2022 20:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666817356;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dsRB4uZi/KKaP9lAl6FKaA6IOQHWSNt54PDXAn7gX6U=;
 b=BQJ/7uQ6bI8FzzCfdKOWDrXTRhQ2kkMLxFqQl5CE337+fFZ2PTMKVqZalew6SpCOFcfp7r
 zMfZMWetPYWFIQC0+gcNa6xOBNyNDiSRDPgza4mnGUZd7vnqKlKUwgyBYWT0E8vEGpD+XB
 nw1+4KqufVq8+/AHltv7Lrlp6ajAQbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666817356;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dsRB4uZi/KKaP9lAl6FKaA6IOQHWSNt54PDXAn7gX6U=;
 b=kPizCeVax2Oi/IOFTU85fYcbGd2UaUL8Iwe97qe+L8Q4bAHveeH5iW1yde+qpcMhwdINgk
 6seQZESZt7EtU7AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30ABF13A6E;
 Wed, 26 Oct 2022 20:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id L5TDCEydWWPlMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Oct 2022 20:49:16 +0000
Date: Wed, 26 Oct 2022 22:49:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y1mdSnShyka6Zva1@pevik>
References: <20221021155740.8339-1-mdoucha@suse.cz> <Y1MCbP1yjLOuoPLb@pevik>
 <CAASaF6ySEcVE=b-7nGy+FeLyg_6dNMjL6J_bivjZ6JYzSx5b=w@mail.gmail.com>
 <3f3dca4e-79d9-9e5b-293f-f27c6644dec8@suse.cz>
 <Y1kxMHBpEhb4SvUb@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1kxMHBpEhb4SvUb@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] save_restore: Check whether path is writable
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

> Hi!
> > > For optional path, if test can't read/write it (b/o of no root privileges),
> > > I think library shouldn't try to save it - then that would also skip
> > > attempt to restore it.

> > There are be two different kinds of optional paths, though:
> > 1) paths that sometimes don't exist but must be written to if they do
> > 2) paths that may be left alone if they exist and already contain the 
> > right value (otherwise TCONF)

> Alternatively we can cleanup the interface, we moved from a single
> string to a structure so we can add more fields, what about adding flags
> that would describe one single attribute of the file instead of
> clobbering several different characteristics of the file into a single
> character?

> We can then do something as:

> struct tst_save_restore {
> 	const char *path;
> 	const char *val;
> 	/* the test needs the file to exist -> TCONF on missing */
> 	int required:1;
> 	/* write the value even if the file already contains it */
> 	int rewrite:1;
> 	...
> };

> This makes the inteface orthogonal and much easier to reason about.

Sounds reasonable approach to me.
Martin, Jan, WDYT?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
