Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECFAC433F5
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 14:00:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D8333CA97A
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 16:00:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCC973CA508
 for <ltp@lists.linux.it>; Tue, 10 May 2022 16:00:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 25E4760084C
 for <ltp@lists.linux.it>; Tue, 10 May 2022 16:00:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 23CAE21B74;
 Tue, 10 May 2022 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652191206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lm8yV4hzjYop2KYZcvK3dShwrc/wPkoNWcBaaDYev2g=;
 b=VGWu0Dg0EElRPx7D4kn93ocGXvDuOE7hjnLNwQRIh7HV2/Irpl5DFYqbpCmYEjzrL7FGAo
 t3XESspt9CTf39fsUJEJ5QMRxeyHHe2onlbyi/v1U3LBr1rBScJCbAdL0ehx9GEvi2JNA1
 TPtOhUBSCkIroPJ+/ePJ5FJV/A6EEwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652191206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lm8yV4hzjYop2KYZcvK3dShwrc/wPkoNWcBaaDYev2g=;
 b=dCt4mUjMwH8s0LymKfwiY0oyX2UGORcGLxoJ7cJ1OHb429JIu0o1rWflhybSfTFLXocaSN
 XxbKyMp9FsImvoAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1DE213AA5;
 Tue, 10 May 2022 14:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aSMEMeVvemIJOwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 May 2022 14:00:05 +0000
Date: Tue, 10 May 2022 16:00:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Ynpv5LPTb6aTmTgQ@pevik>
References: <20220510065104.1199-1-pvorel@suse.cz>
 <20220510065104.1199-3-pvorel@suse.cz> <Ynpjzif7cbxS5GX/@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ynpjzif7cbxS5GX/@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] netns: Rewrite to use tst_net.sh
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> > +netns_usage()
> > +{
> > +	echo "usage: $0 [ -e ] [ -t ]"
>                                   ^
> 				  -I
> > +	echo "OPTIONS"
> > +	echo "-e use ns_exec instead of ip"
> > +	echo "-I test ioctl (with ifconfig) instead of netlink (with ip)"
> > +}

> Otherwise it looks like a nice cleanup.
Good catch, thanks!
FYI I have more plans, i.e. use tst_rhost_run(), but that will come after the
release.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
