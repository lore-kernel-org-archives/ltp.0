Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E062C6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 09:36:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 410003CAAF5
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 11:36:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9C173CA6CB
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 11:36:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CD9B7600326
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 11:36:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9FBC622062;
 Tue, 13 Sep 2022 09:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663061766;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vDJ7XZAr+nsEp9Oy+iO0c2x6HaFh9qkapw8DrquuEcY=;
 b=d06aodrsx8YfQK5QLt6fUALAfVpve9kF48suK+UhBzgIAAF8yZph7Q+pVIBlylGdo9POFe
 +1SgduxgSYxUsrKRCB40QRMgK8gFj3zZo2JlWLDSz6u/Fjx2wgvl60hzOFsPaUXN64+Crr
 YRjYi6yyKiy46d50D00aW1QAUFWEmRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663061766;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vDJ7XZAr+nsEp9Oy+iO0c2x6HaFh9qkapw8DrquuEcY=;
 b=v7qH7cgWC2K0H6A0gFllllpAN+Pfl3nI1/+rw7xjORC9vV92Ld0q8Ax6dqzM+0FFwAeo3G
 4PmXaK6eU6ywuhCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E3F813AB5;
 Tue, 13 Sep 2022 09:36:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4YxZFQZPIGO4NAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Sep 2022 09:36:06 +0000
Date: Tue, 13 Sep 2022 11:36:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YyBPBLi9l+q1KJXr@pevik>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-6-pvorel@suse.cz> <Yx9JPQimBEpXFa4+@yuki>
 <Yx+YtBZOKje6FbWS@pevik> <YyA763/Rx1Do8DHx@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyA763/Rx1Do8DHx@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 05/10] tst_supported_fs: Support skip list when
 query single fs
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
> > > Shouldn't this one go before the addition of the functionality to the wrapper used by shell?
> > Do you mean to put this ("tst_supported_fs: Support skip list when query single
> > fs") before the previous ("tst_supported_fs: Implement skip list")?

> Yes, as far as I can tell this commit implement function that is called
> from the previous patch.
I'm really slow on this. Which function do you mean please?

"[v5,05/10] tst_supported_fs: Support skip list when query single fs" implements
just tst_fs_is_supported_skiplist() which is not used in "[v5,04/10]
tst_supported_fs: Implement skip list".

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
