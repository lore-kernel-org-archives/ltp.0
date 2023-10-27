Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45671C25B67
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 10:34:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B45F33CEBF8
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 12:34:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4670F3CCB26
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 12:34:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9D3AD10007BB
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 12:34:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A8B1121C61;
 Fri, 27 Oct 2023 10:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698402849;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ys2+KPPBYIfu6a3q63u8M+Vw2ehYzu8nyjhXFbl/vnw=;
 b=xrEZbTVHwPFFtZ015Se0dCKJPZI9KXTp0Cr5XiYGj+QOOLSFxShsgFF5kbYYQlJ4R//jXr
 wVaBjbYRiFHtZdUMgfrwBtXGf6/rwHJNqpEUPs9Z9zb6H1e+5ng2nxSJfIP13uuz3AydhM
 dNTluvGZVY7xv91TsKwPUHbe3LH4GV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698402849;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ys2+KPPBYIfu6a3q63u8M+Vw2ehYzu8nyjhXFbl/vnw=;
 b=XeNXvU2bhVWmNs0YMBLenfCQ9PKyPeqqHJ6P1pAzq3k1igQFFyolo6a4hKjdw9s8uvK+Qe
 dCVmbbHnpK24+UCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 700EF1358C;
 Fri, 27 Oct 2023 10:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ven1GCGSO2UQfgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 27 Oct 2023 10:34:09 +0000
Date: Fri, 27 Oct 2023 12:34:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231027103407.GA644399@pevik>
References: <20231005134504.3828-1-mkittler@suse.de> <ZSe6MNMQ6L5yJdV4@yuki>
 <13368109.uLZWGnKmhe@linux-9lzf> <ZTuDOcJ8bG_rO4fA@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZTuDOcJ8bG_rO4fA@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-10.22 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.92)[99.64%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix memcontrol tests under Tumbleweed
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

> Hi!
> > I thought so, too. However, when running this particular test without this 
> > minimum specified explicitly, it runs into the following error:

> Ah, right, we create the tmpfs with size 32MB by default, but the test
> creates 50MB worth of files so it needs slightly more than that, I would
> say 60MB. However the .dev_min_size does limit the size of other FS
> types as well, so we can't se this easily. I suppose that we need the
> per fs minimal size stored in the library as we discussed with Peter
> back then and with that we can set the real minimum in the test and
> override when filesystem needs more.

I guess I should finish this implementation, thanks for reminding me.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
