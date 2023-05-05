Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D744CC77B75
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 10:44:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9081F3CB6E0
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 12:44:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A8083CB671
 for <ltp@lists.linux.it>; Fri,  5 May 2023 12:44:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1EA01200D34
 for <ltp@lists.linux.it>; Fri,  5 May 2023 12:44:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1020C1F8C1;
 Fri,  5 May 2023 10:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683283479;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5mcKZoU9sFVN/fiGmifVNNWu7VXyrMMMjFsjIqNI7M0=;
 b=V/lgxkh71tCBx8d3VztqKsVW+DAbzVyutGyv3pKTXT2SsCj49g0hOHPvRkzODw3l6g/O43
 CqMaSeDOiRgSi1yZkxaLkSECsefjY0r3SkDMNpEpRknzdw4gyUulX3U+C7HLcSk7SZAC09
 +s2DzkmDjWI4BfFUSzVyJdDcr4q9W+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683283479;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5mcKZoU9sFVN/fiGmifVNNWu7VXyrMMMjFsjIqNI7M0=;
 b=W/wRj+Kw6VsTxZWh4QehT+gp8LgsgwEAjP1bU3vo/vmqGqmjBjyMeBhL+3+y1I5f2/mQ2F
 gYYnyLCJRzXAdvCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53E7F13513;
 Fri,  5 May 2023 10:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8/lRDRbeVGRWAgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 May 2023 10:44:38 +0000
Date: Fri, 5 May 2023 12:44:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230505104436.GA31237@pevik>
References: <20230504131414.3826283-1-pvorel@suse.cz>
 <20230504131414.3826283-2-pvorel@suse.cz> <ZFO597l50v9PEQPP@yuki>
 <20230504211634.GA4244@pevik> <ZFTdp3wAO4qbpUjS@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZFTdp3wAO4qbpUjS@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/5] nfs_lib.sh: Cleanup local and remote
 directories setup
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > > It's a bit puzzling why we have two identical functions with a different
> > > name...

> > It's a preparation for TST_ALL_FILESYSTEMS=1 where the location changes.
> > I can squash this into that commit where it changes.

> That is the missing bit. No need to squash maybe just note that the
> directory will change in the last commit of the patchset.

+1 (I intended and obviously forgot).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
