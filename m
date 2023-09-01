Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF83ACA0FE1
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 10:45:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A85B3CBD83
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 12:45:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8E463CBBA7
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 12:45:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2A5CB1A0433D
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 12:45:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7028521850;
 Fri,  1 Sep 2023 10:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693565128;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ot/89N+g4rKg8gL1iv8+bGSkRIbEaw5nE3FWMXZcniY=;
 b=28GBrB6aSZhGU4w4ltlURZqTi2PsdW46astMpzSvI7cU8yq6YXqHGF+aTYBXebsl5mkhZc
 obD7vVXG9IU0cQ1lZGZ6hKGMrkRm6PweWOYU1Ae0LPwu1ifsRALyQhP/S87LDEjIDWBg9K
 PjrIiuQht61+EaRYj3TnzI8w5EHIuF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693565128;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ot/89N+g4rKg8gL1iv8+bGSkRIbEaw5nE3FWMXZcniY=;
 b=/gaxCO3Jwi3//aHa16E5STpYU8ycn19T9fqo7k0SKNgTETIV/oSOA1qj2oKPaqYMdEP31R
 RJ+LQRjNcFH+8ABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59F391358B;
 Fri,  1 Sep 2023 10:45:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id z82cFMjA8WRfagAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 01 Sep 2023 10:45:28 +0000
Date: Fri, 1 Sep 2023 12:45:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230901104526.GA335783@pevik>
References: <20230818071323.89606-1-pvorel@suse.cz>
 <ZPGx2VbtreROQC2N@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZPGx2VbtreROQC2N@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] sched_rr_get_interval01: Add another kernel
 tag
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
> > NOTE: git commit is still only in next tree [1], although hash will be
> > very likely the same, we should wait until it get to mainline (likely in
> > 6.6-rc1).

> The fix has reached the mainline with unchanged hash hence patch
> applied, thanks.

+1

> > I suppose we could write a test for another Cyril's fix [2].

> I guess that I can just send patch for that one, should be fairly easy.

Great, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
