Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D255C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 10:04:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3CEC83C61C8
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 11:04:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CAF93C61C8
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 11:04:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A7CDA100115E
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 11:04:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C0C84218FB;
 Fri, 11 Mar 2022 10:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646993046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NRaVvXCQCEDeSh8NSWU8Rj0qgz/yJD9wpzKbO9cH48w=;
 b=ytm/bduJ+oBrXKaTEwTQVqMz/j/o0CROcVBVjB74CbNPfInQsE1k0RSFM7DtL17dLoS753
 bqC0igNg/rZ8/H3A2ZZgQKPw3yGP3mg1vIFZSYU7SohyWfuX1G7YuxTgtnltbkfkPJEbdF
 YZF6ISrltiKMgS7lYUE3bqMQGaO7Klc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646993046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NRaVvXCQCEDeSh8NSWU8Rj0qgz/yJD9wpzKbO9cH48w=;
 b=f3VDGmPo6zDj3pzf3uOgyU6D8xjbX9P6U+JRu8n0hchDIarvUYHCRQjsY8uB1s+1QMbqGX
 YZINaXYLaUEAF/Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A540413A89;
 Fri, 11 Mar 2022 10:04:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vF3SJ5YeK2IOaAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 11 Mar 2022 10:04:06 +0000
Date: Fri, 11 Mar 2022 11:06:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YisfIWsrgxVt8xc2@yuki>
References: <20220311095101.10112-1-chrubis@suse.cz>
 <8378e9dd-31a5-b39e-36cc-f3d3a1d41345@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8378e9dd-31a5-b39e-36cc-f3d3a1d41345@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pty/pty07: Restore active console after the
 testrun
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >  static void cleanup(void)
> >  {
> > -	tst_fzsync_pair_cleanup(&fzp);
> > -	if (fd >= 0)
> > +	if (fd >= 0) {
> > +		tst_res(TINFO, "Restoring active console");
> > +		SAFE_IOCTL(fd, VT_ACTIVATE, vt_active);
> >  		SAFE_CLOSE(fd);
> > +	}
> > +
> > +	tst_fzsync_pair_cleanup(&fzp);
> 
> If you move the fzsync cleanup to the end of cleanup(), you can end up
> with the open_close() thread racing against fd cleanup.

Ah, right, looking closely at the fzsync, the thread B may be racing
against the restoration in the case that something caused premature exit
in the thread A.

Will move the call back to the start of the cleanup().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
