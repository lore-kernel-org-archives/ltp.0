Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B3BC433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 11:01:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DD263C8EB9
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 12:01:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3C5D3C8C41
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 12:01:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 162D31A017D3
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 12:01:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D1FF21100;
 Wed, 15 Dec 2021 11:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639566097;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZdvpGVSvYGEO1xvXEdQYrdiADxnpF0KotU48wvq+e6c=;
 b=Jh/Qcx+fQrCTkav2DuJ3XM/+rxFTqi9Drjl6MhlrMmQldBOqPEp9LdwNct4w3MQpQ2bkB6
 V7pNTPFd4svrvztI+juBes5wroVJyexp/7Y6odk6nB8iAokflu4JiFZBssoPXRi7GWyaC7
 Izch8m8gxfD9Xo4887Rs1UL4MvH0/9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639566097;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZdvpGVSvYGEO1xvXEdQYrdiADxnpF0KotU48wvq+e6c=;
 b=X90ctHgD2Aw4tn8mPOxld6zV4LFabwUIfh4tNyLuwT7u9VSeMISrPMuhbI2CKFOesUrRPQ
 OWujvC338zGCalAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D704313B1C;
 Wed, 15 Dec 2021 11:01:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Uv16MRDLuWEpBAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Dec 2021 11:01:36 +0000
Date: Wed, 15 Dec 2021 12:01:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YbnLDlV4kL2uOGBH@pevik>
References: <20211210143536.31429-1-pvorel@suse.cz>
 <YbN33UYOL22hf9yv@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YbN33UYOL22hf9yv@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib/safe_net: TCONF SAFE_LISTEN() on ENOSYS
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

Hi Cyril,

> Hi!
> > bind04.c:138: TBROK: listen(3, 1) failed: ENOSYS (38)
> > sctp: failed to load transform for md5: -2

> Looks reasonable.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Merged. Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
