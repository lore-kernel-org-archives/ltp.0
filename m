Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF4EC433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 12:55:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D125F3CAB07
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 14:55:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FA993CAAE8
 for <ltp@lists.linux.it>; Fri, 20 May 2022 14:55:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E98BD6001EF
 for <ltp@lists.linux.it>; Fri, 20 May 2022 14:55:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 35C512199F;
 Fri, 20 May 2022 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653051332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wsm8J63ws82HODFyQaU7vJXRC/aF9H9rafKMb1DL028=;
 b=Mlw2H8obtutzr74bbKq285RBBgmrfJgWbQNUqMaaccbTqTNMAvAiakneSxb3JWtxslwR3p
 vICi8BucmytgI1aZjrG6htVoWVCzh7QDl6h79aoNEOfnupwtQB0S4QPfaA1LFUGic+jpnE
 VHGDfQhy/v10DI1bGVShYhH2SOkaOqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653051332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wsm8J63ws82HODFyQaU7vJXRC/aF9H9rafKMb1DL028=;
 b=RSlkOFOeY88i9wlz6qxvqr65Wei7QU+2zD8AgoG/iIRwZWxiiAuIboiI0JuIVHc7+AF/5U
 j1V9AVCDIKKCi2Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01CB813AF4;
 Fri, 20 May 2022 12:55:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 73BVOsOPh2LwUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 20 May 2022 12:55:31 +0000
Date: Fri, 20 May 2022 14:55:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YoePwfVKuz62wkbO@pevik>
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220520083627.2499121-1-liwang@redhat.com>
 <YoeHGDpo1XgQYb+o@yuki>
 <CAEemH2e-0WsfqWdxWR9nt-jHxaz4qyXqN6qu7=4YDhb_6LOPvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e-0WsfqWdxWR9nt-jHxaz4qyXqN6qu7=4YDhb_6LOPvQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] two follow up fix for Introduce-of-max-runtime
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Cyril,

> > Should I send v4 after all?

> No need, unless someone explicitly explains they will do a review/test for
> V4.
I only briefly looked at the patchset, but LGTM.
+1 for merging.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
