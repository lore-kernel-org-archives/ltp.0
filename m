Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEFDC6FA83
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 20:04:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 781B83CAAE5
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 22:04:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27BE33CAA99
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 22:04:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 46BB2140021F
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 22:04:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 587E320711;
 Mon, 12 Sep 2022 20:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663013078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8SC62xC/EqwZ4iDFBNEylx5qiyVloE7RZztGHUfGSLk=;
 b=m2EJwF+JoQhqyB8aXsz4Sxi+cSkby4Womv541/T3Ov+g5f1gQu/l1V2xcbBa0WlFigTSZU
 K6/orX7rXSbX6Ea+boAwDPa1jobewq/r5CY4vvotD4jW2cv9pNxoxxkNSfCQfrzepsAwoa
 o6fNhbYhaFgTN3vMljXgPl7qzQFwfsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663013078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8SC62xC/EqwZ4iDFBNEylx5qiyVloE7RZztGHUfGSLk=;
 b=3HeNpoXOoJf6cm/HalbsVWw6a/uQoweGw4l5dqIgQL9RVhj84HgLgx8wT4HJ4b+8OajoNa
 9lKODHk6NWs8U0AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBF7B139E0;
 Mon, 12 Sep 2022 20:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CE1KL9WQH2NNOwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Sep 2022 20:04:37 +0000
Date: Mon, 12 Sep 2022 22:04:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yx+Q0+fUokI7jlhT@pevik>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-8-pvorel@suse.cz> <Yx9QFWuRMjDUAafp@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yx9QFWuRMjDUAafp@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 07/10] tst_test.sh: Introduce TST_FS_TYPE_FUSE
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > @@ -307,6 +307,18 @@ tst_mount()
> >  	if [ $ret -ne 0 ]; then
> >  		tst_brk TBROK "Failed to mount device${mnt_err}: mount exit = $ret"
> >  	fi
> > +
> > +	mnt_real="$(grep -E "$TST_MNTPOINT ($TST_FS_TYPE|fuseblk)" /proc/mounts | awk 'NR==1{print $3}')"
> > +	case $mnt_real in
> > +		'') tst_brk TBROK 'Failed to found filesystem type in /proc/mounts';;
> > +		'fuseblk') TST_FS_TYPE_FUSE=1;;
> > +		*)
> > +			if [ "$mnt_real" != "$TST_FS_TYPE" ]; then
> > +				tst_brk TBROK "$mnt_real: unsupported type in /proc/mounts"
> > +			fi
> > +			TST_FS_TYPE_FUSE=
> > +		;;
> > +		esac
> >  }

> I just wonder if this is worth being added to the test library just for
> a single test. Or do you expect this to be usable in more than df01.sh?
Well, the inspiration was the C API, which also allows to skip fuse.
But sure, I can handle it just in df01.sh, just let me know the result.

> Also maybe it would be a better as a function so that the code does not
> run unconditionally on each tst_mount() call?
Do you mean e.g. tst_is_fuse() and df01.sh would call it?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
