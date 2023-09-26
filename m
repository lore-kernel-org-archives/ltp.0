Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6B0E7E635
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 13:39:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3346D3CE1CB
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 15:39:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 859283CDC7D
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 15:39:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E59732001CE
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 15:39:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A1AA1F86A;
 Tue, 26 Sep 2023 13:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695735573;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=smedKZlhgb0ZmswfoL33gAWSGmkTalVkUqC8OwjYr+U=;
 b=naSFDxMfzD9YVXSPjbL7tQwgj7K35JcDsyUS2c1bm1x+ckqw7wEnzaSd8mQR8fkR6RNaJE
 n8NrhiMpoeKi6kAvUna6eqAsj03p9aygV6g1tKYQfmOsAEPMLMIj1gZXj3aTsMt742CheR
 HIIdiTDuWRaKUQxhbCs8ZYjzDhM6CRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695735573;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=smedKZlhgb0ZmswfoL33gAWSGmkTalVkUqC8OwjYr+U=;
 b=VY0QGAaCMJ89nGyeMf2wQu6VXU33PgTOQxLM0+It0VaUaYi4Yyqqn5XAYLXI5l5svcZQnT
 mq7pd/V/F1yucwBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E80F1390B;
 Tue, 26 Sep 2023 13:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0gATAhXfEmUbPgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Sep 2023 13:39:33 +0000
Date: Tue, 26 Sep 2023 15:39:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230926133931.GA159673@pevik>
References: <20230920095318.340582-1-pvorel@suse.cz>
 <20230920095318.340582-5-pvorel@suse.cz> <ZRLEmWtn8zaz9dL0@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZRLEmWtn8zaz9dL0@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] doc: Add Release procedure
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > This slightly outdated document exists in LTP wiki, start versioning it
> > in the original repository. The only unversioned file in the wiki is
> > now Home.rest.

NOTE: "slightly outdated"

...
> > +3. Prepare tarballs
> > +-------------------
> > +[source,sh]
> > +--------------------------------------------------------------------
> > +cd ..
> > +git clone ltp ltp-full-YYYYMMDD
> > +cd ltp-full-YYYYMMDD
> > +# Update mce-inject submodule
>        ^
> We do have a couple of submodules now, so this should be updated

I wanted to put my changes into separate commit, that's why I here just added
the original content. But if it makes more sense, I'll squash my change (next
commit) into this one.

> > +git submodule init
> > +git submodule update
> > +# Generate configure script
> > +make autotools
> > +# Prepare the archives
> > +cd ..
> > +tar -cjf ltp-full-YYYYMMDD.tar.bz2 ltp-full-YYYYMMDD --exclude .git
> > +tar -cJf ltp-full-YYYYMMDD.tar.xz ltp-full-YYYYMMDD --exclude .git
> > +--------------------------------------------------------------------
> > +
> > +4. Upload the tarballs to GitHub
> > +--------------------------------
> > +
> > +Click on 'releases' then switch to 'tags' then click on 'Add release notes' there should be 'Attach binaries ...' link at the bottom of the page.
> > +
> > +Don't forget to upload md5 and sha-1 sums for the tarballs as well.
> > +
> > +5. Send release announcement
> > +----------------------------
> > +
> > +Have a look at http://sourceforge.net/p/ltp/mailman/message/34429656/ to get the idea how it should look.
>                         ^
> 			This is now outdated, I guess that we should
> 			include a template rather than this?

I updated this in next commit to
https://lore.kernel.org/ltp/ZGNiQ1sMGvPU_ETp@yuki/

NOTE: I trust lore more than to our LTP ML - maybe we leave it one day, but I can use
link to our ML if you want. Or should I paste some text instead/with the link?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
