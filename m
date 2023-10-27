Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3660C25B48
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 17:38:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D7C63CEB99
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 19:38:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A673C3CACCC
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:38:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0B9A420092D
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:38:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E426A21CB2;
 Fri, 27 Oct 2023 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698428290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZfufS3ezGTfmOaULjsxdCE+WNF/0ja1NcVDVcdKAInA=;
 b=sTM890V94OFUtg6jpWIpBcoI/Z4JawX0eZsnYa2On+TW7pMqr4vQDlMU4L7HQ4qAExBuOx
 hgdVSS1+jiHYsaMWJ8bjgCQxWp6qWlrk6Ymo03eyDwnJAt2pZJtpjGpLTCST+azlg52WM3
 KjVe88Q7yitZ2fj/L2r0UM5Buc7qG1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698428290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZfufS3ezGTfmOaULjsxdCE+WNF/0ja1NcVDVcdKAInA=;
 b=1cwgBRXqQfwFRLp9fnx2GiLhySgZhX8W0l817seEw0ZahMz0ai6KPJB69CGO/AXbTiLcoM
 aHkwQTgLni3uaqAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AB121358C;
 Fri, 27 Oct 2023 17:38:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xZfzHoL1O2WwUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 27 Oct 2023 17:38:10 +0000
Date: Fri, 27 Oct 2023 19:38:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231027173808.GA709535@pevik>
References: <20230718100050.1162482-1-pvorel@suse.cz>
 <CAEemH2fAuHrE4XyBjpudMCJJ4ZJ+9TOu=LpHXzizUp-uRqWXdA@mail.gmail.com>
 <20230719101225.GB1221211@pevik>
 <CAEemH2esxksDg1NznrCW4QKO3NvEFUENWVcc4s-jf+Yk1-_RHw@mail.gmail.com>
 <20230720094343.GA1300426@pevik>
 <CAEemH2fbuqyT3Crdv_9vhf56BkxpNj_3TB76z8+_8vh5Yfu+wQ@mail.gmail.com>
 <ZTulylBTt01VNnOL@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZTulylBTt01VNnOL@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-10.00 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.70)[98.71%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] compat_16: Define USE_LEGACY_COMPAT_16_H for
 legacy tests
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
Cc: ltp@lists.linux.it,
 Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, Li,

> Hi!
> > > LGTM, would you mind to send it as a follow up to my patch, as an
> > > additional
> > > cleanup?


> > Yes, sure.

> @Peter since there is going to be follow up patch, feel free to push the
> original patch with my Reviewed-by:

Thanks, I rebased it (somebody did a rewrite to new API on bunch of tests)
and merged. I'll send the follow up, so that we don't have to remember it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
