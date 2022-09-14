Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94582ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 13:36:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DDEA3CAC07
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 15:36:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF3DD3CA900
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 15:36:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 170F0200FE6
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 15:35:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E06C821A32;
 Wed, 14 Sep 2022 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663162558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yLTFpfA7MR7Pxj2WX+urJDgtwOFc1lDkuTCeS4BLwpc=;
 b=k2pPK5B94X+2WIFUJFc2rXXI0jUf2BtVRYJUZJEcpxnOIvQYeu0dm0flmH1xwSlpADAAwC
 Splknz5kXXd+dtNYhDps+6Es05icXt+ZeViHVNzwyHR7VdLND63n1/M/IRIkCB40UbXbRi
 Nom/K30R1qLDXUm/MV0YzGl50k2NjN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663162558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yLTFpfA7MR7Pxj2WX+urJDgtwOFc1lDkuTCeS4BLwpc=;
 b=Z1AsMuFdvYG5kcw2lcCAixR9kXDlA5oUCt+XFDuo+AglEjzeW2BNh11wkINtH4xcvrQ0sy
 O3eRNYbFs4d83wCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5A9313494;
 Wed, 14 Sep 2022 13:35:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SmLnKr7YIWO+HgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 14 Sep 2022 13:35:58 +0000
Date: Wed, 14 Sep 2022 15:35:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YyHYvCr0PISg6ISY@pevik>
References: <20220913202839.1807979-1-edliaw@google.com>
 <YyGisrbDIgVa/0QA@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyGisrbDIgVa/0QA@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] minmax: fix type warnings
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> >  	SAFE_SYSINFO(&info);
> >  	safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128L * 1024 * 1024);
> > -	safety = MAX(safety, min_free);
> > +	safety = MAX(safety, (size_t)min_free);
> >  	safety /= info.mem_unit;

> We can define the min_free to be size_t from the start as:
Indeed, that's much better. And the second one as well.
Going to merged with these fixes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
