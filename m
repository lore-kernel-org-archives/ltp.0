Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD671EB64DD
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 08:51:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E3A23CAE14
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 10:51:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F6373C9422
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 10:51:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 63CA410006CE
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 10:51:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 02BFC1F461;
 Fri, 21 Jul 2023 08:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689929500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zvy668gC5BlHSmH0Cybfid2Bt3G3cfLz/rBMWBW3Zas=;
 b=b5djX9hG3aEvKNSlm/uiaQ6CIZhXchXRVWqsVH2PWuoP0fuCgCz1m3X+EHJAyuNKVaxbl4
 I2x9V2tfa3itKBKGLxjoWnY/do4zyGLvDrriPrXsQGL8k7FGfiMCv0CL2AdAmtCHKnAJsp
 y8Jo+B9UhkeKYcI1YlbYZ+LAVNkROZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689929500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zvy668gC5BlHSmH0Cybfid2Bt3G3cfLz/rBMWBW3Zas=;
 b=cp/6HeR4xqRWRTtYpKsuXmUdtdY/vyh3P9jaW9nk8RAYITxbX150Z3g/wlYwaQ3StmbNNk
 qRjD/38eeI7ST6DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB917134B0;
 Fri, 21 Jul 2023 08:51:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TShrJxtHumRgXwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 08:51:39 +0000
Date: Fri, 21 Jul 2023 10:51:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230721085138.GA1348273@pevik>
References: <20230720150206.1338520-1-pvorel@suse.cz>
 <20230720150206.1338520-4-pvorel@suse.cz>
 <92c457da-9b02-88ae-62e4-9a2be155e6cb@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <92c457da-9b02-88ae-62e4-9a2be155e6cb@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] {delete, finit,
 init}_module0[1-3]: Skip on SecureBoot
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

Hi Martin,

> > +++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
> > @@ -52,6 +52,8 @@ static struct tst_test test = {
> >   	.needs_root = 1,
> >   	/* lockdown requires signed modules */
> >   	.skip_in_lockdown = 1,
> > +	/* SecureBoot requires signed modules */

> Nit: the two comments could be merged into one.
+1

...
> > @@ -102,9 +104,16 @@ static void run(unsigned int n)
> >   {
> >   	struct tcase *tc = &tcases[n];
> > -	if (tc->skip_in_lockdown && kernel_lockdown) {
> > -		tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
> > -		return;
> > +	if (tc->skip_in_lockdown) {
> > +		if (secure_boot) {
> > +			tst_res(TCONF, "SecureBoot enabled, skipping %s", tc->name);
> > +			return;
> > +		}
> > +
> > +		if (kernel_lockdown) {
> > +			tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
> > +			return;
> > +		}

> It'd be better to just change the original TCONF message to something like
> "Cannot load unsigned modules, skipping %s". Adding a TINFO message
> "Lockdown on/off" to tst_lockdown_enabled() would provide the explanation
> why.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
