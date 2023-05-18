Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33082C77B7D
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 09:12:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2D103CD430
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 11:12:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 223DA3CB28B
 for <ltp@lists.linux.it>; Thu, 18 May 2023 11:12:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E09E160091C
 for <ltp@lists.linux.it>; Thu, 18 May 2023 11:11:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A63762263F;
 Thu, 18 May 2023 09:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684401107;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9Zz0wDNFRx6I5nbgl2E5Xldxv5MLrcDpmbxCxdH1iI=;
 b=S+TI7bROauJ3Fu6rMna6O8a/kQ1/p8D63Gf5OmaP88UrVBPQ09oQ7kpsK1jqLmGysCg1HV
 na0F86/lTXBPZaPIU9S2x7FPuVeZHc3xTquWFNiclkvaNUE1PZFmQAeKkWceYGIiypbAcf
 EEic4E/MmS5n9e6BZeY6Bjk73jZc/zQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684401107;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9Zz0wDNFRx6I5nbgl2E5Xldxv5MLrcDpmbxCxdH1iI=;
 b=ng4M5JqXYK+8eBZABLeW8YrNYjIzWKcaFtf7xe2eAtPfPpdI4LAB6oYOOCk4VLKRq9Mw8h
 WYOh4vf/i8Rpy3BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79775138F5;
 Thu, 18 May 2023 09:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OCQDHNPrZWRZTgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 18 May 2023 09:11:47 +0000
Date: Thu, 18 May 2023 11:49:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230518094914.GA6467@pevik>
References: <20230517153642.26919-1-mdoucha@suse.cz>
 <20230517153642.26919-2-mdoucha@suse.cz>
 <20230517220827.GA8914@pevik>
 <f7f3ffc0-2455-b7ab-531b-04d7974c7164@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f7f3ffc0-2455-b7ab-531b-04d7974c7164@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/7] KVM: Add VMSAVE/VMLOAD intercept constants
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
Cc: ltp@lists.linux.it, Nicolai Stange <nstange@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > >   /* SVM vmrun exit codes */
> > >   #define SVM_EXIT_HLT 0x78
> > > +#define SVM_EXIT_VMRUN 0x80
> > > +#define SVM_EXIT_VMLOAD 0x82
> > > +#define SVM_EXIT_VMSAVE 0x83
> > It looks like these three aren't used anywhere.

> Yes, the SVM_EXIT_* constants are not used. I originally wanted to use them
> in one of the checks but then decided against it. But let's keep them anyway
> since they'll be needed to handle the intercepts in future tests.

Sure, no problem.

Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
