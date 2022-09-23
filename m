Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE38ECAAD8
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 07:30:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C6423CAD71
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 09:30:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11F133CAC3D
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 09:30:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 357D3600804
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 09:30:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5DE3B1F8E2;
 Fri, 23 Sep 2022 07:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663918233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8UxxWPJeTiUSsM9NG+GSMyQov9PnKC9JZnnxszhzk4=;
 b=gU4iLhjwh1RUqX2oeDD593ovzDPh9qDZGq7WcAq8SI0Qv9IzFiODRnysowyXFMTkOG/145
 IIu3ZkKju2JOUmMSgUSZ8A8m7rrercU/FCEcOAmXnBYKrOShFCK/ruKNUrHWsQsS5hCkAm
 QSNQpR9yXuq24AASJPYUOA2cEinCv0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663918233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8UxxWPJeTiUSsM9NG+GSMyQov9PnKC9JZnnxszhzk4=;
 b=OZpbzx4UDx9S8V6PLyllqQzt6C7QJ+RKbCi+MBylwUf/si0TucYhkLbj7rUIP5LDdjUHYo
 GwxRVxJSYRZY5ACQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B2E913A00;
 Fri, 23 Sep 2022 07:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TL+pCJlgLWMubQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Sep 2022 07:30:33 +0000
Date: Fri, 23 Sep 2022 09:30:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Yy1gl7Gw74h61c+V@pevik>
References: <20220922122047.9368-1-andrea.cervesato@suse.com>
 <YyzPOkOKRpKjSeN5@pevik>
 <dacec9f0-e0b1-a42f-9166-d9b64fd81f2a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dacec9f0-e0b1-a42f-9166-d9b64fd81f2a@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Let user decide command alias in ar01.sh
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

> > > Now it's possible to select ar alias by exporting AR variable before
> > > running ar01.sh test.
> > Why? To allow testing ar from cross compilation toolchain?

> Exactly.
Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Regards,
> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
