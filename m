Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735D2C433FE
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 21:11:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F37353CAE43
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 23:11:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D55953CA962
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 23:11:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2ECC22010AC
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 23:11:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A8521F896;
 Fri,  7 Oct 2022 21:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665177093;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2mIsTa3YxfWdiwotr7QdZlOQCPGV2PSxccFgGjRHWJE=;
 b=xIZvNJ24VFrqrmy9zUv0bBqcPt8VaoExVBt8QpYJ7gtvztGG+dLN0Gq5qBLBWvB7QOnY65
 8IZy991gQAR6FR+NFPdf+EymH5IUjY/xow9HUBaNmpyDUH9MJxps/RTWyYVfuMznXycbQg
 CMXvV8MYqAr5IxpZRTzKUIPQkSGs9og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665177093;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2mIsTa3YxfWdiwotr7QdZlOQCPGV2PSxccFgGjRHWJE=;
 b=Y2R3RKqUMEOdKCYoCWqKSY14CA05d/FeQJsBu12yA/L27IbvjbA26SOPqQrunOudrmWZsS
 lcrtHEcGsn04wqBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29F1513A3D;
 Fri,  7 Oct 2022 21:11:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I7A7CAWWQGMQIAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 07 Oct 2022 21:11:33 +0000
Date: Fri, 7 Oct 2022 23:11:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <Y0CWAi0BnDXaN3ZS@pevik>
References: <20221006102900.3246-1-pvorel@suse.cz>
 <4450243.LvFx2qVVIh@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4450243.LvFx2qVVIh@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Improve .skip_filesystems documentation
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

> > +NOTE: ext2, ext3 or ext4 in '.skip_filesystems' on tests which does *not* use
> > +      '.all_filesystems' needs to be defined as 'ext2/ext3/ext4'. The reason
> > +      is that is hard to detect used filesystem due overlapping the functionality.
> nit:
> s/that is/that it is
> s/due/due to
Thanks Avinesh!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
