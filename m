Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B95C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 17:17:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C40CC3CDCE1
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 18:17:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD2183CDCB1
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 18:17:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 109891000F7D
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 18:17:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F4C51FD84;
 Fri, 25 Nov 2022 17:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669396654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pnxf0gxdkeIn20bMG51XvDhNzHpBPAlc5HBuASkFbho=;
 b=f7hR4CnxNUAsLlTCpDjGuIkvkquHK577u8uFXLxkj4i97i53ETNnqMXEr/TRZJavzURX8t
 m3Dh+XIj/GR0AsfduzBx0U4L2rBB/EnVqCFj6mRoyw0rKJ/nj0hkj9TsyCbt1gW9sN4zdT
 mzeYS4IRKiAdV6BNMXttfI0YgsNdJ9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669396654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pnxf0gxdkeIn20bMG51XvDhNzHpBPAlc5HBuASkFbho=;
 b=jCb/sFePT8jJMBvOT2lRUpp6CtM6ik9jd6/s3SwAN7tVUMhq8Qa0TgNcKGHqjkcy8CRzw2
 vzDn9UyWXMKYblCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DD7C13A08;
 Fri, 25 Nov 2022 17:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NFN/Ca74gGNxPgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Nov 2022 17:17:34 +0000
Date: Fri, 25 Nov 2022 18:17:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y4D4rKNYjyEdDNEL@pevik>
References: <20221125153453.19323-1-mdoucha@suse.cz> <Y4D066q2R/0S2xFe@pevik>
 <8fb62925-43ff-92d2-d310-b78d24b06d21@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8fb62925-43ff-92d2-d310-b78d24b06d21@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Implement tst_setup_netns() helper function
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

> On 25. 11. 22 18:01, Petr Vorel wrote:
> > Hi Martin,

> > > +void tst_setup_netns(void)
> > > +{
> > > +	int real_uid = getuid();
> > > +	int real_gid = getgid();
> > > +	int nscount = 1;
> > > +
> > > +	if (!access("/proc/sys/user/max_user_namespaces", F_OK)) {
> > Out of curiosity, this can happen only on old kernel, which does not support
> > user namespaces (kernel < 3.8) ? I guess there must be other case,
> > I suppose you would not bother about 3.8, right?

> > Also asking that if not readable we don't TCONF (int nscount = 1).

> This is very much still happening on kernel 4.4.180 even though user
> namespaces are supported and enabled by default. That's why
> tst_setup_netns() fails with TCONF only when max_user_namespaces sysfile
> exists, is read-only AND the value inside is zero.

Makes sense.

And missing file: if I'm correct sysctl files were added in v4.9-rc1 in
25f9c0817c53 ("userns: Generalize the user namespace count into ucount")

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
