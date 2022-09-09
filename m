Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647BCECAAD3
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 09:41:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2249B3CAA0B
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 11:41:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B0AC3CA9C9
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 11:41:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1BE45600F2F
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 11:41:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C820A1F88D;
 Fri,  9 Sep 2022 09:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662716471;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vjn1UJWklGbNjtO6gf98e9lzs0fQKGdLxU2jb0EYHGQ=;
 b=rEmz6ZPL7iSIj/8+of+AtKF/gjBudDP1xCnp9Y089dpDzXnkWwZQLKiMub1zleaKditC5E
 ypdS9J5t1Gng6zfTDu/nd0XZu/l/wzBW8z0wrh6b/Y05D1v+Cl1DSum7hKrYRCeLia4NT8
 qfaVkYHfBaCE0BfZRql7yvW/zQS49Mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662716471;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vjn1UJWklGbNjtO6gf98e9lzs0fQKGdLxU2jb0EYHGQ=;
 b=dmV7KKrgR3l1bPqYCsf5ADnWTZ0TaC3MFv3wOjaUzLy7z/mm+5N40BK22ccY+8xn9K4Brl
 +wfoVe66TD/fBRCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79B5913A93;
 Fri,  9 Sep 2022 09:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W1wbHDcKG2MWZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 09:41:11 +0000
Date: Fri, 9 Sep 2022 11:41:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YxsKNhHvO5iCCtKW@pevik>
References: <20220902133710.1785-1-pvorel@suse.cz>
 <20220902133710.1785-4-pvorel@suse.cz> <YxsKBI2256Ldmhpn@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxsKBI2256Ldmhpn@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/9] tst_supported_fs: Implement skip list
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

Hi all,

> > -	if (argc > 2) {
> > -		fprintf(stderr, "Can't specify multiple fs_type\n");
> > -		usage();
> > -		return 2;
> > +	while ((ret = getopt(argc, argv, "hs:"))) {
> > +		if (ret < 0)
> > +			break;
> > +
> > +		switch (ret) {
> > +		case '?':

> No usage?
Ah, make sense to -? be alias of -h.

> > +			return 1;
> > +
> > +		case 'h':
> > +			usage();
> > +			return 0;
> > +
> > +		case 's':
> > +			fs = optarg;
> > +			for (i = 0; fs[i]; i++) {
> > +				if (optarg[i] == SKIP_DELIMITER)
> > +					cnt++;
> > +			}
> > +			skiplist = malloc(++cnt * sizeof(char *));
> > +			if (!skiplist) {
> > +				fprintf(stderr, "malloc() failed\n");
> > +				return 1;
> > +			}
> > +
> > +			fs = optarg;
> > +			for (i = 0; i < cnt; i++)
> > +				skiplist[i] = strtok_r(fs, TST_TO_STR(SKIP_DELIMITER), &fs);
> > +			break;

> It may be a bit cleaner to put this part into a function i.e.

> 	skiplist = parse_skiplist(optarg);

+1, I'll post next version.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
