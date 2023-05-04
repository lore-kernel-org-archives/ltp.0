Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBBDC77B7C
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 21:16:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 028DB3CD85E
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 23:16:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D38183CA13D
 for <ltp@lists.linux.it>; Thu,  4 May 2023 23:16:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1F286600C52
 for <ltp@lists.linux.it>; Thu,  4 May 2023 23:16:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D21B73371B;
 Thu,  4 May 2023 21:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683234996;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+s1XV4cSiudXwWR6T6pIAjl/DxHODUa6ZJRBdF70UY=;
 b=ytII4toP7dcPoX6zFf2MnXrtAWf2B0N3hf9/tPKEUHXhq6Xr76w25cfwUmJLWbJ8cbeNuW
 LGZq4iKX2zhghMYMBQap7c/lkrDU1t5vgU50O4TONfBTK74mD/vDOejGOVbNjjmpEKOuH6
 /thxusxNuz2x+bhJd4tR6h9v/NGaz38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683234996;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+s1XV4cSiudXwWR6T6pIAjl/DxHODUa6ZJRBdF70UY=;
 b=mBJAoPTL6NIQHMEL07CC9HbNyYYb7I27IP8lVyQKrK1SEYsEtAOMt6YuBvoylTassPlnbc
 i30QvyZsCtjkONBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D30F133F7;
 Thu,  4 May 2023 21:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FfjdF7QgVGRVOwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 21:16:36 +0000
Date: Thu, 4 May 2023 23:16:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230504211634.GA4244@pevik>
References: <20230504131414.3826283-1-pvorel@suse.cz>
 <20230504131414.3826283-2-pvorel@suse.cz> <ZFO597l50v9PEQPP@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZFO597l50v9PEQPP@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/5] nfs_lib.sh: Cleanup local and remote
 directories setup
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> > +# directory mounted by NFS client
> > +get_local_dir()
> > +{
> > +	local v="$1"
> > +	local n="$2"
> > +
> > +	echo "$TST_TMPDIR/$v/$n"
> > +}
> > +
> > +# directory on NFS server
> > +get_remote_dir()
> > +{
> > +	local v="$1"
> > +	local n="$2"
> > +
> > +	echo "$TST_TMPDIR/$v/$n"
> > +}

> It's a bit puzzling why we have two identical functions with a different
> name...

It's a preparation for TST_ALL_FILESYSTEMS=1 where the location changes.
I can squash this into that commit where it changes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
