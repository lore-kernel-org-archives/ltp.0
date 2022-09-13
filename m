Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03341C54EE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 14:31:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F6A83CAAF7
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 16:31:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87A183CAA07
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 16:30:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EE057200BC3
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 16:30:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4F9EA5C082;
 Tue, 13 Sep 2022 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663079450;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cAWsBdmqhXYex/mJqXjkRBBp5J70wOWl9Pw4WbvC8SE=;
 b=Y+RtXmkTVeqcLCQaN5usTSgf1mwRLQ7u6/L8x1padH/85EyFvFR2vU6wk1Gg0SaaQ66QbZ
 zhSw1CxFvuQuLRoQpk/H0MCwPBzIgReN/TmhgCPR6Rkhl+2y+R1Y1CvsIhTVjkJoaPqKuG
 2RlMSsPiW9v6t1ZZBc1uusj4VXmrY+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663079450;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cAWsBdmqhXYex/mJqXjkRBBp5J70wOWl9Pw4WbvC8SE=;
 b=7cUFNkOQfqeYBSQgQPQ2K1EoCGadaaXT924bCXOmhzE53xOBtGpgedCTIQO1XTxnUvXLVT
 1qyKboaO8wA64QDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1204113AB5;
 Tue, 13 Sep 2022 14:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zl3uAhqUIGOEOwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Sep 2022 14:30:50 +0000
Date: Tue, 13 Sep 2022 16:30:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YyCUGILaavy5LnEI@pevik>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-8-pvorel@suse.cz> <Yx9QFWuRMjDUAafp@yuki>
 <Yx+Q0+fUokI7jlhT@pevik> <YyA8JQXmeTBQVbgY@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyA8JQXmeTBQVbgY@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 07/10] tst_test.sh: Introduce TST_FS_TYPE_FUSE
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > Also maybe it would be a better as a function so that the code does not
> > > run unconditionally on each tst_mount() call?
> > Do you mean e.g. tst_is_fuse() and df01.sh would call it?

> Yes that looks slightly cleaner than adding another variable.
In the end I add custom code to df01.sh, that's really better until some other
test needs to detects fuse.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
