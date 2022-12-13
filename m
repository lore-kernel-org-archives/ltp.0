Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC2AC4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 19:02:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84A103CBDAF
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 20:02:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7B783CBD88
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 20:02:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3B3791400514
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 20:02:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3FB341FDF1;
 Tue, 13 Dec 2022 19:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670958155;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YmMqb8ByERYF1P2tIN+0un47BS4gnXxwC+T1hdwIwKo=;
 b=mZaO1gPrayQZLyyC/yhUuuhjW/8+VLB3vfyCBGFQJ5bK9Of+Q5T9SR99433AoVWbExTfZG
 4biM+nGqYGY27LP6qLIJ/wvKVi50Pj3pLX6CS4EithHXuvFHQhEJ8h9UnqXkaJWcaPW359
 wfBDlUN+s/Yr4uz6tMlL5iI5pDLUj/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670958155;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YmMqb8ByERYF1P2tIN+0un47BS4gnXxwC+T1hdwIwKo=;
 b=uP/HXItqjnmvXrQCzcSqMAGtVzxIA4HGAkGZGwZ1D3YHsA5iKfE2wXrucPhdAd8BLZHn1B
 vi3VLhYMrSuccnCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5A8D138F9;
 Tue, 13 Dec 2022 19:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c6uiLkrMmGMVBQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Dec 2022 19:02:34 +0000
Date: Tue, 13 Dec 2022 20:02:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y5jMSD73XwDKsRlB@pevik>
References: <20221213094427.32743-1-rpalethorpe@suse.com>
 <Y5hLfAN7NCvsKmNk@pevik>
 <e0488665-e68e-455d-6ee6-8709b5f57599@fujitsu.com>
 <877cyvsi3l.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877cyvsi3l.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcpu01: Reinstate node_id test
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

> Hello,


> >> FYI Richie is touching the same code, one of you will need to rebase.
> >> IMHO it's better to remove this in dedicated patchset (i.e. in Xu).

> > Even I will limit the kernel version check to 3.0 in my patchset because 
> > we don't reach the same target to 3.10, so let me rebase.

> > ps: If we reach the same target to 3.10, then we can remove remain old 
> > version check in the future.

> I'm not sure what you mean. It's not the important thing for this patch
> though. I'll just remove it before merge.

Thank you Richie!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
