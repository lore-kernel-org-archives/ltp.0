Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4EFC433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 11:13:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A17513C9B2A
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 12:13:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 605803C06E5
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 12:12:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AD5C11A0090E
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 12:12:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EBC5F210FB;
 Mon,  7 Feb 2022 11:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644232371;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZ7mHoIKsUl+h3vl4LtMSmI2YPAUIQorie+uv59ISyI=;
 b=r6KqYImuTn9RyJQ/KlE4xCRiY7rz4lU1tjkKZcxuBqqDwwwL4E20WiJm5j9273h9eIpHVC
 WGHL0Dz85R6eMNrKTMcFqrlxSynknoaybP3+jbMufw/CnOhhIGKD5NBGwwaycP5FNegNTx
 3tPe1fBTaLLjwYOFGHknTj9kV4MJINM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644232371;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZ7mHoIKsUl+h3vl4LtMSmI2YPAUIQorie+uv59ISyI=;
 b=Oh8MhvD0zVmSfSP6Scb2oB7k15UFTtiLsSR2h1VHZocr6pbkMLcafzmRtQI6mIni8SfEUK
 LeQVz7S5lSpsjjAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2AA213B9F;
 Mon,  7 Feb 2022 11:12:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Yh4ULrP+AGLuVQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 07 Feb 2022 11:12:51 +0000
Date: Mon, 7 Feb 2022 12:12:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YgD+sty3ymNNkPGq@pevik>
References: <20220207040447.2803113-1-liwang@redhat.com>
 <YgDNB9v0x82mExVE@pevik>
 <CAEemH2fY-Om6z3WJzJ2X80x1H6DUG4Ec6sbWych1gfnT1C81EA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fY-Om6z3WJzJ2X80x1H6DUG4Ec6sbWych1gfnT1C81EA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrusage03: skip on small RAM system
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

Hi Li,

> On Mon, Feb 7, 2022 at 3:41 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Li,

> > > Notes:
> > >     Ps. I also think we might need .min_mem_[avai|total] field but
> > >         not sure if it is really necessary to add that.
> > Is it just a single test? Than maybe not worth of it, but generally I'm for


> By now I only see sporadic tests have this requirement.
> (hugeshmat04.c, swapping01.c, getrusage03.c)

> > adding tags like this into the library - it encapsulates code and gives us
> > a
> > documentation in docparse.


> Agree, maybe just holding as a future plan for adding that.

IMHO more than two are enough to put it into library, but others might think
differently.
Also sure, feel free to merge this fix, library support can be done any time
later.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
