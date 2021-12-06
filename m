Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C676C433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 10:27:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30B6E3C1E14
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 11:27:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A40943C061B
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 11:27:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4EE47600057
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 11:27:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 484C91FD54;
 Mon,  6 Dec 2021 10:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638786421;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2D98uAqas+GlFdYGElZxSJirRNvck9KOX/NBPaUfkg4=;
 b=tSSrH2pRxorpZAJQB4Vq0NTSn3wUEVQdZbFJuR+VVIr0iivSFQ9KC1f99FTBlh5/6gYamM
 fIHzLe1kcHIM1WHBzn7ItWP07k0K5Ez96HkwCd96FCx6vouxVQkYW2Lk59mWaypr68RvNR
 DPlTO4Izze7jQMZpHfJ0wGBsc7Tyoxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638786421;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2D98uAqas+GlFdYGElZxSJirRNvck9KOX/NBPaUfkg4=;
 b=2rqqF9uFTw0yqQZlxJpGd1TkAmOyut0T8wje3XVJCYcwj1smrf3PZl6PII/Vb4BQ69uOBl
 pGL9QbLmkuYvXuBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1941813AED;
 Mon,  6 Dec 2021 10:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gkaoA3XlrWF8QwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Dec 2021 10:27:01 +0000
Date: Mon, 6 Dec 2021 11:26:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Ya3lc9jWR5UZXB3T@pevik>
References: <20211202203006.32259-1-pvorel@suse.cz>
 <CAASaF6we7wki=+4Rt_8NGg848735VdAUeaMSGNUMBcL-cOX5pg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6we7wki=+4Rt_8NGg848735VdAUeaMSGNUMBcL-cOX5pg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] configure.ac: Print summary
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

Hi Jan,

> On Thu, Dec 2, 2021 at 9:30 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Due many checks of structs, members etc are chosen testsuites,
> > presence of used libraries and docparser config results quite hidden.
> > Print them as summary in the end.

> Color output would be nice too. But I find this output useful in plain
> text as well:
> Acked-by: Jan Stancek <jstancek@redhat.com>

Thanks! I can have look on colors later on, but I'd prefer to do it as a
separate approach.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
