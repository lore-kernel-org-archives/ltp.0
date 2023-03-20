Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F892C6FD1D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 14:59:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 693913CD366
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 15:59:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40B103CCC52
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 15:59:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A276F1A006EB
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 15:59:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F31F421AC1;
 Mon, 20 Mar 2023 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679324380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CrcsDIeDl2ZXRx5EHJ+K9fWZv9nEUX3pb5KtREFRf5s=;
 b=1hVjHA/Q5UJLrS0yXcj/lINuiA2cAqYG64uaqYlo5Q+Tzo08bk15eJe7anLiXbdVcjRiPH
 s6jKWTKIhjZsIUQZJ0cClsESTNdAKh4U9w6mDY1YnRopCzHd3j81xLVhjmO3Pm5SbxXa6P
 jKRSuXxhVYSYC+4eD9up3Cnon1Gs5FU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679324380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CrcsDIeDl2ZXRx5EHJ+K9fWZv9nEUX3pb5KtREFRf5s=;
 b=xE8sx5DzFw16irYVfzvNB3x7GT9iMW0PzG+Iy1l9awSzVQfPZoJGy+QbOKAbwUerpGFR+O
 hZC+pKRGApedmxDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B055513A00;
 Mon, 20 Mar 2023 14:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H+ymKdx0GGTaNQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Mar 2023 14:59:40 +0000
Date: Mon, 20 Mar 2023 15:59:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it,
 Fabrice Fontaine <fontaine.fabrice@gmail.com>
Message-ID: <20230320145939.GA222671@pevik>
References: <20230226192554.669332-1-fontaine.fabrice@gmail.com>
 <Y/yTyk9rYYsPJyVA@yuki>
 <CAEemH2fLFYu8=ZRBbu0xgmfYh4=XHJSu07R+4=-qX_1ESVza0w@mail.gmail.com>
 <20230310093117.GA8713@pevik>
 <CAEemH2eBqt1_ZTY3GCRfgx4EQdWiJJepA_wVGpSg6=pYubHddw@mail.gmail.com>
 <20230310114249.GB22294@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230310114249.GB22294@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure.ac: fix mount_attr detection
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> > I mean this commit:
> > https://github.com/kraj/glibc/commit/774058d72942249f71d74e7f2b639f77184160a6

> Thanks for info. Fix from 2.37, it was also cherry picked to release/2.36/master
> branch, but not to branches for older releases (2.35 and 2.34).

> I suppose there will be always some toolchain/distro with older glibc without
> this fix, thus I'd merge it now, and made simplification Cyril suggested
> sometimes next year.

I finally merged this patch adding info why original workaround from b857f8723
is needed.

Li, thanks for your input, Fabrice, thanks for the fix and your patience.

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
