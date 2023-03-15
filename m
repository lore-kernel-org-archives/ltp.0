Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD252C61DA4
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 13:04:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6BD83CD4A5
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 14:04:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C67A13CACA2
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 14:04:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3A1A31400F9C
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 14:04:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2FDF71FD76;
 Wed, 15 Mar 2023 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678885441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9QLMsBYrnHv+BiyUIc81yzPM6Z2WjK/CMjM/AL5K9WM=;
 b=Sv8YiSwohwSHF4ppxcJh6Ql6gRZOmUm4M4Rzp24pC6WK30YQ3ke7B9IOFsfDtpidBtdBqa
 N5SsfNPxpnfO9ZSfF2inekaKs9EPnq7dhHl9STQiCGpURpcA/TijNWD3GLaaU6wlv9oIFK
 wznT2QWH0lnk86YZjxqPx5y/GoyWXBo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42DF713A00;
 Wed, 15 Mar 2023 13:04:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Wg3IAkDCEWQkHQAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 15 Mar 2023 13:04:00 +0000
Date: Wed, 15 Mar 2023 09:03:57 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20230315130357.GC10248@localhost>
References: <20230120010533.11202-1-wegao@suse.com>
 <20230302071555.18420-1-wegao@suse.com>
 <20230302071555.18420-3-wegao@suse.com>
 <20230315123641.GB164307@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230315123641.GB164307@pevik>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] semop04:Refactor with new API
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Mar 15, 2023 at 01:36:41PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> > -int verbose = 0;
> > -int loops = 100;
> > -int errors = 0;
> > +static char *verbose;
> 
> We usually prefer to not introduce verbose option in refactored tests.
> It'd be nice to have output, which is not too verbose, but not just TPASS
> message (something in between).
I just need double confirm with your idea:
Remove this option and let current verbose info print out by default?
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
